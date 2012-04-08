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

    ldx   #$FF
    txs

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

exit_addr:
    .word exit


start:
    lda   #128
    cmp   #130
    bpl   erro  ; If plus
    lda   #'A'
    printchar
    
    lda   #128
    cmp   #125
    bmi   erro  ; If minus
    lda   #'B'
    printchar
    
    lda   #127
    cmp   #125
    beq   erro  ; If equal
    lda   #'C'
    printchar
    
    lda   #124
    cmp   #124
    beq   erro  ; If equal
    lda   #'C'
    printchar

    jmp   (exit_addr)






erro:
    lda   #'E'
    printchar
    lda   #'R'
    printchar
    lda   #'R'
    printchar
    lda   #'O'
    printchar
    lda   #'!'
    printchar
    lda   #'!'
    printchar
    lda   #'!'
    printchar
    lda   #$0A
    printchar

    
exit:
lda   #$0A
printchar
tsx
txa
printnum
brk

