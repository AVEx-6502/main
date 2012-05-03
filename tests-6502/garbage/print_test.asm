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



; Isto serve para gastar um caracter, porque por
; algum motivo ele esta la apos o arranque do Qemu...
getchar


lda     #'J'
printchar
lda     #'o'
printchar
lda     #'a'
printchar
lda     #'o'
printchar
lda     #$0A
printchar
lda     #$0A
printchar
lda     #':'
printchar
lda     #' '
printchar
printchar

;getnum
adc   #50
printnum

lda     #$0A
printchar







brk

