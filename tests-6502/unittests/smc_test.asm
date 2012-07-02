.include "unittests/macros.inc"
.org $1000
; This tests the brk (break) instruction, and also some self-modifying code functionality.

; Isto serve para gastar um caracter, porque por
; algum motivo ele esta la apos o arranque do Qemu...
getchar                 ;$1000
    ldx   #$FF          ;$1001
    txs                 ;$1003
    jmp   start         ;$1013

; Data area...
ourstring: .byte "String printed from the main program!", $0A, 0

start:
    ; Copy code to modifiable address
    ldx     #start&$FF
 @cplp:
    cpx     #startend&$FF
    beq     @cpd
    lda     $1000,X
    sta     $2000,X
    inx
    jmp     @cplp
    
 @cpd: jmp     @cont+$1000
 @cont:
    lda     #printnum_opcode    ; printnum
    sta     invi+$1000
    
    lda     #74
 invi:   .byte $02   ; Invalid instruction
    
    ldx     #ourstring&$FF
    jsr     printstring

    jmp exit
startend:

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
endprog
