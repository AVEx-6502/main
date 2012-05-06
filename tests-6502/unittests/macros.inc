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

.macro endprog
  .byte $0F
.endmacro