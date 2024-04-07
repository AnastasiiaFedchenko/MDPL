MAX_SIZE EQU 9

STK SEGMENT PARA STACK 'STACK'	; STACK ����� ��� ���
	db 100 dup(0)				; �������� ��� ���� � ��������� ������
STK ENDS

DSEG SEGMENT PARA PUBLIC 'DATA'
	n dw 0						; ���������� �����
	m dw 0						; ���������� �������
	arr db MAX_SIZE * MAX_SIZE dup(0)			; �������� ����� ��� ������
	;p db 0						; ��������� �� ������ �������
	i dw 0
	j dw 0
	empty db "EMPTY$"
DSEG ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'	
	assume CS:CSEG, DS:DSEG, SS:STK
next_i_j:
	inc j
	mov dx, j
	cmp dx, m
	je next_row
	ret
next_row:
	mov j, 0
	inc i
	ret	

where_at:
	xor dx, dx          ; ��������� ������
	mov dx, i
	mov ax, MAX_SIZE 
	mul dx				; ���������� �� al
	mov dx, ax			; ����������� ��������� �������
	add dx, j
	xor si, si
	mov si, dx
	ret

read_arr:
	mov ah, 01					; ���� n
	int 21h
	mov ah, 0
	mov n, ax
	sub n, '0'

	mov ah, 01
	int 21h						; ���������� �������

	;mov ah, 01
	int 21h						; ���� m
	mov ah, 0
	mov m, ax
	sub m, '0'

	mov ah, 01
	int 21h						; ���������� �������� �� ����� ������

	xor cx, cx
	mov cx, n
	rows_1:
		mov bx, cx				; ���������� ������� ������� ��� ���� ������
		mov cx, m				; �������� ���������� �������� � �������

		columns_1:
			call where_at
			
			mov ah, 01
			int 21h
			mov arr[si], al		; ���� ���������?
			call next_i_j

			int 21h				; ���������� �������
			loop columns_1

		mov cx, bx
		loop rows_1
	ret

print_arr:
	mov i, 0
	mov j, 0
	xor cx, cx
	mov cx, n
	cmp cx, 0
	je print_empty
	rows_2:
		mov bx, cx				; ���������� ������� ������� ��� ���� ������
		mov cx, m				; �������� ���������� �������� � �������

		columns_2:
			call where_at
			
			mov ah, 02
			mov dl, arr[si]
			int 21h
			call next_i_j

			mov dl, 32			; ������ �������
			int 21h

			loop columns_2

		mov dl, 13					; ������ ��������� � ���. ������
		int 21h
		mov dl, 10					; ��������� ������ �� ���. ������
		int 21h

		mov cx, bx
		loop rows_2
	ret

print_empty:
	mov dx, offset empty
	mov ah, 09
	int 21h
	mov ah, 02
	mov dl, 13					; ������ ��������� � ���. ������
	int 21h
	mov dl, 10					; ��������� ������ �� ���. ������
	int 21h
	jmp exit


delete_all_zero_lines:
	mov i, 0
	mov j, 0
	xor cx, cx
	mov cx, n
	rows_3:
		mov bx, cx				; ���������� ������� ������� ��� ���� ������
		mov cx, m				; �������� ���������� �������� � �������

		columns_3:
			call where_at
			
			cmp arr[si], '0'
			je delete
			call next_i_j

			loop columns_3
		mov cx, bx
		loop rows_3
	done:
		ret
delete:
	inc i						; ��� ����� ����� �������� � ����������� �����
	mov dx, i
	cmp dx, n
	je del_last_row
	jne del_average_row
del_last_row:
	dec i
	dec n
	jmp done
del_average_row:
	dec i
	xor ax, ax
	mov ax, i
	mov di, ax					; ���������� i, ����� ����� ���������� � ���� �� �����

	mov j, 0

	mov cx, n
	sub cx, i					; �����������, ������� ������� ���� ������������ ���� �� �����
	dec cx
	rows_4:
		mov j, 0
		call where_at			; ��������� ����, ����� � dl ������� ���������
		mov dx, cx				; ���������� ������� ������� ��� ���� ������
		mov cx, m				; �������� ���������� �������� � �������
		

		columns_4:
			add si, MAX_SIZE
			mov al, arr[si]
			sub si, MAX_SIZE
			mov arr[si], al

			inc si
			;call next_i_j
			inc j

			loop columns_4
		inc i
		mov cx, dx
		loop rows_4
	
	xor ax, ax
	mov ax, di
	mov i, ax					; ��������������� i
	mov j, 0					; �������� j
	dec n
	mov cx, bx					; ����������� ��������� ����� ����� rows_3, ��� ���� �������� �� 1 �������
	dec cx
	jmp rows_3

main:
	mov ax, DSEG
	mov ds, ax

	call read_arr

	;mov ah, 02
	;mov dl, 13					; ������ ��������� � ���. ������
	;int 21h
	;mov dl, 10					; ��������� ������ �� ���. ������
	;int 21h
	;call print_arr

	call delete_all_zero_lines

	mov ah, 02
	mov dl, 13					; ������ ��������� � ���. ������
	int 21h
	mov dl, 10					; ��������� ������ �� ���. ������
	int 21h
	call print_arr
	jmp exit

	exit:
		mov ax, 4c00h				; ���������� ���������
		int 21h
CSEG ENDS

END main ; ����� �����