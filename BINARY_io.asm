INCLUDE 'emu8086.inc'
.MODEL SMALL
.DATA
.STACK 100H
.CODE

BIN_INPUT PROC     ; BX WILL HOLD OUTPUT VALUE
    
    XOR BX,BX
    
    INPUT:
        MOV AH, 01H
        INT 21H
        
        CMP AL, 0DH
        JE BREAK
        
        
        SHL BX, 1  
        SUB AL, 48
        OR BL, AL
        
        
        JMP INPUT
    
    BREAK:
       RET
    

BIN_INPUT ENDP        


BIN_OUTPUT PROC
              

    AND BX, 000FH
    XOR CH, CH
    MOV CL, 4
    
    
    L1:
        RCL BX, 1
        JC OUTPUT_ONE
        
        MOV DL, 0H
        MOV AH,02H
        INT 21H
        JMP BREAK1
        
        OUTPUT_ONE:
          
        MOV DL, 1H
        MOV AH,02H
        INT 21H
        
        
    BREAK1:     
    
        LOOP L1 
    
    
    
BIN_OUTPUT ENDP


MAIN PROC
    
    CALL BIN_INPUT   
    
    MOV DL, 10
    MOV AH, 02H
    INT 21H
    MOV DL, 13
    MOV AH, 02H
    INT 21H

    CALL BIN_OUTPUT
    
    
MAIN ENDP

END MAIN