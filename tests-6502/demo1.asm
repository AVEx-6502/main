.org $1000

ldx #$FF    ; Load stack pointer
txs
jmp start

; RO Data area
;-------------
;

menu_text:  .byte "Choose an option:", $0A
            .byte " 1 - Multiplication", $0A
            .byte " 2 - Factorial", $0A
            .byte " 3 - Fibonacci", $0A
            .byte " 4 - String info", $0A
            .byte " 5 - Exit", $0A, $0A, 0
invalid_text: .byte "Invalid option.", $0A, $0A, 0
goodbye_text: .byte "Goodbye!", 0
ask_number_text: .byte "Insert a number: ", 0
ask_number1_text: .byte "Insert the first number: ", 0
ask_number2_text: .byte "Insert the second number: ", 0
result_text: .byte "The result is ", 0
mult_text: .byte "Multiplication", $0A, $0A, 0
fact_text: .byte "Factorial", $0A, $0A, 0
fib_text: .byte "Fibonacci", $0A, $0A, 0

opt_jmp_table: .word opt_mult, opt_fact, opt_fib, opt_string, opt_exit

; Code area
;----------
;
opt_inv:    lda     #invalid_text-$1000
            jsr     print_string
start:      lda     #menu_text-$1000        ; Display menu
            jsr     print_string
read_opt:   lda     $FE00
            beq     read_opt
            cmp     #'6'                    ; Check for invalid keys
            bcs     opt_inv
            cmp     #'1'
            bcc     opt_inv
            sec                             ; Compute index of jump table
            sbc     #'1'
            asl
            tax                             ; Store jump location at 0
            lda     opt_jmp_table,X
            sta     0
            inx
            lda     opt_jmp_table,X
            sta     1
            jmp     ($0000)                 ; Jump to it



opt_mult:   lda     #mult_text-$1000
            jsr     print_string
            lda     #1
            sta     $FE01           ; Enable echo
            lda     #ask_number1_text-$1000
            jsr     print_string
            jsr     read_number
            txa
            pha                                 ; push num1
            lda     #ask_number2_text-$1000
            jsr     print_string
            jsr     read_number
            txa                                 ; AC = num2
            jsr     mult
            lda     #result_text-$1000
            jsr     print_string
            pla
            jsr     print_number
            lda     #$0A
            sta     $FE00
            sta     $FE00
            lda     #0
            sta     $FE01           ; Disable echo
            jmp     start

opt_fact:   lda     #fact_text-$1000
            jsr     print_string
            lda     #1
            sta     $FE01           ; Enable echo
            lda     #ask_number_text-$1000
            jsr     print_string
            jsr     read_number
            txa
            jsr     fact
            pha
            lda     #result_text-$1000
            jsr     print_string
            pla
            jsr     print_number
            lda     #$0A
            sta     $FE00
            sta     $FE00
            lda     #0
            sta     $FE01           ; Disable echo
            jmp     start

opt_fib:    lda     #fib_text-$1000
            jsr     print_string
            lda     #1
            sta     $FE01           ; Enable echo
            lda     #ask_number_text-$1000
            jsr     print_string
            jsr     read_number
            txa
            jsr     fib
            pha
            lda     #result_text-$1000
            jsr     print_string
            pla
            jsr     print_number
            lda     #$0A
            sta     $FE00
            sta     $FE00
            lda     #0
            sta     $FE01           ; Disable echo
            jmp     start


opt_string: jmp     start

opt_exit:   lda     #goodbye_text-$1000
            jsr     print_string
end:        jmp     end


; AC - number
print_number:   pha         ; Save registers
                txa
                pha
                tya
                pha
                tsx
                ldy     $103,X  ; Restore AC to Y
                ; Discover largest part of number
                cpy     #100
                bcs     pn_hunds
                cpy     #10
                bcs     pn_tens
                jmp     pn_units
pn_hunds:       lda     #100
                jsr     pn_part
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
; This function will print part of AC: hundreds, tens or units
; The part printed must be the largest part the number has
pn_part:        sta     $FE,X
                tya
                ldy     #'0'
pn_part_loop:   cmp     $FE,X
                bcc     pn_part_print
                sec
                sbc     $FE,X
                iny
                jmp     pn_part_loop
pn_part_print:  sty     $FE00
                tay
                rts



; Return X
read_number:    pha             ; Save AC
                ldx     #0
rn_read_char:   lda     $FE00
                beq     rn_read_char
                cmp     #('9'+1)                ; Only accept numbers
                bcs     rn_end
                cmp     #'0'
                bcc     rn_end
                sbc     #'0'
                pha             ; Save value
                lda     #10     ; AC = X * 10
                pha
                txa
                jsr     mult
                pla
                tsx             ; AC += saved value
                adc     $101,X
                tax
                pla
                jmp     rn_read_char
rn_end:         pla
                rts



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
            sta     $FE00
            inx
            jmp     ps_loop
ps_end:     pla
            tax
            pla
            rts



; AC - address (string saved to address AC)
read_string: pha        ; Save AC and X
             txa
             pha
             tsx
             lda        $102,X      ; X has the address
             tax
rs_read_ch:  lda    $FE00
             beq    rs_read_ch
             sta    $0,X            ; Save char
             inx                    ; Increment index
             cmp    #$0A            ; \n ?
             bne    rs_read_ch
rs_end:      dex                    ; Overwrite saved \n
             lda    #0              ; Save string terminator
             sta    $0,X
             pla
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

