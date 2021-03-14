.MODEL SMALL ; MODEL SMALL rakhlei hobe e offline er jonno. size e chhoto

;emne comment lekhe, age semicolon
;code er tin ta part .STACK .DATA r .CODE 

;STACK ei size rakhlei hobe. function ba procedure (PROC) chhara kaj nai. ei code e ektai procedure (MAIN)
.STACK 100H

;DATA er niche joto variable declare korbi sob thakbe. egula memory te thake
.DATA
    CR EQU 0DH ; 0DH hocchhe carriage return (enter), EQU hocchhe C er #define er moto code er je jaygay CR dekhbe se jaygay 0DH diye replace korbe. CR je jaygay cursor chhilo tar thik niche namay
    LF EQU 0AH ; 0AH hocchhe line feed, eta cursor line er shurute niye jay
  	; CR LF mile newline er kaj kore
    
    MSG1 DB 'ENTER A UPPER CASE LETTER: $' ; MSG1 ekta variable jeta daaner quote er vitor thaka jinista hold kore, DB diye bojhay Define Byte, eta ekta byte array. String shesh korte hobe $ diye
    MSG2 DB CR, LF, 'IN LOWER CASE IT IS: $' ; MSG2 same ager CR LF diye newline store korchhe string er age
    CHAR DB ? ; ? diye bojhay CHAR variable er jonno jayga alada kore rachhe, kichhu store kora nai, ekhane result thakbe

; code part shuru
.CODE

; MAIN PROC mane procedure er naam main. ekhan theke process kora shuru korbe
MAIN PROC
;initialize DS. tor data segment er sathe processor porichito na. porichoy koranor jonno nicher duita line likhte hobe. keno likhchhe eta ekhono jana lagbe na. pore janabe. eta lekha lagbei sob program e
    MOV AX, @DATA
    MOV DS, AX
 
; ekhan theke tor code shuru   
; Input output er 3 ta way dekhaichhe. 31,32,33 line combinedly ekta string print kore.
;print user prompt
    LEA DX, MSG1 ;Load Effective Address, dhore ne MSG1 ke DX e load kore.
    MOV AH, 9 ; AH e 9 move korli, AH er value ekhon decimal 9. 9 ekta function er naam 
    INT 21H ; erpore eta call korle MSG1 terminal e print kore dibe, INT diye interrupt bojhay. processor re interrupt kora lage bairer kajer jonno

;input a upper case character and convert it to lower case     
    MOV AH, 1 ; 36, 37 combinedly ekta character input neyar jonno bose thake, jeta input dibi seta AL e joma hoy
    INT 21H ; ekhaneo interrupt, AL e ekhon upper case character ta  
    ADD AL, 20H ;ADD mane porer je operand seta agertar sathe jog kore agertay rakhe. same biyoger jonno SUB, biyog kintu 2s complement form e. AL er sathe 20H(H digit er pore thakle hexadecimal form) jog korle oikhankar charactertar lowercase pawa jaabe ascii code onujayi
    MOV CHAR, AL ;AL er content (lowercase) CHAR er move kore jetar pore question mark dichhili. Variable theke variable e move kora jay na, kono ekta register hoye jaite hobe.

;result ta display kora lagbe. 
;MSG1 er moto MSG2 print korbi. same instruction combination.   
;display on the next line
    LEA DX, MSG2 
    MOV AH, 9
    INT 21H  

; ekta character print korar jonno 50, 51, 52 th line er combination     
;display the lower case character  
    MOV AH, 2 ; 2 ekta function like 9. AL er content agei soraye rakhbi noile change hoye jaite pare interrupt er por
    MOV DL, CHAR ; je character print korbi seta DL e move kor
    INT 21H ; interrup char print kore dibe
    
;nicher line gula ja achhe ta e likhbi
;mone rakhbi ekhane tui ascii form nie kaj kortechhos, input output ja sob character e, number jog biyoger kaj asle tore number er ascii form e transform korte hobe    
;DOX exit, return 0 er moto DOS re control diye dey nicher instruction duita
    MOV AH, 4CH
    INT 21H
  
MAIN ENDP
;MAIN process shesh hoilo ekhane
    END MAIN
	; code shesh hoilo
