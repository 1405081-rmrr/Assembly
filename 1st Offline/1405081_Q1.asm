.MODEL small

.STACK 100h

.DATA

    X dW 0
    Y dW 0
    Z dW 0
    
    MSG1 DB 'ENTER TWO NUMBERS X & Y:$'
    MSG2 DB 0DH,0AH,'X = $'
    MSG3 DB 0DH,0AH,'Y = $'
    MSG4 DB 0DH,0AH,'Z =  X - 2Y  : $'
    MSG5 DB 0DH,0AH,'Z =  25-X-Y  : $'
    MSG6 DB 0DH,0AH,'Z = 2X - 3Y : $'
    MSG7 DB 0DH,0AH,'Z = Y -X +1 : $'
    
      

.CODE

MAIN PROC
    
mov AX,@DATA
mov DS,AX

lea DX,MSG1
mov AH,9
int 21H

mov AH,2
mov DL,0DH  
int 21H
mov DL,0AH  
int 21H

lea DX,MSG2
mov AH,9
int 21H

;INPUT: X & Y

mov AH,1
int 21h 
mov X,AX

mov AH,2
mov DL,0DH  
int 21H
mov DL,0AH  
int 21H

lea DX,MSG3
mov AH,9
int 21H

mov AH,1
int 21h 
mov Y,AX

 
;Z = X - 2Y

mov AX,X
sub AX,'0'
mov CX,AX

mov BX,Y
SUB BX,'0'

MOV AX,32H
SUB AX,30H

MUL BX

SUB CX,AX
ADD  cx,'0'
mov Z,CX

mov AH,2
mov DL,0DH  
int 21H
mov DL,0AH  
int 21H

lea DX,MSG4
mov AH,9
int 21H

mov AH,2
mov DX,Z
int 21h


;Z =  25-X-Y 

mov AX,X
sub AX,'0'

MOV CX,'9'
SUB CX,AX
MOV AX,Y
SUB CX,AX
MOV AX,'8'
ADD CX,AX
MOV AX,'8'
ADD CX,AX 
SUB CX,48

MOV Z,CX

mov AH,2
mov DL,0DH  
int 21H
mov DL,0AH  
int 21H

lea DX,MSG5
mov AH,9
int 21H

mov AH,2
mov DX,Z
int 21h


;Z = 2X - 3Y 
mov BX,X
sub BX,'0'

mov AX,'2'
sub AX,'0'

mul BX 
MOV CX,AX


mov BX,Y
sub BX,'0'

mov AX,'3'
sub AX,'0'

MUL BX

SUB CX,AX
ADD CX,'0'
MOV Z,CX

mov AH,2
mov DL,0DH  
int 21H
mov DL,0AH  
int 21H

lea DX,MSG6
mov AH,9
int 21H

mov AH,2
mov DX,Z
int 21h

;Z = Y - X + 1
mov BX,Y
sub BX,'0'

mov AX,X
sub AX,'0'

SUB BX,AX
MOV CX,31H
ADD BX,CX

MOV Z,BX

mov AH,2
mov DL,0DH  
int 21H
mov DL,0AH  
int 21H

lea DX,MSG7
mov AH,9
int 21H

mov AH,2
mov DX,Z
int 21h


MAIN ENDP
END MAIN