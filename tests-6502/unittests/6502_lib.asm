.include "unittests/macros.inc"



.org $1000

ldx #$FF
txs
jmp start

text:   .byte   "Hello World!", 0


start:  lda     #text-$1000
        jsr     print_string
        lda     #$0A
        printchar

        ldx     #text-$1000
        jsr     strlen
        txa
        printnum
        lda     #$0A
        printchar


        lda     #20
        pha
        lda     #5
        jsr     mult
        pla
        printnum
        lda     #$0A
        printchar

        lda     #5
        jsr     fact
        printnum
        lda     #$0A
        printchar

        lda     #12
        jsr     fib
        printnum
        lda     #$0A
        printchar

end:    endprog



; X - address (string in $1000+X)
; Return X
strlen:  pha        ; Save AC
         txa
         pha        ; Save start address
sl_loop: lda        $1000,X
         beq        sl_end
         inx
         jmp        sl_loop
sl_end:  txa        ; AC = end address
         tsx
         sec
         sbc        $101,X       ; AC = End address - start address
         tax
         pla
         pla
         rts



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
            printchar
            inx
            jmp     ps_loop
ps_end:     pla
            tax
            pla
            rts


; AC - num1
; Stack 1 - num2
; Return: Stack 1
mult:       pha             ; Save AC and X
            txa
            pha
            tsx             ; X - SP
            lda     #0      ; AC - result
mu_loop:    pha
            lda     $105,x
            sec
            sbc     #1
            sta     $105,x
            pla
            bcc     mu_end
            clc
            adc     $102,x  ; AC += num1
            jmp     mu_loop
mu_end:     sta     $105,x
            pla
            tax
            pla
            rts


; AC - num
; Return: AC
fact:       cmp     #0
            beq     fact_a0
            pha
            sec
            sbc     #1
            jsr     fact
            jsr     mult
            pla
            rts
fact_a0:    lda     #1
            rts


; AC - num
; Return: AC
fib:        cmp     #2
            bcc     fib_end
            pha                 ; Save AC and X
            txa
            pha
            tsx                 ; X - SP
            lda     $102,x      ; Restore AC
            sec
            sbc     #1
            jsr     fib
            pha                 ; Push fib(AC-1)
            lda     $102,x
            sec
            sbc     #2
            jsr     fib         ; AC = fib(AC-2)
            clc
            adc     $100,x      ; AC = fib(AC-1) + fib(AC-2)
            sta     $102,x
            pla                 ; AC = fib(AC-1)
            pla                 ; AC = X
            tax                 ; Restore X
            pla                 ; Restore Saved resultt
fib_end:    rts

