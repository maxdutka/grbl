/*
 * display.c
 *
 * Created: 14.03.2020 10:38:04
 *  Author: Maks
 */ 

#include "grbl.h"
#include "fast_st7920.h"


void display_init(void)
{
	fast_st7920_init();
	fast_st7920_text_write(0, "----- CNC -----");
}


void display_process(void)
{

}