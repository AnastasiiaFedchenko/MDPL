EXTRN read_S: far

STK SEGMENT PARA STACK 'STACK'	; STACK здесь это тип
	db 100 dup(0)				; выделяем сто байт и заполняем нулями
STK ENDS

DSEG SEGMENT BYTE PUBLIC 'DATA'
	S db 100 dup('$')					; выделяем место под переменную 
DSEG ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'	
	assume CS:CSEG, DS:DSEG, SS:STK
main:
	mov ax, DSEG
	mov ds, ax

	call read_S	

	mov ah, 02
	mov dl, 13					; курсор поместить в нач. строки
	int 21h
	mov dl, 10					; перевести курсор на нов. строку
	int 21h
	
	mov dl, S[4]
	int 21h

	mov ax, 4c00h				; завершение программы
	int 21h
CSEG ENDS

PUBLIC S

END main ; точка входа