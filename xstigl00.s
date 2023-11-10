; Autor reseni: Jakub Antonín Štigler xstigl00
; Pocet cyklu k serazeni puvodniho retezce: 675
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
        lb $a0, login($zero)
        daddi $v1, $zero, 1
        daddi $v0, $zero, 2
        beqz $a0, main_end
        lb $a1, login($v1)
        daddi $s2, $zero, 1
        daddi $s3, $zero, 3
        beqz $a1, main_end
        sltu $t0, $a1, $a0
        daddi $s0, $zero, 2
        daddi $s1, $zero, 3
        beqz $t0, outer
        sb $a0, login($v1)
        sb $a1, login($zero)

outer:
        lb $a1, login($s1)

        lb $a2, login($s2)
        daddi $s2, $s2, -1

        sltu $t1, $a1, $a0
        beqz $a1, single_prep

        sltu $t0, $a1, $a2

        beqz $t1, insert_double
        lb $a1, login($s0)
        lb $a0, login($s1)

insert_double:
        beqz $t0, insert_single_prep
        lb $a3, login($s2)
        sb $a2, login($s3)
        daddi $s3, $s3, -1
        sltu $t0, $a1, $a3
        daddi $s2, $s2, -1
        beq $s3, $v0, insert_double_last

        beqz $t0, insert_single_prep3
        lb $a2, login($s2)
        sb $a3, login($s3)
        daddi $s3, $s3, -1
        sltu $t0, $a1, $a2
        daddi $s2, $s2, -1
        bne $s3, $v0, insert_double

; insert_double_last:
        sltu $t1, $a0, $a2
        beq $t0, $v1, insert_double_last012

        ; nop
        beq $t1, $v1, insert_double_last021

; insert_double_last301:
        sb $a0, login($v1)
        sb $a1, login($v0)

        lb $a0, login($s0)
        daddi $s2, $s0, -1
        daddi $s3, $s1, 0
        bnez $a0, outer
        j main_end
insert_double_last021:
        sb $a0, login($zero)
        sb $a2, login($v1)
        sb $a1, login($v0)

        lb $a0, login($s0)
        daddi $s2, $s0, -1
        daddi $s3, $s1, 0
        bnez $a0, outer
        j main_end
insert_double_last012:
        sb $a0, login($zero)
        sb $a1, login($v1)
        sb $a2, login($v0)

        lb $a0, login($s0)
        daddi $s2, $s0, -1
        daddi $s3, $s1, 0
        bnez $a0, outer
        j main_end

insert_double_last:
        sltu $t1, $a0, $a3
        daddi $s2, $s0, -1
        beq $t0, $v1, insert_double_last013

        beq $t1, $v1, insert_double_last031

; insert_double_last201:
        sb $a0, login($v1)
        lb $a0, login($s0)
        sb $a1, login($v0)

        daddi $s3, $s1, 0
        bnez $a0, outer
        j main_end
insert_double_last031:
        sb $a0, login($zero)
        sb $a3, login($v1)
        lb $a0, login($s0)
        sb $a1, login($v0)

        daddi $s3, $s1, 0
        bnez $a0, outer
        j main_end
insert_double_last013:
        sb $a0, login($zero)
        sb $a1, login($v1)
        lb $a0, login($s0)
        sb $a3, login($v0)

        daddi $s3, $s1, 0
        bnez $a0, outer
        j main_end

insert_single_prep3:
        sb $a1, login($s3)
        sltu $t0, $a0, $a3
        daddi $s3, $s3, -1
        j insert_single2

single_prep:
        sltu $t0, $a0, $a2
        daddi $s3, $s3, -1
        j insert_single

insert_single_prep:
        sltu $t0, $a0, $a2
        sb $a1, login($s3)
        daddi $s3, $s3, -1

insert_single:
        beqz $t0, inner_single_end
        lb $a3, login($s2)
        sb $a2, login($s3)
        daddi $s3, $s3, -1
        sltu $t0, $a0, $a3
        daddi $s2, $s2, -1
        beq $s3, $v1, insert_single_last

insert_single2:
        beqz $t0, inner_single_end
        lb $a2, login($s2)
        sb $a3, login($s3)
        daddi $s3, $s3, -1
        sltu $t0, $a0, $a2
        daddi $s2, $s2, -1
        bne $s3, $v1, insert_single

; insert_single_last:
        beq $t0, $v1, insert_single_last02

        sb $a0, login($v1)

        lb $a0, login($s0)
        daddi $s2, $s0, -1
        daddi $s3, $s1, 0
        bnez $a0, outer
        j main_end
insert_single_last02:
        sb $a0, login($zero)
        sb $a2, login($v1)

        lb $a0, login($s0)
        daddi $s2, $s0, -1
        daddi $s3, $s1, 0
        bnez $a0, outer
        j main_end

insert_single_last:
        beq $t0, $v1, insert_single_last03

        sb $a0, login($v1)

        lb $a0, login($s0)
        daddi $s2, $s0, -1
        daddi $s3, $s1, 0
        bnez $a0, outer
        j main_end
insert_single_last03:
        sb $a0, login($zero)
        sb $a3, login($v1)

        lb $a0, login($s0)
        daddi $s2, $s0, -1
        daddi $s3, $s1, 0
        bnez $a0, outer
        j main_end

inner_single_end:
        daddi $s0, $s0, 2
        daddi $s1, $s1, 2
        sb $a0, login($s3)

        lb $a0, login($s0)
        daddi $s2, $s0, -1
        daddi $s3, $s1, 0
        bnez $a0, outer

main_end:
        ; all sorted print result and exit
        daddi r4, r0, login
        jal print_string
        syscall 0 ; exit

print_string:   ; adresa retezce se ocekava v r4
                sw      r4, params_sys5(r0)
                daddi   r14, r0, params_sys5    ; adr pro syscall 5 musi do r14
                ; nop
                ; nop
                syscall 5   ; systemova procedura - vypis retezce na terminal
                jr      r31 ; return - r31 je urcen na return address
