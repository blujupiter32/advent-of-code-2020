#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int check(int ip, int acc, int ops[], int args[], int visits[]) {
    int local_visits[600];
    for (int i = 0; i < 600; i++) {
        local_visits[i] = visits[i];
    }
    local_visits[ip] = 0;
    while (!local_visits[ip]) {
        local_visits[ip]++;
        switch (ops[ip]) {
        case 1:
            acc += args[ip];
            break;
        case 2:
            ip += args[ip];
            goto skip_inc;
        }
        ip++;
    skip_inc:
        if (ip > 594 || ip < 0) {
            break;
        }
    }
    return local_visits[ip] ? 0 : acc;
}

int main() {
    int ops[600], args[600], visits[600], acc = 0, ip = 0;
    for (int i = 0; i < 600; i++) {
        ops[i] = 0; args[i] = 0; visits[i] = 0;
    }
    FILE *file = fopen("input.txt", "r");
    char *line;
    size_t len;
    ssize_t read;
    int i = 0;
    while ((read = getline(&line, &len, file)) != -1) {
        switch (*line) {
        case 'a':
            ops[i] = 1;
            break;
        case 'j':
            ops[i] = 2;
        }
        line += 3;
        args[i] = atoi(line);
        i++;
    }
    int result;
    while (!visits[ip]) {
        visits[ip]++;
        switch (ops[ip]) {
        case 0:
            ops[ip] = 2;
            result = check(ip, acc, ops, args, visits);
            if (result) {
                goto print_result;
            }
            ops[ip] = 0;
            break;
        case 1:
            acc += args[ip];
            break;
        case 2:
            ops[ip] = 0;
            result = check(ip, acc, ops, args, visits);
            if (result) {
                goto print_result;
            }
            ops[ip] = 2;
            ip += args[ip];
            goto skip_inc;
        }
        ip++;
    skip_inc:;
    }
print_result:
    printf("%d\n", result);
    return 0;
}
