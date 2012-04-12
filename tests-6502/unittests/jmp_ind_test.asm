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

	lda		#$34
	sta		$2010
	lda		#$12
	sta		$2011

	lda		#$A9		; lda #'O'
	sta		$1234
	lda		#'O'
	sta		$1235	
	lda		#$FF		; printchar
	sta		$1236
	
	lda		#$A9		; lda #'O'
	sta		$1237
	lda		#'l'
	sta		$1238	
	lda		#$FF		; printchar
	sta		$1239

	lda		#$A9		; lda #'O'
	sta		$123A
	lda		#'a'
	sta		$123B	
	lda		#$FF		; printchar
	sta		$123C

	lda		#$D0		; bne #FE
	sta		$123D
	lda		#$FE
	sta		$123E
	
	jmp		($2010)
