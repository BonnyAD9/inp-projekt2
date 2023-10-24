#include <stdio.h>

int main(void) {
    // rewrite the asm code in C so that i can debug it more esily :)
    char login[] = "vitejte-v-inp-2023\0";
    printf("%s\n", login);

    int s0, s1, s2, s3, s4, s5, t0, a2, t1, t2, zero = 0; // registers
    char a0, a1, v0;
    // many spaces to align the line numbers with the other file



















        // ; Insert sort

        // ; $a0: current value
        // ; $s0: first unsorted
        // ; $s1, $s2: inner_4_more index
        // ; $s3, $s4: inner_3_less index
        // ; $s5: result index
        // ; $t0: temporary
        // ; $v0: 8
        a0 = login[zero]; // lb $a0, login($zero)
        s0 = zero + 1; // daddi $s0, $zero, 1
        t1 = zero + -2; // daddi $t1, $zero, -2
        if (a0 == 0) goto main_end; // beqz $a0, main_end

outer:
        s4 = s0 + 1; // daddi $s4, $s0, 1
        t1 = zero - t1; // dsub $t1, $zero, $t1
        s3 = s0 + -1; // daddi $s3, $s0, -1
        s0 = s0 + 1; // daddi $s0, $s0, 1
        // ; $s1 $s2 --- $s3 $s4
        // ;                 $s0
        // ; $a0 = login1[$s0]
        // ; $a1 = login1[$s1]
        // ; $a2 = login4[$s1]

        // ; t0 = s4 & 0x7; // andi $t0, $s4, 0x7
        // ; if (t0 == 0) goto inner_4_uneaven; // beqz $t0, inner_4_uneaven

inner_3_less:
        s4 = s4 + -1; // daddi $s4, $s4, -1

        a1 = login[s3]; // lb $a1, login($s3)
        ;;;;;;;;;;;;;;;;;;;;;
        t2 = s4 & 0x3; // andi $t2, $s4, 0x3
        t0 = a0 - a1; // dsub $t0, $a0, $a1
        login[s4] = a1; // sb $a1, login($s4)
        s1 = s4 + -4; // daddi $s1, $s4, -4
        ;;;;;;;;;;;;;;;;;;;;;
        if (t0 >= 0) goto inner_end; // bgez $t0, inner_end

        if (t2 != 0) goto inner_3_less; // bnez $t2, inner_3_less

        if (s4 == 0) goto inner_end; // beqz $s4, inner_end

inner_4_more:
        a1 = login[s1]; // lb $a1, login($s1)
        ;;;;;;;;;;;;;;;;;;;;;
        ;;;;;;;;;;;;;;;;;;;;;
        t0 = a0 - a1; // dsub $t0, $a0, $a1
        if (s4 == 0) goto inner_end; // beqz $s4, inner_end
        s3 = s4 + -1; // daddi $s3, $s4, -1
        if (t0 >= 0) goto inner_3_less; // bgez $t0, inner_3_less

        a2 = *(int *)(login + s1); // lw $a2, login($s1)
        ;;;;;;;;;;;;;;;;;;;;;
        ;;;;;;;;;;;;;;;;;;;;;
        t0 = a2 << 8; // dsll $t0, $a2, 8
        ;;;;;;;;;;;;;;;;;;;;;
        ;;;;;;;;;;;;;;;;;;;;;
        *(int *)(login + s1) = t0; // sw $t0, login($s1)
        ;;;;;;;;;;;;;;;;;;;;;
        ;;;;;;;;;;;;;;;;;;;;;
        t0 = a2 >> 24; // dsrl $t0, $a2, 24
        s1 = s1 + -4; // daddi $s1, $s1, -4
        ;;;;;;;;;;;;;;;;;;;;;
        login[s4] = t0; // sb $t0, login($s4)

        s4 = s4 + -4; // daddi $s4, $s4, -4
        if (s1 >= 0) goto inner_4_more; // bgez $s1, inner_4_more

        ;;;;;;;;;;;;;;;;;;;;;
        login[s4] = a0; // sb $a0, login($s4)
        a0 = login[s0]; // lb $a0, login($s0)
        t1 = s0 + -3; // daddi $t1, $s0, -3
        ;;;;;;;;;;;;;;;;;;;;;
        if (a0 != 0) goto outer; // bnez $a0, outer

inner_end:
        login[s4] = a0; // sb $a0, login($s4)
        a0 = login[s0]; // lb $a0, login($s0)
        t1 = s0 + -3; // daddi $t1, $s0, -3
        ;;;;;;;;;;;;;;;;;;;;;
        if (a0 != 0) goto outer; // bnez $a0, outer

main_end:
        printf("%s\n", login);
}
