; Autor reseni: Jakub Antonín Štigler xstigl00
; Pocet cyklu k serazeni puvodniho retezce: 925
; Pocet cyklu razeni sestupne serazeneho retezce: 1225
; Pocet cyklu razeni vzestupne serazeneho retezce: 420
; Pocet cyklu razeni retezce s vasim loginem: 278
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

        ; Insert sort (improved)

        ; inicialization
        lb $a0, login($zero)
        daddi $s3, $zero, 1
        daddi $s1, $zero, 0
        beqz $a0, main_end

        lb $a1, login($s3)
        daddi $v1, $zero, 2
        daddi $v0, $zero, -1
        beqz $a1, main_end

max:
        ; move the max value to the end of the array
        slt $t0, $a1, $a0
        daddi $a2, $a1, 0
        daddi $s3, $s3, 1

        bnez $t0, less
        daddi $a2, $a0, 0
        daddi $a0, $a1, 0
less:
        lb $a1, login($s3)
        sb $a2, login($s1)
        daddi $s1, $s1, 1
        bnez $a1, max

max_end:
        ; prepare for the insert sort
        daddi $s0, $s3, -3
        beq $s3, $v1, main_end_store

outer:
        ; insert sort, but from the end (inserts max values at the end)
        daddi $s3, $s0, 1
        sb $a0, login($s1)

        lb $a0, login($s0)
        lb $a1, login($s3)

        daddi $s2, $s0, 2
        daddi $s1, $s0, 0
        sltu $t0, $a1, $a0
        daddi $s0, $s0, -1
        lb $a2, login($s2)
        beqz $t0, insert_end

insert:
        ; inner loop of the insert sort, because the max value is already at
        ; the end, there is no need to check for out of bounds necause the loop
        ; will end implicitly
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
        bne $s0, $v0, outer

main_end_store:
        sb $a0, login($s1)

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
