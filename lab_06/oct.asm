public input_oct
public number

DSEG SEGMENT PARA PUBLIC 'DATA'
	msg_input db 'Input number in oct: $'
	number dw 0 
DSEG ENDS

CSEG SEGMENT PARA PUBLiC 'CODE'
ASSUME CS:CSEG, DS:DSEG
input_oct proc near
	mov ax, DSEG
	mov ds, ax
	
	mov dx, offset msg_input; Кладем начало строки в dx для вывода
	mov ah, 09 ; Функция вывода строки
	int 21h ; Вызов DOS
	
	mov bx, 0
	mov cx, 0
	
	input_symb_num:
		mov ah, 01
		int 21h

		cmp al, 13  ; если энтер - выйти
		je exit

		mov cl, al

		mov ax, 08   ; кладем в ax основание сс
		mul bx      ; переводим в нашу сс
		mov bx, ax

		sub cl, '0' ; делаем цифру
		add bx, cx  ; прибавляем к уже введенной части числа

		jmp input_symb_num
	
	
	exit:
		mov number, bx
		ret
	
input_oct endp
CSEG ENDS
END