.MODEL  LARGE
.386
.STACK 200h

.DATA

_18					dd		18
_19					dd		19
edad					dd		?
a1					dd		?
b2					dd		?
c3					dd		?
d4					db		?
d5					db		?
_1					dd		1
d6					db		?
_2					dd		2
genero					db		?
_30					dd		30

.CODE

START:
mov AX,@DATA
mov DS,AX
mov es,ax

FLD _19
FSTP edad

etiq_salto_1:

FLD edad
FLD _18

FXCH
FCOM
FSTSW AX
SAHF
JB etiq_salto_2

FLD _1
FSTP a1

JMP etiq_salto_1

etiq_salto_2:

etiq_salto_3:

FLD edad
FLD _18

FXCH
FCOM
FSTSW AX
SAHF
JB etiq_salto_4

FLD _2
FSTP b2

JMP etiq_salto_3

etiq_salto_4:

FLD _30
FSTP a1



mov ax, 4C00h
int 21h
END START
