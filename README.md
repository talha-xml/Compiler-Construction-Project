<div align="center">

# Compiler Construction Project

Custom Urdu-inspired Programming Language using **Flex (Lex)** and **Bison (Yacc)**

---

<img src="https://img.shields.io/badge/Flex-2.6-blue">
<img src="https://img.shields.io/badge/Bison-3.8-green">
<img src="https://img.shields.io/badge/Language-C-orange">
<img src="https://img.shields.io/badge/Compiler-GCC-red">

</div>

---

# Introduction

This project implements a custom compiler front-end for a user-defined programming language developed for the Compiler Construction course.

The language uses Urdu-inspired keywords such as:

- `shuru`
- `khatam`
- `agar`
- `magar`
- `jabtak`
- `likho`
- `padho`

The compiler performs:

✔ Lexical Analysis
✔ Syntax Analysis
✔ Token Generation
✔ Error Detection
✔ Parse Validation

# Features

- Custom Programming Language
- Lexical Analyzer using Flex
- Syntax Analyzer using Bison
- Context-Free Grammar Implementation
- FIRST and FOLLOW Sets
- Parse Tree Construction
- Valid and Invalid Test Cases
- Error Reporting System
- Token Generation

---

# Language Keywords

| Keyword | Meaning              |
| ------- | -------------------- |
| ucp     | Program Start        |
| shuru   | Begin Block          |
| khatam  | End Block            |
| likho   | Print                |
| padho   | Input                |
| kaam    | Variable Declaration |
| agar    | If Statement         |
| magar   | Else Statement       |
| jabtak  | While Loop           |
| barhao  | Increment            |
| ghatao  | Decrement            |
| rukjao  | Pause                |
| wapas   | Return               |

---

# Project Structure

```text
.
├── scanner.l
├── parser.y
├── lex.yy.c
├── parser.tab.c
├── parser.tab.h
├── valid.txt
├── invalid.txt
├── tokens.txt
├── error.txt
├── scanner
├── parser
├── Documentation - Phase 1.pdf
├── Documentation - Phase 2.pdf
└── Video Demonstrations
```

# File Description

| File         | Purpose              |
| ------------ | -------------------- |
| scanner.l    | Lexical rules        |
| parser.y     | Grammar rules        |
| lex.yy.c     | Generated scanner    |
| parser.tab.c | Generated parser     |
| parser.tab.h | Token definitions    |
| valid.txt    | Valid input programs |
| invalid.txt  | Invalid test cases   |
| tokens.txt   | Generated tokens     |
| error.txt    | Error reports        |
| scanner      | Scanner executable   |
| parser       | Parser executable    |

---

# Compilation

Generate scanner:

```bash
flex scanner.l
```

Generate parser:

```bash
bison -d parser.y
```

Compile:

```bash
gcc lex.yy.c parser.tab.c -o parser -lfl
```

Run:

```bash
./parser valid.txt
```

---

# Compiler Workflow

```text
Source Program
      │
      ▼
Lexical Analysis
      │
      ▼
Token Generation
      │
      ▼
Syntax Analysis
      │
      ▼
Error Detection
      │
      ▼
Valid / Invalid Program
```

---

# Valid Program Example

```text
shuru
    kaam x;
    x <- 10;

    agar (x < 20)
    @{
        likho x;
    }@
khatam
```

---

# Invalid Program Example

```text
padho(2num1);
kaam total <- num1 ++ num2;
```

Errors:

- Invalid Identifier
- Invalid Operator
- Unclosed String
- Malformed Number

---

# Project Phases

## Phase 1

- Regular Expressions
- Token Design
- Finite Automata

## Phase 2

- CFG Design
- FIRST/FOLLOW
- Parse Tree
- Syntax Analysis

---

# Technologies

- C Programming
- Flex
- Bison
- GCC
- Linux

---

# Author

**Muhammad Talha Faizan**
L1F22BSCS0103
BS Computer Science
University of Central Punjab
Compiler Construction Project
