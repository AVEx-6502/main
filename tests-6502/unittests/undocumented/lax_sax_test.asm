.include "unittests/macros.inc"

.org $1000

; Isto serve para gastar um caracter, porque por
; algum motivo ele esta la apos o arranque do Qemu...
getchar

        ldy     #42
        sty		$4321
        
        ; lax		$4321
        .byte $AF
        .word $4321
        
        printnum
        lda		#' '
        printchar
        txa
        printnum
        lda		#$0A
        printchar
        
        lda		#$B5
        ldx		#$5B
        
        ; sax		$4321
        .byte $8F
        .word $4321
                
        lda		$4321
        printnum
		
end:    endprog

