#include <stdio.h>

int main(void) {
    // rewrite the asm code in C so that i can debug it more esily :)
    char login[] = "vitejte-v-inp-2023\0";
    printf("%s\n", login);

    int s0, s1, s2, s3, s4, s5, s7, t0, zero = 0; // registers
    char a0, a1, a3, t2, t3, t4, t5;
    // many spaces to align the line numbers with the other file



















                                            // ; Insert sort

                                            // ; $s0: unsorted index
                                            // ; $s1 - $s5: indexes
                                            // ; $s7: result index
                                            // ; $a0: current element
                                            // ; $a1: saved element
                                            // ; $t2 - $t5: elements
                                            // ; $t0 - t1: temporary
        a1 = login[zero];                   // lb $a1, login($zero)
        s0 = zero + 1;                      // daddi $s0, $zero, 1
        if (a1 == 0) goto main_end;         // beqz $a1, main_end

        a1 = login[s0];                     // lb $a1, login($s0)
        if (a1 == 0) goto main_end;         // beqz $a1, main_end
main_outer:
                                            // ; move $a1 to left while it is less than current value
                                            // ; $a1 is $a1 + 1 so that i can do comparision $a1 >= $a0
        a1 = a1 + 1;                        // daddi $a1, $a1, 1

        t0 = zero - t0;                     // dsub $t0, $zero, $s0
        s1 = s0 + 0;                        // daddi $s1, $s0, 0
        s2 = s0 - 1;                        // daddi $s2, $s0, -1
        t0 = t0 + 3;                        // daddi $t0, $t0, 3
        s0 = s0 + 1;                        // daddi $s0, $s0, 1
        if (t0 > 0) goto main_inner_3_less; // bgez $t0, main_inner_3_less

        s3 = s1 - 2;                        // daddi $s3, $s1, -2

main_inner_4_more:                  // main_inner_4_more:
                                            // ; $5 $4 $3 $2 $1
        t2 = login[s2];                     // lb $t2, login($s2)
        s4 = s1 + -3;                       // daddi $s4, $s1, -3
        s5 = s1 + -4;                       // daddi $s5, $s1, -4

        s7 = s2 + 0;                        // daddi $s7, $s2, 0
        t0 = a1 - t2;                       // dsub $t0, $a1, $t2
        t3 = login[s3];                     // lb $t3, login($s3)
        if (t0 > 0) goto main_inner_end;    // bgez $t0, main_inner_end

        login[s1] = t2;                     // sb $t2, login($s1)
        s7 = s3 + 0;                        // daddi $s7, $s3, 0
        t0 = a1 - t3;                       // dsub $t0, $a1, $t3
        s1 = s1 + -4;                       // daddi $s1, $s1, -4
        t4 = login[s4];                     // lb $t4, login($s4)
        if (t0 > 0) goto main_inner_end;    // bgez $t0, main_inner_end

        login[s2] = t3;                     // sb $t3, login($s2)
        s7 = s4 + 0;                        // daddi $s7, $s4, 0
        t0 = a1 - t4;                       // dsub $t0, $a1, $t4
        s2 = s2 + -4;                       // daddi $s2, $s2, -4
        t5 = login[s5];                     // lb $t5, login($s5)
        if (t0 > 0) goto main_inner_end;    // bgez $t0, main_inner_end

        login[s3] = t4;                     // sb $t4, login($s3)
        s7 = s5 + 0;                        // daddi $s7, $s5, 0
        t0 = a1 - t5;                       // dsub $t0, $a1, $t5
        s3 = s3 + -4;                       // daddi $s3, $s3, -4
        if (t0 > 0) goto main_inner_end;    // bgez $t0, main_inner_end

        login[s4] = t5;                     // sb $t5, login($s4)
        if (s4 > 0) goto main_inner_4_more; // bgez $s4, main_inner_4_more

                                            // ; unwrapped loop for 3 or less elements
                                            // ; two consecutive iterations are unwrapped into single iteration
                                            // ; first part of the loop is unwrapped
main_inner_3_less:                  // main_inner_3_less:
                                            // ; loop 3: $s2 $s1
        if (s1 == 0) goto main_inner_end;   // beqz $s1, main_inner_end

        a0 = login[s2];                     // lb $a0, login($s2)
        s3 = s2 + -1;                       // daddi $s3, $s2, -1

        t0 = a1 - a0;                       // dsub $t0, $a1, $a0
        if (t0 > 0) goto main_inner_end;    // bgez $t0, main_inner_end

        login[s1] = a0;                     // sb $a0, login($s1)
        s7 = s2 + 0;                        // daddi $s7, $s2, 0
        if (s2 == 0) goto main_inner_end;   // beqz $s2, main_inner_end

        s2 = s1 + -1;                       // daddi $s2, $s1, -1

                                            // ; loop 2: $s3 $s2 ($s1)
        a0 = login[s3];                     // lb $a0, login($s3)
        s1 = s3 + -1;                       // daddi $s1, $s3, -1

        t0 = a1 - a0;                       // dsub $t0, $a1, $a0
        if (t0 == 0) goto main_inner_end;   // bgez $t0, main_inner_end

        s7 = s3 + 0;                        // daddi $s7, $s3, 0
        login[s2] = a0;                     // sb $a0, login($s2)
        if (s3 == 0) goto main_inner_end;   // beqz $s3, main_inner_end

        s1 = s2 + -2;                       // daddi $s1, $s2, -2
        s7 = s1 + 0;                        // daddi $s7, $s1, 0

                                            // ; loop 1: $s1 $s3
        a0 = login[s1];                     // lb $a0, login($s1)

        t0 = a1 - a0;                       // dsub $t0, $a1, $a0
        if (t0 > 0) goto main_inner_end;    // bgez $t0, main_inner_end

        login[s3] = a0;                     // sb $a0, login($s3)

                                            // ; now i know that this is the first element
        s7 = zero + 0;                      // daddi $s7, $zero, 0

main_inner_end:                     // main_inner_end:
        a3 = login[s0];                     // lb $a3, login($s0)
        a1 = zero - 1;                      // daddi $a1, $zero, -1 ; subtract the 1 that was added
        login[s7] = a1;                     // sb $a1, login($s7)
        a1 = a3 + 0;                        // daddi $a1, $a3, 0
        if (a3 == 0) goto main_outer;       // beqz $a3, main_outer

// ; outer_end

main_end:
        printf("%s\n", login);
}
