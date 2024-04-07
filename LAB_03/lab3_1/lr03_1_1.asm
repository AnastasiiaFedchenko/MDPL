EXTRN output_X: near

STK SEGMENT PARA STACK 'STACK'	; STACK здесь это тип
	db 100 dup(0)				; выдел€ем сто байт и заполн€ем нул€ми
STK ENDS

DSEG SEGMENT PARA PUBLIC 'DATA'
	X db 'R'					; выдел€ем место под переменную с именем X размером в один байт и инициализируем 'R'
DSEG ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'	; public значит доступен из других модулей
	assume CS:CSEG, DS:DSEG, SS:STK
main:
	mov ax, DSEG
	mov ds, ax

	call output_X	

	mov ax, 4c00h				; завершение программы
	int 21h
CSEG ENDS

PUBLIC X

END main ; точка входа