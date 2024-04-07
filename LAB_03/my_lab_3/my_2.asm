PUBLIC read_S
EXTRN S: byte			; пометка о том, что X лежит в другом модуле

CSEG2 SEGMENT BYTE PUBLIC 'CODE'
	assume ES:CSEG2
read_S proc	far		; near характеризует возможность обращения к процедуре из этого же сегмениа кода
	
	mov dx, 0
	mov ah, 0Ah
	int 21h

	ret
read_S endp
CSEG2 ENDS
END