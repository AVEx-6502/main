.macro printflags character
  .byte $BF
.endmacro
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


start:
	; Accumulator test
    lda     #43
    printflags
    printnum
    rol     A
    printflags
    printnum
    rol     A
    printflags    
    printnum
    rol     A
    printflags
    printnum
    
    clc
    lda     #$0A        
    printchar  
          
    ; Memory test   
    lda     #43
    printflags
    sta		$2040
    printnum
    rol     $2040
    printflags
    lda		$2040
    printnum
    ldx     #6
    rol     $2040-6,X
    printflags
    lda		$2040
    printnum
    sta     $40
    ldx     #1
    rol     $3F,X
    printflags
    lda		$40
    printnum


    
    
 jmp right
 right:
    lda     #43
    printnum
    ror     A
    printnum
    ror     A
    printnum
    ror     A
    printnum
    
    
    
    
    
    lda     #43
    sta     42
    printnum
    rol     42
    printnum
    rol     42
    printnum
    rol     42
    printnum
    
    lda     #43
    sta     42
    printnum
    ror     42
    printnum
    ror     42
    printnum
    ror     42
    printnum
    
    
    
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

