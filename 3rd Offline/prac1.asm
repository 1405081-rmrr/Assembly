.MODEL SMALL
.STACK 100H
.DATA
MSG DB "ENTER A NUMBER: $"
TOTAL DW 00H
VALUE DW 00H
.CODE
MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH, 9
    LEA DX, MSG
    INT 21H
    jmp read
    
    READ:
    MOV AH, 1
    INT 21H
    
    CMP AL,0DH
    JE  ENDOFNUMBER
    
    MOV VALUE, AX
    SUB VALUE, 48
    
    MOV AX, TOTAL
    MOV Bx, 10
    MUL BX
    
    ADD Ax, VALUE
    ;SUB AX,'0'
    
    MOV TOTAL, Ax
    
    JMP READ

    ENDOFNUMBER:
    
    mov AH,2
    mov DL,0DH  ;CARRIAGE RETURN
    int 21H
    mov DL,0AH  ;LINE FEED
    int 21H 
    JMP ENJ
    ENJ:
    mov cx,0 
	;mov dx,0
	mov ax,total 
	
	label1: 
		; if ax is zero
		;push ax 
		cmp ax,0
		je print1	 
		
		;initilize bx to 10 
		mov bx,10		 
		cwd
		; extract the last digit 
		div bx				 
		
		;push it in the stack 
		push dx			 
		
		;increment the count 
		inc cx			 
		
		;set dx to 0 
		xor dx,dx 
		jmp label1 
	print1: 
		;check if count 
		;is greater than zero 
		cmp cx,0 
		je exit
		
		;pop the top of stack 
		pop dx 
		
		;add 48 so that it 
		;represents the ASCII 
		;value of digits 
		add dx,48 
		
		;interuppt to print a 
		;character 
		mov ah,02h 
		int 21h 
		
		;decrease the count 
		dec cx 
		jmp print1 
    
    
    
           
exit:
MAIN ENDP
