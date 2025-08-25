# CS3300 Compiler Design – Assignment 1  
### C-like Language Lexer & Parser using Lex and Yacc  

## Overview  
This project implements a **lexer and parser** for a simplified C-like language using **Lex (Flex)** and **Yacc (Bison)**. The goal is to validate C-like programs according to the assignment specifications.  
- **Valid programs** → produce **no output**.  
- **Invalid programs** → print only the **first line number** where the error occurred.  

## Features  
- **Functions & Calls**: Supports function definitions and calls (`main`, `printf`).  
- **Declarations**: Global & local variable declarations. Errors on `static`, `const`, or unsupported types.  
- **Types**: `int`, `char`, `float`, `void`. 1D and 2D arrays supported, 3D arrays optional.  
- **Expressions**: Supports `()`, `+`, `-`, `*`, `/`, `**` (exponentiation).  
  - Precedence: `()` > `**` > `* /` > `+ -`.  
  - Associativity: `**` is right-associative, others left-associative.  
- **Assignments**: `lvalue = expression;`  
- **Conditionals**: `if`, `if-else` with `==`, `!=`, `<`, `<=`, `>`, `>=`.  
- **Loops**: `while`, `for`. Errors on `do-while`.  
- **Return Statements**: `return;` and `return <expr>;`.  
- **Print Statements**: `printf("string", var);`.  
- **Error Handling**: Unsupported constructs (`switch`, `struct`, `union`, `typedef`, `#define`, etc.) → error. First error line printed, parsing stops.  

## Project Structure  
```
├── lexer.l        # Lex (Flex) file for tokenization
├── parser.y       # Yacc (Bison) file for grammar and parsing
├── README.md      # Project documentation
```

## Compilation & Execution  
1. Generate Lexer & Parser  
```bash
flex lexer.l
bison -d parser.y
gcc lex.yy.c parser.tab.c -o parser
```
2. Run on a Test Program  
```bash
./parser < test.c
```
- If the program is **valid**, no output.  
- If **invalid**, prints the first error line number.  

