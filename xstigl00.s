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

        ; Bubble sort

        ; $s0 = index
        ; $s1 = index of last swap
        daddi $s1, $zero, 1
        ; $a0 and $a1 are the chars from the string
        ; ensure that they are 0 so that it works properly with single byte set
        daddi $a0, $zero, 0
        daddi $a1, $zero, 0
        ; check if the string is empty
        lb $a1, login($zero)
        beqz $a1, main_end

        ; the first bubble loop
        ; the first part of the loop is unwrapped so that there are no
        ; unconditional jumps
        ; jump in the loop
        daddi $s0, $zero, 1 ; increase count
        lb $a0, login($s0)
        beqz $a0, main_end ; the length of the string is 1
main_count: ; loop
        ; compare $a0, and $a1
        dsub $t0, $a0, $a1
        bgez $t0, main_count_no_swap
        ; $a0 = login($s0) is the larger value, set there the smaller
        daddi $t0, $s0, -1
        sb $a0, login($t0)
        sb $a1, login($s0)
        ; daddi $a1, $a0, 0 ; make $a1 the larger value
        daddi $s1, $s0, 0 ; save the last swap position
main_count_no_swap:
        daddi $s0, $s0, 1
        lb $a0, login($s0)
        bnez $a0, main_count
; main_count_end:

        ; $s0 = index
        ; $s1 = last swap
        ; $s2 = length
        daddi $t0, $s1, -1
        beqz $t0, main_end
main_outer: ; outer bubble sort loop
        daddi $s2, $s1, 0
        daddi $s0, $zero, 1

        ; inner loop preparation
        lb $a1, login($zero)

        ; inner loop half unwrapped
        daddi $s1, $zero, 1
        lb $a0, login($s0)
main_inner: ; inner bubble sort loop
        ; comapre $a0 and $a1
        dsub $t0, $a0, $a1
        bgez $t0, main_inner_no_swap
        ; $a0 = login($s0) is the larger value, set there the smaller
        daddi $t0, $s0, -1
        sb $a0, login($t0)
        sb $a1, login($s0)
        ; daddi $a1, $a0, 0 ; make $a1 the larger value
        daddi $s1, $s0, 0 ; save the last swap position
        daddi $a0, $a1, 0
main_inner_no_swap:
        daddi $s0, $s0, 1
        daddi $a1, $a0, 0
        lb $a0, login($s0)
        bne $s0, $s2, main_inner
; main_inner_end:

        daddi $t0, $s1, -1
        bnez $t0, main_outer
; main_outer_end:

main_end:
        daddi   r4, r0, login   ; vozrovy vypis: adresa login: do r4
        jal     print_string    ; vypis pomoci print_string - viz nize
        syscall 0   ; halt

print_string:   ; adresa retezce se ocekava v r4
                sw      r4, params_sys5(r0)
                daddi   r14, r0, params_sys5    ; adr pro syscall 5 musi do r14
                syscall 5   ; systemova procedura - vypis retezce na terminal
                jr      r31 ; return - r31 je urcen na return address
