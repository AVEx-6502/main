.macro getnum character
  .byte $CF
.endmacro
.macro printnum character
  .byte $DF
.endmacro
.macro getchar character
  .byte $EF
.endmacro
.macro printchar character
  .byte $FF
.endmacro

.org $1000

; Isto serve para gastar um caracter, porque por
; algum motivo ele esta la apos o arranque do Qemu...
getchar

	; Test sec and add with carry
	lda		0
	sec
	adc		#41
	printnum
    lda     #' '
    printchar

	; Test clc and add without carry
	sec    
    clc	
	lda		#3
	adc		#40
	printnum
    lda     #' '
    printchar

	; Test if add sets the carry
	lda		#$FF
	adc		#45
	tax
	adc		#0	; Carry should be 1, this should increment AC
	tay
	
	txa
	printnum
    lda     #' '    
    printchar

	tya
	printnum
    lda     #' '    
    printchar

	; Resultado esperado: 42 43 44 45

end:	jmp end

