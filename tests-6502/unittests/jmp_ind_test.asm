.include "unittests/macros.inc"


.org $1000

; Isto serve para gastar um caracter, porque por
; algum motivo ele esta la apos o arranque do Qemu...
getchar

; Write an address to $2010 and then put some code at that address
	lda		#$34
	sta		$2010
	lda		#$22
	sta		$2011

	lda		#$A9		; lda #'O'
	sta		$2234
	lda		#'O'
	sta		$2235	
	lda		#$FF		; printchar
	sta		$2236
	
	lda		#$A9		; lda #'l'
	sta		$2237
	lda		#'l'
	sta		$2238	
	lda		#$FF		; printchar
	sta		$2239

	lda		#$A9		; lda #'a'
	sta		$223A
	lda		#'a'
	sta		$223B	
	lda		#$FF		; printchar
	sta		$223C

	lda		#endprog_opcode		; endprog
	sta		$223D

	jmp		($2010)



