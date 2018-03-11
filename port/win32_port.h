#ifndef WIN32_PORT_H__
#define WIN32_PORT_H__

#include "jerryscript.h"
#include "jerryscript-port.h"
#include "jerryscript-core.h"

struct port_ops {
    void (*fatal)(jerry_fatal_code_t code);
    void (*log)(jerry_log_level_t level, const char *fmt, va_list args);
    void (*print_char)(char c);

    bool (*get_time_zone)(jerry_time_zone_t *tz);
    double (*get_current_time)(void);
};

void jerry_port_set_ops(struct port_ops *ops);

#endif
