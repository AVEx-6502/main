.include "unittests/macros.inc"


.org $1000

; Isto serve para gastar um caracter, porque por
; algum motivo ele esta la apos o arranque do Qemu...
getchar

		lda 	#100
loop:	printnum
		tax
		lda		#$0A
		printchar
		txa
		sec
		sbc		#1
out:	beq		end
		jmp		loop


end:endprog
