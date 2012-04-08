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

	; Test page zero stores

	; 1 - sta nn
	lda		#42
	sta		1
	
	; 2 - sta nn,x
	lda		#43
	ldx		#1
	sta		1,x

	; 3 - sta nnnn,y
	lda		#44
	ldy		#2
	sta		1,y		; This actually calls the non-zero-page instruction: sta nn,y doesn't exist

	; 4 - stx nn
	ldx		#45
	stx		4
	
	; 5 - stx nn,y
	ldx		#46
	ldy		#2
	stx		3,y
	
	; 6 - sty nn
	ldy		#47
	sty		6
	
	; 7 - sty nn,x
	ldy		#48
	ldx		#4
	sty		3,x
	
	; 8 - sta nn,x with overflow
	lda		#49
	ldx		#255
	sta		9,x

	; 9 - sta nn,x with overflow
	lda		#50
	ldx		#254
	sta		11,x	; Same as previous: sta nn,y doesn't exist

	; 10 - stx nn,y with overflow
	ldx		#51
	ldy		#255
	stx		11,y

	; 11 - sty nn,x with overflow
	ldy		#52
	ldx		#254
	sty		13,x
	
	;	Memory State	
	;	0		1		2		3		4		5		6		7		8		9		10		11
	;	0		42		43		44		45		46		47		48		49		50		51		52

	lda		#0
	ldx		#0
	ldy		#0
	
	; Test page zero loads
	
	; 1 - lda nn
	lda		1
	printnum
    lda     #' '
    printchar
	
	; 2 - lda nn,x
	ldx		#1
	lda		1,x
	printnum
    lda     #' '
    printchar	
	
	; 3 - ldx nn
	ldx		3
	txa
	printnum
    lda     #' '
    printchar	
	
	; 4 - ldx nn,y
	ldy		#2
	ldx		2,y
	txa
	printnum
    lda     #' '
    printchar
    	
	; 5 - ldy nn
	ldy		5
	tya
	printnum	
    lda     #' '
    printchar
    
	; 6 - ldy nn,x
	ldx		#3
	ldy		3,x
	tya
	printnum
    lda     #' '
    printchar
    
	; 7 - lda nn,x with overflow
	ldx		#254
	lda		9,x
	printnum	
    lda     #' '
    printchar
    	
	; 8 - ldx nn,y with overflow
	ldy		#253
	ldx		11,y
	txa
	printnum
    lda     #' '
    printchar
    
	; 9 - ldy nn,x with overflow
	ldx		#252
	ldy		13,x
	tya
	printnum
    lda     #' '
    printchar
    
	; 10 - lda nn
	lda		10
	printnum
    lda     #' '
    printchar
    
	; 11 - lda nn
	lda		11
	printnum
    lda     #$0A
    printchar
    
    ; Output esperado: 42 43 44 45 46 47 48 49 50 51 52
    
end:	jmp end
	
