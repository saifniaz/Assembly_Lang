include \masm32\include\masm32rt.inc

.data

msg BYTE "Hello there! ", 0
msg1 BYTE "Guess a number between 0 to 9: -> ", 0
msg2 BYTE "Number is lower! Guess again -> ", 0
msg3 BYTE "Number is higher! Guess again -> ", 0
msg4 BYTE "Correct!! Chance you took -> ", 0

crlf BYTE 0ah, 0dh, 0		;Go to new line

x	BYTE	10 DUP	(?)
a DWORD 0

.code
main proc


	invoke StdOut, ADDR msg
	invoke StdOut, ADDR crlf
	invoke StdOut, ADDR msg1


CheckChance:
	inc a
	invoke StdIn, ADDR x, 10
	cmp x, "5"
	je endCheck
	jmp CheckNum


CheckNum:
	cmp x, "5"
	jg Guesshigh
	jmp GuessLow

GuessLow:
	invoke StdOut, ADDR msg3
	jmp CheckChance

Guesshigh:
	invoke StdOut, ADDR msg2
	jmp CheckChance

endCheck:
	add a, 48	
	invoke StdOut, ADDR msg4
	invoke StdOut, ADDR a

	ret			 ; HALT
main endp
end main
