.include "unittests/macros.inc"


.org $1000

; Isto serve para gastar um caracter, porque por
; algum motivo ele esta la apos o arranque do Qemu...
getchar

		lda		#$81
		.byte   $0B
		.byte   $0F
		bmi     erro
		bcs     erro
		beq     erro
		printnum		; 1
		lda		#$0A
		printchar	

		lda		#$E1
		.byte   $2B
		.byte	$A5
		bpl     erro
		bcc     erro
		beq     erro
		printnum		; 161
		lda		#$0A
		printchar	

	
		lda		#$0F
		.byte   $0B
		.byte	$81
		bmi     erro
		bcs     erro
		beq     erro
		printnum		; 1
		lda		#$0A
		printchar	

		lda		#$A5
		.byte	$2B
		.byte	$E1
		bpl     erro
		bcc     erro
		beq     erro
		printnum		; 161
		lda		#$0A
		printchar	

        jmp     end
erro:   lda		#'E'
		printchar	
end:	endprog

