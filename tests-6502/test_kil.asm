.org $1000

jmp 	start

text_start:	.byte	"Started.", $0A, 0
text_nosee:	.byte	"You shouldn't see this!", $0A, 0
text_nmi:	.byte	"NMI", $0A, 0
text_irq:	.byte	"IRQ", $0A, 0
text_rst:	.byte	"RST", $0A, 0


start:		ldx 	#$FF    ; Load stack pointer
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

			cli				; Enable interrupts

			lda		#text_start-$1000
			jsr		print_string

			.byte	$42		; KIL
			
			lda		#text_nosee-$1000
			jsr		print_string
end:		jmp		end
			




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

