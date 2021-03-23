.MODEL small

.STACK 100h

.DATA
   
   COUNT DW 0

.CODE


MAIN PROC
    
    MOV  AX,@DATA
    MOV  DS,AX 

    MOV  AX,7       ;INPUT(N)
    PUSH AX                     ;SP 256
    
    MOV  AX,4       ;INPUT(P)  ;SP 254
    PUSH AX

    CALL GEN_NUM       ;SP 252
    
    MOV  BL,0AH
    
    QR:
    
    DIV  BL
    MOV  CX,0
    MOV  CL,AH 
    PUSH CX
    INC  COUNT
    CMP  AL,0
    JE   PRINT
    MOV  AH,0
    JMP  QR
    
    PRINT:
    
    MOV AH,2
    POP CX
    DEC COUNT
    MOV DL,CL
    ADD DL,30H
    INT 21H
    CMP COUNT,0
    JNE PRINT
     
    
    MOV  AH,4CH
    INT  21H


    MAIN ENDP


GEN_NUM PROC NEAR
    
                    ;SP 250
    PUSH BP
    MOV  BP,SP       ;SP 250 BP 250
    
    MOV  AX,[BP+6]   ;AX 10
    MOV  DX,[BP+4]    ;CX 4
                      
    CMP  AX,0
    JE   RETURN_3
    CMP  DX,1
    JE   RETURN_3
    
    CMP  AX,1
    JE   RETURN_6
    CMP  DX,2
    JE   RETURN_6
    
    CMP  AX,2
    JE   RETURN_4
    CMP  DX,0
    JE   RETURN_4
    
    CMP  AX,3
    JE   RETURN_5
    CMP  DX,2
    JE   RETURN_5
    
    JNE  ELSE
    
    RETURN_3:
    
    MOV  AX,3
    JMP  RETURN

    RETURN_6:
    
    MOV  AX,6
    JMP  RETURN
        
    RETURN_4:
    
    MOV  AX,4
    JMP  RETURN
        
    RETURN_5:    
    
    MOV  AX,5
    JMP  RETURN
    
    ELSE:
    
    ;COMPUTE(N-1,P)
    
    MOV  CX,[BP+6] 
    DEC  CX  ; N 9
    PUSH CX  ;SP 248
    PUSH [BP+4] ;SP 246
    CALL GEN_NUM
    PUSH AX   ;SP 244
    
    ;COMPUTE(N-2,P-1)
    
    MOV  CX,[BP+6]
    SUB  CX,2
    PUSH CX
    MOV  CX,[BP+4]
    DEC  CX
    PUSH CX
    CALL GEN_NUM
    POP  BX
    ADD  AX,BX
    PUSH AX
    
    ;COMPUTE(N-3,P-2)
    
    MOV  CX,[BP+6]
    SUB  CX,3
    PUSH CX
    MOV  CX,[BP+4]
    SUB  CX,2
    PUSH CX
    CALL GEN_NUM
    POP  BX
    ADD  AX,BX
    PUSH AX 
    
    ;COMPUTE(N-4,P)
    
    MOV  CX,[BP+6]
    SUB  CX,4
    PUSH CX
    PUSH [BP+4]
    CALL GEN_NUM
    POP  BX
    ADD  AX,BX
    SUB  AX,7
    
    RETURN:

    POP BP
    RET 4
    
    GEN_NUM ENDP


END MAIN
