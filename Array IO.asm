.MODEL SMALL
.DATA
ARR1 DB 100 DUP(?)   
ARR2 DB 1,2,3,4,5
SUM DB 0
.STACK 100H
.CODE

NEWLINE PROC
    MOV AH,02H
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    RET
    
NEWLINE ENDP

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    
    ;input
    LEA SI,ARR1
    MOV CX,0
    
    MOV AH,01H
    INT 21H
    START:
        CMP AL,0DH
        JE BREAK
        
        AND AL,0FH
        MOV [SI],AL     ;A[i] = USER INPUT
        INC SI 
        
        INC CX
        
        MOV AH,01H
        INT 21H
        JMP START
         
    BREAK:
    CALL NEWLINE
    ;output
    DEC SI
                            
    
    L1:
        MOV AH,02H
        MOV DL,[SI]
        OR DL,30H
        INT 21H
        DEC SI
        LOOP L1
    
    
MAIN ENDP
END MAIN