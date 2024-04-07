STK SEGMENT para STACK 'STACK'
	db 100 dup(0)
STK ENDS

SD1 SEGMENT para common 'DATA'
	W dw 3444h					; единственное, что мне пока не понятно, это почему в памяти 4434
SD1 ENDS
END
