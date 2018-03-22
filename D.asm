%include 'io.inc'

section .bss 
  arr resd 4000001

section .text
global CMAIN
CMAIN:
  GET_DEC 4, EBX ;основание системы счисления k
  GET_DEC 4, ECX ;глубина вычислений n
  GET_DEC 4, EDX ;число a

  PUSH EDX
  PUSH EBX
  PUSH ECX
  CALL NOTREC
  POP ECX
  POP EBX
  POP EDX

  PRINT_DEC 4, EAX
  NEWLINE


  MOV EAX, 0
RET


global NOTREC
NOTREC: ;основная функция вычисления
  PUSH EBP
  MOV EBP, ESP
  
  MOV EBX, DWORD[EBP + 8]  ;глубина вычислений n
  MOV ECX, DWORD[EBP + 12] ;основание системы счисления k
  MOV EAX, DWORD[EBP + 16] ;число a

  MOV EDI, 2011
  DIV EDI
  MOV EAX, EDX

  MOV DWORD[arr], EAX

  MOV EAX, 0

  PUSH EBX
  PUSH ECX
  PUSH DWORD[arr]
  PUSH DWORD[arr]
  CALL 
  POP DWORD[arr]
  POP DWORD[arr]
  POP ECX
  POP EBX

  MOV DWORD[arr + 4], EAX
  
  MOV EDX, 2
  
  INC EBX

  .top:
    cmp EDX, EBX
    jz .end

    PUSH EBX
    PUSH EDX
    PUSH ECX
    PUSH DWORD[arr + EDX*4 - 8]
    PUSH DWORD[arr + EDX*4 - 4]
    CALL OPER
    ADD ESP, 8
    POP ECX
    POP EDX
    POP EBX

    MOV DWORD[arr + EDX*4], EAX
    jmp .top
  .end:

  DEC EBX

  MOV EAX, DWORD[arr + EBX*4]

  MOV ESP, EBP
  POP EBP
RET


global OPER 
OPER: ;оператор # из условия
  PUSH EBP
  MOV EBP, ESP

  MOV ESI, DWORD[EBP + 8]  ;первое число
  MOV EDI, DWORD[EBP + 12] ;второе чилсло
  MOV ECX, DWORD[EBP + 16] ;основание системы счисления

  PUSH ECX
  PUSH EDI
  CALL CONUT
  POP EDI
  POP ECX

  MOV EBX, EAX

  PUSH ESI
  PUSH EBX
  PUSH ECX
  CALL STEP
  POP ECX
  POP EBX
  POP ESI


  MOV EDX, 0
  IMUL EAX, ESI

  MOV EDX, 0
  MOV ESI, 2011
  DIV ESI
  MOV EAX, EDX

  MOV EDX, 0
  ADD EAX, EDI
  DIV ESI

  MOV EAX, EDX

  MOV ESP, EBP
  POP EBP
RET

global COUNT 
COUNT: ;Количество значимых цифр в данной системе счисления
  PUSH EBP
  MOV EBP, ESP

  MOV EAX, DWORD[EBP + 8]  ;число
  MOV ECX, DWORD[EBP + 12] ;основание систеы счисления

  MOV EBX, 0

  .top:
    cmp EAX, 0
    jz .end

    MOV EDX, 0
    DIV ECX
    INC EBX
    jmp .top
  .end:

  MOV EAX, EBX

  MOV ESP, EBP
  POP EBP
RET


global STEP
STEP: ;Степень
  PUSH EBP
  MOV EBP, ESP

  MOV ECX, DWORD[EBP + 8]  ;n - степень
  MOV EBX, DWORD[EBP + 12] ;k - основание


  MOV EAX, 1

  .top:
    IMUL EAX, EBX
    MOV EDX, 0
    MOV ESI, 2011
    DIV ESI
    MOV EAX, EDX ;остаток от деления на 2011
  loop .top

  MOV ESP, EBP
  POP EBP
RET
