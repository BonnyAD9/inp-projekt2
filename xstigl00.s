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
                ; 256 zeros
counts:         .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

; CODE SEGMENT
                .text
main:
        ; SEM DOPLNTE VASE RESENI


        ; daddi   r4, r0, login   ; vozrovy vypis: adresa login: do r4
        ; jal     print_string    ; vypis pomoci print_string - viz nize

        ; Bucket sort

        ; count occurences
        ; s0: index
        ; a0: current item
        ; v0: 256
        ; t0: count
        ; $s1: last
        lbu $a0, login($zero)
        daddi $s0, $zero, 0
        daddi $v0, $zero, 256
        beqz $a0, main_end
        daddi $a1, $a0, 0
count:
        lb $t0, counts($a0)
        dsub $t1, $a0, $a1
        bgez $t1, no_min
        daddi $a1, $a0, 0
no_min:
        daddi $t0, $t0, 1
        ; nop
        ; nop
        sb $t0, counts($a0)
        ; nop
        ; nop
        daddi $s0, $s0, 1
        ; nop
        ; nop
        lbu $a0, login($s0)
        ; nop
        ; nop
        bnez $a0, count

        daddi $s1, $s0, 0
        daddi $s0, $zero, 0
        ; a1 = a0 + 1
generate:
        lbu $t0, counts($a1)
        daddi $a0, $a1, 0
        daddi $a1, $a1, 1

        beqz $t0, generate_inner_end
generate_inner:
        daddi $t0, $t0, -1
        sb $a0, login($s0)
        daddi $s0, $s0, 1
        bnez $t0, generate_inner
generate_inner_end:
        bne $s0, $s1, generate

; outer_end


main_end:
        daddi   r4, r0, login   ; vozrovy vypis: adresa login: do r4
        jal     print_string    ; vypis pomoci print_string - viz nize
        syscall 0   ; halt

print_string:   ; adresa retezce se ocekava v r4
                sw      r4, params_sys5(r0)
                daddi   r14, r0, params_sys5    ; adr pro syscall 5 musi do r14
                ; nop
                ; nop
                syscall 5   ; systemova procedura - vypis retezce na terminal
                jr      r31 ; return - r31 je urcen na return address
