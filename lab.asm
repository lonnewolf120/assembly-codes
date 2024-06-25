;include 'emu8086.inc'
.model small
.stack 100h
.data
   str db "Enter character: $"
   var db ?
.code

MAIN PROC   
     ;data init
     mov AX, @data
     mov DS, AX
     
     ; prompt
     mov AH, 09h
     lea DX, str
     int 21h
     
     ;take input
     mov AH, 01h
     int 21h
     
     ;store value
     mov var, AL
     sub var, 20h
     
     ;newline       
     mov AH, 02h
     mov DL, 0Dh
     int 21h
     mov DL, 0Ah
     int 21h
     
     ;print
     mov DL, var 
     mov AH, 02h
     int 21h   
     
     
MAIN ENDP

END MAIN