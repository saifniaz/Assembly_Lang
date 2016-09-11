include \masm32\include\masm32rt.inc

.data

;Inputs
ind		BYTE	10 DUP	(?)
key	BYTE	10 DUP	(0)
inp	BYTE	51 DUP	(0)
keyp		BYTE	51 DUP	(0)
outp	BYTE	51 DUP	(0)

;Prompts
msg1 BYTE  "Enter 1 to Encrypt & Enter 2 to Decrypt: "	, 0
msg2 BYTE  "Enter the size of the message (1-50): "	, 0
msg3 BYTE  "You Choose: "			, 0
msg4 BYTE  "Decrypted message: ",	0
msg5 BYTE  "Encrypted message: ",	0
msg6 BYTE	"Enter the message: ",	0
msg7 BYTE	"Enter the key: ",	0

crlf BYTE 0ah, 0dh, 0		;To go to New Line

x DWORD 1

.code

;Entrypoint

Encrypt proc
	
	invoke StdOut, ADDR msg2
	invoke StdIn, ADDR 	key, 10

	invoke StdOut, ADDR msg6
	invoke StdIn, ADDR inp, 50

	invoke StdOut, ADDR msg7
	invoke StdIn, ADDR keyp, 50

	invoke	StdOut, ADDR msg5
	invoke StdOut, ADDR crlf

	mov eax, OFFSET inp			
	mov ebx, OFFSET keyp			
	mov ecx, OFFSET outp

process1:
	mov dl, [eax]
	mov	dh, [ebx]
	cmp dl, 0
	je endProccess1
	cmp dh, 0
	je reset_key1
	jmp evaluate1

reset_key1:
	mov ebx, OFFSET keyp
	mov dh, [ebx]

evaluate1:
	sub dh, 65
	add dl, dh
	cmp dl, 91
	jl setOut1
	sub dl, 26

setOut1:
	mov [ecx], dl
	inc eax
	inc ebx
	inc ecx
	jmp process1

endProccess1:
	invoke StdOut, ADDR outp
	ret
Encrypt endp

Decrypt proc

	invoke StdOut, ADDR msg6
	invoke StdIn, ADDR inp, 50

	invoke StdOut, ADDR msg7
	invoke StdIn, ADDR keyp, 50

	invoke	StdOut, ADDR msg4
	invoke StdOut, ADDR crlf

	mov eax, OFFSET inp			;Put string address in register
	mov ebx, OFFSET keyp					;Put string address in register
	mov ecx, OFFSET outp

process2:
	mov dl, [eax]
	mov	dh, [ebx]
	cmp dl, 0
	je endProcess2
	cmp dh, 0
	je reset_key2
	jmp evaluate2

reset_key2:
	mov ebx, OFFSET keyp
	mov dh, [ebx]

evaluate2:
	sub dh, 65
	sub dl, dh
	cmp dl, 64
	jg setOut2
	add dl, 26

setOut2:
	mov [ecx], dl
	inc eax
	inc ebx
	inc ecx
	jmp process2

endProcess2:
	invoke StdOut, ADDR outp
	ret
Decrypt endp

main proc
	invoke StdOut, ADDR msg1
	invoke StdIn, ADDR ind, 10
	invoke StdOut, ADDR msg3
	invoke StdOut, ADDR ind
	invoke StdOut, ADDR crlf


	cmp ind, "1"
	je callEn
	jmp callDe

	callDe:
		call Decrypt
		jmp Cont

	callEn:
		call Encrypt
		jmp Cont

	Cont:
	ret
main endp
end main