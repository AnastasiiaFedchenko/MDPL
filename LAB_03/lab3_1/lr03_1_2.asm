PUBLIC output_X
EXTRN X: byte				; пометка о том, что X лежит в другом модуле

DS2 SEGMENT AT 0b800h
	CA LABEL byte
	ORG 80 * 2 * 2 + 2 * 2	; смещение оносительно начала 324 в 10-тичной => в 16-чной = 144
	SYMB LABEL word
DS2 ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'
	assume CS:CSEG, ES:DS2
output_X proc near			; near характеризует возможность обращения к процедуре из этого же сегмениа кода
	mov ax, DS2
	mov es, ax
	mov ah, 8Ah				; зачем?
	mov al, X
	mov symb, ax
	ret
output_X endp
CSEG ENDS
END 