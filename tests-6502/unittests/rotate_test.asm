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
    jmp   start         ;$1013	; Accumulator test
    lda     #43
    printnum
    printflags
    rol     A
    printnum
    printflags
    rol     A
    printnum
    printflags
    rol     A
    printnum
    printflags
    rol     A
    printnum
    printflags
    rol     A
    printnum
    printflags
    rol     A
    printnum
    printflags
    rol     A
    printnum
    printflags
    rol     A
    printnum
    printflags
    
    clc
    lda     #$0A        
    printchar  
          
    ; Memory test   
    lda     #43
    sta		$2040
    printnum
    printflags
    rol     $2040
    lda		$2040
    printnum
    printflags
    rol     $2040
    lda		$2040
    printnum
    printflags
    rol     $2040
    lda		$2040
    printnum
    printflags
    rol     $2040
    lda		$2040
    printnum
    printflags
    rol     $2040
    lda		$2040
    printnum
    printflags
    rol     $2040
    lda		$2040
    printnum
    printflags
    rol     $2040
    lda		$2040
    printnum
    printflags
    rol     $2040
    lda		$2040
    printnum
    printflags


; Data area...


start:
	; Accumulator test
    lda     #43
    printnum
    printflags
    rol     A
    printnum
    printflags
    rol     A
    printnum
    printflags
    rol     A
    printnum
    printflags
    rol     A
    printnum
    printflags
    rol     A
    printnum
    printflags
    rol     A
    printnum
    printflags
    rol     A
    printnum
    printflags
    rol     A
    printnum
    printflags
    
    clc
    lda     #$0A        
    printchar  
          
    ; Memory test   
    lda     #43
    sta		$2040
    printnum
    printflags
    rol     $2040
    lda		$2040
    printnum
    printflags
    rol     $2040
    lda		$2040
    printnum
    printflags
    rol     $2040
    lda		$2040
    printnum
    printflags
    rol     $2040
    lda		$2040
    printnum
    printflags
    rol     $2040
    lda		$2040
    printnum
    printflags
    rol     $2040
    lda		$2040
    printnum
    printflags
    rol     $2040
    lda		$2040
    printnum
    printflags
    rol     $2040
    lda		$2040
    printnum
    printflags

    clc
    lda     #$0A        
    printchar 
    
    
 jmp right
 right:
 
 	; Accumulator test
    lda     #43
    printnum
    printflags
    ror     A
    printnum
    printflags
    ror     A
    printnum
    printflags
    ror     A
    printnum
    printflags
    ror     A
    printnum
    printflags
    ror     A
    printnum
    printflags
    ror     A
    printnum
    printflags
    ror     A
    printnum
    printflags
    ror     A
    printnum
    printflags
    
    clc
    lda     #$0A        
    printchar     
    
    
    ; Memory test   
    lda     #43
    sta		$2040
    printnum
    printflags
    ror     $2040
    lda		$2040
    printnum
    printflags
    ror     $2040
    lda		$2040
    printnum
    printflags
    ror     $2040
    lda		$2040
    printnum
    printflags
    ror     $2040
    lda		$2040
    printnum
    printflags
    ror     $2040
    lda		$2040
    printnum
    printflags
    ror     $2040
    lda		$2040
    printnum
    printflags
    ror     $2040
    lda		$2040
    printnum
    printflags
    ror     $2040
    lda		$2040
    printnum
    printflags
    
    
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
endprog

