PUBLIC find_degree_of_2_for_x
EXTRN make_10_without_sign: near
EXTRN print_res: near
EXTRN clear_res: near
EXTRN i: word
EXTRN x: word
.386

CSEG SEGMENT PARA PUBLIC 'CODE'	USE16

find_degree_of_2_for_x:
	call find_degree_of_2
	call print_res
	call clear_res
	ret


find_degree_of_2:
	bsf bx, x

	;mov ah, 02
	;mov dx, bx
	;add dl, '0'
	;int 21h

	mov ax, bx
	call make_10_without_sign

	ret

CSEG ENDS
END 