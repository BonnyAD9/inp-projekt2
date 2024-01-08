; Autor reseni: Jakub Antonín Štigler xstigl00
; Pocet cyklu k serazeni puvodniho retezce: 635
; Pocet cyklu razeni sestupne serazeneho retezce: 689
; Pocet cyklu razeni vzestupne serazeneho retezce: 213
; Pocet cyklu razeni retezce s vasim loginem: 167
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

        ; Insert sort (improoved)

        daddi $s0, $zero, 1
        daddi $s1, $zero, 0
        lb $a0, login($zero)
        ; nop
        ; nop
        beqz $a0, main_end

        lb $a1, login($s0)
        ; nop
        ; nop
        beqz $a1, main_end
max:
        slt $t0, $a1, $a0
        daddi $s0, $s0, 1
        ; nop
        bnez $t0, smaller
        sb $a0, login($s1)
        daddi $a0, $a1, 0
        daddi $s1, $s1, 1
        ; nop
        lb $a1, login($s0)
        ; nop
        ; nop
        bnez $a1, max
        j max_end
smaller:
        sb $a1, login($s1)
        daddi $s1, $s1, 1
        ; nop
        lb $a1, login($s0)
        ; nop
        ; nop
        bnez $a1, max

max_end:
        sb $a0, login($s1)
        daddi $s0, $s0, -2
        ; nop
        ; nop
        beqz $s0, main_end

outer:
        daddi $s0, $s0, -1
        ; nop
        ; nop
        lb $a0, login($s0)

        daddi $s1, $s0, 0
        daddi $s2, $s0, 1
        ; nop
        ; nop
        lb $a1, login($s2)
        sltu $t0, $a1, $a0
        daddi $s2, $s2, 1
        lb $a2, login($s2)
        beqz $t0, insert_end

insert:
        sb $a1, login($s1)
        daddi $s2, $s2, 1
        sltu $t0, $a2, $a0
        daddi $s1, $s1, 1
        lb $a1, login($s2)
        beqz $t0, insert_end

        sb $a2, login($s1)
        daddi $s2, $s2, 1
        sltu $t0, $a1, $a0
        daddi $s1, $s1, 1
        lb $a2, login($s2)
        bnez $t0, insert
insert_end:
        sb $a0, login($s1)

        bnez $s0, outer

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
