.include "unittests/macros.inc"

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
    jsr     test_acc
    jsr     test_zpg
    jsr     test_zpgX
    jsr     test_abs
    jsr     test_absX
    jmp     exit


    
    
    

test_acc:
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
    rts

test_zpg:
    ldy     #0          ;$1025
    lda     #1
    sta     $03
 @loop:
    ldx     #shiftby-$1000
    jsr     printstring     ; "shifted by"...
    tya
    printnum                ; amount of shifts
    iny
    ldx     #rest-$1000
    jsr     printstring     ; ": "...
    lda     $03
    printnum                ; resultant number
    lda     #$0A
    printchar               ; newline for next shift
    asl     $03
    bne     @loop       ; We are goint to shift and print until the result of the shift is 0...

    rts

test_zpgX:
    ldy     #0          ;$1025
    lda     #1
    sta     $03
 @loop:
    ldx     #shiftby-$1000
    jsr     printstring     ; "shifted by"...
    tya
    printnum                ; amount of shifts
    iny
    ldx     #rest-$1000
    jsr     printstring     ; ": "...
    lda     $03
    printnum                ; resultant number
    lda     #$0A
    printchar               ; newline for next shift
    ; this will actually work by luck, but X (and Y too) is suposed to be unsigned when used in addressing modes
;    ldx     #-6
;    asl     $03+6,X
    ldx     #0
    asl     $03,X


    bne     @loop       ; We are goint to shift and print until the result of the shift is 0...

    rts


test_abs:
    ldy     #0          ;$1025
    lda     #1
    sta     $0203
 @loop:
    ldx     #shiftby-$1000
    jsr     printstring     ; "shifted by"...
    tya
    printnum                ; amount of shifts
    iny
    ldx     #rest-$1000
    jsr     printstring     ; ": "...
    lda     $0203
    printnum                ; resultant number
    lda     #$0A
    printchar               ; newline for next shift
    asl     $0203
    bne     @loop       ; We are goint to shift and print until the result of the shift is 0...

    rts

test_absX:
    ldy     #0          ;$1025
    lda     #1
    sta     $0204
 @loop:
    ldx     #shiftby-$1000
    jsr     printstring     ; "shifted by"...
    tya
    printnum                ; amount of shifts
    iny
    ldx     #rest-$1000
    jsr     printstring     ; ": "...
    lda     $0204
    printnum                ; resultant number
    lda     #$0A
    printchar               ; newline for next shift
    ldx     #0
    asl     $0204,X
    bne     @loop       ; We are goint to shift and print until the result of the shift is 0...
    rts






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
endprog

