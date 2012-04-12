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
    

    jmp exit

    
exit:
lda   #$0A
printchar
brk
