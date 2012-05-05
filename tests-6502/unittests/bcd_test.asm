; Testa o correcto overflow do stack pointer...


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

.macro newline character
  lda #$0A
  printchar
.endmacro

.org $1000

; Isto serve para gastar um caracter, porque por
; algum motivo ele esta la apos o arranque do Qemu...
getchar                 ;$1000
    ldx   #$FF          ;$1001
    txs                 ;$1003
    jmp   start         ;$1013

; Data area...


start:
    jsr     test_bcd
    jmp exit



test_bcd:
    sed
    ;Immediate add
    lda #$58
    adc #$34
    jsr     printhex    ; 92 (carry no)
    bcs     erro
    newline
    
    ;Memory add
    sed
    lda #$74
    sta $07
    lda #$58
    adc $07
    php
    jsr     printhex    ; 32 (carry yes)
    plp
    bcc     erro
    newline

    rts




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
    
    txa
    rts


erro:
lda #'E'
printchar
    
exit:
lda   #$0A
printchar
brk
