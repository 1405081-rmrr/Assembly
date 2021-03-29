;CSE 214
;Assignment 4
;QUESTION 2
;Recursive Fibonacci Series  
;program for fibonacci series
;sample input: 5
;sample output: 0 1 1 2 3 5 

;@Zahidul Islam
;ID:0905081



.model small
.stack 100h
.data   

LF db 10
CR db 13

TEMP dw 0
X dw ? 
RESULT dw ?
DIGIT db 0 
DIGIT2 dw 0 
DIGIT_COUNT db 0
IS_NEG db 0 
 
N dw N
M dw ?

MSG1 dw 10,10,"# HOW MANY NUMBERS? $"
MSG2 dw 10,13,"# FIBONACCI SERIES = $"

.code

main proc
    mov ax,@data
    mov ds,ax    
    
    lea dx,MSG1
    call print_string
    call number_input
    
    mov bx,TEMP
    mov N,bx
    xor bx,bx
    
    lea dx,MSG2
    call print_string
   
    mov cx,0  
    ;loop starts here
    
    REPEAT_:
    mov M,cx    ;M holds the value of cx
    mov ax,cx
    push ax  
    
    call fibo
    ;======= PRINT ========
    mov X,ax
    call print_large_number  
    mov dx,' '
    call print_output
    ======================
    
    
    xor cx,cx
    mov cx,M
    inc cx
    
    cmp cx,N
    jl REPEAT_
      
    QUIT:
    mov ah,04ch
    int 21h
main endp  


;================= PROCEDURES ===============  

fibo proc
    push bp
    mov bp,sp 
     
    push bx

    cmp word ptr [bp+4],0
    je THEN
    
    cmp word ptr [bp+4],1
    jne CALC_FIBO
    
    THEN:
    mov ax,[bp+4]
    jmp FIBO_RETURN    
    
    CALC_FIBO: 
    ;compute fibo(n-1)
    mov ax,[bp+4]   ;get n
    dec ax        ;n=n-1 
    push ax
    call fibo
    
    mov bx,ax  
    
    mov ax,[bp+4]   
    sub ax,2 
   
    push ax
    call fibo    
    add sp,16
    
    ;calculate fibo(n) = fibo(n) + fibo(n-1)  
    add ax,bx 
      
    FIBO_RETURN:
    mov bx, word ptr [bp-2]
    mov sp,bp
    pop bp
    ret
fibo endp


;# # # procedure to take number input # # # 
number_input proc    
    INPUT:
    call character_input 
    cmp al,CR   ;comparing character with carriage return
    je RETURN 
    
    mov bl,DIGIT_COUNT
    cmp bl,0   ;checking if the 1st entered character is digit
    je SIGN_CHECK       ;if not then check for sign       
    
    SIGN_CHECK:
    cmp al,'-'
    jne POSITIVE
    mov IS_NEG,1      ;make IS_NEG = 1 and hold the value to return    
    
    POSITIVE:
    cmp al,30h  ;comparing character with '0'
    jnge INPUT
    
    cmp al,39h  ;comparing character with '9'
    jnle INPUT 
    
    inc DIGIT_COUNT    ;counting digits
    
    mov DIGIT,al 
    sub DIGIT,30h   ;hex to decimal
    
    mov al,DIGIT
    cbw             ;converting byte to word
    mov DIGIT2,ax
    
    xor ax,ax
    xor bx,bx 
    
    ;performing TEMP = TEMP*10 + DIGIT2
    mov ax,TEMP
    mov bx,10
    mul bx
    add ax,DIGIT2 
   
    mov TEMP,ax
    xor ax,ax
    loop INPUT
    
    mov DIGIT_COUNT,0   ;digit count reset to 0
      
    RETURN:
    ret
number_input endp     


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
print_string proc
    mov ah,09h
    int 21h
    ret
print_string endp
 
 
;take decimal input
character_input proc
    mov ah,01h
    int 21h
    ret
character_input endp 

    end main

ret




