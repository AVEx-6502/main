.org $1000

ldx 	#$FF    ; Load stack pointer
txs
jmp 	start

text:       .byte   "Waiting for interrupt...", $0A, 0
inintr:     .byte   "Handling interrupt.", $0A, 0
text2:	    .byte	"Interrupt happened!", $0A, 0
moreints:   .byte   "More interrupts each second...", $0A, 0


start:	lda		#(intr_handler & $FF)
		sta		$FF00
		lda		#((intr_handler >> 8) & $FF)
		sta		$FF01
		lda		#50		; 5 seconds
		sta		$FE02
        lda     #text-$1000
        jsr     print_string
loop:	lda		0
		beq		loop
out:	lda		#text2-$1000
		jsr		print_string
    	lda     1
        cmp     #10
        beq     end
        
        lda     #moreints-$1000
        jsr     print_string
        lda     #0
        sta     0
        lda     #10     ; 5 seconds
        sta     $FE02
        jmp     loop
        
end:    jmp		end



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



intr_handler:
	pha
    lda     #inintr-$1000
    jsr     print_string
	lda		#1
	sta		0
	inc     1
	pla
	rti
		
