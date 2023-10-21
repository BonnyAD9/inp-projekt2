#include <stdio.h>

int main(void) {
    // rewrite the asm code in C so that i can debug it more esily :)
    char *login = "vitejte-v-inp-2023\0";
    printf("%s", login);

    int s0, s1, s2, t0, zero = 0; // registers
    char a0, a1;

                                         // ; Bubble sort

                                         // ; $s0 = index
                                         // ; $s1 = index of last swap
    s1 = zero + 1;                       // daddi $s1, $zero, 1
                                         // ; $a0 and $a1 are the chars from the string
                                         // ; ensure that they are 0 so that it works properly with single byte set
    a0 = zero + 0;                       // daddi $a0, $zero, 0
    a1 = zero + 0;                       // daddi $a1, $zero, 0
                                         // ; check if the string is empty
    a1 = login[zero];                    // daddi $a1, login($zero)
    if (a1 == 0) goto main_end;          // beqz $a1, main_end

                                         // ; the first bubble loop
                                         // ; the first part of the loop is unwrapped so that there are no
                                         // ; unconditional jumps
                                         // ; jump in the loop
    s0 = zero + 1;                       // daddi $s0, $zero, 1 ; increase count
    a0 = login[s0];                      // lb $a0, login($s0)
    if (a0 == 0) goto main_end;          // beqz $a0, main_end ; the length of the string is 1
main_count:                     // main_count:
                                         // ; compare $a0, and $a1
    t0 = a1 - a0;                        // dsub $t0, $a1, $a0
    if (t0 > 0) goto main_count_no_swap; // bgez $t0, main_count_no_swap
                                         // ; $a0 = login($s0) is the larger value, set there the smaller
    login[s0] = a1;                      // sb $a1, login($s0)
    a1 = a0 + 0;                         // daddi $a1, $a0, 0 ; make $a1 the larger value
    s1 = s0 + 0;                         // daddi $s1, $s0, 0 ; save the last swap position
main_count_no_swap:             // main_count_no_swap:
    s0 = s0 + 1;                         // daddi $s0, $s0, 1
    a0 = login[s0];                      // lb $a0, login($s0)
    if (a0 != 0) goto main_count;        // bnez $a0, main_count
                                // ; main_count_end:

                                         // ; $s0 = index
                                         // ; $s1 = last swap
                                         // ; $s2 = length
main_outer:                     // main_outer: ; outer bubble sort loop
    s2 = s1 + 0;                         // daddi $s2, $s1, 0
    s0 = zero + 1;                       // daddi $s0, $zero, 1

                                         // ; inner loop preparation
    a1 = login[zero];                    // lb $a1, login($zero)

                                         // ; inner loop half unwrapped
    s1 = zero + 1;                       // daddi $s1, $zero, 1
    a0 = login[s0];                      // lb $a0, login($s0)
main_inner:                     // main_inner: ; inner bubble sort loop
                                         // ; comapre $a0 and $a1
    t0 = a1 - a0;                        // dsub $t0, $a1, $a0
    if (t0 > 0) goto main_inner_no_swap; // bgez $t0, main_inner_no_swap
                                         // ; $a0 = login($s0) is the larger value, set there the smaller
    login[s0] = a1;                      // sb $a1, login($s0)
    a1 = a0 + 0;                         // daddi $a1, $a0, 0 ; make $a1 the larger value
    s1 = s0 + 0;                         // daddi $s1, $s0, 0 ; save the last swap position
main_inner_no_swap:             // main_innser_no_swap:
    s0 = s0 + 1;                         // daddi $s0, $s0, 1
    a0 = login[s0];                      // lb $a0, login($s0)
    if (s0 != s2) goto main_inner;       // bne $s0, $s2, main_inner
                                // main_inner_end:

    t0 = s1 + -1;                        // daddi $t0, $s1, -1
    if (t0 != 0) goto main_outer;        // bnez $t0, main_outer
                                // main_outer_end:

main_end:
        printf("%s", login);
}
