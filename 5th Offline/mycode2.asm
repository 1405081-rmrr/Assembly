.MODEL SMALL

.STACK 100H

.DATA

PROMPT   DB 'FILENAME: $'
FILENAME DB 30 DUP (0)
BUFFER   DB 512 DUP (0)
OUTPUT   DB 512 DUP (0)
HANDLE   DW ?
LENGTH   DW ?
OPENERR  DB 0DH,0AH, 'OPEN ERROR - CODE'
ERRCODE  DB 30H,'$'

OUTPUTF  DB "Output.txt",0
TEXT_SIZE = $ - OFFSET OUTPUT

.CODE   

MAIN PROC
    
    MOV AX,@DATA
    MOV DS,AX       ;INITIALIZE DS
    MOV ES,AX       ; AND ES
    CALL GET_NAME   ;READ FILENAME
    LEA DX,FILENAME ;DX HAS FILENAME OFFSET
    MOV AL,0        ; ACCESS CODE 0 FOR READING
    CALL OPEN       ;OPEN FILE
    JC OPEN_ERROR   ;EXIT IF ERROR 
    MOV HANDLE,AX   ;SAVE HANDLE
    
    
    READ_LOOP:
    
    LEA DX, BUFFER  ; DX PTS TO BUFFER
    MOV BX,HANDLE   ;GET HANDLE
    CALL READ       ;READ FILE. AX = BYTES READ
    OR AX,AX        ;EOF?  
    JE EXIT
    MOV CX,AX       ;CX GETS NO OF BYTES READ
    MOV LENGTH,CX
    JMP READ_LOOP
    
    
    OPEN_ERROR:
    
    LEA DX,OPENERR  ;GET ERROR MESSAGE
    ADD ERRCODE,AL  ;CONVERT ERROR CODE TO ASCII
    MOV AH,9
    INT 21H         ;DISPLAY ERROR MESSAGE
    
    EXIT:
    
    MOV BX,HANDLE   ;GET HANDLE
    CALL CLOSE
    
    MOV AH,4CH
    INT 21H
MAIN ENDP
    

GET_NAME PROC NEAR
    
    ;READS AND STORES FILE NAME
    ;INPUT: NONE
    ;OUTPUT: FILE NAME STORED AS ASCII STRING
    
    PUSH AX
    PUSH DX
    PUSH DI
    MOV AH,9
    LEA DX,PROMPT
    INT 21H
    CLD
    LEA DI,FILENAME
    MOV AH,1
    
    READ_NAME:
    
    INT 21H
    CMP AL,0DH
    JE DONE
    STOSB
    JMP READ_NAME
    
    DONE:
    
    MOV AL,0
    STOSB
    POP DI
    POP DX
    POP AX
    RET
    
    GET_NAME ENDP

OPEN PROC NEAR
    
    ;OPENS FILE
    ;INPUT DS:DX FILENAME, AL ACCESS CODE
    ;OUTPUT IF SUCCESSFUL AX HANDLE
    ;IF UNSUCCESSFUL CF =1 , AX = ERROR CODE
    
    MOV AH,3DH
    MOV AL,0
    INT 21H
    RET
     
    OPEN ENDP

READ PROC NEAR
    
    ;READS A FILE SECTOR
    ;INPUT: BX FILE HANDLE
    ;CX BYTES TO READ
    ;DS:DX BUFFER
    ;OUTPUT: IF SUCCESSFUL, SECTOR IN BUFFER
    ;AX NUMBER OF BYTED READ
    ; IF UNSUCCESSFUL CF =1
    
    PUSH CX
    MOV AH,3FH
    MOV CX,512
    INT 21H
    POP CX
    RET
    
    READ ENDP
    DISPLAY NEAR PROC

    ;CREATE AND OPEN FILE: c:\emu8086\MyBuild\Output.txt
    
    PUSH BX
    MOV AH,40H
    MOV BX,1
    INT 21H
    POP BX
    RET
    DISPLAY ENDP

CLOSE PROC NEAR
    
    ;CLOSES A FILE
    ;INPUT BX = HANDLE
    ;OUTPUT CF =1; ERROR CODE IN AX
    
    MOV AH,3EH
    INT 21H
    RET
    
    CLOSE ENDP


END MAIN
    
     