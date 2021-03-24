INCLUDE 'EMU8086.INC'      ;include an assembly library
.MODEL SMALL
.STACK 100h
.DATA        
    ARR DB 50 DUP(?) ; declare array with null value initially 
   ; MSG DW 0AH,0DH, 'ENTER VALUES : $' 
    MSG DW 0AH,0DH, 'ENTER VALUES : $' 
    P DB 0
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        XOR BX,BX
        XOR CX,CX
        MOV SI,0 
        
        ENTER:
        LEA DX,MSG
        MOV AH,9
        INT 21H
        
        MOV AH,1
        INT 21H 
        CMP AL,0DH
        JE OUTPUT
        AND AL,0FH ;convert from ascii value to real value
        
        MOV ARR[SI],AL
        INC SI
        JMP ENTER
        
        OUTPUT:
        MOV SI,0
        JMP OUTPUT1
        
     
        
        OUTPUT1:
        
        MOV AH,2
        MOV DL,0AH
        INT 21H 
               
        MOV AL,ARR[SI]
        MOV P,AL
        ADD P,30H 
        MOV AH,2
        MOV DL,P
        INT 21H
        INC SI       
        
        OUTPUT2:
        
        MOV AH,2
        MOV DL,20H
        INT 21H 
               
        MOV AL,ARR[SI]
        MOV P,AL
        ADD P,30H 
        MOV AH,2
        MOV DL,P
        INT 21H
        INC SI 
        OUTPUT3:
        
        MOV AH,2
        MOV DL,0DH
        INT 21H 
        MOV DL,0AH
        INT 21H       
        MOV AL,ARR[SI]
        MOV P,AL
        ADD P,30H 
        MOV AH,2
        MOV DL,P
        INT 21H
        INC SI 
        OUTPUT4:
        
        MOV AH,2
        MOV DL,0AH
        INT 21H 
               
        MOV AL,ARR[SI]
        MOV P,AL
        ADD P,30H 
        MOV AH,2
        MOV DL,P
        INT 21H
        INC SI 
     
END_:       
  MAIN ENDP
END MAIN