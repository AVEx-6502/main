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
getchar                 ;$1000
    ldx   #$FF          ;$1001
    txs                 ;$1003
    lda     #'O'        ;$1004
    printchar           ;$1006
    lda     #'l'        ;$1007
    printchar           ;$1009
    lda     #'a'        ;$100A
    printchar           ;$100C
    lda     #$0A        ;$100D
    printchar           ;$100F
    lda     #$0A        ;$1010
    printchar           ;$1012
    jmp   start         ;$1013

; Data area...
shiftby:
    .byte   "Shifted by ", 0
rest:
    .byte   ": ", 0


start:
    ldy     #0          ;$1025
    lda     #1
    pha
 @loop:
    ldx     #shiftby-$1000
    jsr     printstring     ; "shifted by"...
    tya
    printnum                ; amount of shifts
    iny
    ldx     #rest-$1000
    jsr     printstring     ; ": "...
    pla
    printnum                ; resultant number
    pha
    lda     #$0A
    printchar               ; newline for next shift
    pla
    asl     A
    pha                     ; NOTE: this instruction does not affect the flags...
    bne     @loop       ; We are goint to shift and print until the result of the shift is 0...

    pla
    jmp     exit


; X - low byte of string address...
printstring:
    pha                 ;$1043
 @loop:
    lda     $1000,X
    beq     @ret
    printchar
    inx
    jmp     @loop
 @ret:
    pla
    rts

    
exit:
lda   #$0A
printchar
tsx
txa
printnum
lda   #$0A
printchar
brk

