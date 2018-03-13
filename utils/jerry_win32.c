#define __attribute__(...)

#include <win32_port.h>

void win32_fatal(jerry_fatal_code_t code)
{
	printf("js engine fatal, code=%d\n", code);
	while (1);
}

void win32_log(jerry_log_level_t level, const char *format, va_list args)
{
	vprintf(format, args);
}

void win32_print_char(char c)
{
	printf("%c", c);
}

bool win32_get_time_zone(jerry_time_zone_t *tz_p)
{
	tz_p->offset = 0;
	tz_p->daylight_saving_time = 0;
	return true;
}

double win32_get_current_time(void)
{
	return 0;
}

struct port_ops _win32_port_ops = 
{
	win32_fatal,
	win32_log,
	win32_print_char,
	win32_get_time_zone,
	win32_get_current_time
};

int win32_port_init(void)
{
	jerry_port_set_ops(&_win32_port_ops);

	return 0;
}
