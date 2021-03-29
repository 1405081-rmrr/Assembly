INCLUDE 'EMU8086.INC'      ;include an assembly library
.MODEL SMALL
.STACK 100h
.DATA        
    ARR DB 50 DUP(?)
    ARR2 DB 50 DUP(?)  
    R DB 50 DUP(?)
    RESULT DB 50 DUP(?) ; declare array with null value initially 
   ; MSG DW 0AH,0DH, 'ENTER VALUES : $' 
    MSG DW 0AH,0DH, 'ENTER FIRST matrix VALUES : $'  
    MSG2 DW 0AH,0DH, 'ENTER SECOND matrix VALUES : $' 
    P DB 0
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        XOR BX,BX
        XOR CX,CX
        MOV SI,0 
        
        ENTER: 
        ;FIRST
        LEA DX,MSG
        MOV AH,9
        INT 21H
        
        mov ah,2
        MOV DL,0DH
        INT 21H 
        MOV DL,0AH
        INT 21H
        
        MOV AH,1
        INT 21H 
        AND AL,0FH ;convert from ascii value to real value
        
        MOV ARR[SI],AL
        INC SI
         
        ;SECOND 
        MOV AH,2
        MOV DL,20H
        INT 21H
        
        
        
        MOV AH,1
        INT 21H 
        
        AND AL,0FH ;convert from ascii value to real value
        
        MOV ARR[SI],AL
        INC SI
        
        ;THIRD
        mov ah,2
        MOV DL,0DH
        INT 21H 
        MOV DL,0AH
        INT 21H
        
        MOV AH,1
        INT 21H 
        
        AND AL,0FH ;convert from ascii value to real value
        
        MOV ARR[SI],AL
        INC SI
        
        ;FOURTH
        mov ah,2
        MOV DL,20H
        INT 21H
        
        MOV AH,1
        INT 21H 
        
        AND AL,0FH ;convert from ascii value to real value
        
        MOV ARR[SI],AL
        INC SI
        
        
        ;SECOND MATRIX
        LEA DX,MSG2
        MOV AH,9
        INT 21H 
        MOV SI,0
        
        ;FIRST
        mov ah,2
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H
        
        MOV AH,1
        INT 21H 
        
        AND AL,0FH ;convert from ascii value to real value
        
        MOV ARR2[SI],AL
        INC SI
       
        ;SECOND
        mov ah,2
        MOV DL,20H
        INT 21H
        
        MOV AH,1
        INT 21H 
       
        AND AL,0FH ;convert from ascii value to real value
        
        MOV ARR2[SI],AL
        INC SI
      
        ;THIRD
        mov ah,2
        MOV DL,0DH
        INT 21H 
        MOV DL,0AH
        INT 21H
        
        MOV AH,1
        INT 21H 
        
        AND AL,0FH ;convert from ascii value to real value
        
        MOV ARR2[SI],AL
        INC SI
       
        ;FOURTH
        mov ah,2
        MOV DL,20H
        INT 21H
        
        MOV AH,1
        INT 21H 
        
        AND AL,0FH ;convert from ascii value to real value
        
        MOV ARR2[SI],AL
        
        
        OUTPUT:
        MOV SI,0
        XOR BX,BX
        
         
         
        MOV AH,2
        MOV DL,0DH
        INT 21H 
        MOV DL,0AH
        INT 21H
        
        OUTPUT1:
        
        MOV AH,2
        MOV DL,0DH
        INT 21H 
        MOV DL,0AH
        INT 21H
               
        MOV AL,ARR[SI]
        MOV BL,ARR2[SI]
        ADD AL,BL
        MOV P,AL
        ADD P,30H
        MOV AL,P 
        mov R[SI],AL
        CALL print_large_number 
        ;MOV AH,2
       ; MOV DL,P
        ;INT 21H
        INC SI       
        
        OUTPUT2:
        
        MOV AH,2
        MOV DL,20H
        INT 21H 
               
        MOV AL,ARR[SI]
        MOV BL,ARR2[SI]
        ADD AL,BL
        MOV P,AL
        
        ADD P,30H 
        MOV AL,P 
        mov R[SI],AL
        CALL PRINT_LARGE_NUMBER 
        ;MOV AH,2
       ; MOV DL,P
        ;INT 21H
        INC SI 
        OUTPUT3:
        
        MOV AH,2
        MOV DL,0DH
        INT 21H 
        MOV DL,0AH
        INT 21H       
        MOV AL,ARR[SI]
        MOV BL,ARR2[SI]
        ADD AL,BL
        MOV P,AL
        ADD P,30H 
        MOV AL,P
        mov R[SI],AL
        CALL PRINT_LARGE_NUMBER
        ;MOV AH,2
       ; MOV DL,P
        ;INT 21H
        INC SI 
        OUTPUT4:
        
        MOV AH,2
        MOV DL,20H
        INT 21H 
               
        MOV AL,ARR[SI] 
        MOV BL,ARR2[SI]
        ADD AL,BL
        MOV P,AL
        
        ADD P,30H 
        MOV AL,P
        mov R[SI],AL
        CALL PRINT_LARGE_NUMBER
       ; MOV AH,2
       ; MOV DL,P
       ; INT 21H
        JMP QUIT 
     
    QUIT:
    mov ah,04ch
    int 21h
main endp 
print_large_number proc  
    xor ax,ax
    xor bx,bx
    mov aL,P
    SUB AL,30H
    mov bx,10
    xor cx,cx        
    xor dx,dx
                  
    LOOP_PUSH:        
    xor dx,dx
    div bx        
    push dx    
    inc cx     
    cmp ax,0 
    jne LOOP_PUSH
    
    LOOP_POP:
    pop dx      ;pop values to dx register from the top of the stack  
    add dx,30h  ;convert to hex ascii
    mov ah,02h
    int 21h
    loop LOOP_POP
    
    ret
print_large_number endp

    end main