include 'emu8086.inc'
.stack 100
.model small

.data
var dd ?  
var1 dd 1
inp db ?                
s1 db 'Enter 1st int: $'
s2 db '*$'
s3 db 'The addition: $'
.code

    main proc  
        
    ;load vars
       mov ax,@data
       mov ds,ax
    
    ;print s1
    
    mov ah,09h
    lea dx, s1
    int 21h
    
    ;take input
    mov ah, 01h
    int 21h 
    sub al, '0'   ; Convert ASCII to integer
    mov inp, al
    mov cl, inp
    mov ch, 0   
             
               
    ;carriage & newline 
    CALL CN
       
  l1: 
  
  
     
     mov var, cx 
     mov cx, var1
     l2:         
     
     ;print star
     mov ah,09h
     lea dx, s2
     int 21h
     
     loop l2 
     
     mov cx, var
     inc var1
     
               
    ;carriage & newline   
     CALL CN  
  
  
  loop l1
               
               
               
  CN: 
   ;carriage & newline   
        mov ah,2
        mov dl,10    ;for new line
        int 21h                 
        mov dl,13    ;for carriage return
        int 21h      
        ret           
       
       
       
    main endp
        
        
    
end main                                              


