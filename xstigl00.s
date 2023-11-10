; Autor reseni: Jakub Antonín Štigler xstigl00
; Pocet cyklu k serazeni puvodniho retezce: 635
; Pocet cyklu razeni sestupne serazeneho retezce: 689
; Pocet cyklu razeni vzestupne serazeneho retezce: 213
; Pocet cyklu razeni retezce s vasim loginem: 167
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

        ; Insert sort (improoved)

        ; The basic idea is insert sort, but insert two items at the same time.
        ;
        ; Every outer loop two first unsorted items are loaded and sorted into
        ; registers a0 and a1.
        ;
        ; The first inner loop inserts a1, and the second inner loop inserts
        ; a0. Because I know that a0 is smaller than a1, I can just continue
        ; and don't have to check the items before.

        ; List of used registers and their usage/meaning:
        ; s0, s1: index of first 2 unsorted items
        ; s2, s3: indexes in the inner loops
        ; a0, a1: ordered items to insert
        ; a2, a3: items from login
        ; t0, t1: temorary (used in conditions)
        ; v1:     1
        ; v0:     2

        ; sort the first 2 items, load the third item to a0 and check if it is
        ; 0.
        lb $a2, login($zero)
        daddi $v1, $zero, 1
        daddi $v0, $zero, 2
        beqz $a2, main_end
        lb $a3, login($v1)
        daddi $s2, $zero, 1
        daddi $s3, $zero, 3
        beqz $a3, main_end
        sltu $t0, $a3, $a2
        daddi $s0, $zero, 2
        daddi $s1, $zero, 3
        lb $a0, login($v0)
        beqz $t0, no_swap
        sb $a2, login($v1)
        sb $a3, login($zero)
no_swap:
        beqz $a0, main_end

outer:
        ; The outer loop, the next a0 has already been loaded by the previous
        ; iteration. Load to a1, check for zero, prepare for the inner loops.
        lb $a1, login($s1)

        lb $a2, login($s2) ; part of inner loop unwrapped
        daddi $s2, $s2, -1 ; part of inner loop unwrapped

        sltu $t1, $a1, $a0
        beqz $a1, single_prep ; When a1 is zero, insert only single item: a0

        sltu $t0, $a1, $a2 ; part of inner loop unwrapped

        beqz $t1, insert_double ; check if I should swap a0 an a1
        lb $a1, login($s0) ; swap by loading in opposite order
        lb $a0, login($s1) ; swap by loading in opposite order

insert_double:
        ; The first inner loop. It finds place for a1 in the sorted part.
        ; While searching for the place, shift all examined items to the right
        ; by 2.

        ; The current version of loop is optimized version of original loop.
        ; The current version has two iterations of the original version merged
        ; into a single iteration, it goes only to index 1 to avoid negative
        ; index because it assumes that there will always be at least 1 next
        ; item.
        ;
        ; When the loop finds place for a1, it jums to the other loop
        ; (insert_single). When it comes to the last idnex it jumps to a
        ; special case that correctly inserts the two items and the item at
        ; index 0 at the indexes 0, 1 and 2.
        ;
        ; The two original loops are somehow visible - you can see two symetric
        ; parts tat just have a2 and a3 swapped.

        ; part 1:
        beqz $t0, insert_single_prep
        lb $a3, login($s2)
        sb $a2, login($s3)
        daddi $s3, $s3, -1
        sltu $t0, $a1, $a3
        daddi $s2, $s2, -1
        beq $s3, $v0, insert_double_last

        ; part 2:
        beqz $t0, insert_single_prep3
        lb $a2, login($s2)
        sb $a3, login($s3)
        daddi $s3, $s3, -1
        sltu $t0, $a1, $a2
        daddi $s2, $s2, -1
        bne $s3, $v0, insert_double

        ; Correctly insert the a0, a1 and a2/a3 in indexes 0, 1 and 2.
        ;
        ; There are two versions, one to jump from the first part of the double
        ; loop, and one for the second part of the double loop. This is because
        ; in the first part of the loop, a3 already has the value of the item
        ; at index 0, and in the secon part of the loop this value is in a2.

        ; first version of insert_double_last
; insert_double_last:
        sltu $t1, $a0, $a2
        daddi $s0, $s0, 2
        daddi $s1, $s1, 2
        beq $t0, $v1, insert_double_last012

        beq $t1, $v1, insert_double_last021

; insert_double_last201:
        sb $a0, login($v1)
        sb $a1, login($v0)

        ; preparation for next iteration of outer loop
        lb $a0, login($s0)
        daddi $s2, $s0, -1
        daddi $s3, $s1, 0
        bnez $a0, outer
        j main_end
insert_double_last021:
        sb $a0, login($zero)
        sb $a2, login($v1)
        sb $a1, login($v0)

        ; preparation for next iteration of outer loop
        lb $a0, login($s0)
        daddi $s2, $s0, -1
        daddi $s3, $s1, 0
        bnez $a0, outer
        j main_end
insert_double_last012:
        sb $a0, login($zero)
        sb $a1, login($v1)
        sb $a2, login($v0)

        ; preparation for next iteration of outer loop
        lb $a0, login($s0)
        daddi $s2, $s0, -1
        daddi $s3, $s1, 0
        bnez $a0, outer
        j main_end

        ; second version of insert_double_last
insert_double_last:
        sltu $t1, $a0, $a3
        daddi $s0, $s0, 2
        daddi $s1, $s1, 2
        beq $t0, $v1, insert_double_last013

        beq $t1, $v1, insert_double_last031

; insert_double_last301:
        sb $a0, login($v1)
        sb $a1, login($v0)

        ; preparation for next iteration of outer loop
        lb $a0, login($s0)
        daddi $s2, $s0, -1
        daddi $s3, $s1, 0
        bnez $a0, outer
        j main_end
insert_double_last031:
        sb $a0, login($zero)
        sb $a3, login($v1)
        sb $a1, login($v0)

        ; preparation for next iteration of outer loop
        lb $a0, login($s0)
        daddi $s2, $s0, -1
        daddi $s3, $s1, 0
        bnez $a0, outer
        j main_end
insert_double_last013:
        sb $a0, login($zero)
        sb $a1, login($v1)
        sb $a3, login($v0)

        ; preparation for next iteration of outer loop
        lb $a0, login($s0)
        daddi $s2, $s0, -1
        daddi $s3, $s1, 0
        bnez $a0, outer
        j main_end

        ; Now there is preparation for the second inner loop (insert_single).
        ;
        ; There are different preparation steps based on from where is jumped
        ; into this loop.

        ; Prep 1: jump from the first part of the insert_double loop.
insert_single_prep3:
        sb $a1, login($s3)
        sltu $t0, $a0, $a3
        daddi $s3, $s3, -1
        j insert_single2 ; Jump to the second part of the loop, so that I don't
                         ; have to copy a3 to a2

        ; Prep 2: jump from the start of the outer loop
single_prep:
        sltu $t0, $a0, $a2
        daddi $s3, $s3, -1
        j insert_single

        ; Prep 3: jump from the second part of the insert_double loop.
insert_single_prep:
        sltu $t0, $a0, $a2
        sb $a1, login($s3)
        daddi $s3, $s3, -1

insert_single:
        ; The second inner loop. It finds place for a0 in the sorted part.
        ; While searching for the place, shift all examined items to the right
        ; by 1.
        ;
        ; The loop is optimized in the exact same way as insert_double and so
        ; it also has the same two parts.

        ; Part 1:
        beqz $t0, inner_single_end
        lb $a3, login($s2)
        sb $a2, login($s3)
        daddi $s3, $s3, -1
        sltu $t0, $a0, $a3
        daddi $s2, $s2, -1
        beq $s3, $v1, insert_single_last

insert_single2:
        ; Part 2:
        beqz $t0, inner_single_end
        lb $a2, login($s2)
        sb $a3, login($s3)
        daddi $s3, $s3, -1
        sltu $t0, $a0, $a2
        daddi $s2, $s2, -1
        bne $s3, $v1, insert_single

        ; The last iteration of the insert_single loop. It is simpler because
        ; it only has to sort a0 and a2/a3 at indexes 0 and 1.
        ;
        ; It also has the two versions for the same reason.

        ; Version 1:
; insert_single_last:
        daddi $s0, $s0, 2
        daddi $s1, $s1, 2
        beq $t0, $v1, insert_single_last02

        sb $a0, login($v1)

        ; preparation for next iteration of outer loop
        lb $a0, login($s0)
        daddi $s2, $s0, -1
        daddi $s3, $s1, 0
        bnez $a0, outer
        j main_end
insert_single_last02:
        sb $a0, login($zero)
        sb $a2, login($v1)

        ; preparation for next iteration of outer loop
        lb $a0, login($s0)
        daddi $s2, $s0, -1
        daddi $s3, $s1, 0
        bnez $a0, outer
        j main_end

        ; Version 2:
insert_single_last:
        beq $t0, $v1, insert_single_last03

        sb $a0, login($v1)

        ; preparation for next iteration of outer loop
        lb $a0, login($s0)
        daddi $s2, $s0, -1
        daddi $s3, $s1, 0
        bnez $a0, outer
        j main_end
insert_single_last03:
        sb $a0, login($zero)
        sb $a3, login($v1)

        ; preparation for next iteration of outer loop
        lb $a0, login($s0)
        daddi $s2, $s0, -1
        daddi $s3, $s1, 0
        bnez $a0, outer
        j main_end

        ; When the loop insert_single finds place for a0, it jumps here.
inner_single_end:
        daddi $s0, $s0, 2
        daddi $s1, $s1, 2
        sb $a0, login($s3)

        ; preparation for next iteration of outer loop
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
