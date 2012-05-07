.include "unittests/macros.inc"


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
    jmp     start


; Data area...
myarray = 0

start:
  lda #'Q'
  sta 0
  sta 1
  sta 2
  sta 3
  sta 4

  ; Print the whole array
  ldx     #0
  lda     myarray,X
  printchar
  lda     #'Z'
  ldy     #1
  lda     myarray,y
  printchar
  lda     #'Z'
  lda     myarray+2
  printchar
  lda     #'Z'
  ldx     myarray+3
  txa
  printchar
  lda     #'Z'
  ldy     myarray+4
  tya
  printchar
  lda     #'Z'
  
  nop
  lda     #$0A
  nop
  printchar
  nop
  
  ;Replace the array chars by other chars using different registers...
  lda     #'A'
  ldx     #0
  sta     myarray,x
  lda     #'B'
  ldy     #1
  sta     myarray,y
  lda     #'C'
  sta     myarray+2
  ldx     #'D'
  stx     myarray+3
  ldy     #'E'
  sty     myarray+4
 
 
   ; Print the whole array
  ldx     #0
  ldy     myarray,x
  tya
  printchar
  lda     #'Z'
  ldy     #1
  ldx     myarray,y
  txa
  printchar
  lda     #2
  tay
  lda     #'Z'
  lda     myarray,y
  printchar
  lda     #3
  tax
  lda     #'Z'
  lda     myarray,x
  printchar
  lda     #'Z'
  ldy     myarray+4
  tya
  printchar
  lda     #'Z'


endprog

