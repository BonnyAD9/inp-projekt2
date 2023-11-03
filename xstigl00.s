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

        ; raw stalls are market by nop comment (there are no raw stalls, only
        ; in print_string)

        ; inicialization, check that the string is at least 2 characters long
        daddi $s0, $zero, 1
        lb $a1, login($zero)
        daddi $v1, $zero, 1
        lb $a0, login($s0)
        beqz $a1, main_end

        daddi $s0, $s0, 1
        dsub $t0, $a0, $a1
        beqz $a0, main_end

        ; first iteration on the last item
        daddi $s2, $s0, -1
        bgez $t0, inner_end2

        sb $a1, login($v1)
        sb $a0, login($zero)
        lb $a0, login($s0)

        lb $a1, login($s2)
        daddi $s1, $s0, 0
        beqz $a0, main_end
outer:
        ; outer loop, goes trough all the items in the array to be inserted
        ; in the ordered part of the array

        ; inicialization for inner loop
        dsub $t0, $a0, $a1
        daddi $s2, $s2, -1
        daddi $s0, $s0, 1

        ; s1 starts at the same position as original s0 (the current s0 is
        ; already increased), s2 is s1 - 2:
        ; s2, --, s1, s0
        ; in the loop below, s1 and s2 decrease by one twice in each iteration
        ; (once in one iteration of the original loop), loop jumps to last
        ; iteration when s1 == 0:
        ; 0   1   2   3   4   5
        ; --, --, s2, --, s1, s0
        ; --, s2, --, s1, --, s0
        ; s2, --, s1, --, --, s0
        ; --, s1, --, --, --, s0
inner:
        ; inner finds where to put a0, moves the array to right on its way.
        ;
        ; The original inner loop was unwrapped so that there are now two
        ; iterations of the original loop in single iteration of this loop
        ; and they are intertwined to remove all raw stalls.
        ;
        ; The last iteration was taken out of the loop (last_inner1 and
        ; last_inner2) to avoid reading at negative indexes.
        ;
        ; You can see the two symetric parts that just use different registers.

        ; inner part1:
        bgez $t0, inner_end
        lb $a2, login($s2)
        sb $a1, login($s1)
        daddi $s1, $s1, -1
        dsub $t0, $a0, $a2
        daddi $s2, $s2, -1
        beq $s1, $v1, last_inner2

        ; inner part2
        bgez $t0, inner_end
        lb $a1, login($s2)
        sb $a2, login($s1)
        daddi $s1, $s1, -1
        dsub $t0, $a0, $a1
        daddi $s2, $s2, -1
        bne $s1, $v1, inner

; last_inner1:
        ; last interation when jumped from the second part of inner
        ; and insert a0 at the correct position
        daddi $s2, $s0, -1
        bgez $t0, inner_end2

        sb $a1, login($v1)
        sb $a0, login($zero)
        lb $a0, login($s0)

        ; prepare for the next loop of inner
        daddi $s1, $s0, 0
        lb $a1, login($s2)
        bnez $a0, outer

        ; all sorted print result and exit
        daddi r4, r0, login
        jal print_string
        syscall 0 ; exit

last_inner2:
        ; last iteration when jumped from the first part of inner
        ; and insert a0 at the correct position
        daddi $s2, $s0, -1
        bgez $t0, inner_end2

        sb $a2, login($v1)
        sb $a0, login($zero)
        lb $a0, login($s0)

        ; prepare for the next iteration of inner
        daddi $s1, $s0, 0
        lb $a1, login($s2)
        bnez $a0, outer

        ; all sorted print result and exit
        daddi r4, r0, login
        jal print_string
        syscall 0 ; exit
inner_end2:
        sb $a0, login($v1)
        lb $a0, login($s0)

        ; prepare for the next iteration of inner
        daddi $s1, $s0, 0
        lb $a1, login($s2)
        bnez $a0, outer

        ; all sorted print result and exit
        daddi r4, r0, login
        jal print_string
        syscall 0 ; exit
inner_end:
        ; insert a0 at the found position
        daddi $s2, $s0, -1
        sb $a0, login($s1)
        lb $a0, login($s0)

        ; prepare for the nest iteration of inner
        daddi $s1, $s0, 0
        lb $a1, login($s2)
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
