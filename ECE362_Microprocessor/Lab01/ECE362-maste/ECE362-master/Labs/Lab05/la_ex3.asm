;***********************************************************************
; ECE 362 - Logic Analyzer Experiment
;
; Skeleton file for Step 3
;***********************************************************************
;
; Completed by: < your name >
;               < your lab partners name >
;               < your class number >
;               < your lab division >
;
;***********************************************************************
;
; Exercise 3 for Logic Analyzer Experiment
;
; Program: Square Wave Generator
;
; Purpose: Produces a square wave on Pin 0 of Port A
;
; Starting Address: 0800
;
; Note: This program is an infinite loop
;
;***********************************************************************

ddra	equ	$0002
porta	equ	$0000

	org	$0800
        lds     #$0C00
	movb	#$FF,ddra		; Initialize Port A for Output
	movb	#$00,porta		; Set PA0 = 0
loop	bsr	delay			; Wait 6 ms
	com	porta			; Toggle PA0
	bra	loop

;***********************************************************************
;
; Subroutine
;
; delay -- Produce a delay of 6 ms
;
; Note: The boards used in lab for this experiment run at 12.5 MHz.

delay


	rts

	end
