.MODEL small

.STACK 100h

.DATA

    A db 0
    B db 0
    C db 0
    Q DB 0  
    U DB 0
    L DB 0
    N DB 0
    F1 DB 0
    F2 DB 0
    F3 DB 0
    F4 DB 0
    
    MSG1 DB 0DH,0AH,'Enter a series of character $'
    MSG4 DB 0DH,0AH,'PRESS ANY KEY TO CONTINUE. PRESS Q or q TO QUIT : $'
    MSG5 DB 0DH,0AH,'VALID PASSWORD$'
    MSG6 DB 0DH,0AH,'INVALID PASSWORD$'
    MSG7 DB 0DH,0AH,'TOTAL UPPERCASE : $'  
    MSG8 DB 0DH,0AH,'TOTAL LOWERCASE : $'
    MSG9 DB 0DH,0AH,'TOTAL NUMBER : $'

.CODE

MAIN PROC
    
mov AX,@DATA
mov DS,AX  
START:
    lea DX,MSG4
    mov AH,9
    int 21H 
    
    JMP PROMPT

PROMPT:
    
    MOV AH,1   ;PRESS ANY KEY TO CONTINUE
    INT 21H    ;PRESS Q or q TO FINISH
    MOV Q,AL
    CMP AL,051H
    JZ FINISH
    CMP AL,71H
    JZ FINISH
    JNZ PRINT
    
PRINT:
    LEA DX,MSG1
    MOV AH,9
    INT 21H
    JMP ENTER_CHARACTER
    

ENTER_CHARACTER:

    mov AH,1
    int 21h
    mov A,AL
    CMP AL,020H ;SPACE
    JE VALIDCASE1 
    CMP AL,09H ;TAB
    JE VALIDCASE1
    CMP AL,0DH ;NEWLINE
    JE VALIDCASE1
    JMP CHECK_PRINTABLE33
     
    
    

CHECK_PRINTABLE33:

    CMP AL, 21H
    JAE CHECK_PRINTABLE47
    JB ENTER_CHARACTER
    
CHECK_PRINTABLE47:

    CMP AL,2FH
    JBE ENTER_CHARACTER
    JA CHECK_NUMBER0
        

CHECK_PRINTABLE127:

    CMP AL,7FH
    JBE ENTER_CHARACTER
    JA VALIDCASE1

    
CHECK_NUMBER0:
    CMP AL,30H
    JB ENTER_CHARACTER
    JAE CHECK_NUMBER9
   
CHECK_NUMBER9:
    CMP AL,39H
    JBE CHECK_NUMBER
    JMP CHECK_PRINTABLE58  
    
CHECK_PRINTABLE58:

    CMP AL,3AH
    JAE CHECK_PRINTABLE64
    
CHECK_PRINTABLE64:

    CMP AL,40H
    JBE ENTER_CHARACTER
    JA CHECK_PPERCASEA
    
CHECK_PPERCASEA:
    CMP AL,041H 
    JAE CHECK_UPPERCASEZ 
    ;JMP ENTER_CHARACTER 
    JBE CHECK_NUMBER0
    
CHECK_UPPERCASEZ:
      CMP AL,5AH 
      JA CHECK_PRINTABLE91
      JBE CHECK_UPPERCASE 
      
CHECK_PRINTABLE91:

    CMP AL,5BH
    JMP CHECK_PRINTABLE96
    
CHECK_PRINTABLE96:

    CMP AL,60H
    JBE ENTER_CHARACTER
    JA CHECK_LOWERCASEA
    
          
CHECK_UPPERCASE:
      
      MOV BL,F1
      INC BL
      MOV F1,BL
      JMP ENTER_CHARACTER 
      
CHECK_LOWERCASEA:
      CMP AL,61H
      ;JB CHECK_PPERCASEA
      JAE CHECK_LOWERCASEZ
      
CHECK_LOWERCASEZ:

      CMP AL,7AH
      JBE CHECK_LOWERCASE 
      JA  CHECK_PRINTABLE127
      ;JA ENTER_CHARACTER
      
CHECK_LOWERCASE:
     
      MOV BL,F2
      INC BL
      MOV F2,BL
      JMP ENTER_CHARACTER 
      
CHECK_NUMBER: 

      
      MOV BL,F3
      INC BL
      MOV F3,BL 
      JMP ENTER_CHARACTER 
      
      
VALIDCASE1:

    MOV BL,F1 
    MOV CL,U
    CMP BL,CL
    JA VALIDCASE2
    JZ INVALID
VALIDCASE2:

    MOV BL,F2
    MOV CL,L
    CMP BL,CL
    JA VALIDCASE3
    JZ INVALID
    
VALIDCASE3:

    MOV BL,F3 
    MOV CL,N
    CMP BL,CL
    JA RESULT
    JZ INVALID
    
INVALID:

    LEA DX,MSG6
    MOV AH,9
    INT 21H
    JMP FINISH
      

RESULT:

    LEA DX,MSG5
    MOV AH,9
    INT 21H
    JMP COUNT
    
    
    
COUNT:

    mov AH,2
    mov DL,0DH  ;CARRIAGE RETURN
    int 21H
    mov DL,0AH  ;LINE FEED
    int 21H

    lea DX,MSG7
    mov AH,9
    int 21H

    mov AH,2
    mov DL,F1
    add DL,30H
    int 21h  
    
    mov AH,2
    mov DL,0DH  ;CARRIAGE RETURN
    int 21H
    mov DL,0AH  ;LINE FEED
    int 21H

    lea DX,MSG8
    mov AH,9
    int 21H

    mov AH,2
    mov DL,F2
    add DL,30H
    int 21h
    
    mov AH,2
    mov DL,0DH  ;CARRIAGE RETURN
    int 21H
    mov DL,0AH  ;LINE FEED
    int 21H

    lea DX,MSG9
    mov AH,9
    int 21H

    mov AH,2
    mov DL,F3
    add DL,30H
    int 21h  
    
    JMP FINISH

FINISH:       
MAIN ENDP 
END MAIN