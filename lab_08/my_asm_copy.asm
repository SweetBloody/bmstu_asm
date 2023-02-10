section .text
global my_asm_copy

; dst - rdi
; src - rsi
; len - rdx

my_asm_copy:
    mov rbx, rdi ; сохраняем dst в неиспользуемый регистр, чтобы в конце вернуть его из функции
    mov rcx, rdx ; кладём n в rcx

    cmp rdi, rsi ; проверка на случай перекрытия src и dst
    jbe copy ; если dst <= src, то переходим к копированию

    mov rax, rdi
    sub rax, rsi

    cmp rax, rcx
    ja copy ; если dst - src > len, то переходим к копированию

    add rdi, rcx
    add rsi, rcx
    dec rsi ; поставили rsi и rdi в концы строк,
    dec rdi ; на которые они указывали
    std ; установка флага направления DF
 ; DF контролирует поведение команд обработки строк (если установлен в 1, то строки обрабатываются в сторону уменьшения адресов, если сброшен в 0, то наоборот)

copy:
    rep movsb ; цикл копирования строки
    cld ; сброс флага направления DF

    mov byte [rbx + rdx], 0
quit:
    ret