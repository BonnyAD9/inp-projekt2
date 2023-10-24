#include <stdio.h>

int main(void) {
    // rewrite the asm code in C so that i can debug it more esily :)
    char login[] = "vitejte-v-inp-2023\0";
    printf("%s\n", login);

    int s0, s1, s2, s3, s4, s5, s7, t0, v1, zero = 0; // registers
    char a0, a1, a3, t2, t3, t4, t5, a2;
    // many spaces to align the line numbers with the other file



















        // // ; Insert sort

        s0 = zero + 1; // daddi $s0, $zero, 1
        a0 = login[zero]; // lb $a0, login($zero)
        ;;;;;;;;;;;;;;;;;;;;;;
        ;;;;;;;;;;;;;;;;;;;;;;
        if (a0 == 0) goto main_end; // beqz $a0, main_end

        a0 = login[s0]; // lb $a0, login($s0)
        s1 = s0 + 1; // daddi $s1, $s0, 1
        if (a0 == 0) goto main_end; // beqz $a0, main_end
        goto last_inner; // j last_inner
outer:
        a1 = login[s2]; // lb $a1, login($s2)
        s0 = s0 + 1; // daddi $s0, $s0, 1

        // ; s2, --, s1
inner:
        s2 = s2 + -1; // daddi $s2, $s2, -1
        t0 = a0 - a1; // dsub $t0, $a0, $a1
        ;;;;;;;;;;;;;;;;;;;;;;
        ;;;;;;;;;;;;;;;;;;;;;;

        if (t0 >= 0) goto inner_end; // bgez $t0, inner_end
        a2 = login[s2]; // lb $a2, login($s2)
        login[s1] = a1; // sb $a1, login($s1)
        s1 = s1 + -1; // daddi $s1, $s1, -1
        if (s2 == 0) goto last_inner; // beqz $s2, last_inner

        s2 = s2 + -1; // daddi $s2, $s2, -1
        t0 = a0 - a2; // dsub $t0, $a0, $a2
        ;;;;;;;;;;;;;;;;;;;;;;
        ;;;;;;;;;;;;;;;;;;;;;;

        if (t0 >= 0) goto inner_end; // bgez $t0, inner_end
        a1 = login[s2]; // lb $a1, login($s2)
        login[s1] = a2; // sb $a2, login($s1)
        s1 = s1 + -1; // daddi $s1, $s1, -1
        if (s2 != v1) goto inner; // bne $s2, $v1, inner
last_inner:
        a1 = login[zero]; // lb $a1, login($zero)
        ;;;;;;;;;;;;;;;;;;;;;;
        ;;;;;;;;;;;;;;;;;;;;;;
        t0 = a0 - a1; // dsub $t0, $a0, $a1
        s1 = s2 + 0; // daddi $s1, $s2, 0
        ;;;;;;;;;;;;;;;;;;;;;;
        if (t0 >= 0) goto inner_end; // bgez $t0, inner_end
        login[s2] = a1; // sb $a1, login($s2)

        login[zero] = a0; // sb $a0, login($zero)
        a0 = login[s0]; // lb $a0, login($s0)
        s1 = s0 + 0; // daddi $s1, $s0, 0
        s3 = s0 + -1; // daddi $s3, $s0, -1
        s2 = s0 + -2; // daddi $s2, $s0, -2
        if (a0 != 0) goto outer; // bnez $a0, outer
inner_end:
        login[s1] = a0; // sb $a0, login($s1)
        a0 = login[s0]; // lb $a0, login($s0)
        s1 = s0 + 0; // daddi $s1, $s0, 0
        s3 = s0 + -1; // daddi $s3, $s0, -1
        s2 = s0 + -2; // daddi $s2, $s0, -2
        if (a0 != 0) goto outer; // bnez $a0, outer

main_end:
        printf("%s\n", login);
}
