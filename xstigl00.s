; Autor reseni: Jakub Antonín Štigler xstigl00
; Pocet cyklu k serazeni puvodniho retezce: 729
; Pocet cyklu razeni sestupne serazeneho retezce: 729
; Pocet cyklu razeni vzestupne serazeneho retezce: 729
; Pocet cyklu razeni retezce s vasim loginem: 578
; Implementovany radici algoritmus: bucket sort
; ------------------------------------------------

; DATA SEGMENT
                .data
; lorem ipsum - 7058 cylků
login:          .asciiz "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
; login:          .asciiz "vitejte-v-inp-2023"    ; puvodni uvitaci retezec
; login:          .asciiz "v"    ; puvodni uvitaci retezec
; login:          .asciiz "vvttpnjiiee3220---"  ; sestupne serazeny retezec
; login:          .asciiz "---0223eeiijnpttvv"  ; vzestupne serazeny retezec
login:          .asciiz "xlogin00"            ; SEM DOPLNTE VLASTNI LOGIN
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
        ; Bucket sort
        ;
        ; 729 cycles for the default string, the same is for sorted and reverse
        ;     sorted.
        ;
        ; The main idea is to count how many of each char is in the string and
        ; than generate string in order.
        ;
        ; The array counts is used to store the count of each char. Index is
        ; the char and value is count of that char.
        ;
        ; The algorithm has linear complexity, so it is usable for larger
        ; strings, such as the lorem ipsum text (7058 cycles)

        ; s0: index in string
        ; a0, a2: current item
        ; a1: the smallest value in string
        ; v0: 1
        ; t0: value from counts
        ; t1: temorary (used in conditions)

        ; inicialization
        lbu $a2, login($zero)
        daddi $s0, $zero, 1
        daddi $v0, $zero, 256
        dsll $a0, $a2, 2 ; the index to the counts array must be multiplied by
        dsll $a1, $a2, 2 ; 8, shift is equivalent but faster.
        beqz $a2, main_end
count:  ; loop - counts the number of occurences of each letter
        ; two consecutive iterations of the loop are merged into a single
        ; interation so that there are no raw stalls and there is something
        ; useful computed at all times
        lw $t0, counts($a0)
        dsub $t1, $a0, $a1
        lbu $a2, login($s0)
        daddi $t0, $t0, 1

        ; check for smallest value
        bgez $t1, no_min
        daddi $a1, $a0, 0
no_min:
        dsll $a2, $a2, 2
        sw $t0, counts($a0)
        daddi $s0, $s0, 1
        beqz $a2, count_end

        ; second part of loop
        lw $t0, counts($a2)
        dsub $t1, $a2, $a1
        lbu $a0, login($s0)
        daddi $t0, $t0, 1

        ; check for smallest value
        bgez $t1, no_min2
        daddi $a1, $a2, 0
no_min2:
        dsll $a0, $a0, 2
        daddi $s0, $s0, 1
        sw $t0, counts($a2)
        bnez $a0, count ; loop around

count_end:
        ; prepare for next loop
        daddi $s1, $s0, -1
        daddi $s0, $zero, 0
        ; now follows loop that generates the sorted array.
        ; it goes trough the counts array in order
        ;
        ; the loop consists of a outer and nested inner loop.
        ; The outer loop goes trough all the items in the counts array
        ; starting at the smallest item in the source array, and ends when
        ; the sorted array has the required length.
        ;
        ; The inner loop repeats each character the required number of times.
        ;
        ; The loop is hevily unwrapped because there would be so many wrong
        ; branching guesses.

        ; s1: length f the string - 1
        ; a0: current item
        ; a1: the smallest value in string, starting index
        ; v0: 1
        ; t0: value from counts

        ; first part of the loop is moved before the loop
        lw $t0, counts($a1)
        dsrl $a0, $a1, 2
        daddi $a1, $a1, 4

        beqz $t0, generate_inner_end
generate_inner:
        ; the inner loop repeated four times
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
        ; end of the inner loop, now here is the outer loop only code
        lw $t0, counts($a1)
        beq $s0, $s1, main_end

        dsrl $a0, $a1, 2
        daddi $a1, $a1, 4

        beqz $t0, generate_inner_end

        ; the inner loop repeated 4 times
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

main_end:
        ; string is sorted, print it
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
