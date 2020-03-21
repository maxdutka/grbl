
/*
 * fast_st7920.s
 *
 * Created: 20.03.2020 15:12:50
 *  Author: Maks
 */ 

   #include <avr/io.h>

 .equ LCD_PORT, _SFR_IO_ADDR(PORTA)
 .equ LCD_DDR, _SFR_IO_ADDR(DDRA)
 .equ LCD_CLK_BIT, 7
 .equ LCD_DATA_BIT, 5
 .equ LCD_CE_BIT, 3

 // +++++++++++++++++++++++++++++++++++++++++++++

  .global fast_st7920_ll_init
   fast_st7920_ll_init:

   in r18, LCD_PORT
   andi r18, ~(0xFF & ((1<<LCD_CLK_BIT)|(1<<LCD_DATA_BIT)|(1<<LCD_CE_BIT)))
   out LCD_PORT, r18

   in r18, LCD_DDR
   ori r18, (1<<LCD_CLK_BIT)|(1<<LCD_DATA_BIT)|(1<<LCD_CE_BIT)
   out LCD_DDR, r18
  ret

  // ------------------------------------------

   st7920_put_zero:
   cbi LCD_PORT, LCD_DATA_BIT
   sbi LCD_PORT, LCD_CLK_BIT
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   cbi LCD_PORT, LCD_CLK_BIT
  ret

  // ------------------------------------------

st7920_put_one:
   sbi LCD_PORT, LCD_DATA_BIT
   sbi LCD_PORT, LCD_CLK_BIT
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   cbi LCD_PORT, LCD_CLK_BIT
  ret

  // ------------------------------------------
  // in r22, r24 gcc put params
  // use cbi/sbi because it can be interrupt safe

  .global fast_st7920_ll_write
	fast_st7920_ll_write:
	cbi LCD_PORT, LCD_CLK_BIT
	cbi LCD_PORT, LCD_DATA_BIT

	sbi LCD_PORT, LCD_CE_BIT
	nop
	nop

	// 11111
	call st7920_put_one
	nop
	call st7920_put_one
	nop
	call st7920_put_one
	nop
	call st7920_put_one
	nop
	call st7920_put_one
	nop

	// RW
	call st7920_put_zero

	// RS

	sbrc r24, 0
    call st7920_put_one
	sbrs r24, 0
	call st7920_put_zero

	// dump 0
	nop
	call st7920_put_zero

	// Data

	sbrc r22, 7
    call st7920_put_one
	sbrs r22, 7
	call st7920_put_zero

	sbrc r22, 6
    call st7920_put_one
	sbrs r22, 6
	call st7920_put_zero

	sbrc r22, 5
    call st7920_put_one
	sbrs r22, 5
	call st7920_put_zero

	sbrc r22, 4
    call st7920_put_one
	sbrs r22, 4
	call st7920_put_zero

	// 0000
	nop
	call st7920_put_zero
	nop
	call st7920_put_zero
	nop
	call st7920_put_zero
	nop
	call st7920_put_zero

	// next data part

	sbrc r22, 3
    call st7920_put_one
	sbrs r22, 3
	call st7920_put_zero

	sbrc r22, 2
    call st7920_put_one
	sbrs r22, 2
	call st7920_put_zero

	sbrc r22, 1
    call st7920_put_one
	sbrs r22, 1
	call st7920_put_zero

	sbrc r22, 0
    call st7920_put_one
	sbrs r22, 0
	call st7920_put_zero

	// 0000
	nop
	call st7920_put_zero
	nop
	call st7920_put_zero
	nop
	call st7920_put_zero
	nop
	call st7920_put_zero

	nop
	nop
	 
	cbi LCD_PORT, LCD_CE_BIT

	nop
	nop

	ret
