include 'emu8086.inc'
.stack 100
.model small

.data                  
s1 db 'Enter 1st no: $'      
s2 db 10,13,'Enter 2nd no: $'
s3 db 10,13,'Result: $'

.code

    main proc  ;PROGRAM TO compare no 1 & no 2
      
      mov ax,@data
      mov ds,ax
    
    ;1st number           
      mov ah,9
      lea dx,s1
      int 21h
      
      mov ah,01h
      int 21h
      mov bl,al   ;no in BL
    
    ;2nd number  
      mov ah,9
      lea dx,s2
      int 21h
      
      mov ah,01h
      int 21h
      mov bh,al   ;no in BH  
      
     ;result text    
      mov ah,9
      lea dx,s3
      int 21h 
     
     ;compare function 
      biggest:
      cmp bh,bl
      jg l1     ;if bh>bl  -> l1
      jmp l2    ;else -> l2
         
              
      l1:
      mov ah,02h
      mov dl,bh 
      ;sub dl,48
      int 21h      
      jmp exit
      
      
      l2:
      mov ah,02h
      mov dl,bl 
      ;sub dl,48
      int 21h
      jmp exit
             
             
      exit:
      mov ah,4ch
      int 21h
    
                
        
    main endp
        
        
    
end main