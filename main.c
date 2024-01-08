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

        v0 = zero + -1; // daddi $v0, $zero, -1
        s0 = zero + 1; // daddi $s0, $zero, 1
        s1 = zero + 0; // daddi $s1, $zero, 0
        a0 = login[zero]; // lb $a0, login($zero)
        // ; nop
        // ; nop
        if (a0 == 0) goto main_end; // beqz $a0, main_end

        a1 = login[s0]; // lb $a1, login($s0)
        // ; nop
        // ; nop
        if (a1 == 0) goto main_end; // beqz $a1, main_end
max:
        t0 = a1 < a0; // slt $t0, $a1, $a0
        a2 = a1 + 0; // daddi $a2, $a1, 0
        s0 = s0 + 1; // daddi $s0, $s0, 1

        if (t0 == 0) goto less; // beqz $t0, less
        a2 = a0 + 0; // daddi $a2, $a0, 0
        a0 = a1 + 0; // daddi $a0, $a1, 0

less:
        a1 = login[s0]; // lb $a1, login($s0)
        login[s1] = a2; // sb $a2, login($s1)
        s1 = s1 + 1; // daddi $s1, $s1, 1
        if (a1 != 0) goto max; // bnez $a1, max

max_end:
        s0 = s0 + -3; // daddi $s0, $s0, -3
        // ; nop
        // ; nop
        if (s0 == v0) goto main_end_store; // beq $s0, $v0, main_end_store

outer:
        s3 = s0 + 1; // daddi $s3, $s0, 1
        login[s1] = a0; // sb $a0, login($s1)

        a0 = login[s0]; // lb $a0, login($s0)
        a1 = login[s3]; // lb $a1, login($s3)

        s2 = s0 + 2; // daddi $s2, $s0, 2
        s1 = s0 + 0; // daddi $s1, $s0, 0
        t0 = a1 < a0; // sltu $t0, $a1, $a0
        s0 = s0 + -1; // daddi $s0, $s0, -1
        a2 = login[s2]; // lb $a2, login($s2)
        if (t0 == 0) goto insert_end; // beqz $t0, insert_end

insert:
        login[s1] = a1; // sb $a1, login($s1)
        s2 = s2 + 1; // daddi $s2, $s2, 1
        t0 = a2 < a0; // sltu $t0, $a2, $a0
        s1 = s1 + 1; // daddi $s1, $s1, 1
        a1 = login[s2]; // lb $a1, login($s2)
        if (t0 == 0) goto insert_end; // beqz $t0, insert_end

        login[s1] = a2; // sb $a2, login($s1)
        s2 = s2 + 1; // daddi $s2, $s2, 1
        t0 = a1 < a0; // sltu $t0, $a1, $a0
        s1 = s1 + 1; // daddi $s1, $s1, 1
        a2 = login[s2]; // lb $a2, login($s2)
        if (t0 != 0) goto insert; // bnez $t0, insert
insert_end:
        if (s0 != v0) goto outer; // bne $s0, $v0, outer

main_end_store:
        login[s1] = a0; // sb $a0, login($s1)


main_end:
        printf("%s\n", login);
}
