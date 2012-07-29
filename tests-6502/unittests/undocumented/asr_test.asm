.include "unittests/macros.inc"


.org $1000

; Isto serve para gastar um caracter, porque por
; algum motivo ele esta la apos o arranque do Qemu...
getchar

		lda		#$EB
		.byte   $4B
		.byte   $5E
		bmi     erro
		bcs     erro
		beq     erro
		printnum		; 37
		lda		#$0A
		printchar	

		lda		#$AD
		.byte   $4B
		.byte	$D7
		bmi     erro
		bcc     erro
		beq     erro
		printnum		; 66
		lda		#$0A
		printchar	

	
		lda		#$A5
		.byte   $4B
		.byte	$5B
		bmi     erro
		bcc     erro
		bne     erro
		printnum		; 0
		lda		#$0A
		printchar	

		lda		#$A5
		.byte	$4B
		.byte	$5A
		bmi     erro
		bcs     erro
		bne     erro
		printnum		; 0
		lda		#$0A
		printchar	

        jmp     end
erro:   lda		#'E'
		printchar	
end:	endprog

