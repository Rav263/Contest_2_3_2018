%include 'io.inc'

section .bss
  x resd 1
  y resd 1
  now resd 1

section .text
global CMAIN
CMAIN:
  PUSH EBP
  MOV EBP, ESP

  GET_DEC 4, EDI
  
  GET_DEC 4, [x]
  GET_DEC 4, [y]

  MOV ESI, 1

  .top:
    cmp ESI, EDI
    jz .end
    GET_DEC 4, EBX
    GET_DEC 4, ECX

    PUSH EBX
    PUSH ESI
    PUSH EDI
    PUSH ECX
    PUSH DWORD[y]
    CALL NOK
    POP DWORD[y]
    POP ECX
    POP EDI
    POP ESI
    POP EBX

    MOV DWORD[now], EAX
    
    MOV EDX, 0
    DIV DWORD[y]
    IMUL EAX, DWORD[x]
    MOV DWORD[x], EAX

    MOV EAX, DWORD[now]
    MOV EDX, 0
    DIV ECX
    IMUL EBX, EAX

    ADD DWORD[x], EBX
    MOV EAX, DWORD[now]
    MOV DWORD[y], EAX

    INC ESI
    cmp ESI, EDI
  jnz .top
  .end:

  PUSH DWORD[x]
  PUSH DWORD[y]
  CALL NOD
  POP DWORD[y]
  POP DWORD[x]

  MOV EDI, EAX
  MOV EDX, 0
  MOV EAX, DWORD[x]

  DIV EDI
  PRINT_DEC 4, EAX
  PRINT_STRING " "

  MOV EDX, 0
  MOV EAX, DWORD[y]
  
  DIV EDI
  PRINT_DEC 4, EAX
  NEWLINE

  MOV EAX, 0

  MOV ESP, EBP
  POP EBP
RET



global NOK
NOK:
  PUSH EBP
  MOV EBP, ESP

  MOV EBX, DWORD[EBP + 8]
  MOV ECX, DWORD[EBP + 12]

  PUSH ECX
  PUSH EBX
  CALL NOD
  POP EBX
  POP ECX


  IMUL ECX, EBX
  MOV EBX, EAX
  MOV EAX, ECX
  MOV EDX, 0
  
  DIV EBX

  MOV ESP, EBP
  POP EBP
RET

global NOD
NOD:
  PUSH EBP
  MOV EBP, ESP

  MOV ESI, DWORD[EBP + 8]
  MOV EDI, DWORD[EBP + 12]


  .top:
    cmp ESI, EDI
    jle .a
      MOV EDX, 0
      MOV EAX, ESI
      MOV EBX, EDI
      DIV EBX
      MOV ESI, EDX
      jmp .b
    .a:
      MOV EDX, 0
      MOV EAX, EDI
      MOV EBX, ESI
      DIV EBX
      MOV EDI, EDX
    .b:

    cmp ESI, 0
  jz .en
    cmp EDI, 0
  jz .en
  jmp .top
  .en:

  ADD ESI, EDI
  MOV EAX, ESI

  MOV ESP, EBP
  POP EBP
RET
