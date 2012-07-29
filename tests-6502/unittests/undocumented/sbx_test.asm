.include "unittests/macros.inc"


.org $1000

; Isto serve para gastar um caracter, porque por
; algum motivo ele esta la apos o arranque do Qemu...
getchar

    lda     #$FF
	ldx		#100
	.byte   $CB
	.byte	1
	txa
	printnum
	lda 	#' '
	printchar

    lda     #$FF
	ldx		#250
	.byte   $CB
	.byte	200
	txa
	printnum
	lda 	#' '
	printchar
		
    lda     #$FF		
	ldx		#10
	.byte   $CB
	.byte	5
    txa
	printnum
	lda 	#' '
	printchar
	
    lda     #$FF			
	ldx		#10
	.byte   $CB
	.byte	$FB	;	-5
	txa
	printnum
	lda 	#' '
	printchar
	
    lda     #$FF	
	ldx		#50
	.byte   $CB
	.byte	$38		;	-200
	txa
	printnum
	lda 	#' '
	printchar
	
    lda     #$FF		
	ldx		#50
	.byte   $CB
	.byte	200
	txa		
	printnum		; 6A = 106
	lda 	#' '
	printchar		
	
	
	
	
endprog

