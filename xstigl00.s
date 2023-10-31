; Autor reseni: Jmeno Prijmeni login
; Pocet cyklu k serazeni puvodniho retezce:
; Pocet cyklu razeni sestupne serazeneho retezce:
; Pocet cyklu razeni vzestupne serazeneho retezce:
; Pocet cyklu razeni retezce s vasim loginem:
; Implementovany radici algoritmus:
; ------------------------------------------------

; DATA SEGMENT
                .data
; login:          .asciiz "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."    ; puvodni uvitaci retezec
login:          .asciiz "vitejte-v-inp-2023"    ; puvodni uvitaci retezec
; login:          .asciiz "v"    ; puvodni uvitaci retezec
; login:          .asciiz "vvttpnjiiee3220---"  ; sestupne serazeny retezec
; login:          .asciiz "---0223eeiijnpttvv"  ; vzestupne serazeny retezec
; login:          .asciiz "xlogin00"            ; SEM DOPLNTE VLASTNI LOGIN
                                                ; A POUZE S TIMTO ODEVZDEJTE

params_sys5:    .space  8   ; misto pro ulozeni adresy pocatku
                            ; retezce pro vypis pomoci syscall 5
                            ; (viz nize - "funkce" print_string)
                ; 256 zeros
counts:         .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

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
        lbu $a2, login($zero)
        daddi $s0, $zero, 1
        daddi $v0, $zero, 256
        dsll $a0, $a2, 2
        dsll $a1, $a2, 2
        beqz $a2, main_end
count:
        lw $t0, counts($a0)
        dsub $t1, $a0, $a1
        lbu $a2, login($s0)
        daddi $t0, $t0, 1
        bgez $t1, no_min
        daddi $a1, $a0, 0
no_min:
        dsll $a2, $a2, 2
        sw $t0, counts($a0)
        daddi $s0, $s0, 1
        beqz $a2, count_end

        lw $t0, counts($a2)
        dsub $t1, $a2, $a1
        lbu $a0, login($s0)
        daddi $t0, $t0, 1
        bgez $t1, no_min2
        daddi $a1, $a2, 0
no_min2:
        dsll $a0, $a0, 2
        daddi $s0, $s0, 1
        sw $t0, counts($a2)
        bnez $a0, count

count_end:
        daddi $s1, $s0, -1
        daddi $s0, $zero, 0
        lw $t0, counts($a1)
        ; a1 = a0 + 1
generate:
        dsrl $a0, $a1, 2
        daddi $a1, $a1, 4

        beqz $t0, generate_inner_end
generate_inner:
        daddi $t0, $t0, -1
        sb $a0, login($s0)
        daddi $s0, $s0, 1
        beqz $t0, generate_inner_end

        daddi $t0, $t0, -1
        sb $a0, login($s0)
        daddi $s0, $s0, 1
        beqz $t0, generate_inner_end

        daddi $t0, $t0, -1
        sb $a0, login($s0)
        daddi $s0, $s0, 1
        beqz $t0, generate_inner_end

        daddi $t0, $t0, -1
        sb $a0, login($s0)
        daddi $s0, $s0, 1
        bnez $t0, generate_inner
generate_inner_end:
        lw $t0, counts($a1)
        beq $s0, $s1, main_end

        dsrl $a0, $a1, 2
        daddi $a1, $a1, 4

        beqz $t0, generate_inner_end

        daddi $t0, $t0, -1
        sb $a0, login($s0)
        daddi $s0, $s0, 1
        beqz $t0, generate_inner_end

        daddi $t0, $t0, -1
        sb $a0, login($s0)
        daddi $s0, $s0, 1
        beqz $t0, generate_inner_end

        daddi $t0, $t0, -1
        sb $a0, login($s0)
        daddi $s0, $s0, 1
        beqz $t0, generate_inner_end

        daddi $t0, $t0, -1
        sb $a0, login($s0)
        daddi $s0, $s0, 1
        beqz $t0, generate_inner_end
        j generate_inner

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
