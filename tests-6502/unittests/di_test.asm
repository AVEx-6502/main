; Testa o correcto overflow do stack pointer...
.include "unittests/macros.inc"

.org $1000

; Isto serve para gastar um caracter, porque por
; algum motivo ele esta la apos o arranque do Qemu...
getchar                 ;$1000
    ldx   #$FF          ;$1001
    txs                 ;$1003
    jmp   start         ;$1013

; Data area...


start:

    cld
    cli
    php
    pla
    and     #%00011100
    jsr     printhex        ; 10
    lda     #' '
    printchar
    
    cld
    sei
    php
    pla
    and     #%00011100
    jsr     printhex        ; 14
    lda     #' '
    printchar
    
    sed
    sei
    php
    pla
    and     #%00011100
    jsr     printhex        ; 1C
    lda     #' '
    printchar
    
    sed
    cli
    php
    pla
    and     #%00011100
    jsr     printhex        ; 18
    lda     #' '
    printchar
    

    jmp exit


hexchars: .byte "0123456789ABCDEF"
printhex:
    tax
    lsr     A
    lsr     A
    lsr     A
    lsr     A
    and     #$0F
    tay
    lda     hexchars,y
    printchar
    
    txa
    and     #$0F
    tay
    lda     hexchars,y
    printchar
    
    rts

    
exit:
lda   #$0A
printchar
endprog
