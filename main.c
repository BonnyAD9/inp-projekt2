#include <stdio.h>

int main(void) {
    // rewrite the asm code in C so that i can debug it more esily :)
    // char login[] = "vitejte-v-inp-2023\0";
    // char login[] = "vvttpnjiiee3220---\0";
    char login[] = "abcdef\0";
    printf("%s\n", login);

    int s0, s1, s2, s3, s4, s5, s7, t0, v1, v0, t1, zero = 0; // registers
    char a0, a1, a3, t2, t3, t4, t5, a2;
    // many spaces to align the line numbers with the other file















        // ; Insert sort

        // ; The basic idea is insert sort, but insert two items at the same time.

        // ; List of used registers and their usage/meaning:
        // ; s0, s1: index of first 2 unsorted items
        // ; s2, s3: indexes in the inner loops
        // ; a0, a1: ordered items to insert
        // ; a2, a3: items from login
        // ; t0, t1: temorary (used in conditions)
        // ; v1:     1
        // ; v0:     2
        a0 = login[zero]; // lb $a0, login($zero)
        v1 = zero + 1; // daddi $v1, $zero, 1
        v0 = zero + 2; // daddi $v0, $zero, 2
        if (a0 == 0) goto main_end; // beqz $a0, main_end
        a1 = login[v1]; // lb $a1, login($v1)
        s2 = zero + 1; // daddi $s2, $zero, 1
        s3 = zero + 3; // daddi $s3, $zero, 3
        if (a1 == 0) goto main_end; // beqz $a1, main_end
        t0 = a1 < a0; // sltu $t0, $a1, $a0
        s0 = zero + 2; // daddi $s0, $zero, 2
        s1 = zero + 3; // daddi $s1, $zero, 3
        if (t0 == 0) goto outer; // beqz $t0, outer
        login[v1] = a0; // sb $a0, login($v1)
        login[zero] = a1; // sb $a1, login($zero)

outer:
        a1 = login[s1]; // lb $a1, login($s1)

        a2 = login[s2]; // lb $a2, login($s2)
        s2 = s2 + -1; // daddi $s2, $s2, -1

        t1 = a1 < a0; // sltu $t1, $a1, $a0
        if (a1 == 0) goto single_prep; // beqz $a1, single_prep

        t0 = a1 < a2; // sltu $t0, $a1, $a2

        if (t1 == 0) goto insert_double; // beqz $t1, insert_double
        a1 = login[s0]; // lb $a1, login($s0)
        a0 = login[s1]; // lb $a0, login($s1)

insert_double:
        if (t0 == 0) goto insert_single_prep; // beqz $t0, insert_single_prep
        a3 = login[s2]; // lb $a3, login($s2)
        login[s3] = a2; // sb $a2, login($s3)
        s3 = s3 + -1; // daddi $s3, $s3, -1
        t0 = a1 < a3; // sltu $t0, $a1, $a3
        s2 = s2 + -1; // daddi $s2, $s2, -1
        if (s3 == v0) goto insert_double_last; // beq $s3, $v0, insert_double_last

        if (t0 == 0) goto insert_single_prep3; // beqz $t0, insert_single_prep3
        a2 = login[s2]; // lb $a2, login($s2)
        login[s3] = a3; // sb $a3, login($s3)
        s3 = s3 + -1; // daddi $s3, $s3, -1
        t0 = a1 < a2; // sltu $t0, $a1, $a2
        s2 = s2 + -1; // daddi $s2, $s2, -1
        if (s3 != v0) goto insert_double; // bne $s3, $v0, insert_double

// ; insert_double_last:
        t1 = a0 < a2; // sltu $t1, $a0, $a2
        s0 = s0 + 2; // daddi $s0, $s0, 2
        s1 = s1 + 2; // daddi $s1, $s1, 2
        if (t0 == v1) goto insert_double_last012; // beq $t0, $v1, insert_double_last012

        if (t1 == v1) goto insert_double_last021; // beq $t1, $v1, insert_double_last021

// ; insert_double_last301:
        login[v1] = a0; // sb $a0, login($v1)
        login[v0] = a1; // sb $a1, login($v0)

        a0 = login[s0]; // lb $a0, login($s0)
        s2 = s0 + -1; // daddi $s2, $s0, -1
        s3 = s1 + 0; // daddi $s3, $s1, 0
        if (a0 != 0) goto outer; // bnez $a0, outer
        goto main_end; // j main_end
insert_double_last021:
        login[zero] = a0; // sb $a0, login($zero)
        login[v1] = a2; // sb $a2, login($v1)
        login[v0] = a1; // sb $a1, login($v0)

        a0 = login[s0]; // lb $a0, login($s0)
        s2 = s0 + -1; // daddi $s2, $s0, -1
        s3 = s1 + 0; // daddi $s3, $s1, 0
        if (a0 != 0) goto outer; // bnez $a0, outer
        goto main_end; // j main_end
insert_double_last012:
        login[zero] = a0; // sb $a0, login($zero)
        login[v1] = a1; // sb $a1, login($v1)
        login[v0] = a2; // sb $a2, login($v0)

        a0 = login[s0]; // lb $a0, login($s0)
        s2 = s0 + -1; // daddi $s2, $s0, -1
        s3 = s1 + 0; // daddi $s3, $s1, 0
        if (a0 != 0) goto outer; // bnez $a0, outer
        goto main_end; // j main_end

insert_double_last:
        t1 = a0 < a3; // sltu $t1, $a0, $a3
        s0 = s0 + 2; // daddi $s0, $s0, 2
        s1 = s1 + 2; // daddi $s1, $s1, 2
        if (t0 == v1) goto insert_double_last013; // beq $t0, $v1, insert_double_last013

        if (t1 == v1) goto insert_double_last031; // beq $t1, $v1, insert_double_last031

// ; insert_double_last201:
        login[v1] = a0; // sb $a0, login($v1)
        login[v0] = a1; // sb $a1, login($v0)

        a0 = login[s0]; // lb $a0, login($s0)
        s2 = s0 + -1; // daddi $s2, $s0, -1
        s3 = s1 + 0; // daddi $s3, $s1, 0
        if (a0 != 0) goto outer; // bnez $a0, outer
        goto main_end; // j main_end
insert_double_last031:
        login[zero] = a0; // sb $a0, login($zero)
        login[v1] = a3; // sb $a3, login($v1)
        login[v0] = a1; // sb $a1, login($v0)

        a0 = login[s0]; // lb $a0, login($s0)
        s2 = s0 + -1; // daddi $s2, $s0, -1
        s3 = s1 + 0; // daddi $s3, $s1, 0
        if (a0 != 0) goto outer; // bnez $a0, outer
        goto main_end; // j main_end
insert_double_last013:
        login[zero] = a0; // sb $a0, login($zero)
        login[v1] = a1; // sb $a1, login($v1)
        login[v0] = a3; // sb $a3, login($v0)

        a0 = login[s0]; // lb $a0, login($s0)
        s2 = s0 + -1; // daddi $s2, $s0, -1
        s3 = s1 + 0; // daddi $s3, $s1, 0
        if (a0 != 0) goto outer; // bnez $a0, outer
        goto main_end; // j main_end

insert_single_prep3:
        login[s3] = a1; // sb $a1, login($s3)
        t0 = a0 < a3; // sltu $t0, $a0, $a3
        s3 = s3 + -1; // daddi $s3, $s3, -1
        goto insert_single2; // j insert_single2

single_prep:
        t0 = a0 < a2; // sltu $t0, $a0, $a2
        s3 = s3 + -1; // daddi $s3, $s3, -1
        goto insert_single; // j insert_single

insert_single_prep:
        t0 = a0 < a2; // sltu $t0, $a0, $a2
        login[s3] = a1; // sb $a1, login($s3)
        s3 = s3 + -1; // daddi $s3, $s3, -1

insert_single:
        if (t0 == 0) goto inner_single_end; // beqz $t0, inner_single_end
        a3 = login[s2]; // lb $a3, login($s2)
        login[s3] = a2; // sb $a2, login($s3)
        s3 = s3 + -1; // daddi $s3, $s3, -1
        t0 = a0 < a3; // sltu $t0, $a0, $a3
        s2 = s2 + -1; // daddi $s2, $s2, -1
        if (s3 == v1) goto insert_single_last; // beq $s3, $v1, insert_single_last

insert_single2:
        if (t0 == 0) goto inner_single_end; // beqz $t0, inner_single_end
        a2 = login[s2]; // lb $a2, login($s2)
        login[s3] = a3; // sb $a3, login($s3)
        s3 = s3 + -1; // daddi $s3, $s3, -1
        t0 = a0 < a2; // sltu $t0, $a0, $a2
        s2 = s2 + -1; // daddi $s2, $s2, -1
        if (s3 != v1) goto insert_single; // bne $s3, $v1, insert_single

// ; insert_single_last:
        s0 = s0 + 2; // daddi $s0, $s0, 2
        s1 = s1 + 2; // daddi $s1, $s1, 2
        if (t0 == v1) goto insert_single_last02; // beq $t0, $v1, insert_single_last02

        login[v1] = a0; // sb $a0, login($v1)

        a0 = login[s0]; // lb $a0, login($s0)
        s2 = s0 + -1; // daddi $s2, $s0, -1
        s3 = s1 + 0; // daddi $s3, $s1, 0
        if (a0 != 0) goto outer; // bnez $a0, outer
        goto main_end; // j main_end
insert_single_last02:
        login[zero] = a0; // sb $a0, login($zero)
        login[v1] = a2; // sb $a2, login($v1)

        a0 = login[s0]; // lb $a0, login($s0)
        s2 = s0 + -1; // daddi $s2, $s0, -1
        s3 = s1 + 0; // daddi $s3, $s1, 0
        if (a0 != 0) goto outer; // bnez $a0, outer
        goto main_end; // j main_end

insert_single_last:
        if (t0 == v1) goto insert_single_last03; // beq $t0, $v1, insert_single_last03

        login[v1] = a0; // sb $a0, login($v1)

        a0 = login[s0]; // lb $a0, login($s0)
        s2 = s0 + -1; // daddi $s2, $s0, -1
        s3 = s1 + 0; // daddi $s3, $s1, 0
        if (a0 != 0) goto outer; // bnez $a0, outer
        goto main_end; // j main_end
insert_single_last03:
        login[zero] = a0; // sb $a0, login($zero)
        login[v1] = a3; // sb $a3, login($v1)

        a0 = login[s0]; // lb $a0, login($s0)
        s2 = s0 + -1; // daddi $s2, $s0, -1
        s3 = s1 + 0; // daddi $s3, $s1, 0
        if (a0 != 0) goto outer; // bnez $a0, outer
        goto main_end; // j main_end

inner_single_end:
        s0 = s0 + 2; // daddi $s0, $s0, 2
        s1 = s1 + 2; // daddi $s1, $s1, 2
        login[s3] = a0; // sb $a0, login($s3)

        a0 = login[s0]; // lb $a0, login($s0)
        s2 = s0 + -1; // daddi $s2, $s0, -1
        s3 = s1 + 0; // daddi $s3, $s1, 0
        if (a0 != 0) goto outer; // bnez $a0, outer

main_end:
        printf("%s\n", login);
}
