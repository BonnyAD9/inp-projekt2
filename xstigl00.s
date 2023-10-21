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

params_sys5:    .space  8   ; misto pro ulozeni adresy pocatku
                            ; retezce pro vypis pomoci syscall 5
                            ; (viz nize - "funkce" print_string)

; CODE SEGMENT
                .text
main:
        ; SEM DOPLNTE VASE RESENI


        daddi   r4, r0, login   ; vozrovy vypis: adresa login: do r4
        jal     print_string    ; vypis pomoci print_string - viz nize

        ; Insert sort

        ; $s0: unsorted index
        ; $s1 - $s5: indexes
        ; $s7: result index
        ; $a0: current element
        ; $a1: saved element
        ; $t2 - $t5: elements
        ; $t0: temporary
        lb $a1, login($zero)
        daddi $s0, $zero, 1
        beqz $a1, main_end

        lb $a1, login($s0)
        beqz $a1, main_end
main_outer:
        dsub $t0, $zero, $s0
        daddi $s1, $s0, 0
        daddi $s2, $s0, -1
        daddi $t0, $t0, 3
        daddi $s0, $s0, 1
        bgez $t0, main_inner_3_less

        daddi $s3, $s1, -2
        daddi $s4, $s1, -3
        daddi $s5, $s1, -4

main_inner_4_more:
        ; $5 $4 $3 $2 $1
        lb $t2, login($s2)

        daddi $s7, $s1, 0
        dsub $t0, $a1, $t2
        lb $t3, login($s3)
        bgez $t0, main_inner_end

        sb $t2, login($s1)
        daddi $s7, $s2, 0
        dsub $t0, $a1, $t3
        daddi $s1, $s1, -4
        lb $t4, login($s4)
        bgez $t0, main_inner_end

        sb $t3, login($s2)
        daddi $s7, $s3, 0
        dsub $t0, $a1, $t4
        daddi $s2, $s2, -4
        lb $t5, login($s5)
        bgez $t0, main_inner_end

        sb $t4, login($s3)
        daddi $s7, $s4, 0
        dsub $t0, $a1, $t5
        daddi $s3, $s3, -4
        bgez $t0, main_inner_end

        sb $t5, login($s4)
        daddi $s5, $s1, -4
        daddi $s4, $s1, -3
        bgez $s5, main_inner_4_more

        ; unwrapped loop for 3 or less elements
        ; two consecutive iterations are unwrapped into single iteration
        ; first part of the loop is unwrapped
main_inner_3_less:
        ; loop 3: $s2 $s1
        daddi $s7, $s1, 0
        beqz $s1, main_inner_end

        lb $a0, login($s2)
        daddi $s3, $s2, -1

        dsub $t0, $a1, $a0
        bgez $t0, main_inner_end

        sb $a0, login($s1)
        daddi $s7, $s2, 0
        beqz $s2, main_inner_end

        daddi $s2, $s1, -1

        ; loop 2: $s3 $s2 ($s1)
        lb $a0, login($s3)
        daddi $s1, $s3, -1

        dsub $t0, $a1, $a0
        bgez $t0, main_inner_end

        daddi $s7, $s3, 0
        sb $a0, login($s2)
        beqz $s3, main_inner_end

        daddi $s1, $s2, -2
        daddi $s7, $s1, 0

        ; loop 1: $s1 $s3
        lb $a0, login($s1)

        dsub $t0, $a1, $a0
        bgez $t0, main_inner_end

        sb $a0, login($s3)

        ; now i know that this is the first element
        daddi $s7, $zero, 0

main_inner_end:
        lb $a3, login($s0)
        sb $a1, login($s7)
        daddi $a1, $a3, 0
        bnez $a3, main_outer

; outer_end


main_end:
        daddi   r4, r0, login   ; vozrovy vypis: adresa login: do r4
        jal     print_string    ; vypis pomoci print_string - viz nize
        syscall 0   ; halt

print_string:   ; adresa retezce se ocekava v r4
                sw      r4, params_sys5(r0)
                daddi   r14, r0, params_sys5    ; adr pro syscall 5 musi do r14
                syscall 5   ; systemova procedura - vypis retezce na terminal
                jr      r31 ; return - r31 je urcen na return address
