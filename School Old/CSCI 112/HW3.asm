;Tyler Gillette


.586
.MODEL	FLAT
.STACK	4096
INCLUDE io.h
.DATA
	P1      BYTE		"Enter a number: ",0
	P2	    BYTE		"Answer: ", 0
	string  DWORD		 40 DUP (?)
	string2 DWORD		 40 DUP (?)
	number1	DWORD			?

.CODE
_MainProc PROC

	input P1, string, 40
	atod string
	mov number1, eax
	mov eax, number1

	push number1

	call func1

	add esp, 4

	dtoa string2, eax
	output P2, string2
	mov eax, 0

ret

_MainProc EndP

func1 PROC
	push ebp
	mov ebp, esp
	push ebx
	mov ebx, [ebp+8]
	mov eax, 1
	cmp ebx, 1
		je endh
		dec ebx
		push ebx
		call func1
		add esp, 4
		mov ebx, [ebp+8]
		mul ebx
	endh:
	pop ebx
	pop ebp
	ret
func1 ENDP
END







