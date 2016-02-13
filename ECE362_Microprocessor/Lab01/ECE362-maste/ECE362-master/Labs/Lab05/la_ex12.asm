;
; Exercise 1 & 2 for Logic Analyzer Experiment
;
ddra    equ    $0002
porta   equ    $0000

	org     $0800
	movb    #$ff,ddra             ; Initialize Port A for Output
	movb    #$fe,porta            ; Set PA0 = 0
	nop
	movb    #$ff,porta            ; Set PA0 = 1
	nop
	movb    #$fe,porta            ; Set PA0 = 0
        stop
