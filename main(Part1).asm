include \masm32\include\masm32rt.inc

.data

inp		BYTE	51 DUP	(0)

;Prompts
msg1 BYTE  "Enter a number: "	, 0
msg2 BYTE  "This number is prime. "	, 0
msg3 BYTE  "This number is not a prime. "	, 0

crlf BYTE 0ah, 0dh, 0		;To go to New Line
i BYTE 48

.code

main proc
	invoke StdOut, ADDR msg1
	invoke StdIn, ADDR inp, 50

	mov eax, offset inp
	mov dl, [eax]
	sub dl, 1
	forLOOP: 
	cmp i, (dl)
	je prime
	mov dh, 0
	mov ch, dl
	mov bh, i
	div bh
	cmp bh, 0
	je nprime
	inc i
	jmp forLOOP

	prime:
	invoke StdOut, ADDR msg2
	invoke StdOut, ADDR crlf
	jmp cont

	nprime:
	invoke StdOut, ADDR msg3
	invoke StdOut, ADDR crlf
	jmp cont
	cont:
	ret
main endp
end main