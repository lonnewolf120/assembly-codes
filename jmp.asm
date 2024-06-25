include 'emu8086.inc'
.stack 100
.model small

.data                  
s1 db 'Enter 1st int: $'
s2 db 'Enter 2nd int: $'
s3 db 'The addition: $'
.code

    main proc  ;PROGRAM TO ADD 2digit numbers
    
    ;load vars
       mov ax,@data
       mov ds,ax
       
    ;print s1   
       mov ah,9
       lea dx,s1
       int 21h
    
    ;take inp 1       
       mov ah, 01h
       int 21h
       mov bh,ah
       
       mov ah, 01h
       int 21h
       mov bl,ah
       
    ;carriage & newline   
        mov ah,2
        mov dl,10    ;for new line
        int 21h                 
        mov dl,13    ;for carriage return
        int 21h    
    
    ;print s2   
       mov ah,9
       lea dx,s2
       int 21h
    
    ;take inp 2       
       mov ah, 01h
       int 21h
       mov ch,ah
       
       mov ah, 01h
       int 21h
       mov cl,ah 
       
    ;carriage & newline   
        mov ah,2
        mov dl,10    ;for new line
        int 21h                 
        mov dl,13    ;for carriage return
        int 21h
          
    ;print s3
        mov ah,9
        lea dx,s3 
        int 21h
        
        add cl,bl
        mov dl,cl
        sub dl,48
        mov ah,02h
        int 21h
        add ch,bh
        mov dh,ch
        sub dh,48
        mov ah,02h
        int 21h
        
    main endp
        
        
    
end main                                              


