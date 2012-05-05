.org	$1000
jmp start

str0:		"Write a string: "
str_hello:	.byte	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0; 


start:	lda		#str0-$1000
		jsr		print_string
		lda		#1
		sta		$FE01				; Enable echo
		lda		#str_hello-$1000
		jsr		read_string
		jsr		print_string
		lda		#0
		sta		$FE01				; Disable echo		
end:	jmp 	end


; AC - address
read_string: pha		; Save AC and X				
			 txa
			 pha
			 tsx			
			 lda		$102,X		; X has the address		
			 tax	 
rs_read_ch:  lda	$FE00
			 beq	rs_read_ch
			 sta	$1000,X			; Save char
			 inx				 	; Increment index
			 cmp	#$0A			; \n ?
			 bne	rs_read_ch
rs_end:		 dex					; Overwrite saved \n
			 lda	#0				; Save string terminator
			 sta	$1000,X
			 pla
			 tax
			 pla
			 rts
			


; AC - address
print_string:	
			pha		; Save AC and X				
			txa
			pha		
			tsx			
			lda		$102,X		; X has the address						
			tax
ps_loop:	lda		$1000,X		; Load char
			beq		ps_end		; br.z
			sta		$FE00
			inx
			jmp		ps_loop
ps_end:		pla
			tax
			pla
			rts


