;***********************************************************************
;
; ECE 362 - Experiment 5 - Step 1
;
; Program: Square Wave Generator for MSO Demonstration
;
; Purpose: Produces a square wave on Pin 0 of Port B
;
; Starting Address: 0800
;
;***********************************************************************

NMS	equ	1		; number of milliseconds between toggles
		          	; (this is one-half of the period)

ddrb	equ	$0003
portb	equ	$0001

	org 	$0800
	lds	#$0C00
      	movb	#$01,ddrb	; initialize Port B Pin 0 for Output
      	clr	portb
	ldaa	#NMS		; load (A) with desired delay
loop	jsr 	delay		; wait 
	com 	portb		; toggle port pin 
	bra	loop		; loop continuously

;***********************************************************************
;
; delay subroutine - reference: slide 181 in Lecture Module 1-D
;
; Note: The boards used for this experiment run at 12.5 MHz (80 ns/cycle)

ILC	equ	?		; innner loop count for approx. 1 ms


delay
      	pshx			; [2]
      	psha			; [2]
      	pshc			; [2]
loopo
      	ldx	#ILC		; [3]
loopi
      	dbne	x,loopi		; [3]

      	dbne	a,loopo		; [3]

      	pulc			; [3]
      	pula			; [3]
      	pulx			; [3]
      	rts			; [5]

	end
