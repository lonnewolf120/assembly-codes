# Compare ♾️ char/numbers

```nasm
include 'emu8086.inc'
.stack 100
.model small

.data                  
s1 db 'Enter 1st no: $'      
s2 db 10,13,'Enter 2nd no: $'  
s3 db 10,13,'Enter another no: $'
s4 db 10,13,'Big so far: $'

.code

    main proc  ;PROGRAM TO compare no 1 & no 2
      
      mov ax,@data
      mov ds,ax
    
    ;print s1           
      mov ah,9
      lea dx,s1
      int 21h
    
    ;input 1st number  
      mov ah,01h
      int 21h
      mov bl,al   ;no in BL
    
    ;print s2  
      mov ah,9
      lea dx,s2
      int 21h
      
    ;input 2nd number 
      mov ah,01h
      int 21h
      mov bh,al   ;no in BH  
      
     
    ;compare & store the bigger val in BH, then print 
      biggest:
      cmp bh,bl
      jg l1         ;if bh>bl  -> l1
      jmp l2        ;else -> l2
         
     ;BH bigger         
      l1:
      ;print BH
      mov ah,02h
      mov dl,bh
      int 21h      
      jmp n3
     
     ;BL bigger (store it in BH)                
      l2: 
      mov bh,bl
      ;print BH
      mov ah,02h
      mov dl,bh
      int 21h   
      jmp n3
      
      n3:
      ;print s3
      mov ah,9
      lea dx,s3
      int 21h
      ;take 3rd input
      mov ah,01h
      int 21h
      mov bl,al
      ;print s4
      mov ah,9
      lea dx,s4
      int 21h
      
      
      jmp biggest
           
             
      exit:
      mov ah,4ch
      int 21h
    
    main endp
    
end main
```