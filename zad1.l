%{
#include <stdio.h>
#include <string.h>

int line_count = 0;  // Liczba linii
int word_count = 0;  // Liczba słów
%}

%%

[\n]+ {
    line_count++;
    printf("\n");
}

^[[:blank:]]+ {}

[[:blank:]]+$ {}

[[:blank:]]+ { 
    printf(" ");
}

[[:^space:]]+ { 
    word_count++;
    printf("%s", yytext);
}

%%

int yywrap() {}

int main(int argc, char **argv) {
    if (argc == 0) {
        printf("Please provide file as argument");
    } else if (argc > 1) {
        FILE *f = fopen(argv[1], "r");
        if (f == NULL) {
            perror("Error opening file");
            return 1;
        }
        yyin = f;
    }

    yylex();

    printf("\nLines: %d, Words: %d\n", line_count, word_count);

    return 0;

}
