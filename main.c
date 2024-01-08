#include <stdio.h>

int main(void) {
    // rewrite the asm code in C so that i can debug it more esily :)
    char login[] = "vitejte-v-inp-2023\0";
    // char login[] = "vvttpnjiiee3220---\0";
    // char login[] = "abcdef\0";
    printf("%s\n", login);

    int s0, s1, s2, s3, s4, s5, s7, t0, v1, v0, t1, zero = 0; // registers
    char a0, a1, a3, t2, t3, t4, t5, a2;
    // many spaces to align the line numbers with the other file















        // ; Insert sort (improoved)

        s0 = zero + 1; // daddi $s0, $zero, 1
        v0 = zero + -1; // daddi $v0, $zero, -1
        s1 = zero + 0; // daddi $s1, $zero, 0
        a0 = login[zero]; // lb $a0, login($zero)
        if (a0 == 0) goto main_end; // beqz $a0, main_end

        a1 = login[s0]; // lb $a1, login($s0)
        if (a1 == 0) goto main_end; // beqz $a1, main_end
max:
        t0 = a1 < a0; // slt $t0, $a1, $a0
        if (t0 != 0) goto smaller; // bnez $t0, smaller
        login[s1] = a0; // sb $a0, login($s1)
        a0 = a1 + 0; // daddi $a0, $a1, 0
        s0 = s0 + 1; // daddi $s0, $s0, 1
        s1 = s1 + 1; // daddi $s1, $s1, 1
        a1 = login[s0]; // lb $a1, login($s0)
        if (a1 != 0) goto max; // bnez $a1, max
        goto max_end; // j max_end
smaller:
        login[s1] = a1; // sb $a1, login($s1)
        s0 = s0 + 1; // daddi $s0, $s0, 1
        s1 = s1 + 1; // daddi $s1, $s1, 1
        a1 = login[s0]; // lb $a1, login($s0)
        if (a1 != 0) goto max; // bnez $a1, max

max_end:
        login[s1] = a0; // sb $a0, login($s0)
        s0 = s0 + -2; // daddi $s0, $s0, -1

        if (s0 == 0) goto main_end; // beqz $s0, main_end

outer:
        s0 = s0 + -1; // daddi $s0, $s0, -1
        a0 = login[s0]; // lb $a0, login($s0)

        s1 = s0 + 0; // daddi $s1, $s0, 0
        s2 = s0 + 1; // daddi $s2, $s0, 1

        a1 = login[s2]; // lb $a1, login($s2)
        t0 = a1 < a0; // sltu $t0, $a1, $a0
        s2 = s2 + 1; // daddi $s2, $s2, 1
        if (t0 == 0) goto insert_end; // beqz $t0, insert_end

insert:
        login[s1] = a1; // sb $a1, login($s1)
        s1 = s1 + 1; // daddi $s1, $s1, 1
        a1 = login[s2]; // lb $a1, login($s2)
        t0 = a1 < a0; // sltu $t0, $a1, $a0
        s2 = s2 + 1; // daddi $s2, $s2, 1
        if (t0 != 0) goto insert; // bnez $t0, insert
insert_end:
        login[s1] = a0; // sb $a0, login($s1)

        if (s0 != 0) goto outer; // bnez $s0, outer

main_end:
        printf("%s\n", login);
}
