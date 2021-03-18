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
       
    call number_input    ;eta ekta procedure. number input ney.
    xor ax,ax            ;edi ax re clear kore fele. mane 0 bosay
    mov ax,TEMP          ;negative kina check kore.cx=1 hole negative. cx=0 hole positive
    CMP CX,0 
    JE MOVE_NUMBER1      ;negative na hole nai. move_number1 e jabe
    JMP MAKE_NEG
    
    MAKE_NEG:             ;NEG er dara negative banaya dey bal
    NEG AX
    
    MOVE_NUMBER1:
    mov NUM1,ax
    xor ax,ax
    mov TEMP,0
    ;XOR CX,CX 
    mov cx,0

    
    ;number2 input
    NUMBER2_INPUT:    ;same. arek nmbr input ney
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
    lea dx,MSG3            ;edi + - * / eisob input ney
    mov ah,09h
    int 21h
    call operator_input    ;edi procedure. oikhane jaya kahini lekhum etar.
       
    ;result output
    lea dx,MSG4                  
    mov ah,09h          ;edi rslr er leiga
    int 21h
    NEXT_NUM1:
    xor ax,ax            ;edi numbr re X e move kore. then print kore number ta.
    mov ax,NUM1           ;kmne kore pore bltasi.
    ;mov X,ax
    CMP AX,0
    JL MAKE_NUM1 
    MOV X,AX
    CALL print_large_number 
    JMP  NEXT_NUM2
    ;MOV BL,NEGA
    ;CMP BL,1
    ;JE MNS  
    
    MAKE_NUM1:
    NEG AX
    MOV X,AX 
    mov dl,'-'
    mov ah,02h
    int 21h
    call print_large_number 
    JMP NEXT_NUM2
    ;MNS: 
    ;MOV NEGA,0
   ; MOV DL,'-'
    ;MOV AH,02H
   ; INT 21H
   ; CALL print_large_number 
    
    NEXT_NUM2:
    xor dx,dx 
    mov dl,OPERATOR   ;edi operator print kore.
    mov ah,02h
    int 21h 
    
    xor ax,ax    
    mov ax,NUM2
    ;mov X,ax
    CMP AX,0
    JL MAKE_NUM2 
    MOV X,AX
    call print_large_number  
    JMP ASSIGN1
    
    
    MAKE_NUM2: 
    NEG AX
    MOV X,AX
    mov dl,'-'
    mov ah,02h
    int 21h
    
    
    ;MOV BL,NEGA
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
    mov ah,02h       ;assign upre ase. .Data er moddhe. deikhn ki ase.
    int 21h  
    
    xor ax,ax  
    mov ax,RESULT  
    mov X,ax 
    cmp ax,0
    je PLUS
    mov bl,NEGATIVE
    cmp bl,1
    jne PLUS 
    CMP BL,NEGATIVE      ;edi - print kore. jdi 65-90 hoy taile register e dhuke 25. ekhane aisha samne - boshe.
    CMP BL,2
    JE PLUS
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
    CMP AL,2DH ;jdi minus sign dei tahole Negat e chole jabe.CX ke 1 banabe
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
                           ;EDI NORMAL. DHOREN 9 DILAM INPUT.SE CHARACTER HISEBE NEBE.TEMP
    mov ax,TEMP
    mov bx,10               ; E INITIALLY 0 ACHE. 10*0=0. EI 0 ER SATHE 9 JOG KORE 9.EDIRE
    mul bx                  ;TEMP E RAKHBE.TRPR 3 DILEN.3 RE DIGIT 2 TE RAKHBE. TEMP E ASE 9. 9 RE
    add ax,DIGIT2
                            ;10 DIA GUN DILE 90.THEN ADD AX,DIGIT2 MANE 90+3=93
   
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
    cmp ax,0
    jl ADDI  
    mov RESULT,ax
    jmp RETURN2 
    
    ADDI:
    NEG AX 
    MOV CL,NEGATIVE
    INC CL
    MOV NEGATIVE,CL
    MOV RESULT,AX
    JMP RETURN2
    
    SUBTRACTION:
    mov ax,NUM1 
    mov bx,NUM2
    cmp ax,bx  ;jdi first number boro hoy tahole negative ke 1 banabe.trpr
    jge OK            ;NOT_OK te jump debe
    mov NEGATIVE,1
    JMP NOT_OK
    
    NOT_OK:
    SUB AX,BX ;say -9 first number.6 second.tahole -9+6=-3 hobe.
    NOT AX    ;then NEG kore 1 barale 3 hobe. trpr age lekha ache.
    INC AX      ;print korar somoy - dia debe
    ;AND AX,255
    MOV RESULT,AX
    JMP RETURN2
    
    OK: 
    sub ax,bx 
    mov RESULT,ax
    jmp RETURN2 
    
    MULTIPLICATION:
    CHECK_NEG1:
    MOV AX,NUM1   ;first e check korbe minus disi kina. mane CX e 1 ache kina.
    CMP AX,0      ;thakle CHANGE1 e jaya positive banaya disi NEX AX e jaya
    JL CHANGE1
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
    CMP BX,0
    JL CHANGE2 
    JMP MULTI
    
    CHANGE2:     ;same kaj eikhaneo
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
    NOT AX
    INC AX       ;-90*10=900 EIJNNO HOISE. THN APNER KTHA MOTO MINUS ER KAJ KORA LAGBE
    MOV RESULT,AX 
    MOV NEGATIVE,1
    JMP RETURN2
    
    DIVISION: 

    mov ax,NUM1
    mov bx,NUM2 
    CHECK_NEG11:
    MOV AX,NUM1   ;first e check korbe minus disi kina. mane CX e 1 ache kina.
    CMP AX,0      ;thakle CHANGE1 e jaya positive banaya disi NEX AX e jaya
    JL CHANGE11
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
    CMP BX,0
    JL CHANGE12 
    JMP DIVI
    
    CHANGE12:     ;same kaj eikhaneo
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
    xor cx,cx        ;EDI BOI E ASE. JIGANOR KTHA NA. VAAG DIA ULTA KAJ.93 RE 10 DIA VAG DILE 
    xor dx,dx
                      ;REMAINDER 3.SO 3 PUSH HBE. 9 RE 10 DIA VAG DILE 9 REMAINDER.
    LOOP_PUSH:         ;RESULT 0. 9/10=0.SO LOOP SHES. STACK E NICHE ASE 3 ERPR 9.
    xor dx,dx
    div bx             ;SO POP KORLE 9 ASBE THEN 3. SO 93 PRINT HBE .
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
