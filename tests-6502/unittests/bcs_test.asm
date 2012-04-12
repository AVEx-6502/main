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

		lda 	#0
loop:	printnum
		tax
		lda		#$0A
		printchar
		txa
		sec
		adc		#1
out:	bcs		out
		jmp		loop


