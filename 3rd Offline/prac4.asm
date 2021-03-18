;program for binary arithmetic operation
;(operand) (operator) (operand)
;eg. operan d=> 101, 5050, 6400 etc
;eg. operator => +, -, -, / etc

.model small
.stack 100h 
    
.data


X dw ?
DIGIT db 0 
DIGIT2 dw 0  

TEMP dw 0
NUM1 dw 0
NUM2  dw 0
SUM db 0 
RESULT dw ?
NEGA DB 0
NEGA1 DB 0
OPERATOR db ?    
ASSIGN db '=$' 
NEGATIVE db 0

MSG1 dw 10,13,"Enter 1ST Number: $"   
MSG2 dw 10,13,"Enter 2ND Number: $"  
MSG3 dw 10,13,"Enter Operator[+, -, *, /]: q to QUIT $"   

MSG4 dw 10,13,"RESULT: $"
MSG5 dw 10,13,"Invalid Operator $"  

.code
main proc
    mov ax,@data
    mov ds,ax    
    MOV CX,0
    ;number1 input 
    NUMBER1_INPUT:                   
    lea dx,MSG1                  
    mov ah,09h
    int 21h
       
    call number_input 
    xor ax,ax
    mov ax,TEMP
    CMP CX,0 
    JE MOVE_NUMBER1
    JMP MAKE_NEG
    
    MAKE_NEG:
    NEG AX
    
    MOVE_NUMBER1:
    mov NUM1,ax
    xor ax,ax
    mov TEMP,0
    ;XOR CX,CX 
    mov cx,0

    
    ;number2 input
    NUMBER2_INPUT:
    lea dx,MSG2                  
    mov ah,09h
    int 21h
         
    call number_input     
    xor ax,ax
    mov ax,TEMP
    CMP CX,0
    JE MOVE_NUMBER2
    NEG AX
    
    MOVE_NUMBER2:
    mov NUM2,ax
    xor ax,ax   
    mov TEMP,0
    XOR CX,CX
    
    ;operator input
    lea dx,MSG3
    mov ah,09h
    int 21h
    call operator_input
       
    ;result output
    lea dx,MSG4                  
    mov ah,09h
    int 21h
    
    xor ax,ax
    mov ax,NUM1 
    mov X,ax
    ;MOV BL,NEGA
    ;CMP BL,1
    ;JE MNS 
    call print_large_number 
    JMP NEXT_NUM
    ;MNS: 
    ;MOV NEGA,0
   ; MOV DL,'-'
    ;MOV AH,02H
   ; INT 21H
   ; CALL print_large_number 
    
    NEXT_NUM:
    xor dx,dx 
    mov dl,OPERATOR 
    mov ah,02h
    int 21h 
    
    xor ax,ax    
    mov ax,NUM2
    mov X,ax 
    MOV BL,NEGA
    ;CMP BL,1
    ;JE MNS1 
    call print_large_number  
    JMP ASSIGN1
    ;MNS1: 
    ;MOV NEGA,0
    ;MOV DL,'-'
   ; MOV AH,02H
    ;INT 21H
    ;CALL print_large_number 
    ASSIGN1:   
    mov dl,ASSIGN  
    mov ah,02h
    int 21h  
    
    xor ax,ax  
    mov ax,RESULT  
    mov X,ax 
    mov bl,NEGATIVE
    cmp bl,1
    jne PLUS
    mov dl,'-'
    mov ah,02h
    int 21h
    xor bx,bx
    xor dx,dx
     
    PLUS:
    call print_large_number            
 
    QUIT:
    mov ah,04ch
    int 21h
main endp  

;================= PROCEDURES =======================

;# # # procedure to take number input # # # 
number_input proc  
    
    INPUT: 
    
    mov ah,01h
    int 21h 
    cmp al,13   ;comparing character with carriage return
    je RETURN 
    CMP AL,2DH
    JE NEGAT 
    cmp al,30h  ;comparing character with '0'
    jnge INPUT 
    
    cmp al,39h  ;comparing character with '9'
    jnle INPUT 
    
    mov DIGIT,al 
    sub DIGIT,30h   ;hex to decimal
    
    mov al,DIGIT
    cbw             ;converting byte to word
    mov DIGIT2,ax
    
    xor ax,ax
    xor bx,bx 
    
    mov ax,TEMP
    mov bx,10
    mul bx
    add ax,DIGIT2
     
   
    mov TEMP,ax
    
    xor ax,ax
    xor bx,bx 
    jmp INPUT
     
    NEGAT:
   
    MOV CX,1
    JMP INPUT 
    RETURN:  
    ret
number_input endp


;# # # procedure to take operator input # # # 
operator_input proc         
    xor ax,ax
    xor bx,bx
    xor cx,cx
    xor dx,dx
    
    OP_INPUT:
    MOV AH,1
    INT 21H
    mov OPERATOR,al 
    
    cmp al,2Bh  ;comparing with '+' operator
    je ADDITION  
    
    cmp al,2Dh  ;comparing with '-' operator
    je SUBTRACTION  
    
    cmp al,2Ah  ;comparing with '*' operator
    je MULTIPLICATION  
    
    cmp al,2Fh  ;comparing with /' operator
    je DIVISION
    
    cmp al,071h ;comparing with 'q' operator
    je QUIT
    jne WRONG 
    
    ADDITION:
    mov ax,NUM1
    mov bx,NUM2
    add ax,bx  
    mov RESULT,ax
    jmp RETURN2 
    
    SUBTRACTION:
    mov ax,NUM1 
    mov bx,NUM2
    cmp ax,bx 
    jge OK
    mov NEGATIVE,1
    JMP NOT_OK
    
    NOT_OK:
    SUB AX,BX
    NOT AX
    INC AX
    ;AND AX,255
    MOV RESULT,AX
    JMP RETURN2
    
    OK: 
    sub ax,bx 
    mov RESULT,ax
    jmp RETURN2 
    
    MULTIPLICATION:
    CHECK_NEG1:
    MOV AX,NUM1
    CMP AX,0
    JL CHANGE1
    JMP CHECK_NEG2 
    
    CHANGE1:
    NEG AX
   ; INC AX 
    
    CHECK_NEG2:
    MOV BX,NUM2
    CMP BX,0
    JL CHANGE2 
    JMP MULTI
    
    CHANGE2:
    NEG BX 
    ;INC BX

    
    MULTI:
    
    MUL BX 
    CMP AX,32767
    JG NEW_RESULT_MUL
    MOV RESULT, AX
    JMP RETURN2
     
     
    NEW_RESULT_MUL:
    NOT AX
    INC AX
    MOV RESULT,AX
    JMP RETURN2
    
    DIVISION: 
    mov ax,NUM1
    mov bx,NUM2
    div NUM2
    mov cx,1    ;to remove division overflow
    mov RESULT,ax
    jmp RETURN2 
       
    WRONG:
    lea dx,MSG5
    MOV AH,9
    INT 21H
    jmp QUIT      
    
    RETURN2:
    ret
operator_input endp

;# # # procedure to print multi digit number # # # 
print_large_number proc  
    xor ax,ax
    mov ax,X
    mov bx,10
    xor cx,cx
    xor dx,dx
    
    LOOP_PUSH:
    xor dx,dx
    div bx
    push dx     ;pushes remainder of division in dx stack segment
    inc cx      ;increments cx to count digits
    cmp ax,0    ;compares ax if quotient is zero or not
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