.MODEL SMALL
 .STACK 100H

 .DATA
    PROMPT  DB  'The contents of 4x5 2D array in column major order are : ',0DH,0AH,'$\'

    ARRAY   DW  1,6,11,16
            DW  2,7,12,17    
            DW  3,8,13,18
            DW  4,9,14,19      
            DW  5,10,15,20

 .CODE
   MAIN PROC
     MOV AX, @DATA                ; initialize DS
     MOV DS, AX

     LEA DX, PROMPT               ; load and display the string PROMPT
     MOV AH, 9
     INT 21H

     LEA SI, ARRAY                ; set SI=offset address of ARRAY
     MOV CX, 5                    ; set CX=5

     @LOOP_1:                     ; loop label
       MOV BX, 4                  ; set BX=4

       @LOOP_2:                   ; loop label
         MOV AH, 2                ; set output function
         MOV DL, 20H              ; set DL=20H
         INT 21H                  ; print a character

         MOV AX, [SI]             ; set AX=[SI]

         CALL OUTDEC              ; call the procedure OUTDEC

         ADD SI, 2                ; set SI=SI+2
         DEC BX                   ; set BX=BX-1
       JNZ @LOOP_2                ; jump to label @LOOP_2 if BX=0

       MOV AH, 2                  ; set output function
       MOV DL, 0DH                ; set DL=0DH
       INT 21H                    ; print a character

       MOV DL, 0AH                ; set DL=0AH
       INT 21H                    ; print a character
     LOOP @LOOP_1                 ; jump to label @LOOP_1 while CX!=0

     MOV AH, 4CH                  ; return control to DOS
     INT 21H
   MAIN ENDP



 ;-------------------------  Procedure Definitions  ------------------------;




 ;--------------------------------  OUTDEC  --------------------------------;


 OUTDEC PROC
   ; this procedure will display a decimal number
   ; input : AX
   ; output : none

   PUSH BX                        ; push BX onto the STACK
   PUSH CX                        ; push CX onto the STACK
   PUSH DX                        ; push DX onto the STACK

   XOR CX, CX                     ; clear CX
   MOV BX, 10                     ; set BX=10

   @OUTPUT:                       ; loop label
     XOR DX, DX                   ; clear DX
     DIV BX                       ; divide AX by BX
     PUSH DX                      ; push DX onto the STACK
     INC CX                       ; increment CX
     OR AX, AX                    ; take OR of Ax with AX
   JNE @OUTPUT                    ; jump to label @OUTPUT if ZF=0

   MOV AH, 2                      ; set output function

   @DISPLAY:                      ; loop label
     POP DX                       ; pop a value from STACK to DX
     OR DL, 30H                   ; convert decimal to ascii code
     INT 21H                      ; print a character
   LOOP @DISPLAY                  ; jump to label @DISPLAY if CX!=0

   POP DX                         ; pop a value from STACK into DX
   POP CX                         ; pop a value from STACK into CX
   POP BX                         ; pop a value from STACK into BX

   RET                            ; return control to the calling procedure
 OUTDEC ENDP





 END MAIN