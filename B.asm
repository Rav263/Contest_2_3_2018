
%include 'io.inc'

section .bss
  reg resd 4


section .text
global CMAIN
CMAIN:
  GET_DEC 4, EBX
  
  MOV ECX, 1
  MOV EDI, 0
  MOV ESI, 0


  .top1:
    PUSH EBX
    PUSH ESI
    PUSH EDI
    PUSH ECX
    CALL FUN
    POP ECX
    POP EDI
    POP ESI
    POP EBX

    cmp EAX, 1
    jnz .endl
    
    INC EDI
    MOV ESI, ECX
    .endl:
    INC ECX
    cmp EDI, EBX
  jl .top1

  PRINT_DEC 4, ESI
  NEWLINE

  MOV EAX, 0
RET


global FUN
FUN:
  PUSH EBP
  MOV EBP, ESP

  MOV EBX, DWORD[EBP + 8]
  MOV ECX, 1
  MOV EDI, 0
  MOV ESI, EBX
  INC ESI


  .top1:
    cmp ECX, EBX
    jz .endtop
    ;PRINT_DEC 4, ECX
    ;NEWLINE
    MOV EAX, EBX
    MOV EDX, 0
    DIV ECX
    cmp EDX, 0
    jnz .endl
    ADD EDI, ECX
    .endl:
    INC ECX
  jmp .top1
  .endtop:

  MOV EAX, 0
  
  cmp EDI, EBX
  jge .end
  MOV EAX, 1
  .end:

  MOV ESP, EBP
  POP EBP
RET
