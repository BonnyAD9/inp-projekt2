; Autor reseni: Jakub Antonín Štigler xstigl00
; Pocet cyklu k serazeni puvodniho retezce: 922
; Pocet cyklu razeni sestupne serazeneho retezce: 1232
; Pocet cyklu razeni vzestupne serazeneho retezce: 223
; Pocet cyklu razeni retezce s vasim loginem: 251
; Implementovany radici algoritmus: Insert sort
; ------------------------------------------------

; DATA SEGMENT
                .data
; login:          .asciiz "vitejte-v-inp-2023"    ; puvodni uvitaci retezec
; login:          .asciiz "vvttpnjiiee3220---"  ; sestupne serazeny retezec
; login:          .asciiz "---0223eeiijnpttvv"  ; vzestupne serazeny retezec
login:          .asciiz "xstigl00"            ; SEM DOPLNTE VLASTNI LOGIN
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
        daddi $s0, $zero, 1
        daddi $s1, $zero, 2
        daddi $v1, $zero, 1
        lb $a0, login($zero)
        beqz $a0, main_end

outer:
        daddi $s2, $s0, -1
        daddi $s3, $s1, 0
        lb $a0, login($s0)
        beqz $a0, main_end
        lb $a1, login($s1)
        beqz $a1, single_prep
        sltu $t0, $a1, $a0
        beqz $t0, insert_double
        lb $a1, login($s0)
        lb $a0, login($s1)

insert_double:
        lb $a2, login($s2)
        sltu $t0, $a1, $a2
        beqz $t0, insert_single_prep
        sb $a2, login($s3)
        daddi $s2, $s2, -1
        daddi $s3, $s3, -1
        bgez $s2, insert_double

; inner_insert_double_end:
        sb $a0, login($zero)
        sb $a1, login($v1)
        daddi $s0, $s0, 2
        daddi $s1, $s1, 2
        j outer

insert_single_prep:
        sb $a1, login($s3)
single_prep:
        daddi $s3, $s3, -1

insert_single:
        lb $a2, login($s2)
        sltu $t0, $a0, $a2
        beqz $t0, inner_end
        sb $a2, login($s3)
        daddi $s2, $s2, -1
        daddi $s3, $s3, -1
        bgez $s2, insert_single

; inner_insert_single_end:
        sb $a0, login($zero)
        daddi $s0, $s0, 2
        daddi $s1, $s1, 2
        j outer

inner_end:
        sb $a0, login($s3)
        daddi $s0, $s0, 2
        daddi $s1, $s1, 2
        j outer

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
