public convert_to_hex
EXTRN number: word

DSEG SEGMENT PARA PUBLIC 'DATA'
	msg_out db 'Number in hex: $'
DSEG ENDS

CSEG SEGMENT PARA PUBLiC 'CODE'
ASSUME CS:CSEG, DS:DSEG
convert_to_hex proc near
	mov ax, DSEG
	mov ds, ax
	
	mov dx, offset msg_out; Кладем начало строки в dx для вывода
	mov ah, 09 ; Функция вывода строки
	int 21h ; Вызов DOS
	
	mov dx, number
    mov di, dx
    mov cl, 4
    mov si, 4
    loop1:
        dec si
        mov dx, di
        mov bx, 0
        mov bl, dh
        shl bx, cl
        shl dx, cl
        mov di, dx
        mov dl, bh
        cmp dl, 9
        jna less_than_10
        jmp more_than_A
        output:
            mov ah, 2
            int 21h
            cmp si, 0
            jne loop1
            ret
    less_than_10:
        add dl, '0'
        jmp output
    more_than_A:
        sub dl, 10
        add dl, 'A'
        jmp output
	ret
convert_to_hex endp
CSEG ENDS
END