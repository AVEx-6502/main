.include "unittests/macros.inc"

.org $1000

ldx 	#$FF    ; Load stack pointer
txs
;jmp 	start


start:      ; Test 1 setup
			ldy		#41
			sty		$7FFE
			ldy		#42		; $2A
			sty		0
			ldx		#1

			; Test 1
			lda		$7FFD,X
			printnum			
			lda     #$0A
			printchar
						
			lda		$FF,X
			printnum
			lda     #$0A
			printchar

			inc		0			
			lda		$FFFF,X
			printnum
			lda     #$0A
			printchar
			
			; Test 2 setup
			ldy		#$3C
			sty		$FF
			ldy		#44
			sty		$2B3C
			ldx		#0
			
			; Test 2
			lda		($FF,X)
			printnum
			lda     #$0A
			printchar

			; Test 3 setup
			ldy		#45
			sty		$982B
			ldy		#$98
			sty		1
			ldx		#1
			
			; Test 3
			lda		($FF,X)
			printnum
			lda     #$0A
			printchar

			; Test 4 setup
			ldy		#$FE
			sty		$00FF
			ldy		#46
			sty		$2C21
			ldy		#$23
			
			; Test 4
			lda		($FF),Y
			printnum
			lda     #$0A
			printchar
			
			; Test 5 setup
			ldy		#(correct & $FF)
			sty		$5FFF
			ldy		#((correct >> 8) & $FF)
			sty		$5F00
			
			; Test 5
			jmp		($5FFF)
			
			
end:		endprog			
correct:	lda		#47
			printnum
			jmp		end			

