.MODEL SMALL
 .STACK 100H

 .DATA
    PROMPT  DB  'The resultant 2X2 matrix is  : ',0DH,0AH,'$\'

    ARRAY1   DW  1,3
             DW  1,5
            
    ARRAY2   DW 6,5
             DW 8,3
    
    A DW 0
    B DW 0
    RESULT DW 0        

 .CODE
   MAIN PROC
     MOV AX, @DATA                ; initialize DS
     MOV DS, AX

     LEA DX, PROMPT               ; load and display the string PROMPT
     MOV AH, 9
     INT 21H 
     
     INIT_ARRAY: 
     XOR AX,AX
     XOR BX,BX
     XOR CX,CX
     XOR DX,DX
     
     LEA DI,ARRAY1
     LEA SI,ARRAY2 
     
     
     INIT_CX:
     MOV CX,2
     JMP INIT_BX 
     
     
     NEW_LINE:
     mov AH,2
     mov DL,0DH  ;CARRIAGE RETURN
     int 21H
     mov DL,0AH  ;LINE FEED
     int 21H
     
     INIT_BX:
     MOV BX,2
     
      SET_ARRAY1:
      
      MOV AX,[DI]
      MOV A,AX 
      
      SET_ARRAY2:
      MOV AX,[SI]
      MOV B,AX
      
      
      ADDI:
      XOR AX,AX
      MOV AX,A
      ADD AX,B
      MOV RESULT,AX
      
      MOV AH, 2                ; set output function
      MOV DL, 20H              ; set DL=20H
      INT 21H   
      MOV AH,2
      ADD RESULT,30H
      MOV DX,RESULT
      INT 21H
      
      
      INC_DI_SI:
      ADD DI,2
      ADD SI,2
      DEC BX
      JNZ SET_ARRAY1
      JZ DEC_CX 
      
      DEC_CX:
      DEC CX
      CMP CX,0
      JE END_
      JNZ NEW_LINE
    
     

     
 
      
END_:      
     MOV AH, 4CH                  ; return control to DOS
     INT 21H
     MAIN ENDP
END MAIN   