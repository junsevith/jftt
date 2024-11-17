%{
#include <stdio.h>
#include <string.h>

int line_count = 0;  // Liczba linii
int word_count = 0;  // Liczba słów
%}

%%

--.*$ {}

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

    return 0;

}
