#include <stdio.h>

int main(void) {
    // rewrite the asm code in C so that i can debug it more esily :)
    char login[] = "vitejte-v-inp-2023\0";
    char counts[256] = {};
    printf("%s\n", login);

    int s0, s1, s2, s3, s4, s5, s7, t0, v1, zero = 0; // registers
    int v0, a0, a1, a3, t2, t3, t4, t5, a2;
    // many spaces to align the line numbers with the other file



























        // ; Bucket sort

        // ; count occurences
        // ; s0: index
        // ; a0: current item
        // ; v0: 256
        // ; t0: count
        s0 = zero + 0; // daddi $s0, $zero, 256
        v0 = zero + 256; // daddi $s0, $zero, 256
        a0 = (unsigned char)login[s0]; // lbu $a0, login($s0)
        if (a0 == 0) goto main_end; // beqz $a0, main_end
count:
        t0 = counts[a0]; // lb $t0, counts($a0)
        t0 = t0 + 1; // daddi $t0, $t0, 1
        counts[a0] = t0; // sb $t0, counts($a0)
        s0 = s0 + 1; // daddi $s0, $s0, 1
        a0 = (unsigned char)login[s0]; // lbu $a0, login($s0)
        if (a0 != 0) goto count; // bnez $a0, count

        a0 = zero + 0; // daddi $a0, $zero, 0
        s0 = zero + 0; // daddi $s0, $zero, 0
generate:
        t0 = (unsigned char)counts[a0]; // lbu $s0, counts($a0)

        if (t0 == 0) goto generate_inner_end; // beqz $t0, generate_inner_end
generate_inner:
        login[s0] = a0; // sb $a0, login($s0)
        t0 = t0 + -1; // daddi $t0, $t0, -1
        s0 = s0 + 1; // daddi $s0, $s0, 1
        if (t0 != 0) goto generate_inner; // bnez $t0, generate_inner
generate_inner_end:
        a0 = a0 + 1; // daddi $a0, $a0, 1
        if (a0 != v0) goto generate; // bne $a0, $v0, generate

main_end:
        printf("%s\n", login);
}
