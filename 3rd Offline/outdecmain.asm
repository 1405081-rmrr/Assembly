.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC 
 
CALL OUTDEC
MOV AH,4CH
INT 21H
MAIN ENDP
INCLUDE outdec.asm
END MAIN