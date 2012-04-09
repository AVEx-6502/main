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



	;  A1 nn     nz----  6   LDA (nn,X)  Load A with (Indirect,X)  A=[WORD[nn+X]]
	;  B1 nn     nz----  5*  LDA (nn),Y  Load A with (Indirect),Y  A=[WORD[nn]+Y]

	;  81 nn     ------  6   STA (nn,X)  Store A in (Indirect,X)  [[nn+x]]=A
	;  91 nn     ------  6   STA (nn),Y  Store A in (Indirect),Y  [[nn]+y]=A




	;
	;	Indirect X test
	;

	; Load data address 0x2040 in page 0 at 10
	lda 	#$40
	sta		10	
	lda		#$20
	sta		11	

	; 1 - sta (nn,x)
	ldx		#0
	lda		#42
	sta		(10,x)	

	lda 	#0
	
	; 2 - lda (nn,x)
	ldx		#10
	lda		(0,x)
	printnum
    lda     #' '
    printchar	
    	
	; 3 - sta (nn,x)
	ldx		#1
	lda		#43
	sta		(9,x)	

	; 4 - lda (nn,x)
	ldx		#0
	lda		(10,x)
	printnum
    lda     #' '
    printchar	
    
	; 5 - sta (nn,x) with overflow
	ldx		#16
	lda		#44
	sta		(250,x)	

	; 6 - lda (nn,x) with overflow
	ldx		#254
	lda		(12,x)
	printnum	
    lda     #' '
    printchar	

	;
	;	Indireect Y test
	;

	; Load data address 0xFFFE in page 0 at 20
	lda 	#$FE
	sta		20	
	lda		#$FF
	sta		21	

	; 1 - sta (nn),y
	ldy		#0
	lda		#45
	sta		(20),y	

	; 2 - sta (nn),y
	ldy		#1
	lda		#46
	sta		(20),y	

	; 3 - sta (nn),y - with overflow
	ldy		#2
	lda		#47
	sta		(20),y	

	; 4 - sta (nn),y - with overflow
	ldy		#3
	lda		#48
	sta		(20),y	

	; 5 - lda (nn),y
	ldy		#0
	lda		(20),y
	printnum
    lda     #' '
    printchar	
	
	; 6 - lda (nn),y
	ldy		#1
	lda		(20),y
	printnum
    lda     #' '
    printchar	
    
	; 7 - lda (nn),y with overflow
	ldy		#2
	lda		(20),y
	printnum
    lda     #' '
    printchar	
    	
	; 8 - lda (nn),y with overflow
	ldy		#3
	lda		(20),y
	printnum
    lda     #' '
    printchar		

    ; Output esperado: 42 43 44 45 46 47 48
    
end:	jmp end


	
