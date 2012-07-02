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

printflags_opcode = $32
getnum_opcode = $52
printnum_opcode = $72
getchar_opcode = $92
printchar_opcode = $B2
endprog_opcode = $D2

.macro printflags character
  .byte printflags_opcode
.endmacro
.macro getnum character
  .byte getnum_opcode
.endmacro
.macro printnum character
  .byte printnum_opcode
.endmacro
.macro getchar character
  .byte getchar_opcode
.endmacro
.macro printchar character
  .byte printchar_opcode
.endmacro
.macro endprog
  .byte endprog_opcode
.endmacro
