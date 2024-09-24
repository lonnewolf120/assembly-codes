
INCLUDE 'emu8086.inc'

; Define the model and stack size
.MODEL SMALL
.STACK 100H

; Define the data segment
.DATA
    ARR DW 10 DUP(0)     ; Array to store up to 10 decimal numbers
    INDEX DW 0           ; Index to track the position in the array

; Define the code segment
.CODE
    MOV AX, @DATA
    MOV DS, AX

; Procedure to read decimal input and store it in the array
DEC_INPUT PROC
    ; Initialize BX to 0
    XOR BX, BX

    ; Loop to read input until Enter key is pressed
    WHILE:
        ; Read a character
        MOV AH, 01H
        INT 21H
        
        ; Check if Enter key is pressed
        CMP AL, 0DH
        JE STORE_AND_EXIT

        ; Convert ASCII to decimal
        SUB AL, '0'
        PUSH AX

        ; Multiply BX by 10
        MOV AX, 10
        MUL BX
        MOV BX, AX

        ; Add the digit to BX
        POP AX
        ADD BX, AX

        ; Loop back to read the next character
        JMP WHILE

    ; Store the number in the array and exit
    STORE_AND_EXIT:       
        LEA SI, ARR
        MOV [SI], BX
        INC SI
        XOR BX, BX
        CMP SI, 10
        JL WHILE

    RET
DEC_INPUT ENDP

; Procedure to print the array
DEC_OUTPUT PROC
    ; Initialize array index
    MOV SI, 0

    ; Loop to print each number in the array
    PRINT_ARRAY:
        ; Load the number from the array
        MOV AX, ARR[SI]
        
        ; Print the number
        CALL PRINT_NUMBER
        
        ; Move to the next array element
        INC SI
        
        ; Check if end of input
        CMP SI, INDEX
        JL PRINT_ARRAY

    RET
DEC_OUTPUT ENDP

; Procedure to print a number
PRINT_NUMBER PROC
    ; Initialize CX and BX
    MOV CX, 0
    MOV BX, 10

    ; Loop to divide the number by 10 and store the remainder
    DIV_LOOP:
        XOR DX, DX
        DIV BX
        PUSH DX
        INC CX
        CMP AX, 0
        JNE DIV_LOOP

    ; Loop to print each digit
    PRINT_DIGITS:
        POP DX
        ADD DL, '0'
        MOV AH, 02H
        INT 21H
        LOOP PRINT_DIGITS

    RET
PRINT_NUMBER ENDP

; Main procedure
MAIN PROC
    ; Call the decimal input procedure
    CALL DEC_INPUT

    ; Print a newline
    MOV DL, 0AH
    MOV AH, 02H
    INT 21H
    MOV DL, 0DH
    MOV AH, 02H
    INT 21H

    ; Call the decimal output procedure
    CALL DEC_OUTPUT

    ; Terminate the program
    MOV AH, 4CH
    INT 21H
MAIN ENDP

END MAIN