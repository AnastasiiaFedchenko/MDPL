PUBLIC read_S
EXTRN S: byte			; ������� � ���, ��� X ����� � ������ ������

CSEG2 SEGMENT BYTE PUBLIC 'CODE'
	assume ES:CSEG2
read_S proc	far		; near ������������� ����������� ��������� � ��������� �� ����� �� �������� ����
	
	mov dx, 0
	mov ah, 0Ah
	int 21h

	ret
read_S endp
CSEG2 ENDS
END