;CSE 214
;Assignment 4
;QUESTION 1
;2x2 Matrix Addition 
;Zahidul Islam
;ID:0905081

.model small
.stack 100h 
    
.data

LF db 10
CR db 13

TEMP dw 0          ;returns larger number input from 'number_input'
X dw ?             ;used to pass number to 'print_large_number'
RESULT dw ?        ;used in 'number_input' 
DIGIT db 0         ;used in 'number_input' 
DIGIT2 dw 0        ;used in 'number_input'  
DIGIT_COUNT db 0   ;used in 'number_input' 
IS_NEG db 0        ;used in 'number_input'  

A dw 0,0           ;MATRIX A
  dw 0,0
B dw 0,0           ;MATRIX B
  dw 0,0
S dw 0,0           ;MATRIX S = MATRIX A + MATRIX B
  dw 0,0

I dw ?
J dw ?
K db 31h

MSG1 dw 10,13,"Matrix A(2x2): $"     
MSG2 dw 10,13,"Matrix B(2x2): $"  

ELEMENT dw 10,13,"ELEMENT $"

MSG3 dw 10,13,"MATRIX A: $"  
MSG4 dw 10,13,"MATRIX B: $"
MSG5 dw 10,13,"MATRIX B + MATRIX B: $"  

NEWLINE dw 10,13,"$"

.code
main proc
    mov ax,@data
    mov ds,ax    
    
    ;MATRIX A INPUT 
    xor bx,bx
    xor si,si
    xor bx,bx
    xor si,si
    xor ax,ax 
        
    lea dx,MSG1
    call print_string
        
    OUTER_A: 
        INNER_A:
        mov I,bx
        mov J,si
        
        ;input code
        lea dx,ELEMENT
        call print_string
         
        mov dl,K
        mov ah,2
        int 21h 
          
        mov dl,':'
        mov ah,2
        int 21h
        
        call number_input 
        xor ax,ax
        mov ax,TEMP
        
        xor bx,bx
        xor si,si
        mov bx,I
        mov si,J 
        
        mov word ptr A[bx+si],ax
        xor ax,ax
        
        mov al,K
        inc al
        mov K,al
        
        mov bx,I
        mov cx,J
        
        xor ax,ax 
     
        add si,2
        cmp si,2
        jle INNER_A 
        xor si,si
    add bx,4
    cmp bx,4
    jle OUTER_A
             

    
    ;MATRIX B INPUT 
    xor bx,bx
    xor si,si
    xor bx,bx
    xor si,si
    
    mov al,31h 
    mov K,al
    
    xor ax,ax
    
    lea dx,NEWLINE
    call print_string    
    lea dx,MSG2
    call print_string
        
    OUTER_B: 
        INNER_B:
        mov I,bx
        mov J,si
        
        lea dx,ELEMENT
        call print_string
         
        mov dl,K
        mov ah,2
        int 21h 
          
        mov dl,':'
        mov ah,2
        int 21h 
        
        call number_input 
        xor ax,ax
        mov ax,TEMP 
        
                
        xor bx,bx
        xor si,si
        mov bx,I
        mov si,J 
        
        mov word ptr B[bx+si],ax 
        
        xor ax,ax
        
        mov al,K
        inc al
        mov K,al
        
        mov bx,I
        mov cx,J 
        
        add si,2
        cmp si,2
        jle INNER_B 
        xor si,si
    add bx,4
    cmp bx,4
    jle OUTER_B
    
    ;result calculation i.e. performing matrix addition        
    xor bx,bx
    xor si,si
    xor bx,bx
    xor si,si
    xor ax,ax     
    
    OUTER_S: 
        INNER_S: 
        mov ax,word ptr A[bx+si]
        add ax,word ptr B[bx+si]
        mov word ptr S[bx+si],ax 
        
        add si,2
        cmp si,2
        jle INNER_S 
        xor si,si
    add bx,4
    cmp bx,4
    jle OUTER_S
             
    xor bx,bx
    xor si,si
    
    
    ;print matrix A
    xor bx,bx
    xor si,si
    xor bx,bx
    xor si,si
    
    mov al,31h 
    mov K,al
    
    xor ax,ax  
    
    lea dx,NEWLINE
    call print_string   
    lea dx,MSG3
    call print_string 
    lea dx,NEWLINE
    call print_string 
        
    xor bx,bx
    xor si,si
    xor bx,bx 
    xor dx,dx
    xor si,si
    
    xor ax,ax
       
    
    OUTER_PRINT_A:   
      INNER_PRINT_A:
                  
        mov I,bx
        mov J,cx 
        mov dx,word ptr A[bx+si] 

        mov X,dx  
        call print_large_number
        mov dx,' '
        call print_output 
        
        xor ax,ax
        
        mov bx,I
        mov cx,J   
    
        add si,2
        cmp si,2
        jle INNER_PRINT_A 
        xor si,si
        
        lea dx,NEWLINE
        call print_string
        
    add bx,4
    cmp bx,4
    jle OUTER_PRINT_A    

    
    ;print matrix B
    xor bx,bx
    xor si,si
    xor bx,bx
    xor si,si
    
    mov al,31h 
    mov K,al
    
    xor ax,ax  
    
    lea dx,NEWLINE
    call print_string   
    lea dx,MSG4
    call print_string
    lea dx,NEWLINE
    call print_string 

        
    xor bx,bx
    xor si,si
    xor bx,bx 
    xor dx,dx
    xor si,si
    
    xor ax,ax
       
    
    OUTER_PRINT_B:   
      INNER_PRINT_B:
                  
        mov I,bx
        mov J,cx 
        mov dx,word ptr B[bx+si] 

        mov X,dx  
        call print_large_number
        mov dx,' '
        call print_output 
        
        xor ax,ax
        
        mov bx,I
        mov cx,J   
    
        add si,2
        cmp si,2
        jle INNER_PRINT_B 
        xor si,si
        
        lea dx,NEWLINE
        call print_string
        
    add bx,4
    cmp bx,4
    jle OUTER_PRINT_B 

   
    ;print output i.e addition
    xor bx,bx
    xor si,si
    xor bx,bx
    xor si,si
    
    mov al,31h 
    mov K,al
    
    xor ax,ax   
    
    lea dx,NEWLINE
    call print_string        
    lea dx,MSG5
    call print_string
    lea dx,NEWLINE
    call print_string  

        
    xor bx,bx
    xor si,si
    xor bx,bx 
    xor dx,dx
    xor si,si
    
    xor ax,ax
       
    
    OUTER_PRINT_S:   
      INNER_PRINT_S:
                  
        mov I,bx
        mov J,cx 
        mov dx,word ptr S[bx+si] 

        mov X,dx  
        call print_large_number
        mov dx,' '
        call print_output 
        
        xor ax,ax
        
        mov bx,I
        mov cx,J   
    
        add si,2
        cmp si,2
        jle INNER_PRINT_S 
        xor si,si
        
        lea dx,NEWLINE
        call print_string
        
    add bx,4
    cmp bx,4
    jle INNER_PRINT_S
    
    
    QUIT:
    mov ah,04ch
    int 21h
main endp

 
;========================= PROCEDURES =======================  
;# # # procedures for i/o operations   

;# # # procedure to take number input # # # 
number_input proc 
    mov ax,0
    mov TEMP,ax
    xor ax,ax
       
    INPUT:
    call char_input 
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


;print output procedure
print_output proc
    mov ah,02h
    int 21h
    ret
print_output endp 

;print string procedure
print_string proc
    mov ah,09h
    int 21h
    ret
print_string endp

;character input procedure
char_input proc
    mov ah,1
    int 21h
    ret
char_input endp
   
end main





