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

	; ~C, N, Z
	ldx		#$F0
	stx		6
	lda		#$0F
	bit		6
	jsr		update_flag_counts
	
	; ~C, N, ~Z
	ldx		#$FA
	stx		$4321
	lda		#$AF
	bit		$4321
	jsr		update_flag_counts			
			
	; ~C, ~N, Z
	ldx		#$70
	stx		42
	lda		#$0F
	bit		42
	jsr		update_flag_counts
		
	; ~C, N, ~Z
	ldx		#$75
	stx		$2040
	lda		#$5F
	bit		$2040
	jsr		update_flag_counts
	
	sec
	
	; C, N, Z
	ldx		#$F0
	stx		24
	lda		#$0F
	bit		24
	jsr		update_flag_counts
		
	; C, N, ~Z
	ldx		#$FA
	stx		$4020
	lda		#$AF
	bit		$4020
	jsr		update_flag_counts			
			
	; C, ~N, Z
	ldx		#$70
	stx		24
	lda		#$0F
	bit		24
	jsr		update_flag_counts
		
	; C, N, ~Z
	ldx		#$75
	stx		$4020
	lda		#$5F
	bit		$4020
	jsr		update_flag_counts
	
	lda		0
	printnum		; 4
	lda		1
	printnum		; 4
	lda		2
	printnum		; 4
	lda		3
	printnum		; 4
	lda		4
	printnum		; 4
	lda		5
	printnum		; 4

end:brk



; Results (memory):
; 0 - flag Z count
; 1 - flag ~Z count		
; 2 - flag N count
; 3 - flag ~N count
; 4 - flag C count
; 5 - flag ~C count

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
ufc_check_c:		bcc		ufc_c0
					bcs		ufc_c1
ufc_c0:				inc		5
					rts					
ufc_c1:				inc		4
					rts					

