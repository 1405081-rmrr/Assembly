 .MODEL SMALL
.STACK 100H
.DATA
N DW ?
M DW ?
i DW ?
j DW ?
X DW ?
Y DW ?

C DW ?
S1 DW "ENTER YOUR NUMBER : $"
S2 DW "ENTER YOUR BASE : $"
S3 DW "YOUR TOTAL NUMBER OF 1'S: $"
.CODE
MOV AX,@DATA
MOV DS,AX   
;INPUT:
MOV N,0
MOV M,10
LEA DX,S1
MOV AH,9
INT 21H
MOV AH,1
WHILE:
    INT 21H
    CMP AL,0DH
    JE MAIN
    SUB AL,48
    MOV BL,AL 
    MOV AX,N
    IMUL M
    MOV DX,AX
    MOV AL,BL
    AND AX,000FH  
    ADD DX,AX
    MOV N,DX 
    MOV AH,1
    JMP WHILE 
    
    
MAIN PROC
    
    MOV AX,N
    SUB AX,1
    PUSH AX
    CALL FIBO
    MOV C,AX    
    
    MOV AH,4CH
    INT 21H             ;DOS EXIT
    
    MAIN ENDP



FIBO PROC NEAR
    PUSH BP
    MOV BP,SP
    MOV AX,[BP+4]
    CMP AX,1
    JE RETURN
    CMP AX,2
    JE RETURN
     
     
    SUB AX,1
    PUSH AX
    CALL FIBO
    PUSH AX
    
    
    MOV AX, [BP+4]
    SUB AX,2
    PUSH AX
    CALL FIBO
    
    
    
    POP BX
    ADD AX,BX
    
    
    
   RETURN:
   POP BP
   RET 2
   FIBO ENDP 