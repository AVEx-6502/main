.macro lsrn    Oper, Count
    .repeat Count
        lsr Oper
    .endrepeat
.endmacro

.macro printbitn   Val, N
    lda Val
    lsrn A, N
    and #1
    clc
    adc #'0'
    printchar
.endmacro


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

endprog_opcode = $0F
.macro endprog
  .byte endprog_opcode
.endmacro