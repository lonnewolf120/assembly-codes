include 'emu8086.inc'
.stack 100
.model small

.data


.code

    main proc  ;PROGRAM TO PRINT from char 1 till char 2
           
           
        print 'Enter 1st char: '  ;this uses the same steps as below for printing
        
        mov ah, 01h  ;Input saved to AL
        int 21h      ;default interrupt
        
        mov bl, al   ;temporarily store 1st char in BL

        
    ;carriage & newline   
        mov ah,2
        mov dl,10    ;for new line
        int 21h                 
        mov dl,13    ;for carriage return
        int 21h 
                
                        
        print 'Enter 2nd: '              
        mov ah,01h    
        int 21h 
        mov bh,al  ;store 2nd char in BH 
        
        sub bh,bl  ;2nd char - 1st char = loop amount
        inc bh     ;increment, as we gotta to 2nd char
       
        
    ;carriage & newline   
        mov ah,2
        mov dl,10    ;for new line
        int 21h                 
        mov dl,13    ;for carriage return
        int 21h 
        
    ;loop func:
        mov cl,bh  ;cl is count reg, store amount of looping in it
        mov dl,bl  ;store 1st char in DL, as we'll display & increment it from there
        mov ah,2   ;start output
        
        level1:
        int 21h
        inc dl      ;increment dl (the characters)
        loop level1 ;loop cl times
        
        
                
        
    main endp
        
        
    
end main