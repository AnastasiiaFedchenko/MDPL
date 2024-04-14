.model tiny
.386

CSEG SEGMENT PARA PUBLIC 'CODE' USE16
	org 100h
	assume CS:CSEG, DS:CSEG, ES:CSEG, SS:CSEG 
	
Start:
	jmp Init
	old_vector dd ? 
	time db 0									; для отмера интервала времени
	speed db 0									; для изменения скорости

new_handler:
	
	push ax
	push dx
	xor ax, ax
	mov ah, 02h									;команда читает время из постоянных часов 
    int 1ah										;прерывание для таймера
	cmp dh, time								;после отработки команды выше в dh лежит количество секунд
    mov time, dh
	jz pass_on
	call faster
	pass_on:
	pop dx
	pop ax
	jmp cs:old_vector
	;iret

faster: 
	push ax
	push bx
	push cx

	mov time, 0
	cmp speed, 31								; проверяем, если скорость больше 31 - то обнуляем, если нет увеличиваем на 1
	je zero
	jne next
	zero:
		mov speed, 0
		jmp change

	next:
		inc speed
		jmp change
	
	change:
		mov al, 0F3h							; передаём значение скорости в порт 60h
		OUT 60h, al
		mov al, speed
		OUT 60h, al

		pop cx
		pop bx
		pop ax
	ret		

	

Init: 
	
	mov ax, 3508h								; получаем адрес старого обработчика прерывания, восьмой тк нам нужен таймер
    int 21h
	
	mov word ptr old_vector, bx
	mov word ptr old_vector+2, es

	mov ax, 2508h               
    mov dx, offset new_handler
    int 21h										; произошёл захват 
	mov dx, offset Init  
    int 27h

CSEG ENDS
END Start