.include "unittests/macros.inc"


.org $1000

; Isto serve para gastar um caracter, porque por
; algum motivo ele esta la apos o arranque do Qemu...
getchar

	lda		#100
	sec
	sbc		#1
	printnum
	lda 	#' '
	printchar


	lda		#250
	sec
	sbc		#200
	printnum
	lda 	#' '
	printchar
		
	lda		#10
	sec
	sbc		#5
	printnum
	lda 	#' '
	printchar
	
	lda		#10
	sec
	sbc		#$FB	;	-5
	printnum
	lda 	#' '
	printchar
	
	lda		#50
	sec
	sbc		#$38		;	-200
	printnum
	lda 	#' '
	printchar
	
	lda		#50
	sec
	sbc		#200		
	printnum		; 6A = 106
	lda 	#' '
	printchar		
	
	
	
	
endprog

