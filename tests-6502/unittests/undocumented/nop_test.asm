.include "unittests/macros.inc"

.org $1000

; Isto serve para gastar um caracter, porque por
; algum motivo ele esta la apos o arranque do Qemu...
getchar

        lda     #0

        ; 1 byte NOPs
        .byte $1A
        .byte $3A
        .byte $5A
        .byte $7A
        .byte $DA
        .byte $FA

        ; 2 byte NOPs
        .byte $04, $42
        .byte $14, $42
        .byte $34, $42
        .byte $44, $42
        .byte $54, $42
        .byte $64, $42
        .byte $74, $42
        .byte $80, $42
        .byte $82, $42
        .byte $89, $42
        .byte $C2, $42
        .byte $D4, $42
        .byte $E2, $42
        .byte $F4, $42

        ; 3 byte NOPs
        .byte $0C, $42, $42
        .byte $1C, $42, $42
        .byte $3C, $42, $42
        .byte $5C, $42, $42
        .byte $7C, $42, $42
        .byte $DC, $42, $42
        .byte $FC, $42, $42

        bne     erro

        lda     #'C'
        printchar
end:    endprog

erro:   lda     #'E'
        printchar
        jmp     end
