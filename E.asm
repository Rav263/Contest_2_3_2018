%include 'io.inc'


section .data
  znk dd 1


section .text
global CMAIN
CMAIN:
  PUSH EBP
  MOV EBP, ESP
  
  GET_DEC 4, EAX
  GET_DEC 4, ESI
  GET_DEC 4, EDI

  MOV EBX, 1

  cmp EAX, 0
  jg .next1
  
  IMUL EAX, -1
  IMUL EBX, -1

  .next1:

  cmp ESI, 0
  jg .next2

  IMUL ESI, -1
  IMUL EBX, -1
  
  .next2:

  cmp EDI, 0
  jg .next3

  IMUL EDI, -1
  IMUL EBX, -1

  .next3:
  
  MOV DWORD[znk], EBX


  MUL ESI
  MOV EBX, EDX ; EBX = X EAX = Y
  
  MUL EDI
  MOV ESI, EDX ; ESI = YC1 
  MOV ECX, EAX ; ECX = YC0
  
  
  MOV EAX, EBX
  MUL EDI
  MOV EDI, EDX ; EDI = XC1
  MOV EBX, EAX ; EBX = XC0

  ;EDI:ESI:ECX

  ADD ESI, EBX
  ADC EDI, 0

  cmp DWORD[znk], -1
  jnz .next4
  PRINT_STRING "-"

  .next4:
 PUSH EDI
 PUSH ESI
 PUSH ECX
 CALL PRNT
 ADD ESP, 12



 NEWLINE

 MOV EAX, 0


 MOV ESP, EBP
 POP EBP
RET

global PRNT
PRNT:
  PUSH EBP
  MOV EBP, ESP

  MOV ECX, DWORD[EBP + 8]
  MOV ESI, DWORD[EBP + 12]
  MOV EDI, DWORD[EBP + 16]

  MOV EBX, 10


  MOV EDX, 0
  MOV EAX, EDI
  DIV EBX
  MOV EDI, EAX
    
  MOV EAX, ESI
  DIV EBX
  MOV ESI, EAX

  MOV EAX, ECX
  DIV EBX
  MOV ECX, EAX

  MOV EAX, EDI
  OR EAX, ESI
  OR EAX, ECX

  test EAX, EAX
  jz .end
  
  PUSH EDX
  PUSH EDI
  PUSH ESI
  PUSH ECX
  CALL PRNT
  POP ECX
  POP ESI
  POP EDI
  POP EDX
  
  .end:
  PRINT_DEC 4, EDX

  MOV ESP, EBP
  POP EBP
ret
