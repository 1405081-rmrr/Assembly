.MODEL small

.STACK 100h

.DATA

    A db 0
    B db 0
    C db 0
    Q DB 0
    
    MSG1 DB 0DH,0AH,'Enter the 3 numbers: $'
    MSG2 DB 0DH,0AH,'The second largest number is: $'
    MSG3 DB 0DH,0AH,'All the numbers are equal$' 
    MSG4 DB 0DH,0AH,'PRESS ANY KEY TO CONTINUE. PRESS Q or q TO QUIT : $'

.CODE

MAIN PROC
    
mov AX,@DATA
mov DS,AX 

PROMPT:
    lea DX,MSG4
    mov AH,9
    int 21H
    
    MOV AH,1   ;PRESS ANY KEY TO CONTINUE
    INT 21H    ;PRESS Q or q TO FINISH
    MOV Q,AL
    CMP AL,051H
    JZ FINISH
    CMP AL,71H
    JZ FINISH
    JNZ PROMPT1
    

PROMPT1:

    lea DX,MSG1
    mov AH,9
    int 21H
    
    mov AH,1
    int 21h
    mov A,AL
    
    mov AH,2
    mov DL,20H
    int 21H
    
    mov AH,1
    int 21h
    mov B,AL
    
    mov AH,2
    mov DL,20H
    int 21H
    
    mov AH,1
    int 21h
    mov C,AL
    
    mov AL,A
    sub AL,'0'
    
    mov BL,B
    sub BL,'0'
    
    mov CL,C
    sub CL,'0'
    
    
    cmp AL,BL
    JZ  L0
    JA  L1  ;a>b
    JB  L2

L0:
    
    cmp BL,CL
    JZ  PRINT_EQUAL
    JNZ L0_1

L0_1:

    cmp BL,CL
    JA  PRINT_CL
    JB  PRINT_BL

L0_2:
    
    cmp AL,BL
    JA  PRINT_BL
    JB  PRINT_AL
       
     
L1:
    
    cmp AL,CL
    JE  L0_2 ;a>b now a=c
    JA  L1_1
    JB  L2
    
L1_1:
    
    cmp BL,CL
    JZ  L0_2
    JA  PRINT_BL
    JB  PRINT_CL
    
L2:
    
    cmp BL,CL
    JE  L0_2
    JA  L2_1    
    JB  L2_2
    
L2_1:

    cmp AL,CL
    JZ  L0_2
    JA  PRINT_AL
    JB  PRINT_CL
    
L2_2:

     cmp AL,BL
     JA  PRINT_AL
     JB  PRINT_BL
    

PRINT_EQUAL:

    lea DX,MSG3
    mov AH,9
    int 21H
    
    mov AH,2
    mov DL,0DH  ;CARRIAGE RETURN
    int 21H
    mov DL,0AH  ;LINE FEED
    int 21H
    
    JMP PROMPT
    
PRINT_AL:

    lea DX,MSG2
    mov AH,9
    int 21H
    
    mov AH,2 
    mov DL,A
    int 21H
    
    mov AH,2
    mov DL,0DH  ;CARRIAGE RETURN
    int 21H
    mov DL,0AH  ;LINE FEED
    int 21H
    
    JMP PROMPT

PRINT_BL:
    
    lea DX,MSG2
    mov AH,9
    int 21H
    
    mov AH,2 
    mov DL,B
    int 21H
    
    mov AH,2
    mov DL,0DH  ;CARRIAGE RETURN
    int 21H
    mov DL,0AH  ;LINE FEED
    int 21H
    
    JMP PROMPT

PRINT_CL:

    lea DX,MSG2
    mov AH,9
    int 21H
    
    mov AH,2 
    mov DL,C
    int 21h
    
    mov AH,2
    mov DL,0DH  ;CARRIAGE RETURN
    int 21H
    mov DL,0AH  ;LINE FEED
    int 21H
    
    JMP PROMPT 
    
mov AH,4CH
int 21H
FINISH:    
MAIN ENDP 
END MAIN
