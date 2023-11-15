; Autor reseni: Jakub Antonín Štigler xstigl00
; Pocet cyklu k serazeni puvodniho retezce: 1092
; Pocet cyklu razeni sestupne serazeneho retezce: 1232
; Pocet cyklu razeni vzestupne serazeneho retezce: 223
; Pocet cyklu razeni retezce s vasim loginem: 251
; Implementovany radici algoritmus: Insert sort
; ------------------------------------------------

; DATA SEGMENT
                .data
login:          .asciiz "vitejte-v-inp-2023"    ; puvodni uvitaci retezec
; login:          .asciiz "vvttpnjiiee3220---"  ; sestupne serazeny retezec
; login:          .asciiz "---0223eeiijnpttvv"  ; vzestupne serazeny retezec
; login:          .asciiz "xstigl00"            ; SEM DOPLNTE VLASTNI LOGIN
                                                ; A POUZE S TIMTO ODEVZDEJTE

params_sys5:    .space  8   ; misto pro ulozeni adresy pocatku
                            ; retezce pro vypis pomoci syscall 5
                            ; (viz nize - "funkce" print_string)

; CODE SEGMENT
                .text
main:
        ; SEM DOPLNTE VASE RESENI

        ; Insert sort

        ; List of used registers and their usage/meaning:
        ; s0:     index of first unsorted item
        ; s1, s2: indexes
        ; a0:     inserted item
        ; a1, a2: items from login
        ; t0:     temorary (used in conditions)
        ; v1:     1
        ; v0:     2
        daddi $v1, $zero, 1
        daddi $v0, $zero, 2
        lb $a0, login($zero)
        daddi $s0, $zero, 2
        daddi $s1, $zero, 3
        beqz $a0, main_end
        daddi $s2, $zero, 1
        daddi $s3, $zero, 3
        lb $a1, login($v1)
        ; nop
        ; nop
        beqz $a1, main_end

        sltu $t0, $a1, $a0
        ; nop
        ; nop
        beqz $t0, outer
        sb $a0, login($v1)
        sb $a1, login($zero)

outer:
        lb $a1, login($s1)
        ; nop
        ; nop
        beqz $a1, single_prep
        sltu $t0, $a1, $a0
        ; nop
        ; nop
        beqz $t0, insert_double_prep
        lb $a1, login($s0)
        lb $a0, login($s1)

insert_double_prep:
        and $t0, $s2, $v1
        ; nop
        ; nop
        bnez $t0, insert_double_jmp
        lb $a2, login($s2)
        ; nop
        ; nop
        sltu $t0, $a1, $a2
        daddi $s4, $s2, 0
        daddi $s5, $s3, 0
        beqz $t0, insert_single_prep5
        sb $a2, login($s3)
        daddi $s2, $s2, -1
        daddi $s3, $s3, -1

        ; nop
insert_double_jmp:
        daddi $s4, $s2, -1
        daddi $s5, $s3, -1
        ; s4 s2 s5 s3
insert_double:
        lb $a2, login($s2)
        lb $a3, login($s4)
        ; nop
        sltu $t0, $a1, $a2
        sltu $t1, $a1, $a3
        sb $a2, login($s3)
        beqz $t0, insert_single_prep2

        beqz $t1, insert_single_prep4

        sb $a3, login($s5)

        daddi $s3, $s3, -4
        daddi $s5, $s5, -4
        beq $s2, $v0, inner_end

        lb $a2, login($s3)
        lb $a3, login($s5)
        ; nop
        sltu $t0, $a1, $a2
        sltu $t1, $a1, $a3
        sb $a2, login($s2)
        beqz $t0, insert_single_prep3


        beqz $t1, insert_single_prep5

        sb $a3, login($s4)

        daddi $s2, $s2, -4
        daddi $s4, $s4, -4
        bne $s3, $v0, insert_double

        j inner_end

insert_single_prep4:
        sb $a1, login($s5)
        daddi $s3, $s5, -1
        daddi $s2, $s4, 0
        daddi $s4, $s4, -1
        j insert_single_cmp

insert_single_prep5:
        sb $a1, login($s4)
        daddi $s3, $s4, -1
        daddi $s2, $s5, 0
        daddi $s4, $s5, -1

        ; nop
insert_single_cmp:
        and $t0, $s2, $v1
        ; nop
        ; nop
        bnez $t0, insert_single_jmp
        lb $a2, login($s2)
        ; nop
        ; nop
        sltu $t0, $a0, $a2
        ; nop
        ; nop
        beqz $t0, insert_single_end3
        sb $a2, login($s3)
        daddi $s2, $s2, -1
        daddi $s3, $s3, -1
        daddi $s4, $s4, -1
        j insert_single_jmp

insert_single_prep3:
        sb $a1, login($s2)
        daddi $s3, $s2, -1
        daddi $s2, $s3, 0
        daddi $s4, $s3, -1
        j insert_single_jmp
insert_single_prep2:
        sb $a1, login($s3)
single_prep:
        daddi $s3, $s3, -1
        daddi $s4, $s2, -1

        ; nop
insert_single_jmp:
        beqz $s3, insert_single_end3
insert_single:
        lb $a2, login($s2)
        ; nop
        ; nop
        sltu $t0, $a0, $a2
        ; nop
        ; nop
        beqz $t0, insert_single_end3

        sb $a2, login($s3)

        lb $a2, login($s4)
        ; nop
        ; nop
        sltu $t0, $a0, $a2
        ; nop
        ; nop
        beqz $t0, insert_single_end2

        sb $a2, login($s2)

        daddi $s4, $s4, -2
        daddi $s2, $s2, -2
        daddi $s3, $s3, -2
        bgez $s4, insert_single

        j inner_end

insert_single_end3:
        sb $a0, login($s3)
        j inner_end

insert_single_end2:
        sb $a0, login($s2)

        ; nop
inner_end:
        daddi $s0, $s0, 2
        daddi $s1, $s1, 2
        daddi $s2, $s0, -1
        daddi $s3, $s1, 0
        lb $a0, login($s0)
        ; nop
        ; nop
        bnez $a0, outer

main_end:
        ; all sorted print result and exit
        daddi r4, r0, login
        jal print_string
        syscall 0 ; exit

print_string:   ; adresa retezce se ocekava v r4
                sw      r4, params_sys5(r0)
                daddi   r14, r0, params_sys5    ; adr pro syscall 5 musi do r14
                syscall 5   ; systemova procedura - vypis retezce na terminal
                jr      r31 ; return - r31 je urcen na return address
