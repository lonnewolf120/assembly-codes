.MODEL SMALL

.DATA

PRINT_GCD PROC  
    LEA DX,MSG1
    MOV AH,9
    INT 21H
             
    CALL DEC_IN         
    MOV AX, BX
    PUSH AX              
    
    LEA DX,MSG2
    MOV AH,9
    INT 21H

    CALL DEC_IN           
    MOV AX, BX
    PUSH AX               
    
    XOR BX,BX             
    POP BX                
    POP AX
                
    CMP AX,BX             
    JLE SWAP             
    JMP GCD              

SWAP:       
    MOV A,AX
    MOV AX,BX
    MOV BX,A             

GCD:
    XOR DX,DX             
    MOV B,BX              
    DIV B                 
    
    CMP DX,0              
    JE GO                 
    
    MOV AX,BX             
    MOV BX,DX             
    JMP GCD              

GO: 
    LEA DX,MSG3
    MOV AH,9
    INT 21H               
    
    MOV AX, B             
    MOV GCD_VAL, AX
    
    CALL DEC_OUT          
    RET

PRINT_GCD ENDP

END
