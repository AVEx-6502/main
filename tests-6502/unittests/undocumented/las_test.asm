.include "unittests/macros.inc"


.org $1000

; Isto serve para gastar um caracter, porque por
; algum motivo ele esta la apos o arranque do Qemu...
getchar

        ldy     #0

		ldx		#$81
		txs        
        ldx     #$0F
        stx     $0042
		.byte   $BB
		.byte   $42
		.byte   $00
		bmi     erro
		beq     erro
		printnum		; 1
		lda		#$0A
		printchar	
        txa
		printnum		; 1
		lda		#$0A
		printchar	
		tsx
		txa
		printnum		; 1
		lda		#$0A
		printchar	
		
        
		ldx		#$E1
		txs
		ldx     #$A5
		stx     $0042
		.byte   $BB
		.byte	$42
		.byte   $00
		bpl     erro
		beq     erro
		printnum		; 161
		lda		#$0A
		printchar	
        txa
		printnum		; 161
		lda		#$0A
		printchar	
		tsx
		txa
		printnum		; 161
		lda		#$0A
		printchar	


		ldx		#$0F
		txs        
        ldx     #$81
        stx     $0042
		.byte   $BB
		.byte   $42
		.byte   $00
		bmi     erro
		beq     erro
		printnum		; 1
		lda		#$0A
		printchar	
        txa
		printnum		; 1
		lda		#$0A
		printchar	
		tsx
		txa
		printnum		; 1
		lda		#$0A
		printchar	


		ldx		#$A5
		txs
		ldx     #$E1
		stx     $0042
		.byte   $BB
		.byte	$42
		.byte   $00
		bpl     erro
		beq     erro
		printnum		; 161
		lda		#$0A
		printchar	
        txa
		printnum		; 161
		lda		#$0A
		printchar	
		tsx
		txa
		printnum		; 161
		lda		#$0A
		printchar	
		
        jmp     end
erro:   lda		#'E'
		printchar	
end:	endprog

