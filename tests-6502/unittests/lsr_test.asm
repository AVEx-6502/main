.include "unittests/macros.inc"


.org $1000

; Isto serve para gastar um caracter, porque por
; algum motivo ele esta la apos o arranque do Qemu...
getchar

		; Immediate test
		lda 	#$AA
loop:	ldy		#0		; Y - carry
		lsr
		printnum		; print result
		tax				; save AC in X
		bcc		not_c	
    	iny
not_c:	lda		#$0A
		printchar
		tya
		printnum		; print carry
		lda		#$0A
		printchar
		txa				; Restore AC
		bne		loop	; loop until AC is 0
		
		; Memory test		
		ldx 	#$55
		stx		42		
loop2:	ldy		#0		; Y - carry
		lsr		42
		lda		42
		printnum		; print result
		tax				; save AC in X
		bcc		not_c2	
    	iny
not_c2:	lda		#$0A
		printchar
		tya
		printnum		; print carry
		lda		#$0A
		printchar
		txa				; Restore AC
		bne		loop2	; loop until AC is 0

end:	endprog

