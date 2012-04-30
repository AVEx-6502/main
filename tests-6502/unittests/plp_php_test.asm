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
getchar

start:	ldx		#$FF
		txs
loop:	pha
		ldy		#1	; Clear flags
		clc
		clv
		plp
		php
		jsr		update_flag_counts
		; Compare the value saved by PHP with the value in AC
		pha				
		ora		#$30		; Some bits are always 1 or always 0 (Change this test when the remaining flags are implemented)
		and		#$F3
		cmp		$100,X
		bne		end
		pla					; Remove junk from stack, increment AC and loop again
		tay
		iny
		beq		res
		pla
		tya
		jmp		loop

res:	lda		0	
		printnum		
		lda		1
		printnum		
		lda		2
		printnum		
		lda		3
		printnum		
		lda		4
		printnum		
		lda		5
		printnum		
		lda		6
		printnum
		lda		7
		printnum
end:brk



; Results (memory):
; 0 - flag Z count
; 1 - flag ~Z count		
; 2 - flag N count
; 3 - flag ~N count
; 4 - flag C count
; 5 - flag ~C count
; 6 - flag V count
; 7 - flag ~V count

update_flag_counts:	bne		ufc_z0
					beq		ufc_z1
ufc_z0:				bpl		ufc_z0n0
					bmi		ufc_z0n1
ufc_z1:				bpl		ufc_z1n0
					bmi		ufc_z1n1
ufc_z0n0:			inc		1
					inc		3
					jmp		ufc_check_c					
ufc_z0n1:			inc		1
					inc		2
					jmp		ufc_check_c									
ufc_z1n0:			inc		0
					inc		3
					jmp		ufc_check_c					
ufc_z1n1:			inc		0
					inc		2
ufc_check_c:		bcs		ufc_c1
ufc_c0:				inc		5
					jmp		ufc_check_v
ufc_c1:				inc		4			
ufc_check_v:		bvs		ufc_v1
ufc_v0:				inc		7
					rts
ufc_v1:				inc		6
					rts			
					





