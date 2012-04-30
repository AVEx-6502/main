.macro printnum character
  .byte $DF
.endmacro

.macro printchar character
  .byte $FF
.endmacro



.org $1000

ldx	#$FF
txs
jmp start

text:	.byte   "Hello World!", 0


start:	lda		#text-$1000
		jsr		print_string
		lda		#$0A
		printchar
		
		lda		#20
		pha
		lda		#5
		jsr		mult
		pla
		printnum
		lda		#$0A
		printchar
		
		lda		#5
		jsr		fact
		printnum		
		lda		#$0A
		printchar
		
		lda		#12
		jsr		fib
		printnum
		lda		#$0A
		printchar

end:	brk



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
			printchar
			inx
			jmp		ps_loop
ps_end:		pla
			tax
			pla
			rts
								
		
; AC - num1
; Stack 1 - num2
; Return: Stack 1
mult:		
			pha				; Save AC and X
			txa
			pha			
			tsx				; X - SP
			lda		#0		; AC - result		
mu_loop:	dec		$105,x	; num2--
			bmi		mu_end	; br.n
			clc
			adc		$102,x	; AC += num1
			jmp		mu_loop
mu_end:		sta		$105,x
			pla
			tax
			pla
			rts							
		
		
; AC - num
; Return: AC		
fact:
			cmp		#0
			beq		fact_a0
			pha
			sec
			sbc		#1
			jsr		fact
			jsr		mult
			pla
			rts			
fact_a0:	lda		#1
			rts
		
; AC - num
; Return: AC				
fib:		cmp		#2
			bmi		fib_end
			pha					; Save AC and X
			txa
			pha
			tsx					; X - SP
			lda		$102,x		; Restore AC
			sec
			sbc		#1
			jsr		fib			
			pha					; Push fib(AC-1)
			lda		$102,x
			sec
			sbc		#2
			jsr		fib			; AC = fib(AC-2)
			clc
			adc		$100,x		; AC = fib(AC-1) + fib(AC-2)					
			sta		$102,x			
			; Can be done this way
			pla					; AC = fib(AC-1)
			pla					; AC = X
			tax					; Restore X
			pla					; Restore Saved result
			; or this way
			;lda		$101,x		; AC = X			
			;inx
			;txs					; Restore SP
			;tax					; Restore X			
			;pla					; Restore saved result		
fib_end:	rts
		

		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
