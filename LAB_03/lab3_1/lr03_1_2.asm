PUBLIC output_X
EXTRN X: byte				; ������� � ���, ��� X ����� � ������ ������

DS2 SEGMENT AT 0b800h
	CA LABEL byte
	ORG 80 * 2 * 2 + 2 * 2	; �������� ����������� ������ 324 � 10-������ => � 16-���� = 144
	SYMB LABEL word
DS2 ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'
	assume CS:CSEG, ES:DS2
output_X proc near			; near ������������� ����������� ��������� � ��������� �� ����� �� �������� ����
	mov ax, DS2
	mov es, ax
	mov ah, 8Ah				; �����?
	mov al, X
	mov symb, ax
	ret
output_X endp
CSEG ENDS
END 