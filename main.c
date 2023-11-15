#include <stdio.h>

int main(void) {
    // rewrite the asm code in C so that i can debug it more esily :)
    char login[] = "vitejte-v-inp-2023\0";
    printf("%s\n", login);

    int s0, s1, s2, s3, s4, s5, s7, t0, v0, v1, zero = 0; // registers
    char a0, a1, a3, t2, t3, t4, t5, a2;
    // many spaces to align the line numbers with the other file















        v1 = zero + 1; // daddi $v1, $zero, 1
        v0 = zero + 2; // daddi $v0, $zero, 2
        a0 = login[zero]; // lb $a0, login($zero)
        s0 = zero + 2; // daddi $s0, $zero, 2
        s1 = zero + 3; // daddi $s1, $zero, 3
        if (a0 == 0) goto main_end; // beqz $a0, main_end
        s2 = zero + 1; // daddi $s2, $zero, 1
        s3 = zero + 3; // daddi $s3, $zero, 3
        a1 = login[v1]; // lb $a1, login($v1)
        // ; nop
        // ; nop
        if (a1 == 0) goto main_end; // beqz $a1, main_end

        t0 = a1 < a0; // sltu $t0, $a1, $a0
        if (t0 == 0) goto outer; // beqz $t0, outer
        login[v1] = a0; // sb $a0, login($v1)
        login[zero] = a1; // sb $a1, login($zero)

outer:
        a1 = login[s1]; // lb $a1, login($s1)
        // ; nop
        // ; nop
        if (a1 == 0) goto single_prep; // beqz $a1, single_prep
        t0 = a1 < a0; // sltu $t0, $a1, $a0
        // ; nop
        // ; nop
        if (t0 == 0) goto insert_double_prep; // beqz $t0, insert_double_prep
        a1 = login[s0]; // lb $a1, login($s0)
        a0 = login[s1]; // lb $a0, login($s1)

insert_double_prep:
        t0 = s2 & v1; // and $t0, $s2, $v1
        if (t0 != 0) goto insert_double; // bnez $t0, insert_double
        a2 = login[s2]; // lb $a2, login($s2)
        t0 = a1 < a2; // sltu $t0, $a1, $a2
        if (t0 == 0) goto insert_single_prep; // beqz $t0, insert_single_prep
        login[s3] = a2; // sb $a2, login($s3)
        s2 = s2 + -1; // daddi $s2, $s2, -1
        s3 = s3 + -1; // daddi $s3, $s3, -1

insert_double:
        a2 = login[s2]; // lb $a2, login($s2)
        t0 = a1 < a2; // sltu $t0, $a1, $a2
        if (t0 == 0) goto insert_single_prep; // beqz $t0, insert_single_prep

        login[s3] = a2; // sb $a2, login($s3)
        s2 = s2 + -1; // daddi $s2, $s2, -1
        s3 = s3 + -1; // daddi $s3, $s3, -1

        a2 = login[s2]; // lb $a2, login($s2)
        t0 = a1 < a2; // sltu $t0, $a1, $a2
        if (t0 == 0) goto insert_single_prep; // beqz $t0, insert_single_prep

        login[s3] = a2; // sb $a2, login($s3)

        s2 = s2 + -1; // daddi $s2, $s2, -1
        s3 = s3 + -1; // daddi $s3, $s3, -1
        if (s2 != 0) goto insert_double; // bnez $s2, insert_double

        goto inner_end; // j inner_end

insert_single_prep:
        login[s3] = a1; // sb $a1, login($s3)
single_prep:
        s3 = s3 + -1; // daddi $s3, $s3, -1
        s4 = s2 + -1; // daddi $s4, $s2, -1

insert_single_cmp:
        t0 = s2 & v1; // and $t0, $s2, $v1
        if (t0 != 0) goto insert_single_jmp; // bnez $t0, insert_single_jmp
        a2 = login[s2]; // lb $a2, login($s2)
        t0 = a0 < a2; // sltu $t0, $a0, $a2
        if (t0 == 0) goto insert_single_end3; // beqz $t0, insert_single_end3
        login[s3] = a2; // sb $a2, login($s3)
        s2 = s2 + -1; // daddi $s2, $s2, -1
        s3 = s3 + -1; // daddi $s3, $s3, -1
        s4 = s4 + -1; // daddi $s4, $s4, -1

insert_single_jmp:
        if (s3 == 0) goto insert_single_end3; // beqz $s3, inner_end
insert_single:
        a2 = login[s2]; // lb $a2, login($s2)
        t0 = a0 < a2; // sltu $t0, $a0, $a2
        if (t0 == 0) goto insert_single_end3; // beqz $t0, insert_single_end3

        login[s3] = a2; // sb $a2, login($s3)

        a2 = login[s4]; // lb $a2, login($s4)
        t0 = a0 < a2; // sltu $t0, $a0, $a2
        if (t0 == 0) goto insert_single_end2; // beqz $t0, insert_single_end2

        login[s2] = a2; // sb $a2, login($s2)

        s4 = s4 + -2; // daddi $s4, $s4, -2
        s2 = s2 + -2; // daddi $s2, $s2, -2
        s3 = s3 + -2; // daddi $s3, $s3, -2
        if (s4 >= 0) goto insert_single; // bgez $s4, insert_single
        goto inner_end; // j inner_end

insert_single_end3:
        login[s3] = a0; // sb $a0, login($s3)
        goto inner_end; // j inner_end

insert_single_end2:
        login[s2] = a0; // sb $a0, login($s2)

        // ; nop
inner_end:
        s0 = s0 + 2; // daddi $s0, $s0, 2
        s1 = s1 + 2; // daddi $s1, $s1, 2
        s2 = s0 + -1; // daddi $s2, $s0, -1
        s3 = s1 + 0; // daddi $s3, $s1, 0
        a0 = login[s0]; // lb $a0, login($s0)
        // ; nop
        // ; nop
        if (a0 != 0) goto outer; // bnez $a0, outer

main_end:
        printf("%s\n", login);
}
