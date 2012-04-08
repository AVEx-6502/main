.macro getnum character
  .byte $CF
.endmacro
.macro printnum character
  .byte $DF
.endmacro
.macro getchar character
  .byte $EF
.endmacro
.macro printchar character
  .byte $FF
.endmacro

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


brk

