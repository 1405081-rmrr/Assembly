;program for binary arithmetic operation
;(operand) (operator) (operand)
;eg. operan d=> 101, 5050, 6400 etc
;eg. operator => +, -, -, / etc

.model small
.stack 100h 
    
.data

LF db 10
CR db 13

X dw ?
DIGIT db 0 
DIGIT2 dw 0  

TEMP dw 0
NUM1 dw 0
NUM2  dw 0
SUM db 0 
NEGA DB 0
RESULT dw ?

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
  
    ;number1 input                    
    lea dx,MSG1                  
    call string_output 
       
    call number_input 
    xor ax,ax
    mov ax,TEMP
    mov NUM1,ax
    xor ax,ax
    mov TEMP,0

    
    ;number2 input
    lea dx,MSG2                  
    call string_output  
         
    call number_input     
    xor ax,ax
    mov ax,TEMP
    mov NUM2,ax
    xor ax,ax   
    mov TEMP,0
    
    ;operator input
    lea dx,MSG3
    call string_output
    call operator_input
       
    ;result output
    lea dx,MSG4                  
    call string_output
    
    xor ax,ax
    mov ax,NUM1 
    mov X,ax 
    call print_large_number  
    
    xor dx,dx 
    mov dl,OPERATOR 
    call print_output  
    
    xor ax,ax    
    mov ax,NUM2
    mov X,ax 
    call print_large_number  
         
    mov dl,ASSIGN  
    call print_output  
    
    xor ax,ax  
    mov ax,RESULT  
    mov X,ax 
    
    mov bl,NEGATIVE
    cmp bl,1
    jne PLUS
    mov dl,'-'
    call print_output 
    
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
    call character_input 
    cmp al,CR   ;comparing character with carriage return
    je RETURN
    
    
    
    
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
    loop INPUT
      
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
    call character_input
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
    ;sub ax,bx  
    cmp ax,bx 
    jge OK
    mov NEGATIVE,1
    JMP NOT_OK
    
    NOT_OK:
    SUB AX,BX
    NOT AX
    INC AX
    MOV RESULT,AX
    JMP RETURN2
    
    OK: 
    sub ax,bx 
    mov RESULT,ax
    jmp RETURN2  
    
    MULTIPLICATION:
    mov ax,NUM1
    mov bx,NUM2
    mul bx   
    mov RESULT,ax
    jmp RETURN2 
    
    DIVISION: 
    mov ax,NUM1
    mov bx,NUM2
    div NUM2
    mov cx,1    ;to remove division overflow
    mov RESULT,ax
    jmp RETURN2 
       
    WRONG:
    lea dx,MSG5
    call string_output
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
    call print_output
    loop LOOP_POP
    
    ret
print_large_number endp
   
    
;# # # procedures for i/o operations
;print output procedure
print_output proc
    mov ah,02h
    int 21h
    ret
print_output endp 
 
 
;string output procedure
string_output proc
    mov ah,09h
    int 21h
    ret
string_output endp
 
 
;take decimal input
character_input proc
    mov ah,01h
    int 21h
    ret
character_input endp 

    end main
