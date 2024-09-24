.MODEL SMALL

.DATA

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
        ADD BX,AX   ; BX = DECIMAL INPUT
        
        MOV AH,01H
        INT 21H
        JMP WHILE
        
    BREAK1:    
    RET

DEC_IN ENDP

END
