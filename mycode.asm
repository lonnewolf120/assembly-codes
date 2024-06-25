include 'emu8086.inc'
.stack 100
.model small

.data




.code



    main proc
        
        print 'Enter 1st character: '  ;this uses the same steps as below for printing
        
        mov ah, 01h  ;Input saved to AL
        int 21h      ;default interrupt
        
        sub al, 48   ;convert ascii code to number
        mov bl, al   ;temporarily store AL data in BL

        
        mov dl,10    ;for new line
        mov ah,02h   ;02h is used to print data
        int 21h 
                              
        mov dl,13    ;for carriage return
        mov ah,02h   ;02h is used to print data
        int 21h 
                        
        print 'Enter 2nd character: '  
        
        mov ah, 01h  ;Input saved to AL
        int 21h      ;default interrupt
        
        sub al, 48   ;convert ascii code to number
        mov cl, al   ;temporarily store AL data in CL

        
        mov dl,10    ;for new line
        mov ah,02h   ;02h is used to print data
        int 21h 
                              
        mov dl,13    ;for carriage return
        mov ah,02h   ;02h is used to print data
        int 21h 
        
        print 'The addition: '
        add cl, bl
        add cl,48    ;converting num to ascii code
        mov dl, cl
        mov ah, 02h
        int 21h
        
    main endp
        
        
    
end main