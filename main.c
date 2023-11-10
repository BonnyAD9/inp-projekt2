#include <stdio.h>

int main(void) {
    // rewrite the asm code in C so that i can debug it more esily :)
    char login[] = "vitejte-v-inp-2023\0";
    printf("%s\n", login);

    int s0, s1, s2, s3, s4, s5, s7, t0, v1, zero = 0; // registers
    char a0, a1, a3, t2, t3, t4, t5, a2;
    // many spaces to align the line numbers with the other file















        // ; Insert sort

        // ; List of used registers and their usage/meaning:
        // ; s0:     index of first unsorted item
        // ; s1, s2: indexes
        // ; a0:     inserted item
        // ; a1, a2: items from login
        // ; t0:     temorary (used in conditions)
        // ; v1:     1
        s0 = zero + 1; // daddi $s0, $zero, 1
        s1 = zero + 2; // daddi $s1, $zero, 2
        v1 = zero + 1; // daddi $v1, $zero, 1
        a0 = login[zero]; // lb $a0, login($zero)
        if (a0 == 0) goto main_end; // beqz $a0, main_end

outer:
        s2 = s0 + -1; // daddi $s2, $s0, -1
        s3 = s1 + 0; // daddi $s3, $s1, 0
        a0 = login[s0]; // lb $a0, login($s0)
        if (a0 == 0) goto main_end; // beqz $a0, main_end
        a1 = login[s1]; // lb $a1, login($s1)
        if (a1 == 0) goto single_prep; // beqz $a1, single_prep
        t0 = a1 < a0; // sltu $t0, $a1, $a0
        if (t0 == 0) goto insert_double; // beqz $t0, no_swap
        a1 = login[s0]; // lb $a1, login($s0)
        a0 = login[s1]; // lb $a0, login($s1)

insert_double:
        a2 = login[s2]; // lb $a2, login($s2)
        t0 = a1 < a2; // sltu $t0, $a1, $a2
        if (t0 == 0) goto insert_single_prep; // beqz $t0, insert_single_prep
        login[s3] = a2; // sb $a2, login($s3)
        s2 = s2 + -1; // daddi $s2, $s2, -1
        s3 = s3 + -1; // daddi $s3, $s3, -1
        if (s2 >= 0) goto insert_double; // bgez $s2, insert_double

// ; inner_insert_double_end:
        login[zero] = a0; // sb $a0, login($zero)
        login[v1] = a1; // sb $a1, login($v1)
        s0 = s0 + 2; // daddi $s0, $s0, 2
        s1 = s1 + 2; // daddi $s1, $s1, 2
        goto outer; // j outer

insert_single_prep:
        login[s3] = a1; // sb $a1, login($s3)
single_prep:
        s3 = s3 + -1; // daddi $s3, $s3, -1

insert_single:
        a2 = login[s2]; // lb $a2, login($s2)
        t0 = a0 < a2; // sltu $t0, $a0, $a2
        if (t0 == 0) goto inner_end; // beqz $t0, inner_end
        login[s3] = a2; // sb $a2, login($s3)
        s2 = s2 + -1; // daddi $s2, $s2, -1
        s3 = s3 + -1; // daddi $s3, $s3, -1
        if (s2 >= 0) goto insert_single; // bgez $s2, insert_single

// ; inner_insert_single_end:
        login[zero] = a0; // sb $a0, login($zero)
        s0 = s0 + 2; // daddi $s0, $s0, 2
        s1 = s1 + 2; // daddi $s1, $s1, 2
        goto outer; // j outer

inner_end:
        login[s3] = a0; // sb $a0, login($s3)
        s0 = s0 + 2; // daddi $s0, $s0, 2
        s1 = s1 + 2; // daddi $s1, $s1, 2
        goto outer; // j outer

main_end:
        printf("%s\n", login);
}
