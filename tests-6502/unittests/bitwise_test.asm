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

		lda		#$0F
		and		#$81
		printnum		; 1
		lda		#$0A
		printchar	
		
		lda		#$0F
		ora		#$81
		printnum		; 143
		lda		#$0A
		printchar	
		
		lda		#$0F
		eor		#$81
		printnum		; 142
		lda		#$0A
		printchar	
		
		lda		#$0F
		ldx		#$81
		stx		42
		ldx		0		
		and		42
		printnum		; 1
		lda		#$0A
		printchar	
		
		lda		#$0F
		ldx		#$81
		stx		42
		ldx		0		
		ora		42
		printnum		; 143
		lda		#$0A
		printchar	
		
		lda		#$0F
		ldx		#$81
		stx		42
		ldx		0		
		eor		42
		printnum		; 142
		lda		#$0A
		printchar	



end:	brk
