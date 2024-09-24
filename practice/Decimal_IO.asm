INCLUDE 'emu8086.inc'
.MODEL SMALL
.STACK 100H
.DATA      

ARR DW ?

.CODE      
    MOV AX,@DATA
    MOV DS, AX

DEC_INPUT PROC     ; BX WILL HOLD OUTPUT VALUE
    
    XOR BX,BX 
    
    WHILE:   
        MOV AH,01H
        INT 21H
        CMP AL, 0DH
        JE BREAK
        
        PUSH AX
        
        MOV AX,10
        MUL BX
        MOV BX, AX
        
        POP AX  
        
        AND AX, 000FH ; FOR TAKING ONLY TILL 16
        ADD BX, AX
        
        JMP WHILE
        
    
    BREAK:
       RET
    

DEC_INPUT ENDP        


DEC_OUTPUT PROC
                 
    MOV CX, 0 
    MOV BX, 10
                
    ; KEEP DIVIDING AX BY 10, AND PUSH THE REMAINDER IN STACK            
    DIVISION: 
                                                
        XOR DX, DX 
        DIV BX ; AX /= BX, DX %= BX
        PUSH DX
        INC CX  ; TO STORE THE NUMBER OF DIGITS
        CMP AX,0 ; IF AX = 0, JUST PRINT
        JE PRINT 
        
     JMP DIVISION  
       
        
    ; PRINT THE ELEMENTS OF THE STACK    
    PRINT:                          
        POP DX    
        ADD DX, 30H  ; CONVERSION
        MOV AH,02H
        INT 21H
        
        LOOP PRINT
               
 
    RET    
    
    
DEC_OUTPUT ENDP


MAIN PROC
    
    CALL DEC_INPUT   
    
    MOV DL, 10
    MOV AH, 02H
    INT 21H
    MOV DL, 13
    MOV AH, 02H
    INT 21H
    
    MOV DATA,BX       ;  OUTPUT TO CONSOLE MUST BE STORED IN AX

    CALL DEC_OUTPUT
    
    
MAIN ENDP

END MAIN