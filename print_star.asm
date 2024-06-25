;print ?
;the print 11 stars & in the middle print the taken 3digit input

include 'emu8086.inc'
.model small
.stack 100h
.data                  
    star11 db '***********',10,13,'$'
    star4 db '****','$'

.code
    main proc
         
         mov ax, @data
         mov ds, ax
         
         ;print ?
         mov dl,'?'
         mov ah,02h
         int 21h
         
         ;take input, 3digits -> (bl)(bh)(cl)
         mov ah,01h
         int 21h
         mov bl, al
          
         mov ah,01h
         int 21h
         mov bh, al
          
         mov ah,01h
         int 21h
         mov ch, al
         
         ;print newline
         mov ah,02h
         mov dl,10
         int 21h
         mov dl,13
         int 21h
         
         
         
         mov cl,5
         ;print 11stars 5 times
         print_star:
         mov ah,9
         lea dx,star11
         int 21h
         loop print_star
         
         
        
    main endp
        
end main        

