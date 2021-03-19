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
F1 DB 0
F2 DB 0
RESULT dw ?
;NEGA DB 0
;NEGA1 DB 0
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
    MOV F1,1
    
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
    MOV F2,1
    
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
    NEXT_NUM1:
    xor ax,ax            
    mov ax,NUM1          
    ;mov X,ax
    ;CMP AX,0
    CMP F1,1
    JE MAKE_NUM1 
    MOV X,AX
    CALL print_large_number 
    JMP  NEXT_NUM2
    ;MOV BL,NEGA
    ;CMP BL,1
    ;JE MNS  
    
    MAKE_NUM1:
    NEG AX
    MOV X,AX 
    mov dl,'['
    mov ah,02h
    int 21h
    
    mov dl,'-'
    mov ah,02h
    int 21h
   
    
    call print_large_number 
    mov dl,']'
    mov ah,02h
    int 21h
    JMP NEXT_NUM2
    ;MNS: 
    ;MOV NEGA,0
   ; MOV DL,'-'
    ;MOV AH,02H
   ; INT 21H
   ; CALL print_large_number 
    
    NEXT_NUM2:
    xor dx,dx 
    mov dl,OPERATOR   
    mov ah,02h
    int 21h 
    
    xor ax,ax    
    mov ax,NUM2
    ;mov X,ax
    ;CMP AX,0
    CMP F2,1
    JE MAKE_NUM2 
    MOV X,AX
    call print_large_number  
    JMP ASSIGN1
    
    
    MAKE_NUM2: 
    NEG AX
    MOV X,AX
    mov dl,'['
    mov ah,02h
    int 21h
    
     mov dl,'-'
    mov ah,02h
    int 21h
    
   
    
    
    ;MOV BL,NEGA
    ;CMP BL,1
    ;JE MNS1 
    call print_large_number
    mov dl,']'
    mov ah,02h
    int 21h  
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
    cmp ax,0 ; answer 0 dile +- print hbena
    je PLUS 
    XOR BX,BX
    mov bl,NEGATIVE 
    CMP BL,0
    JE PLUS
    cmp bl,1
    je MINUS 
    CMP BL,NEGATIVE      
    CMP BL,3
    JE MINUS 
    CMP BL,2
    JE PLUS 
    
    
    
    MINUS:
    mov dl,'-'
    mov ah,02h
    int 21h 
    xor bx,bx
    xor dx,dx
    JMP PLUS
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
    CMP AL,2DH ;
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
    XOR CX,CX
    mov ax,NUM1
    mov bx,NUM2
    ADD AX,BX
    CMP AX,0
    JL ADD_FINAL
    MOV RESULT,AX 
    JMP OKA
    ADD_FINAL:
    NEG AX
    MOV RESULT,AX
    JMP OKA
    OKA: 
    XOR CX,CX
    MOV CL,F1
    CMP CL,1
    JE OKA2
    JMP RETURN2
    
    OKA2:
    XOR CX,CX
    MOV CL,F2
    CMP CL,1 
    JE INC_NEG
    JNE RETURN2
    
    INC_NEG:
    XOR CX,CX
    MOV CL,NEGATIVE
    INC CL
    INC CL
    INC CL
    MOV NEGATIVE,CL
    JMP RETURN2
    
    
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
    ;CMP AX,0
    CMP F1,1     
    JE CHANGE1
    JMP CHECK_NEG2 
    
    CHANGE1:
    NEG AX
    MOV CL,NEGATIVE
    INC CL
    MOV NEGATIVE,CL
    XOR CX,CX
    ;INC AX 
    
    CHECK_NEG2:
    MOV BX,NUM2
    ;CMP BX,0
    CMP F2,1
    JE CHANGE2 
    JMP MULTI
    
    CHANGE2:    
    NEG BX 
    MOV CL,NEGATIVE
    INC CL
    MOV NEGATIVE,CL
    XOR CX,CX
    ;INC BX

    
    MULTI:
    
    MUL BX 
    CMP AX,0
    JL NEW_RESULT_MUL
    MOV RESULT, AX 
    ;mov NEGATIVE,1
    JMP RETURN2
     
     
    NEW_RESULT_MUL:
    NEG AX
    ;INC AX 
          
    MOV RESULT,AX 
    MOV NEGATIVE,1
    JMP RETURN2
    
    DIVISION: 

    mov ax,NUM1
    mov bx,NUM2 
    CHECK_NEG11:
    MOV AX,NUM1   
    ;CMP AX,0
    CMP F1,1      
    JE CHANGE11
    JMP CHECK_NEG12 
    
    CHANGE11:
    NEG AX
    MOV CL,NEGATIVE
    INC CL
    MOV NEGATIVE,CL
    XOR CX,CX
    ;INC AX 
    
    CHECK_NEG12:
    MOV BX,NUM2
    ;CMP BX,0
    CMP F2,1
    JE CHANGE12 
    JMP DIVI
    
    CHANGE12:     
    NEG BX 
    MOV CL,NEGATIVE
    INC CL
    MOV NEGATIVE,CL
    XOR CX,CX
    DIVI:
    div BX
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
    xor bx,bx
    mov ax,X
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
