.include "unittests/macros.inc"


.org $1000

; Isto serve para gastar um caracter, porque por
; algum motivo ele esta la apos o arranque do Qemu...
getchar

; Write an address to $2010 and then put some code at that address
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
	
	lda		#$A9		; lda #'l'
	sta		$1237
	lda		#'l'
	sta		$1238	
	lda		#$FF		; printchar
	sta		$1239

	lda		#$A9		; lda #'a'
	sta		$123A
	lda		#'a'
	sta		$123B	
	lda		#$FF		; printchar
	sta		$123C

	lda		#endprog_opcode		; endprog
	sta		$123D

	jmp		($2010)



