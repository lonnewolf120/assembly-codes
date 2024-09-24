.model small
.stack 100h
.data
msg1 db 'Enter a binary number:$'
msg2 db 10,13,'Random numbers are:$'
msg3 db 10,13,'illegal entry: try again:$'
va dw ?
vb dw ?
vc dw ?
.code


INDEC PROC
    PUSH BX               ; SAVE BX REGISTER
    PUSH CX               ; SAVE CX REGISTER
    PUSH DX               ; SAVE DX REGISTER

START:
    MOV AH,2              ; DOS FUNCTION TO OUTPUT CHARACTER
    MOV DL,0DH            ; CARRIAGE RETURN
    INT 21H               ; CALL DOS INTERRUPT
    MOV DL,0AH            ; NEW LINE
    INT 21H

    MOV AH,2              ; DOS FUNCTION TO OUTPUT CHARACTER
    MOV DL,'?'            ; PRINT '?' TO PROMPT USER
    INT 21H

    XOR BX,BX             ; BX IS FOR TOTAL, INITIALIZE TO 0
    XOR CX,CX             ; CX IS FOR DETECTING SIGN, INITIALIZE TO 0
    MOV AH,1              ; DOS FUNCTION TO READ CHARACTER
    INT 21H               ; CALL DOS INTERRUPT
    CMP AL,'-'            ; CHECK IF CHARACTER IS MINUS SIGN
    JE MIN                ; JUMP IF MINUS SIGN
    CMP AL,'+'            ; CHECK IF CHARACTER IS PLUS SIGN
    JE PL                 ; JUMP IF PLUS SIGN
    JMP CONVERT           ; ELSE, CONVERT TO DECIMAL

MIN:
    MOV CX,1              ; SET NEGATIVE FLAG
    JMP PL                ; JUMP TO PL

PL:
    INT 21H               ; READ NEXT CHARACTER

CONVERT:
    CMP AL,'0'            ; CHECK IF CHARACTER IS LESS THAN '0'
    JL ILLEGAL            ; JUMP IF ILLEGAL CHARACTER
    CMP AL,'9'            ; CHECK IF CHARACTER IS GREATER THAN '9'
    JG ILLEGAL            ; JUMP IF ILLEGAL CHARACTER

    AND AX,000FH          ; CONVERT ASCII CHARACTER TO DECIMAL
    PUSH AX               ; SAVE DECIMAL VALUE ON STACK

    MOV AX,10             ; SET VALUE 10 FOR MULTIPLICATION
    IMUL BX               ; MULTIPLY TOTAL BY 10 (AX = TOTAL * 10)

    JO OF1                ; JUMP IF OVERFLOW OCCURS

    POP BX                ; POP CONVERTED DECIMAL DIGIT FROM STACK
    ADD BX,AX             ; TOTAL = TOTAL * 10 + DECIMAL DIGIT
    JO OF2                ; JUMP IF OVERFLOW OCCURS
    MOV AH,1              ; DOS FUNCTION TO READ CHARACTER
    INT 21H               ; CALL DOS INTERRUPT
    CMP AL,0DH            ; CHECK IF ENTER KEY (CARRIAGE RETURN) IS PRESSED
    JE CR                 ; JUMP IF ENTER KEY IS PRESSED
    JMP CONVERT           ; CONTINUE CONVERSION

CR:
    MOV AX,BX             ; MOVE DECIMAL NUMBER TO AX
    OR CX,CX              ; CHECK NEGATIVE SIGN FLAG
    JE EXIT               ; JUMP IF NOT NEGATIVE
    NEG AX                ; NEGATE AX IF NEGATIVE

EXIT:
    POP DX                ; RESTORE DX REGISTER
    POP CX                ; RESTORE CX REGISTER
    POP BX                ; RESTORE BX REGISTER
    RET                   ; RETURN FROM PROCEDURE

OF1:
    POP BX                ; POP STACK TO CLEAN UP
    MOV AH,9              ; DOS FUNCTION TO DISPLAY STRING
    LEA DX,MSG1           ; LOAD ADDRESS OF ERROR MESSAGE
    INT 21H               ; CALL DOS INTERRUPT
    JMP START             ; RESTART INPUT

OF2:
    MOV AH,9              ; DOS FUNCTION TO DISPLAY STRING
    LEA DX,MSG1           ; LOAD ADDRESS OF ERROR MESSAGE
    INT 21H               ; CALL DOS INTERRUPT
    JMP START             ; RESTART INPUT

ILLEGAL:
    MOV AH,2              ; DOS FUNCTION TO OUTPUT CHARACTER
    MOV DL,0AH            ; NEW LINE
    INT 21H               ; CALL DOS INTERRUPT
    JMP START             ; RESTART INPUT

INDEC ENDP                                      

OUTDEC PROC

    PUSH AX              ; SAVE AX REGISTER
    PUSH BX              ; SAVE BX REGISTER
    PUSH CX              ; SAVE CX REGISTER
    PUSH DX              ; SAVE DX REGISTER

    OR AX,AX             ; CHECK IF AX IS NEGATIVE
    JGE VALID            ; IF AX >= 0, JUMP TO VALID

    PUSH AX              ; SAVE AX ON STACK
    MOV DL,'-'           ; LOAD '-' FOR NEGATIVE SIGN
    MOV AH,2             ; DOS FUNCTION TO OUTPUT CHARACTER
    INT 21H              ; CALL DOS INTERRUPT

    POP AX               ; RESTORE AX
    NEG AX               ; MAKE AX POSITIVE

VALID:

    XOR CX,CX            ; CLEAR CX (DIGIT COUNT)
    MOV BX,10D           ; BX IS DIVISOR, SET TO 10

DIVIDE:

    XOR DX,DX            ; CLEAR DX (REMAINDER)

    DIV BX               ; DIVIDE AX BY BX, AX = QUOTIENT, DX = REMAINDER

    PUSH DX              ; SAVE REMAINDER ON STACK

    INC CX               ; INCREMENT DIGIT COUNT
    OR AX,AX             ; CHECK IF AX IS ZERO
    JNE DIVIDE           ; IF NOT ZERO, CONTINUE DIVISION

    MOV AH,2             ; DOS FUNCTION TO OUTPUT CHARACTER

PRINT:

    POP DX               ; POP DIGIT FROM STACK
    OR DL,30H            ; CONVERT TO ASCII
    INT 21H              ; CALL DOS INTERRUPT TO PRINT DIGIT

    LOOP PRINT           ; LOOP THROUGH ALL DIGITS

    POP DX               ; RESTORE DX REGISTER
    POP CX               ; RESTORE CX REGISTER
    POP BX               ; RESTORE BX REGISTER
    POP AX               ; RESTORE AX REGISTER
    RET                  ; RETURN FROM PROCEDURE

OUTDEC ENDP                        

main proc
    
main endp

end main