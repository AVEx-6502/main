.org $1000

jmp 	start

text1:      .byte   "Interrupts ", 0
text_on:	.byte	"enabled!", $0A, 0
text_off:	.byte	"disabled!", $0A, 0
text_nmi:	.byte	"NMI", $0A, 0
text_irq:	.byte	"IRQ", $0A, 0
text_rst:	.byte	"RST", $0A, 0


start:		sty		0				; [0] holds the state of the interrups, 0 = disabled, 1 = enabled
			ldx 	#$FF    ; Load stack pointer
			txs
			
			; Setup the handlers for all types of interrupts
			lda		#(irq_handler & $FF)
			sta		$FFFE
			lda		#((irq_handler >> 8) & $FF)
			sta		$FFFF

			lda		#(rst_handler & $FF)
			sta		$FFFC
			lda		#((rst_handler >> 8) & $FF)
			sta		$FFFD		
		
			lda		#(nmi_handler & $FF)
			sta		$FFFA
			lda		#((nmi_handler >> 8) & $FF)
			sta		$FFFB		
		
            ldx		#text_off-$1000
            jmp		print_msg

wait_key:   lda     $FE00
            beq     wait_key
            
            lda		0
            bne		int_on				; If interrupts are off, turn them on otherwise turh them off
            inc		0					; Update state
            cli							; Enable interrupts
            ldx		#text_on-$1000
			jmp		print_msg
int_on:		dec		0					; Update state
			sei							; Disable interrupts
            ldx		#text_off-$1000
print_msg:	lda     #text1-$1000
		    jsr     print_string
		    txa
		    jsr     print_string
		    jmp		wait_key
			




; AC - address (string in $1000+AC)
print_string:
            pha     ; Save AC and X
            txa
            pha
            tsx
            lda     $102,X      ; X has the address
            tax
ps_loop:    lda     $1000,X     ; Load char
            beq     ps_end      ; br.z
            sta     $FE00
            inx
            jmp     ps_loop
ps_end:     pla
            tax
            pla
            rts



irq_handler:
	pha
    lda     #text_irq-$1000
    jsr     print_string
	pla
	rti
		
nmi_handler:
	pha
    lda     #text_nmi-$1000
    jsr     print_string
	pla
	rti
	
rst_handler:
	pha
    lda     #text_rst-$1000
    jsr     print_string
	jmp		start

