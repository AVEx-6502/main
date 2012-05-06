.include "unittests/macros.inc"

.org $1000

; Isto serve para gastar um caracter, porque por
; algum motivo ele esta la apos o arranque do Qemu...
getchar


    lda     #'O'
    printchar
    lda     #'l'
    printchar
    lda     #'a'
    printchar
    lda     #$0A
    printchar
    lda     #$0A
    printchar
    jmp   start


function:
    lda     #'A'
    printchar
    jmp nextstuff
    
  previousstuff:
    lda     #'D'
    printchar
    lda     #'E'
    printchar
    jmp     laststuff
    
  nextstuff:
    lda     #'B'
    printchar
    lda     #'C'
    printchar
    jmp     previousstuff
    
  laststuff:
    lda     #'F'
    printchar
    rts



start:
    ldx   #$FF
    txs

    jsr   function
    
    lda   #$0A
    printchar
    tsx
    txa
    printnum


endprog

