#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "jerry_util.h"
#include "jerry_module.h"

#include <jerryscript-ext/module.h>
#ifdef _WIN32
#define strdup _strdup
#endif

#ifndef PATH_MAX
#define PATH_MAX    256
#endif

char *strdup(const char *);
char *getcwd(char *buf, size_t size);

typedef jerry_value_t (*module_init_func_t)(void);

char *js_module_dirname(char *path)
{
    size_t i;
    char *s = NULL;

    if (!path || !*path) return NULL;

    s = strdup(path);
    if (!s) return NULL;

    i = strlen(s)-1;
    for (; s[i]=='/'; i--) if (!i) { s[0] = '/'; goto __exit; }
    for (; s[i]!='/'; i--) if (!i) { s[0] = '.'; goto __exit; }
    for (; s[i]=='/'; i--) if (!i) { s[0] = '/'; goto __exit; }

__exit:
    s[i+1] = 0;
    return s;
}

char *js_module_normalize_path(const char *directory, const char *filename)
{
    char *fullpath;
    char *dst0, *dst, *src;
    char *cwd = NULL;

    /* check parameters */
    if (filename == NULL) return NULL;

    if (directory == NULL && filename[0] != '/')
    {
        cwd = (char*) malloc (PATH_MAX);
        if (cwd == NULL) return NULL;

        /* get current working directory */
        getcwd(cwd, PATH_MAX);
        directory = cwd;
    }

    if (filename[0] != '/') /* it's a absolute path, use it directly */
    {
        fullpath = malloc(strlen(directory) + strlen(filename) + 2);

        if (fullpath == NULL)
        {
            free(cwd);
            return NULL;
        }

        /* join path and file name */
        snprintf(fullpath, strlen(directory) + strlen(filename) + 2,
            "%s/%s", directory, filename);
    }
    else
    {
        fullpath = strdup(filename); /* copy string */

        if (fullpath == NULL)
            return NULL;
    }

    src = fullpath;
    dst = fullpath;

    dst0 = dst;
    while (1)
    {
        char c = *src;

        if (c == '.')
        {
            if (!src[1]) src ++; /* '.' and ends */
            else if (src[1] == '/')
            {
                /* './' case */
                src += 2;

                while ((*src == '/') && (*src != '\0'))
                    src ++;
                continue;
            }
            else if (src[1] == '.')
            {
                if (!src[2])
                {
                    /* '..' and ends case */
                    src += 2;
                    goto up_one;
                }
                else if (src[2] == '/')
                {
                    /* '../' case */
                    src += 3;

                    while ((*src == '/') && (*src != '\0'))
                        src ++;
                    goto up_one;
                }
            }
        }

        /* copy up the next '/' and erase all '/' */
        while ((c = *src++) != '\0' && c != '/')
            *dst ++ = c;

        if (c == '/')
        {
            *dst ++ = '/';
            while (c == '/')
                c = *src++;

            src --;
        }
        else if (!c)
            break;

        continue;

up_one:
        dst --;
        if (dst < dst0)
        {
            free(cwd);
            free(fullpath);
            return NULL;
        }
        while (dst0 < dst && dst[-1] != '/')
            dst --;
    }

    *dst = '\0';

    /* remove '/' in the end of path if exist */
    dst --;
    if ((dst != fullpath) && (*dst == '/'))
        *dst = '\0';

    /* final check fullpath is not empty, for the special path of lwext "/.." */
    if ('\0' == fullpath[0])
    {
        fullpath[0] = '/';
        fullpath[1] = '\0';
    }

    free(cwd);

    return fullpath;
}

/* load module from file system */
static bool load_module_from_filesystem(const jerry_value_t module_name, jerry_value_t *result)
{
    bool ret = false;
    char *str = NULL;
    char *module = js_value_to_string(module_name);

    char *dirname  = NULL;

    jerry_value_t dirname_value  = 0;
    jerry_value_t filename_value = 0;
    jerry_value_t global_obj     = 0;

    char *full_path = NULL;
    char *full_dir  = NULL;

    global_obj  = jerry_get_global_object();
    dirname_value = js_get_property(global_obj, "__dirname");
    if (jerry_value_is_string(dirname_value))
    {
        dirname = js_value_to_string(dirname_value);
    }
    else
    {
        dirname = NULL;
    }

    if (module[0] != '/') /* is a relative path */
    {
        full_path = js_module_normalize_path(dirname, module);
    }
    else
    {
        full_path = js_module_normalize_path(NULL, module);
    }
    free(dirname);

    uint32_t len = js_read_file(full_path, &str);
    if (len == 0) goto __exit;

    filename_value = js_get_property(global_obj, "__filename");

    /* set new __filename and __dirname */
    full_dir = js_module_dirname(full_path);

    js_set_string_property(global_obj, "__dirname",  full_dir);
    js_set_string_property(global_obj, "__filename", full_path);

    (*result) = jerry_eval((jerry_char_t *)str, len, false);
    if (jerry_value_has_error_flag(*result))
        printf("failed to evaluate JS\n");
    else
        ret = true;

    /* restore __filename and __dirname */
    js_set_property(global_obj, "__dirname",  dirname_value);
    js_set_property(global_obj, "__filename", filename_value);

__exit:
    if (full_dir) free(full_dir);
    if (full_path) free(full_path);

    jerry_release_value(global_obj);
    jerry_release_value(dirname_value);
    jerry_release_value(filename_value);

    free(module);
    free(str);

    return ret;
}

/* load builtin module */
static bool load_module_from_builtin(const jerry_value_t module_name,
                                     jerry_value_t *result)
{
    bool ret = false;
    module_init_func_t module_init;

    char *module = js_value_to_string(module_name);

    {
        extern jerry_value_t js_module_rtthread_init(void);

        if (strcmp(module, "os") == 0)
        {
            module_init = js_module_rtthread_init;
            *result = module_init();
            ret = true;
        }
    }

    free(module);

    return ret;
}

static jerryx_module_resolver_t load_filesystem_resolver =
{
    NULL,
    load_module_from_filesystem
};

static jerryx_module_resolver_t load_builtin_resolver =
{
    NULL,
    load_module_from_builtin
};

static const jerryx_module_resolver_t *resolvers[] =
{
    &load_builtin_resolver,
    &load_filesystem_resolver
};

DECLARE_HANDLER(require)
{
    if (args_cnt == 0)
    {
        printf("No module name supplied\n");
        return jerry_create_null();
    }

    if (jerry_value_is_string(args[0]) == 0)
    {
        printf("No module name supplied as string\n");
        return jerry_create_null();
    }

    /* make new module.exports */
    jerry_value_t global_obj  = jerry_get_global_object();
    jerry_value_t modules_obj = 0;
    jerry_value_t exports_obj = 0;

    modules_obj = js_get_property(global_obj, "module");
    exports_obj = js_get_property(modules_obj, "exports");

    jerry_value_t module_exports_obj = jerry_create_object();
    js_set_property(modules_obj, "exports", module_exports_obj);
    jerry_release_value(module_exports_obj);

    /* Try each of the resolvers to see if we can find the requested module */
    char *module = js_value_to_string(args[0]);
    jerry_value_t result = jerryx_module_resolve(args[0], resolvers, sizeof(resolvers)/sizeof(resolvers[0]));
    if (jerry_value_has_error_flag(result))
    {
        printf("Couldn't load module %s\n", module);

        jerry_release_value(result);

        /* create result with error */
        result = jerry_create_error(JERRY_ERROR_TYPE,
                                  (const jerry_char_t *) "Module not found");
    }

    /* restore the parent module.exports */
    js_set_property(modules_obj, "exports", exports_obj);

    jerry_release_value(global_obj);
    jerry_release_value(modules_obj);
    jerry_release_value(exports_obj);

    free(module);

    return result;
}

int js_module_init(void)
{
    jerry_value_t global_obj = jerry_get_global_object();
    jerry_value_t modules_obj = jerry_create_object();
    jerry_value_t exports_obj = jerry_create_object();

    js_set_property(modules_obj, "exports", exports_obj);
    js_set_property(global_obj, "module", modules_obj);

    REGISTER_HANDLER(require);

    jerry_release_value(global_obj);
    jerry_release_value(modules_obj);
    jerry_release_value(exports_obj);

    return 0;
}
