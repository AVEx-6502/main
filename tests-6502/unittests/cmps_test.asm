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

		lda		#42
		cmp		#42
		bne		l1
		inc		0
		lda		#'A'
		printchar	
l1:		lda		#43
		cmp		#42
		beq		l2
		inc		0
		lda		#'B'
		printchar

l2:		ldx		#42
		cpx		#42
		bne		l3
		inc		0	
		lda		#'C'
		printchar		
l3:		ldx		#43
		cpx		#42
		beq		l4
		inc		0
		lda		#'D'
		printchar

l4:		ldy		#42
		cpy		#42
		bne		l5
		inc		0
		lda		#'E'
		printchar			
l5:		ldy		#43
		cpy		#42
		beq		l6
		inc		0
		lda		#'F'
		printchar



l6:		lda		#$FF
		cmp		#$FF
		bcc		l7
		inc		0	
		lda		#'G'
		printchar		
l7:		lda		#$0
		cmp		#$1
		bcs		l8
		inc		0
		lda		#'H'
		printchar		

l8:		ldx		#$FF
		cpx		#$FF
		bcc		l9
		inc		0
		lda		#'I'
		printchar		
l9:		ldx		#$0
		cpx		#$1
		bcs		l10
		inc		0
		lda		#'J'
		printchar		

l10:	ldy		#$FF
		cpy		#$FF
		bcc		l11
		inc		0	
		lda		#'K'
		printchar		
l11:	ldy		#$0
		cpy		#$1
		bcs		l12
		inc		0
		lda		#'L'
		printchar



l12:	lda		#$02
		cmp		#$FE
		bmi		l13
		inc		0
		lda		#'M'
		printchar		
l13:	lda		#$F0
		cmp		#$FE				
		bpl		l14
		inc		0
		lda		#'N'
		printchar

l14:	ldx		#$02
		cpx		#$FE
		bmi		l15
		inc		0	
		lda		#'O'
		printchar		
l15:	ldx		#$F0
		cpx		#$FE
		bpl		l16
		inc		0
		lda		#'P'
		printchar

l16:	ldy		#$02
		cpy		#$FE
		bmi		l17
		inc		0
		lda		#'Q'
		printchar		
l17:	ldy		#$F0
		cpy		#$FE
		bpl		l18
		inc		0
		lda		#'R'
		printchar



l18:	lda		#42
		sta		24
		cmp		24
		bne		l19
		inc		0
		lda		#'S'
		printchar		
l19:	lda		#43
		sta		24
		lda		#0
		cmp		24
		beq		l20
		inc		0
		lda		#'T'
		printchar

l20:	lda		0
		printnum		; 20
end:	brk





