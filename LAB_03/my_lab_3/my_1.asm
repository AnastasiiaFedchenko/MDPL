EXTRN read_S: far

STK SEGMENT PARA STACK 'STACK'	; STACK ����� ��� ���
	db 100 dup(0)				; �������� ��� ���� � ��������� ������
STK ENDS

DSEG SEGMENT BYTE PUBLIC 'DATA'
	S db 100 dup('$')					; �������� ����� ��� ���������� 
DSEG ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'	
	assume CS:CSEG, DS:DSEG, SS:STK
main:
	mov ax, DSEG
	mov ds, ax

	call read_S	

	mov ah, 02
	mov dl, 13					; ������ ��������� � ���. ������
	int 21h
	mov dl, 10					; ��������� ������ �� ���. ������
	int 21h
	
	mov dl, S[4]
	int 21h

	mov ax, 4c00h				; ���������� ���������
	int 21h
CSEG ENDS

PUBLIC S

END main ; ����� �����