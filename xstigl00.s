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


        ; daddi   r4, r0, login   ; vozrovy vypis: adresa login: do r4
        ; jal     print_string    ; vypis pomoci print_string - viz nize

        ; Insert sort

        daddi $s0, $zero, 1
        lb $a0, login($zero)
        beqz $a0, main_end
        lb $a0, login($s0)
        beqz $a0, main_end
outer:
        daddi $s1, $s0, 0
        daddi $s2, $s0, -1
        lb $a0, login($s0)
        daddi $s0, $s0, 1

        ; s2, s1
inner:
        lb $a1, login($s2)
        dsub $t0, $a0, $a1
        bgez $t0, inner_end
        sb $a1, login($s1)
        daddi $s2, $s2, -1
        daddi $s1, $s1, -1
        bgez $s2, inner
inner_end:
        sb $a0, login($s1)
        lb $a0, login($s0)
        bnez $a0, outer

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
