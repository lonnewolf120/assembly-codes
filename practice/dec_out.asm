.MODEL SMALL

.DATA

DEC_OUT PROC
    MOV CX,0
    MOV BX, 10
    DIVISION:
        XOR DX, DX      
        DIV BX          
        PUSH DX         
        INC CX          
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

END
