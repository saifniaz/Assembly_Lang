include \masm32\include\masm32rt.inc

.data

inp		BYTE	51 DUP	(0)
outp	BYTE	51 DUP	(0)

;Prompts
msg1 BYTE  "Enter a string: "	, 0
msg2 BYTE  "This string is a palindrome. "	, 0
msg3 BYTE  "This string is not a palindrome. "	, 0


crlf BYTE 0ah, 0dh, 0		;To go to New Line


.code

main proc
	invoke StdOut, ADDR msg1
	invoke StdIn, ADDR inp, 50

	mov eax, OFFSET inp
	mov ecx, OFFSET outp

	process:
	mov dl, [eax]
	cmp dl, 0
	je key_reset
	mov [ecx], dl
	inc eax
	inc ecx
	jmp process

	key_reset:
	mov eax, OFFSET inp
	jmp compare

	compare:
	mov dl, [eax]
	mov cl, [ecx]
	cmp dl, 0
	je pali
	jmp evaluate

	evaluate:
	cmp cl, bl
	jne itkey
	invoke StdOut, ADDR msg3
	invoke StdOut, ADDR crlf
	jmp cont

	itkey:
	inc eax
	dec ecx
	jmp compare

	pali:
	invoke StdOut, ADDR msg2
	invoke StdOut, ADDR crlf
	jmp cont


	cont:
	ret
main endp
end main