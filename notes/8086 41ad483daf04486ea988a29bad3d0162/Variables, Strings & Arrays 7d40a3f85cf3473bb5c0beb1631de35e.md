# Variables, Strings & Arrays

# Variables

<aside>
💡 Syntax for a variable declaration:

`*name*  **DB** *value`         //DB stands for Define Byte*

`*name*  **DW** *value`      //DW stands for Define Word*

</aside>

you can use **DW** instead of **DB** if it's required to keep values larger then 255 or smaller then -128.

**DW cannot be used to declare strings.**

```nasm
.data
msg1 db 3
msg2 db 'I love bangladesh $' ;this dollar sign is mendatory, it represents the end of a string

.code
main proc
	mov ax, @data ;initializing the variables & moving to ax reg
	mov ds, ax    ;storing them to DS(data segment) register
;for small data, the data will be in al reg but for big/16bit data it'll be in ax register
```

# Arrays & String

Arrays can be seen as chains of variables. A text string is an example of a byte array, each character is presented as an ASCII code value (0..255).

Here are some array definition examples:

`a DB 48h, 65h, 6Ch, 6Ch, 6Fh, 00h`

`b DB 'Hello', 0`

*b* is an exact copy of the *a*

array, when compiler sees a string inside quotes it automatically converts it to set of bytes. This chart shows a part of the memory where these arrays are declared:

![https://yassinebridi.github.io/asm-docs/img/array.gif](https://yassinebridi.github.io/asm-docs/img/array.gif)

You can access the value of any element in array using square brackets, for example:

`MOV AL, a[3]`

You can also use any of the memory index registers **BX, SI, DI, BP**, for example:

`MOV SI, 3`

`MOV AL, a[SI]`

If you need to declare a large array you can use **DUP (duplicate)** operator.

The syntax for **DUP** :

`number DUP ( value(s) )`

number - number of duplicate to make (any constant value).

value - expression that DUP will duplicate.

one more example:

`d DB 5 DUP(1, 2)`

is an alternative way of declaring:

`d DB 1, 2, 1, 2, 1, 2, 1, 2, 1, 2`

another:

`c DB 5 DUP(9)`

is an alternative way of declaring:

`c DB 9, 9, 9, 9, 9`

### Printing Strings

```nasm
.model small
.stack 100h
.data
str db 'Hello World! $' ;dont forget the $ at the end of string
;str db 'Hello World!', 0 works similarly
.code
main proc
	mov ax,@data ;this @data segment will be converted for code later
	mov ds,ax    ;initialize the variables by moving them into data segment

	mov ah,9    ;print character string as output
	lea dx,str  ;DX = str, use DX instead of DL cause str needs more space
	int 21h
	
```

# Pointer / Getting address of variable

There is **LEA** (Load Effective Address) instruction and alternative **OFFSET** operator. 

Both **OFFSET** and **LEA** can be used to get the offset address of the variable.

**LEA**

is more powerful because it also allows you to get the address of an indexed variables. Getting the address of the variable can be very useful in some situations, for example when you need to pass parameters to a procedure.

### **Syntax to get pointer access:**

In order to tell the compiler about data type, these prefixes should be used:

**BYTE PTR** - for byte.

**WORD PTR** - for word (two bytes).

For example:
      `BYTE PTR [BX]     ; byte access.`
or,  `WORD PTR [BX]     ; word access.`
assembler supports shorter prefixes as well:

**b.** - for **BYTE PTR**

**w.** - for **WORD PTR**

in certain cases the assembler can calculate the data type automatically.

- Here is first example that uses LEA
    
    ```nasm
    ORG 100h
    MOV    AL, VAR1           ; check value of VAR1 by moving it to AL.
    **LEA    BX, VAR1           ; get address of VAR1 in BX.**
    MOV    BYTE PTR [BX], 44h ; modify the contents of VAR1.
    MOV    AL, VAR1           ; check value of VAR1 by moving it to AL.
    RET
    VAR1   DB  22h
    END
    ```
    
- Here is another example, that uses **OFFSET instead of LEA:**
    
    ```nasm
    ORG 100h
    MOV    AL, VAR1           ; check value of VAR1 by moving it to AL.
    **MOV    BX, OFFSET VAR1**    **; get address of VAR1 in BX.**
    MOV    BYTE PTR [BX], 44h ; modify the contents of VAR1.
    MOV    AL, VAR1           ; check value of VAR1 by moving it to AL.
    RET
    VAR1   DB  22h
    END
    ```
    

  **Both examples above have the same functionality.**

    These lines:

`LEA BX, VAR1`

`MOV BX, OFFSET VAR1`

are even compiled into the same machine code: `MOV BX, num`

*num* is a 16 bit value of the variable offset.

Please note that only these registers can be used inside square brackets (as memory pointers):  **BX, SI, DI, BP**

- **Constants**
    
    the value of the constant cannot be changed throughout the program. 
    And NO memory is allocated for a constant
    
    ```nasm
    name equ value
    ```
    
    now, we can store even strings inside equ:
    
    ```nasm
    s1 equ 'Author: Iftee, Write Date: 12/3/2024 $'
    str db s1   ;to access/print this string, we need to store it in memory
    ```