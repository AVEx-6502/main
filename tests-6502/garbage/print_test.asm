.include "unittests/macros.inc"



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
lda   #50
printnum
sta $01

lda     #$0A
printchar







endprog

