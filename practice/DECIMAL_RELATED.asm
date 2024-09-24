
; TAKE DECIMAL INPUT FROM USER AND PRINT THE GCD, PRINT SUBSEQUENT LINES FOR BETTER UNDERSTANDING

; 



.MODEL SMALL
.STACK 100H
.DATA                                                              
MSG1 DB 'ENTER M=$'       ; MESSAGE TO PROMPT M
MSG2 DB 10,13,'ENTER N=$' ; MESSAGE TO PROMPT N    

MSG4 DB 10,13, 'ENTER :$'
MSG3 DB 10,13,'GCD IS=$'  ; MESSAGE TO DISPLAY GCD
A DW ?                    ; VARIABLE TO TEMPORARILY STORE VALUE
B DW ?                    ; VARIABLE TO STORE DIVISOR

C DW ?
D DW ?    


F DW ?

M DW ?
N DW ?       
           
GCD_VAL DW ?
LCM_VAL DW ?           
        
ARR DW 10 DUP(?)     
SUM DW ?
SUM2 DW ?

    
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
        POP DX          ; EVERYTIME IT POPS THE VALUE OF STACK IN DX
        ADD DX, 30H
       
        MOV AH, 02H     ; PRINT DX
        INT 21H
        LOOP PRINT      ; CONTINUE LOOP TILL COUNT
       
    RET
                       
                       
                       
DEC_OUT ENDP  
               
               

DIGIT_SUM PROC
    MOV CX,0
    MOV BX, 10
    DIVISION1:
        
        XOR DX, DX      ; CLEARING DX            
        DIV BX          ; QUOTIENT => AX & REMAINDER => DX                  
        PUSH DX         ; REMAINDER SAVED IN STACK
        INC CX          ; NO. OF DIGITS IN THE NUMBER
        CMP AX,0        
        JE PRINT
    JMP DIVISION1 
           
    PRINT1:
        POP DX          ; EVERYTIME IT POPS THE VALUE OF STACK IN DX
        ADD DX, 30H
        
        ADD SUM2, DX
        
        MOV AH, 02H     ; PRINT DX
        INT 21H
        LOOP PRINT1      ; CONTINUE LOOP TILL COUNT
       
    RET
                       
                       
                       
DIGIT_SUM ENDP  
             
               
               


PRINT_SUM PROC  
    LEA DX,MSG4           ; LOAD ADDRESS OF MSG1 INTO DX
    MOV AH,9              ; DOS FUNCTION TO DISPLAY STRING
    INT 21H               ; CALL DOS INTERRUPT
            
    
    MOV CX, 5
    
    LEA SI, ARR
    
    MOV AH, 01H
    INT 21H
    
    INPUT_ARR:
       
        CALL DEC_IN  
        
        ADD SUM, BX
        
        MOV [SI], BX
        INC SI
        
        LOOP INPUT_ARR   
        
        
    LEA SI, ARR
    
    PRINT_ARR:
        
        MOV AX, [SI]
        INC SI
        
        CALL DEC_OUT
        
        
        
    
    PRINT_S:
        MOV AX, SUM
        CALL DEC_OUT
        
    
    
     RET

PRINT_SUM ENDP   

NEWLINE PROC
   
    MOV AH, 02H
    MOV DX, 0DH
    INT 21H
    MOV DX, 0AH
    INT 21H
    RET 
    
    
    
NEWLINE ENDP    

          
          
FRACTION PROC
    
    
    LEA DX,MSG1           ; LOAD ADDRESS OF MSG1 INTO DX
    MOV AH,9              ; DOS FUNCTION TO DISPLAY STRING
    INT 21H               ; CALL DOS INTERRUPT
             
             
             
    CALL DEC_IN           ; INPUT M      
    
    MOV AX, BX                         
    
    MOV M, AX
    
    PUSH AX               ; SAVE M ON STACK   
    
    

    LEA DX,MSG2           ; LOAD ADDRESS OF MSG2 INTO DX
    MOV AH,9              ; DOS FUNCTION TO DISPLAY STRING
    INT 21H               ; CALL DOS INTERRUPT
                                            
                                            
                                            
                                            
    CALL DEC_IN           ; INPUT N
    
    MOV AX, BX                        
    
    MOV N, AX
    
    PUSH AX               ; SAVE N ON STACK
                                            
                                            
                                            
    XOR BX,BX             ; CLEAR BX     
    
    POP BX                ; POP N INTO BX    BX = N
    
    POP AX                ; POP M INTO AX    AX = M            
    
    
    DIV BX
    
    MOV C, AX   ; QUOTIENT
    MOV D, DX   ; REMAINDER
                          
    CALL NEWLINE                      
                          
    MOV AX, C
    
    CALL DEC_OUT     
    
    XOR DX, DX
    
    MOV DX,2EH 
    
    MOV AH, 02H
    INT 21H
    
    MOV AX, D
    
    CALL DEC_OUT
    
    
     RET
    
FRACTION ENDP    
                   
                   
                   
PRINT_GCD PROC  
    
      
    LEA DX,MSG1           ; LOAD ADDRESS OF MSG1 INTO DX
    MOV AH,9              ; DOS FUNCTION TO DISPLAY STRING
    INT 21H               ; CALL DOS INTERRUPT
             
             
             
    CALL DEC_IN           ; INPUT M      
    
    MOV AX, BX
    
    PUSH AX               ; SAVE M ON STACK   
    
    

    LEA DX,MSG2           ; LOAD ADDRESS OF MSG2 INTO DX
    MOV AH,9              ; DOS FUNCTION TO DISPLAY STRING
    INT 21H               ; CALL DOS INTERRUPT
                                            
                                            
                                            
                                            
    CALL DEC_IN           ; INPUT N
    
    MOV AX, BX
    
    PUSH AX               ; SAVE N ON STACK
                                            
                                            
                                            
    XOR BX,BX             ; CLEAR BX     
    
    POP BX                ; POP N INTO BX    BX = N   
    
    POP AX                ; POP M INTO AX    AX = M
         
          
    CMP AX,BX             ; COMPARE M AND N     
    
    JLE SWAP               ; IF M < N, SWAP THEM  
    
    JMP GCD               ; OTHERWISE, START GCD CALCULATION

SWAP:       
    ; SWAP BETWEEN M AND N

    MOV A,AX              ; STORE AX IN A
    MOV AX,BX             ; MOVE BX TO AX
    MOV BX,A              ; MOVE A (ORIGINAL AX) TO BX

GCD:
    XOR DX,DX             ; CLEAR DX FOR REMAINDER
    
    MOV B,BX              ; STORE DIVISOR IN B
    
    DIV B                 ; DIVIDE AX BY BX  
    
    ; AX = AX / B , DX = REMAINDER
    

    CMP DX,0              ; CHECK IF REMAINDER IS ZERO 
    
    JE GO                 ; IF ZERO, GCD FOUND              
    
    MOV AX,BX             ; REPLACE DIVIDEND WITH DIVISOR  
    
    MOV BX,DX             ; REPLACE DIVISOR WITH REMAINDER 
    
    JMP GCD               ; REPEAT GCD CALCULATION


GO: 

    LEA DX,MSG3           ; LOAD ADDRESS OF MSG3 INTO DX
    MOV AH,9              ; DOS FUNCTION TO DISPLAY STRING
    INT 21H               ; CALL DOS INTERRUPT               
    
    
    MOV AX, B             ; MOVE GCD INTO AX    
    
    MOV GCD_VAL, AX
    
    CALL DEC_OUT          ; PRINT GCD      
    


LCM:
    
    XOR DX, DX
    
    ; LCM = (M*N)/GCD
    
    MOV AX, M
    MOV BX, N
    MUL BX
    
    MOV AX, BX ; TEMPORARILY STORE AX IN CX, BX = M*N
    
    MOV DX, GCD_VAL
    
    DIV DX   ; AX = AX/ DX = (M*N)/GCD_VAL
    
    CALL DEC_OUT
    
    


FINISH:
    RET

    
PRINT_GCD ENDP                       


    
  


MAIN PROC
    MOV AX,@DATA          ; INITIALIZE DATA SEGMENT
    MOV DS,AX  
   
    
    

MAIN ENDP   

    CALL PRINT_GCD
    
    
    
    MOV AH,4CH            ; DOS FUNCTION TO TERMINATE PROGRAM
    INT 21H               ; CALL DOS INTERRUPT   
    


END MAIN