.MODEL small

.STACK 100h

.DATA

    A db 0
    B db 0
    C db 0
    Q DB 0 
    F1 DB 0
    F2 DB 0
    F3 DB 0
    F4 DB 0
    
    MSG1 DB 0DH,0AH,'Enter a series of character $'
    MSG2 DB 0DH,0AH,'The second largest number is: $'
    MSG3 DB 0DH,0AH,'All the numbers are equal$' 
    MSG4 DB 0DH,0AH,'PRESS ANY KEY TO CONTINUE. PRESS Q or q TO QUIT : $'

.CODE

MAIN PROC
    
mov AX,@DATA
mov DS,AX 

    lea DX,MSG4
    mov AH,9
    int 21H

PROMPT:
    
    MOV AH,1   ;PRESS ANY KEY TO CONTINUE
    INT 21H    ;PRESS Q or q TO FINISH
    MOV Q,AL
    CMP AL,051H
    JZ FINISH
    JNZ ENTERMESSAGE
    
ENTERMESSAGE:
    lea DX,MSG1
    mov AH,9
    int 21H
    JMP ENTER_CHARACTER

ENTER_CHARACTER:

    mov AH,1
    int 21h
    mov A,AL
    CMP AL,020H ;SPACE
    JE FINISH 
    CMP AL,09H ;TAB
    JE FINISH
    CMP AL,0DH ;NEWLINE
    JE COUNT 
    CMP AL,041H
    JGE CHECK_UPPERCASE
    CMP AL,05AH
    JLE CHECK_UPPERCASE
    ;JMP ENTER_CHARACTER 
    
CHECK_UPPERCASE:
      MOV BL,F1
      INC BL
      MOV F1,BL
      JMP ENTER_CHARACTER
      ;JMP COUNT

COUNT:
    
    mov AH,2
    mov DL,0DH  ;CARRIAGE RETURN
    int 21H
    mov DL,0AH  ;LINE FEED
    int 21H 
    ADD BL,'0'
    mov DL,BL
    int 21h
    JMP FINISH    

FINISH:       
MAIN ENDP 
END MAIN