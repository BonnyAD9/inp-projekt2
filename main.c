#include <stdio.h>

int main(void) {
    // rewrite the asm code in C so that i can debug it more esily :)
    char login[] = "vitejte-v-inp-2023\0";
    printf("%s\n", login);

    int s0, s1, s2, s3, s4, s5, s7, t0, zero = 0; // registers
    char a0, a1, a3, t2, t3, t4, t5;
    // many spaces to align the line numbers with the other file



















        // ; Insert sort

        s0 = zero + 1; // daddi $s0, $zero, 1
        a0 = login[zero]; // lb $a0, login($zero)
        if (a0 == 0) goto main_end; // beqz $a0, main_end
        a0 = login[s0]; // lb $a0, login($s0)
        if (a0 == 0) goto main_end; // beqz $a0, main_end
outer:
        s1 = s0 + 0; // daddi $s1, $s0, 0
        s2 = s0 + -1; // daddi $s2, $s0, -1
        a0 = login[s0]; // lb $a0, login($s0)
        s0 = s0 + 1; // daddi $s0, $zero, 1

        // ; s2, s1
inner:
        a1 = login[s2]; // lb $a1, login($s2)
        t0 = a0 - a1; // dsub $t0, $a0, $a1
        if (t0 >= 0) goto inner_end; // bgez $t0, inner_end
        login[s1] = a1; // sb $a1, login($s1)
        s2 = s2 + -1; // daddi $s2, $s2, -1
        s1 = s1 + -1; // daddi $s1, $s1, -1
        if (s2 >= 0) goto inner; // bnez $s2, inner
inner_end:
        login[s1] = a0; // sb $a0, login($s2)
        a0 = login[s0]; // lb $a0, login($s0)
        if (a0 != 0) goto outer; // bnez $a0, outer

// // ; outer_end

main_end:
        printf("%s\n", login);
}
