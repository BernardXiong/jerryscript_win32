#include "jerry_util.h"

DECLARE_HANDLER(ps)
{
    /* list thread information */
    printf("list thread\n");

    return jerry_create_undefined();
}

jerry_value_t js_module_rtthread_init(void)
{
    jerry_value_t rtthread_obj = jerry_create_object();
    REGISTER_METHOD(rtthread_obj, ps);

    return rtthread_obj;
}
JS_MODULE(os, js_module_rtthread_init);
