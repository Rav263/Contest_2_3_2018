%include 'io.inc'

section .bss 
  arr resd 4000001
  step resd 13

section .text
global CMAIN
CMAIN:
  PUSH EBP
  MOV EBP, ESP


  GET_DEC 4, EBX ;основание системы счисления k
  GET_DEC 4, ECX ;глубина вычислений n
  GET_DEC 4, EDX ;число a

  MOV EAX, 1
  MOV DWORD[step], EBX
  MOV ESI, 1

  .top:
    cmp ESI, 13
    jz .end
    IMUL EAX, EBX
    MOV DWORD[step + ESI*4], EAX 
    INC ESI
    jmp .top
  .end:

  MOV EAX, 0
  MOV ESI, 0

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

  MOV ESP, EBP
  POP EBP
RET


global NOTREC
NOTREC: ;основная функция вычисления
  PUSH EBP
  MOV EBP, ESP
  
  MOV EBX, DWORD[EBP + 8]  ;глубина вычислений n
  MOV ECX, DWORD[EBP + 12] ;основание системы счисления k
  MOV EAX, DWORD[EBP + 16] ;число a
  
  MOV EDX, 0
  MOV EDI, 2011
  DIV EDI
  MOV EAX, EDX

  MOV DWORD[arr], EAX

  MOV EAX, 0

  PUSH EBX
  PUSH ECX
  PUSH DWORD[arr]
  PUSH DWORD[arr]
  CALL OPER
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
    INC EDX
    jmp .top
  .end:

  DEC EBX

  MOV EAX, DWORD[arr + EBX*4]
  DEC EDX

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
  CALL COUNT
  POP EDI
  POP ECX

  MOV EBX, EAX

  MOV EAX, DWORD[step + EBX*4]

  MOV EDX, 0
  IMUL EAX, ESI

  MOV EDX, 0
  MOV ESI, 2011
  
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

