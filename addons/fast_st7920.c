// Based on: https://www.onetransistor.eu/2018/03/code-text-mode-st7920-arduino.html


extern void fast_st7920_ll_init (void);
extern void fast_st7920_ll_write (unsigned char rs, unsigned char data);

#include <util/delay.h>


void fast_st7920_init(void)
{
	fast_st7920_ll_init();
	
	_delay_ms(40);
	fast_st7920_ll_write(0, 0x30);
	_delay_ms(1);
	fast_st7920_ll_write(0, 0x01); // CLS
	_delay_ms(10);
	fast_st7920_ll_write(0, 0x06); // Entry mode set
	_delay_ms(1);
	fast_st7920_ll_write(0, 0x0C); // Display control
	_delay_ms(1);	
	
}

/* 4 lines x 16 chars */
void fast_st7920_text_write(int line, char *str)
{
	switch(line)
	{
		case 0:
		fast_st7920_ll_write(0, 0x80);
		break;
		case 1:
		fast_st7920_ll_write(0, 0x90);
		break;
		case 2:
		fast_st7920_ll_write(0, 0x88);
		break;
		case 3:
		fast_st7920_ll_write(0, 0x98);
		break;
	}
	
	//_delay_us(50);
	
	while(*str)
	{
		fast_st7920_ll_write(1, *str);
		//_delay_us(50);
		str++;
	}		
}
