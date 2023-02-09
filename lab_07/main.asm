.MODEL TINY

CODESEG SEGMENT
    ASSUME  cs:CODESEG, ds:CODESEG
    ORG     100h
main:
    jmp         init
    sys_handler DD  0
    speed       DB  0
    cur_sec     DB  0

handler proc
    push ax ; Сохраняем
    push cx ; значения
    push dx ; регистров

    mov ah, 02h
    int 1Ah

    cmp dh, cur_sec
    je to_pop

    mov cur_sec, dh
    dec speed

    cmp speed, 01Fh
    jbe set

    mov speed, 01Fh

set:
    mov al, 0F3h
    out 60h, al
    mov al, speed
    out 60h, al

to_pop:
    pop dx ; Восстанавливаем
    pop cx ; значения
    pop ax ; регистров
    jmp cs:sys_handler
handler endp

init:
    mov ah, 35h ; Дать вектор прерывания
	mov al, 09h ; Номер прерывания
    int 21h ; В ES:BX помещается адрес обработчика прерывания
	 ; загружает в BX 0000:[AL*4], а в ES - 0000:[(AL*4)+2]

    mov word ptr sys_handler, bx ; Сохранение смещения системного обработчика
    mov word ptr sys_handler + 2, es ; Сохранение сегмента системного обработчика

    mov ah, 25h ; Установить вектор прерывания
	mov al, 09h ; Номер прерывания
    mov dx, OFFSET handler ;  вектор прерывания: адрес программы обработки прерывания
    int 21h ; Устанавливаем значение элемента таблицы векторов прерываний для прерывания с номером AL равным DS:DX

    mov dx, OFFSET msg
    mov ah, 09h
    int 21h

    mov dx, OFFSET init ; Удаляем init из памяти
    int 27h

    msg    DB  "Success$", 13, 10

CODESEG ENDS
END main