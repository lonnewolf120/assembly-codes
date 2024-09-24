.MODEL SMALL
.STACK 100H

INCLUDE dec_in.asm
INCLUDE dec_out.asm
INCLUDE gcd.asm

.DATA                                                              
MSG1 DB 'ENTER M=$'       
MSG2 DB 10,13,'ENTER N=$'
MSG3 DB 10,13,'GCD IS=$'
MSG4 DB 10,13, 'ENTER :$'
A DW ?
B DW ?
M DW ?
N DW ?
GCD_VAL DW ?

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX  

    CALL PRINT_GCD
    
    MOV AH,4CH
    INT 21H

MAIN ENDP
END MAIN
