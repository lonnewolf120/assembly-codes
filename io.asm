include 'emu8086.inc'
.stack 100
.model small

.data




.code



    main proc
        
        print 'Enter character to loop from: '  ;this uses the same steps as below for printing
        
        mov ah, 01h  ;Input saved to AL
        int 21h      ;default interrupt
        
        mov bl, al   ;temporarily store AL data in BL

        
       ;carriage & newline   
        mov ah,2
        mov dl,10    ;for new line
        int 21h                 
        mov dl,13    ;for carriage return
        int 21h 
                
                        
        print 'Enter character to loop till (bigger than prev inp): '              
        
        mov dl,bl    ;we'll store the char from which we'll print in dl
        
        mov ah,01h    
        int 21h
        mov bl,al
        sub bl,dl    ;bcoz we'll loop from char 1 to 2    
        
        ;loop func:
        mov cx,bx
        mov ah,2
        
        level1:
        int 21h
        inc dl
        loop level1
        
        ;carriage & newline   
        mov ah,2
        mov dl,10    ;for new line
        int 21h                 
        mov dl,13    ;for carriage return
        int 21h 
                
        
    main endp
        
        
    
end main