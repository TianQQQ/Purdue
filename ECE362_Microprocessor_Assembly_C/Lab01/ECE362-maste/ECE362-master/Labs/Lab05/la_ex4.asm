;
; Exercise 4 for Logic Analyzer Experiment
;
; Equates

PEAR    equ     $000A
MODE    equ     $000B

        org     $0800

; Startup Code, used to put the HC12 in Special Expanded Wide Mode

        movb    #$04,PEAR       ; enable ECLK and R/W output
        movb    #$E9,MODE	; switch to normal expanded wide mode
				; with internal visibility enabled
loop	nop
        nop

; Four load and store operations, analyze these using TLA 714

        ldaa    $0900
        ldab    $0901
        staa    $0902
        stab    $0903

        bra     loop

; Test Data

        org     $0900

        fcb     $5E
        fcb     $A2
        rmb     2

        end
