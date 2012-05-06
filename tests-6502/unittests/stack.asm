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



.macro showstackptr
    lda   #$0A
    printchar
    tsx
    txa
    printnum
.endmacro

start:
    showstackptr
    pha
    showstackptr
    pha
    showstackptr
    pha
    showstackptr
    pha
    showstackptr
    
    lda   #$0A
    printchar
    
    showstackptr
    pla
    showstackptr
    pla
    showstackptr
    pla
    showstackptr
    pla
    showstackptr
    
    lda   #$0A
    printchar
    lda   #$0A
    printchar
    
    showstackptr
    pla
    showstackptr
    pla
    showstackptr
    pla
    showstackptr
    pla
    showstackptr
    
    lda   #$0A
    printchar
    
    showstackptr
    pha
    showstackptr
    pha
    showstackptr
    pha
    showstackptr
    pha
    showstackptr
    
    lda   #$0A
    printchar
    lda   #$0A
    printchar
    
    ; Subrotinas...
    lda     #$00    ; Vamos pushar o PC mesmo mesmo na borda da página, para ver se isto rebenta...
    tax
    txs
    jsr     vamos
  vamos:
    lda     $01FF   ; Low byte
    ldx     #1
    cmp     #(vamos-1) & $FF
    bne     erro
    
    lda     $0100   ; High byte
    ldx     #2
    cmp     #(vamos-1) >> 8
    bne     erro

    ; Tweakar o valor e retornar...
    lda     #(voltemos-1) >> 8
    sta     $0100
    lda     #(voltemos-1) & $FF
    sta     $01FF
    rts
  voltemos:
    lda     #'B'
    printchar

    jmp exit

erro:
lda     #'E'
printchar
lda     #'R'
printchar
lda     #'R'
printchar
lda     #'O'
printchar
lda     #'!'
printchar
txa
printnum
showstackptr
lda   #$0A
printchar
lda     $01FF   ; Low byte
printnum
lda   #$0A
printchar
lda     $0100   ; High byte
printnum
    
exit:
lda   #$0A
printchar
endprog
