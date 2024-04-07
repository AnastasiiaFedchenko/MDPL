PUBLIC make_10_without_sign
PUBLIC make_10_without_sign_out_of_x
EXTRN print_res: near
EXTRN clear_res: near
EXTRN i: word
EXTRN x: word
EXTRN res: byte
.386

CSEG SEGMENT PARA PUBLIC 'CODE'	USE16

make_10_without_sign_out_of_x:
	mov ax, x
	call make_10_without_sign
	
	call print_res
	call clear_res
	ret


make_10_without_sign:
	mov si, 0
    xor cx,cx
    mov bx,10						; делитель
 
	loop2:							; считаю символы в обратном порядке
		xor dx,dx               
		div bx						; деление AX=(DX:AX)/BX, остаток в DX
		add dl,'0'					
		push dx                 
		inc cx						
		test ax, ax					; проверка AX
		jnz loop2			        ; если частное не 0
 
	loop3:							; разворот
		pop dx                  
		mov res[si],dl            
		inc si                 
		loop loop3

	;mov ah, 02
	;mov dx, si
	;add dl, '0'
	;int 21h

	mov i, si  
    ret

CSEG ENDS

END 