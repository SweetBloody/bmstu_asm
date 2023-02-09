EXTRN input_oct: near
EXTRN number: word
EXTRN convert_to_hex: near
EXTRN convert_to_bin: near

SSEG SEGMENT PARA STACK 'STACK'
	db 200h dup (0)
SSEG ENDS

DSEG SEGMENT PARA PUBLIC 'DATA'
	msg_menu db 'Menu', 10, 13
	         db '1. Input unsigned oct;', 10, 13
	         db '2. Convert to unsigned hex;', 10, 13
	         db '3. Convert to signed bin;', 10, 13
			 db '4. Exit;', 10, 13
	         db '> $'
	arr_menu dw input_oct, convert_to_hex, convert_to_bin, exit; ; Массив указателей на функцию
DSEG ENDS

CSEG SEGMENT PARA PUBLiC 'CODE'
ASSUME CS:CSEG, DS:DSEG, SS: SSEG

print_enter:
	mov ah, 02
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	ret

input_action:
	mov ah, 01 ; Функция считывания символа из консоли с эхом
	int 21h ; Вызов DOS
	mov ah, 0
	sub al, '1'
	mov dl, 02
	mul dl
	mov bx, ax ; Сохраняем результат в bx
	ret
	
exit proc near
	mov ah, 4ch
	int 21h
exit endp

main:
	mov ax, DSEG ; Кладем адрес сегмента данных в ax
	mov ds, ax ; Кладем значение ах в ds

	menu:
		mov ah, 09
		mov dx, offset msg_menu
		int 21h
		
		call input_action ; Вводим желаемое действие
		call print_enter
		call print_enter
		
		
		call arr_menu[bx] ; Вызываем выбранную функцию
		
		call print_enter
		call print_enter
		
		jmp menu ; Обратно к меню
		
CSEG ENDS
END main
		