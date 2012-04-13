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

		ldx		#1
		stx		1
		inc		1
		lda		1
		printnum		; 2
		lda		#$0A
		printchar

		ldx		#$FF
		stx		1
		inc		1
		lda		1
		printnum		; 0
		lda		#$0A
		printchar
		
		ldx		#1
		stx		1
		dec		1
		lda		1
		printnum		; 0
		lda		#$0A
		printchar
		
		dec		1
		lda		1
		printnum		; 255
		lda		#$0A
		printchar
		
end:	brk
