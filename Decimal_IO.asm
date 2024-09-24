.MODEL SMALL
.DATA
.STACK 100H
.CODE
    
DEC_IN PROC
    XOR BX,BX
    
    MOV AH,01H
    INT 21H
    WHILE:
        CMP AL,0DH
        JE BREAK1
        PUSH AX
        
        MOV AX,10   ; AX = 10
        MUL BX      ; AX = 10 x BX
        MOV BX,AX   ; BX = BX x 10
        
        POP AX
        AND AX,000FH; CONVERSION
        ADD BX,AX
        
        MOV AH,01H
        INT 21H
        JMP WHILE
        
    BREAK1:
    RET

DEC_IN ENDP

DEC_OUT PROC
    MOV CX,0
    MOV BX, 10
    DIVISION:
        
        XOR DX, DX      ; CLEARING DX            
        DIV BX          ; QUOTIENT => AX & REMAINDER => DX                  
        PUSH DX         ; REMAINDER SAVED IN STACK
        INC CX          ; NO. OF DIGITS IN THE NUMBER
        CMP AX,0        
        JE PRINT
    JMP DIVISION 
           
    PRINT:
        POP DX
        ADD DX, 30H
        MOV AH, 02H
        INT 21H
        LOOP PRINT    
       
    RET
    
DEC_OUT ENDP
    
    
MAIN PROC
    CALL DEC_IN     ; INPUT FROM USER STORED IN BX
    
    MOV AH,02H
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    
    MOV AX,BX       ;  OUTPUT TO CONSOLE MUST BE STORED IN AX
    CALL DEC_OUT
    
       
MAIN ENDP
END MAIN