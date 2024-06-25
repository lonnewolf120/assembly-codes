.model small
.stack 100h
.data
str db 'Hello World! $' ;dont forget the $ at the end of string
.code
main proc
	mov ax,@data ;this @data segment will be converted for code later
	mov ds,ax    ;initialize the variables by moving them into data segment

	mov ah,9  ;print character string as output
	lea dx,str  ;DX = str
	int 21h
	
	mov ah, 02h
	mov dl, 07
	int 21h  