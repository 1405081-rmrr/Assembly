.MODEL SMALL
 .STACK 100H

 .DATA
    PROMPT  DB  'The resultant 2X2 matrix is  : ',0DH,0AH,'$\' 
    PROMPT2  DB  'FIRST MATRIX  : ',0DH,0AH,'$\' 
    PROMPT3  DB  'FIRST ELEMENT : ',0DH,0AH,'$\'
    PROMPT4  DB  'SECOND ELEMENT  : ',0DH,0AH,'$\'
    PROMPT5  DB  'THIRD ELEMENT  : ',0DH,0AH,'$\'
    PROMPT6  DB  'FOURTH ELEMENT  : ',0DH,0AH,'$\'
    PROMPT7  DB  'SECOND MATRIX : ',0DH,0AH,'$\'
    
    

    ARRAY1 DW 0
    ARRAY2 DW 0
    FINALARRAY DW 0
    A DW 0
    B DW 0
    RESULT DW 0
    C1 DW 0
    B1 DW 0 
    F DW 0       

 .CODE
   MAIN PROC
     MOV AX, @DATA                ; initialize DS
     MOV DS, AX
     
     XOR AX,AX
     XOR BX,BX
     XOR CX,CX
     XOR DX,DX
     XOR SI,SI

     LEA DX, PROMPT               ; load and display the string PROMPT
     MOV AH, 9
     INT 21H 
     
     
     LEA DX, PROMPT2              ; load and display the string PROMPT
     MOV AH, 9
     INT 21H
     
     
     
     
     
     XOR AX,AX
     XOR BX,BX
     XOR SI,SI
     XOR CX,CX 
     INIT_BX1:
     MOV BX,0
     MOV SI,2 
     
     
    
     
     INPUT_NUMBER1: 
     LEA DX, PROMPT3              ; load and display the string PROMPT
     MOV AH, 9
     INT 21H 
     
     MOV AH,1
     INT 21H 
     MOV ARRAY1[BX][SI],AX 
     
     INPUT_NUMBER2:
     mov AH,2
     mov DL,0DH  ;CARRIAGE RETURN
     int 21H
     mov DL,0AH  ;LINE FEED
     int 21H
     ADD SI,2
     LEA DX, PROMPT4              ; load and display the string PROMPT
     MOV AH, 9
     INT 21H 
     
     MOV AH,1
     INT 21H 
     MOV ARRAY1[BX][SI],AX 
     
     INPUT_NUMBER3:
     mov AH,2
     mov DL,0DH  ;CARRIAGE RETURN
     int 21H
     mov DL,0AH  ;LINE FEED
     int 21H
     ADD SI,2
     MOV BX,8
     LEA DX, PROMPT5              ; load and display the string PROMPT
     MOV AH, 9
     INT 21H 
     MOV AH,1
     INT 21H 
     MOV ARRAY1[BX][SI],AX
     
     INPUT_NUMBER4: 
     mov AH,2
     mov DL,0DH  ;CARRIAGE RETURN
     int 21H
     mov DL,0AH  ;LINE FEED
     int 21H
     ADD SI,2
     LEA DX, PROMPT6              ; load and display the string PROMPT
     MOV AH, 9
     INT 21H 
     MOV AH,1
     INT 21H 
     MOV ARRAY1[BX][SI],AX
     JMP PRINT 
     
     
     PRINT:      
     XOR AX,AX
     XOR BX,BX
     XOR SI,SI
     XOR CX,CX 
     XOR DX,DX
     
     
     MOV BX,0
     MOV SI,2
     
     
     MOV ax,ARRAY1[BX][SI] 
     MOV RESULT,AX
     ADD RESULT,30H
     MOV AH,2
     MOV DX,RESULT
     INT 21H 
     
     MOV BX,0
     ADD SI,2
     
    
     MOV ax,ARRAY1[BX][SI] 
     MOV RESULT,AX
     ADD RESULT,30H  
     MOV AH,2
     MOV DX,RESULT
     INT 21H
     
      MOV BX,4
     ADD SI,2
     
    
     MOV ax,ARRAY1[BX][SI] 
     MOV RESULT,AX
     ADD RESULT,30H
     MOV AH,2
     MOV DX,RESULT
     INT 21H
     
      MOV BX,4
      ADD SI,2
     
     
     MOV ax,ARRAY1[BX][SI] 
     MOV RESULT,AX
     ADD RESULT,30H
     MOV AH,2
     MOV DX,RESULT
     INT 21H

      

    

END_: 
   
     MOV AH, 4CH                  ; return control to DOS
     INT 21H
     MAIN ENDP

END MAIN   