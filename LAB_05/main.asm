PUBLIC x
PUBLIC res
PUBLIC i
PUBLIC ans
EXTRN read_number: near
EXTRN clear_res: near
EXTRN print_res: near
EXTRN make_10_without_sign_out_of_x: near
EXTRN make_16_with_sign_cropped_out_of_x: near
EXTRN find_degree_of_2_for_x: near
.386


STK SEGMENT PARA STACK 'STACK' USE16	; STACK здесь это тип
	db 1000 dup(0)				; выделяем сто байт и заполняем нулями
STK ENDS

DSEG SEGMENT PARA PUBLIC 'DATA' USE16
	x dw 0
	res db 100 dup("$")				; то, что будет выводиться
	i dw 0
	funcs dd exit, make_10_without_sign_out_of_x, make_16_with_sign_cropped_out_of_x, find_degree_of_2_for_x
	menu_text db "Menu:", 0Dh, 0Ah
			  db "0) exit", 0Dh, 0Ah
			  db "1) print without sign in 10 ns", 0Dh, 0Ah
			  db "2) print with sign in 16 ns croped", 0Dh, 0Ah
			  db "3) print the degree of 2 that divides x", 0Dh, 0Ah, "$"
	ans db "Answer: $"
DSEG ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'	USE16
	assume CS:CSEG, DS:DSEG, SS:STK

print_menu_line:
	mov ah, 09
	mov dx, offset menu_text
	int 21h
	ret

menu:
	call print_menu_line

	mov ah, 01
	int 21h
	sub al, '0'
	xor ah, ah
	imul ax, 4
	mov si, ax

	mov ah, 02
	mov dl, 13					; курсор поместить в нач. строки
	int 21h
	mov dl, 10					; перевести курсор на нов. строку
	int 21h	
	call funcs[si]
	jmp menu

main:
	mov ax, DSEG
	mov ds, ax

	call read_number
	mov ah, 02
	mov dl, 13					; курсор поместить в нач. строки
	int 21h
	mov dl, 10					; перевести курсор на нов. строку
	int 21h
	mov ax, x
	
	jmp menu

	jmp exit

	exit:
		mov ax, 4c00h				; завершение программы
		int 21h
CSEG ENDS

END main ; точка входа