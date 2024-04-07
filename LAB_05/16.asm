PUBLIC make_16_with_sign_cropped_out_of_x
EXTRN print_res: near
EXTRN clear_res: near
EXTRN i: word
EXTRN x: word
EXTRN res: byte
.386

CSEG SEGMENT PARA PUBLIC 'CODE'	USE16

make_16_with_sign_cropped_out_of_x:
	
	mov ax, x
	call make_16_with_sign_cropped

	call print_res
	call clear_res
	ret

neg_al:
	mov res[si], '-'
	inc si
	neg al
	jmp continue2

turn_16digit_into_symbol:
	add res[si], '0'
	cmp res[si], '9'              ;Сравнение с символом '9' (код 0x39)
    jle thd_end						;Если получилось '0'-'9', то выход
    add res[si], 7                ;Прибавляем ещё 7 для символов 'A'-'F'
	thd_end:
		ret


make_16_with_sign_cropped:					; for 8 bits
	mov ah, 0
	cmp al, 0
	mov si, 0
	jl neg_al						; если ax < 0

	continue2:
		
		mov bl, al						; сохраним модуль числа

		and al, 240
		shr al, 4
		mov res[si], al
		call turn_16digit_into_symbol
		inc si

		mov al, bl
		and al, 0Fh
		mov res[si], al
		call turn_16digit_into_symbol
		inc si
		mov i, si
		ret

	

CSEG ENDS

END