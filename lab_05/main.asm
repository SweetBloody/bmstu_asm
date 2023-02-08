SSEG SEGMENT PARA STACK 'STACK'
	db 200h dup (0)
SSEG ENDS

DSEG SEGMENT PARA PUBLIC 'DATA'
	matrix db 81 dup('0') ; Инициализируем матрицу 9х9 нулями
	n db 0h ; Количество строк
	m db 0h ; Количество столбцов
	min db 9h ; Минимальный элемент
	max db 0h ; Максимальный элемент
	min_i db 0 ; Индекс строки с минимальным элементом
	max_i db 0 ; Индекс строки с максимальным элементом
	msg_n db 'Input n: $'
	msg_m db 'Input m: $'
	msg_matr_in db 'Input matrix:', 13, 10, '$'
	msg_matr_out db 'Changed matrix:', 13, 10, '$'
	msg_ent db 13, 10, '$'
DSEG ENDS

CSEG SEGMENT PARA 'CODE'
ASSUME CS:CSEG, DS:DSEG
	
input_digit:
	mov ah, 01 ; Функция считывания символа из консоли с эхом
	int 21h ; Вызов DOS
	ret
	
print_msg_n:
	mov dx, offset msg_n
	mov ah, 09 ; Функция вывода строки в консоль
	int 21h ; Вызов DOS
	ret
	
print_msg_m:
	mov dx, offset msg_m
	mov ah, 09 ; Функция вывода строки в консоль
	int 21h ; Вызов DOS
	ret
	
print_msg_matr_in:
	mov dx, offset msg_matr_in
	mov ah, 09 ; Функция вывода строки в консоль
	int 21h ; Вызов DOS
	ret
	
print_msg_matr_out:
	mov dx, offset msg_matr_out
	mov ah, 09 ; Функция вывода строки в консоль
	int 21h ; Вызов DOS
	ret

print_msg_ent:
	mov dx, offset msg_ent
	mov ah, 09 ; Функция вывода строки в консоль
	int 21h ; Вызов DOS
	ret
	
input_matr_size:
	call print_msg_n
	mov ah, 01 ; Функция считывания символа из консоли с эхом
	int 21h ; Вызов DOS
	sub al, 30h
	mov n, al ; Кладем в n введенное значение
	call print_msg_ent
	call print_msg_m
	mov ah, 01 ; Функция считывания символа из консоли с эхом
	int 21h ; Вызов DOS
	sub al, 30h
	mov m, al ; Кладем в m введенное значение
	call print_msg_ent
	ret
	
input_matr:
	call print_msg_matr_in
	mov cx, 0
	mov cl, n ; Счетчик цикла по строкам
	mov si, 0 ; Индекс элемента матрицы
	loop1:
		mov ah, 01 ; Функция считывания символа из консоли с эхом
		push cx ; Сохраняем значение счетчика цикла перед входом во вложенный цикл
		mov cl, m
		loop2:
			int 21h ; Вызов DOS
			sub al, 30h
			mov matrix[si], al ; Кладем считанное значение в матрицу
			inc si ; Увеличиваем смещение
			loop loop2
		call print_msg_ent
		pop cx ; Возвращаем значение счетчика внешнего цикла
		loop loop1
	ret
	
print_matr:
	call print_msg_matr_out
	mov cx, 0
	mov cl, n ; Счетчик цикла по строкам
	mov si, 0 ; Индекс элемента матрицы
	loop3:
		mov ah, 02
		push cx ; Сохраняем значение счетчика цикла перед входом во вложенный цикл
		mov cl, m ; Счетчик цикла по столбцам
		loop4:
			mov dl, matrix[si]
			add dl, 30h
			int 21h ; Вызов DOS
			inc si ; Увеличиваем смещение
			loop loop4
		call print_msg_ent
		pop cx ; Возвращаем значение счетчика внешнего цикла
		loop loop3
	ret

find_min_max:
	mov cx, 0
	mov cl, n ; Счетчик цикла по строкам
	mov al, 0 ; Индекс строки
	mov si, 0 ; Индекс элемента матрицы
	loop5:
		push cx ; Сохраняем значение счетчика цикла перед входом во вложенный цикл
		mov cl, m ; Счетчик цикла по столбцам
		loop6:
			mov bh, matrix[si]
			cmp bh, [min] ; Сравниваем очередной элемент с минимумом
			ja else1 ; Если очередной больше минимума
			mov [min], bh ; Если очередной меньше или равен минимуму
			mov [min_i], al
			else1:
			cmp bh, [max] ; Сравниваем очередной элемент с максимумом
			jb else2 ; Если очередной меньше максимума
			mov [max], bh ; Если очередной больше или равен максимуму
			mov [max_i], al
			else2:
			inc si ; Увеличиваем смещение
			loop loop6
		pop cx ; Возвращаем значение счетчика внешнего цикла
		inc al ; Увеличиваем значение индекса строки
		loop loop5
	ret
		
change_strings:
	mov cx, 0
	mov cl, m ; Счетчик цикла
	
	mov al, min_i ; Кладем индекс строки с мин элементом в al для перемножения
	mul m ; Умножаем на количество столбцов
	mov si, ax ; Индекс первого элемента из строки с минимумом
	
	mov al, max_i ; Кладем индекс строки с макс элементом в al для перемножения
	mul m ; Умножаем на количество столбцов
	mov di, ax ; Индекс первого элемента из строки с максимумом
	loop7:
		mov dl, matrix[si] ;  Меняем
		xchg dl, matrix[di] ; местами
		mov matrix[si], dl ;  элементы
		inc si ; Увеличиваем значение индекса элемента строки
		inc di ; Увеличиваем значение индекса элемента строки
		loop loop7
	ret
	
main:
	mov ax, DSEG ; Кладем адрес сегмента данных в ax
	mov ds, ax ; Кладем значение ах в ds
	
	call input_matr_size ; Ввод размера матрицы
	call input_matr ; Ввод матрицы
	call find_min_max ; Определение индекса строк с максимальным и минимальным элементом
	call change_strings ; переставить местами строки с наибольшим и наименьшим элементами
	call print_matr ; Вывод матрицы
	
	mov ah, 4ch ; Функция завершения процесса
	int 21h ; Вызов DOS
	

CSEG ENDS
END main
