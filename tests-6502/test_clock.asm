.org $1000

			ldx 	#$FF    ; Load stack pointer
			txs
			jmp 	start


start:		lda		#(intr_handler & $FF)
			sta		$FFFE
			lda		#((intr_handler >> 8) & $FF)
			sta		$FFFF
			lda		#10		; 1 second
			sta		$FE02
print_time:
			; Print hours
			lda		0
			jsr		print_number
			lda		#':'
			sta		$FE00
			; Print minutes
			lda		1
		    jsr		print_number		
			lda		#':'
			sta		$FE00		
			; Print seconds
			lda		2
		    jsr		print_number
		    ; Wait for interrupt
loop:		cmp		2
			beq		loop
			; Set the interrupt again
			lda		#10		; 1 second
			sta		$FE02
			; Fix the time if needed
			lda		2
			cmp		#60		
			bcc		min_chk
			inc		1
			lda		#0
			sta		2
min_chk:	lda		1
			cmp		#60		
			bcc		chk_done
			inc		0
			lda		#0
			sta		1			
chk_done:	lda		#$0D
			sta		$FE00
			jmp		print_time	




; AC - number (up to 99, always prints 2 digits)
print_number:   pha         ; Save registers
                txa
                pha
                tya
                pha
                tsx
                ldy     $103,X  ; Restore AC to Y
pn_tens:        lda     #10
                jsr     pn_part
pn_units:       lda     #1
                jsr     pn_part
pn_end:         pla
                tay
                pla
                tax
                pla
                rts
; This function will print part of AC: tens or units
; The part printed must be the largest part the number has
pn_part:        pha
                tya
                ldy     #'0'
pn_part_loop:   cmp     a:$FE,X
                bcc     pn_part_print
                sec
                sbc     a:$FE,X
                iny
                jmp     pn_part_loop
pn_part_print:  sty     $FE00
                tay
                pla
                rts





intr_handler:
	inc		2
	rti






