.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC 
 mov ax,100
CALL OUTDEC
MOV AH,4CH
INT 21H
MAIN ENDP
INCLUDE outdec.asm
END MAIN