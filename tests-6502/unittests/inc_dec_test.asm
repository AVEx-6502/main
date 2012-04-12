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
		inx
		txa
		printnum
		lda		#$0A
		printchar

		ldx		#$FF
		inx
		txa
		printnum
		lda		#$0A
		printchar
		
		ldy		#1
		iny
		tya
		printnum
		lda		#$0A
		printchar

		ldy		#$FF
		iny
		tya
		printnum
		lda		#$0A
		printchar
		
		ldx		#1
		dex
		txa
		printnum
		lda		#$0A
		printchar
		dex
		txa
		printnum
		lda		#$0A
		printchar
				
		ldy		#1
		dey
		tya
		printnum
		lda		#$0A
		printchar
		dey
		tya
		printnum
		lda		#$0A
		printchar	
end:	jmp end			
