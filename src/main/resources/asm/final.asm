.MODEL  LARGE
.386
.STACK 200h

.DATA

a1					dd		?
b2					dd		?
c3					dd		?
_1					dd		1
_2					dd		2
_6					dd		6
edad					dd		?

.CODE

START:
mov AX,@DATA
mov DS,AX
mov es,ax

FLD _2
FLD _6
FMUL

FLD _1
FADD

FSTP a1

FLD _a1
FSTP b2



mov ax, 4C00h
int 21h
END START
