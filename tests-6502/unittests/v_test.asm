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

		clv
		CLC      ; 1 + 1 = 2, returns V = 0
		LDA #$01
		ADC #$01
		bvs		erro

		clv
		CLC      ; 1 + -1 = 0, returns V = 0
		LDA #$01 
		ADC #$FF
		bvs		erro

		clv
		CLC      ; 127 + 1 = 128, returns V = 1
		LDA #$7F
		ADC #$01
		bvc		erro

		clv
		CLC      ; -128 + -1 = -129, returns V = 1
		LDA #$80
		ADC #$FF
		bvc		erro
		
		clv
		SEC      ; 0 - 1 = -1, returns V = 0
		LDA #$00
		SBC #$01
		bvs		erro

		clv
		SEC      ; -128 - 1 = -129, returns V = 1
		LDA #$80
		SBC #$01
		bvc		erro

		clv
		SEC      ; 127 - -1 = 128, returns V = 1
		LDA #$7F
		SBC #$FF
		bvc		erro

		clv
		SEC      ; Note: SEC, not CLC
		LDA #$3F ; 63 + 64 + 1 = 128, returns V = 1
		ADC #$40
		bvc		erro

		clv
		CLC      ; Note: CLC, not SEC
		LDA #$C0 ; -64 - 64 - 1 = -129, returns V = 1
		SBC #$40
		bvc		erro
		
		clv
		bvs		erro
		
		lda		#$FF
		ldx		#$FF
		stx		0
		bit		0
		bvc		erro
		ldx		#$0F
		stx		0
		bit		0
		bvs		erro

		lda		#'C'
		printchar

end:	brk


erro:	lda		#'E'
		printchar
		jmp		end





