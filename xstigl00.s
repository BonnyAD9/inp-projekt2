; Autor reseni: Jmeno Prijmeni login
; Pocet cyklu k serazeni puvodniho retezce:
; Pocet cyklu razeni sestupne serazeneho retezce:
; Pocet cyklu razeni vzestupne serazeneho retezce:
; Pocet cyklu razeni retezce s vasim loginem:
; Implementovany radici algoritmus:
; ------------------------------------------------

; DATA SEGMENT
                .data
login:          .asciiz "vitejte-v-inp-2023"    ; puvodni uvitaci retezec
; login:          .asciiz "vvttpnjiiee3220---"  ; sestupne serazeny retezec
; login:          .asciiz "---0223eeiijnpttvv"  ; vzestupne serazeny retezec
; login:          .asciiz "xlogin00"            ; SEM DOPLNTE VLASTNI LOGIN
                                                ; A POUZE S TIMTO ODEVZDEJTE

test_print: .asciiz "test\n"
params_sys5:    .space  8   ; misto pro ulozeni adresy pocatku
                            ; retezce pro vypis pomoci syscall 5
                            ; (viz nize - "funkce" print_string)

; CODE SEGMENT
                .text
main:
        ; SEM DOPLNTE VASE RESENI


        ; daddi   r4, r0, login   ; vozrovy vypis: adresa login: do r4
        ; jal     print_string    ; vypis pomoci print_string - viz nize

        ; Insert sort

        ; $a0: current value
        ; $s0: first unsorted
        ; $s1, $s2: inner_4_more index
        ; $s3, $s4: inner_3_less index
        ; $s5: result index
        ; $t0: temporary
        ; $v0: 8
        lb $a0, login($zero)
        daddi $s0, $zero, 1
        ;;;;;;;;;;;;;;;;;;;;;
        beqz $a0, main_end

outer:
        daddi $s4, $s0, 0
        dsub $t1, $zero, $t1
        daddi $s3, $s0, -1
        daddi $s0, $s0, 1
        bgez $t1, inner_3_less
        ; $s1 $s2 --- $s3 $s4
        ;                 $s0
        ; $a0 = login1[$s0]
        ; $a1 = login1[$s1]
        ; $a2 = login4[$s1]

        ; andi $t0, $s4, 0x7
        ; beqz $t0, inner_4_uneaven

inner_4_uneaven:
        lb $a1, login($s3)
        andi $t2, $s4, 0x3
        dsub $t0, $a0, $a1
        sb $a1, login($s4)
        daddi $s1, $s4, -4
        ;;;;;;;;;;;;;;;;;;;;;
        bgez $t0, inner_end

        beqz $t2, inner_4_more

        daddi $s4, $s4, -1
        daddi $s3, $s3, -1
        ;;;;;;;;;;;;;;;;;;;;;
        bnez $s4, inner_4_uneaven

inner_4_more:
        lb $a1, login($s1)
        ;;;;;;;;;;;;;;;;;;;;;
        ;;;;;;;;;;;;;;;;;;;;;
        dsub $t0, $a0, $a1
        beqz $s4, inner_end
        daddi $s3, $s4, -1
        bgez $t0, inner_3_less

        lw $a2, login($s1)
        ;;;;;;;;;;;;;;;;;;;;;
        ;;;;;;;;;;;;;;;;;;;;;
        dsll $t0, $a2, 8
        ;;;;;;;;;;;;;;;;;;;;;
        ;;;;;;;;;;;;;;;;;;;;;
        sw $t0, login($s1)
        ;;;;;;;;;;;;;;;;;;;;;
        ;;;;;;;;;;;;;;;;;;;;;
        dsrl $t0, $a2, 24
        daddi $s1, $s1, -4
        ;;;;;;;;;;;;;;;;;;;;;
        sb $t0, login($s4)

        daddi $s4, $s4, -4
        bgez $s1, inner_4_more

        ;;;;;;;;;;;;;;;;;;;;;
        sb $a0, login($s4)
        lb $a0, login($s0)
        daddi $t1, $s0, -3
        ;;;;;;;;;;;;;;;;;;;;;
        bnez $a0, outer

inner_3_less:
        lb $a1, login($s3)
        ;;;;;;;;;;;;;;;;;;;;;
        ;;;;;;;;;;;;;;;;;;;;;
        dsub $t0, $a0, $a1
        sb $a1, login($s4)
        ;;;;;;;;;;;;;;;;;;;;;
        bgez $t0, inner_end

        daddi $s4, $s4, -1
        daddi $s3, $s3, -1
        ;;;;;;;;;;;;;;;;;;;;;
        bnez $s4, inner_3_less
inner_end:
        sb $a0, login($s4)
        lb $a0, login($s0)
        daddi $t1, $s0, -3
        ;;;;;;;;;;;;;;;;;;;;;
        bnez $a0, outer

main_end:
        daddi   r4, r0, login   ; vozrovy vypis: adresa login: do r4
        jal     print_string    ; vypis pomoci print_string - viz nize
        syscall 0   ; halt

print_string:   ; adresa retezce se ocekava v r4
                sw      r4, params_sys5(r0)
                daddi   r14, r0, params_sys5    ; adr pro syscall 5 musi do r14
                syscall 5   ; systemova procedura - vypis retezce na terminal
                jr      r31 ; return - r31 je urcen na return address
