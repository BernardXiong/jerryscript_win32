#include <string.h>
#include <stdlib.h>
#include <stdarg.h>
#include <stdbool.h>

#include "win32_port.h"

struct port_ops *_win32_ops = NULL;
void jerry_port_set_ops(struct port_ops *ops)
{
    _win32_ops = ops;
}

void jerry_port_fatal (jerry_fatal_code_t code)
{
    if (_win32_ops) _win32_ops->fatal(code);

    while (1);
}

void jerry_port_log (jerry_log_level_t level, const char *format, ...)
{
    va_list args;

    va_start(args, format);
    if (_win32_ops) _win32_ops->log(level, format, args);
    va_end(args);
}

void jerryx_port_handler_print_char (char c)
{
    if (_win32_ops) _win32_ops->print_char(c);
}

bool jerry_port_get_time_zone (jerry_time_zone_t *tz_p)
{
    bool ret = false;

    if (_win32_ops) ret = _win32_ops->get_time_zone(tz_p);

    return ret;
}

double jerry_port_get_current_time (void)
{
    if (_win32_ops) return _win32_ops->get_current_time();

    return 0;
}
