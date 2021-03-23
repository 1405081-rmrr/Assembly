.MODEL SMALL
 .STACK 100H

 .DATA
    PROMPT  DB  'The contents of 4x5 2D array in column major order are : ',0DH,0AH,'$\'

    ARRAY1   DW  1,2
             DW  3,4
            
    ARRAY2   DW 1,2
             DW 3,4
    
    A DW 0
    B DW 0        

 .CODE
   MAIN PROC
     MOV AX, @DATA                ; initialize DS
     MOV DS, AX

     LEA DX, PROMPT               ; load and display the string PROMPT
     MOV AH, 9
     INT 21H 
     
     ARRAY:
     
     LEA DI,ARRAY1
     LEA SI,ARRAY2
     MOV CX,2 
     XOR DX,DX 
     JMP LOOP1
     
     
     DEC_CX:
     DEC CX
     CMP CX,0
     JE  ARRAY22
     mov AH,2
     mov DL,0DH  ;CARRIAGE RETURN
     int 21H
     mov DL,0AH  ;LINE FEED
     int 21H
     
     LOOP1:
     
     MOV BX,2
     
     LOOP2:
      
      MOV AX,[DI]
      MOV A,AX 
      MOV AH, 2                ; set output function
      MOV DL, 20H              ; set DL=20H
      INT 21H   
      MOV AH,2
      ADD A,30H
      MOV DX,A
      INT 21H
      
      ADD DI,2
      DEC BX
      JNZ LOOP2
      JZ DEC_CX  
      
      
     ARRAY22:
     
     MOV CX,2 
     XOR DX,DX 
     JMP LOOP11 
     
     
     DEC_CX1:
     DEC CX
     CMP CX,0
     JE  END_
     mov AH,2
     mov DL,0DH  ;CARRIAGE RETURN
     int 21H
     mov DL,0AH  ;LINE FEED
     int 21H
     
     LOOP11:
     
     MOV BX,2
     
     LOOP12:
      
      MOV AX,[SI]
      MOV A,AX 
      MOV AH, 2                ; set output function
      MOV DL, 20H              ; set DL=20H
      INT 21H   
      MOV AH,2
      ADD A,30H
      MOV DX,A
      INT 21H
      
      ADD SI,2
      DEC BX
      JNZ LOOP12
      JZ DEC_CX1
      
END_:      
     MOV AH, 4CH                  ; return control to DOS
     INT 21H
     MAIN ENDP
END MAIN   