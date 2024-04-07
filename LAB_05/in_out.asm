PUBLIC read_number
PUBLIC clear_res
PUBLIC print_res
EXTRN i: word
EXTRN x: word
EXTRN ans: byte
EXTRN res: byte
.386

CSEG SEGMENT PARA PUBLIC 'CODE'	USE16

read_number:
	xor cx, cx
	mov cl, 16
	mov ah, 01
	loop1:
		mov ah, 01
		int 21h
		sub al, '0'
		shl x, 1					; циклический сдвиг на один влево
		mov ah, 0
		add x, ax
		loop loop1
	ret

clear_res:
	xor cx, cx
	mov cx, i
	mov si, 0
	clear_loop:
		mov res[si], '$'
		inc si
		loop clear_loop
	mov si, 0
	mov i, si

	ret

print_res:
	mov ah, 09
	mov dx, offset ans
	int 21h
	mov dx, offset res
	int 21h
	mov ah, 02
	mov dl, 13					; курсор поместить в нач. строки
	int 21h
	mov dl, 10					; перевести курсор на нов. строку
	int 21h	

	ret

CSEG ENDS

END 