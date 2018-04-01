%include 'io.inc'

section .text
global CMAIN
CMAIN:
  PUSH EBP
  MOV EBP, ESP

  CALL REC

  NEWLINE

  MOV EAX, 0

  MOV ESP, EBP
  POP EBP
RET
 
global REC
REC:
  PUSH EBP
  MOV EBP, ESP
  PUSH EAX

  GET_DEC 4, EAX
  CMP EAX, 0
  jz .end

  push EAX
  CALL REC
  POP EAX
  
  PRINT_DEC 4, EAX
  PRINT_STRING " "

  
  .end:
  POP EAX
  MOV ESP, EBP
  POP EBP
RET
