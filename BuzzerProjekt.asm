cseg	at 0x0000
	JMP	MAIN

cseg	at 0x0003
isr0:
	cjne	R7, #1, sieg2
	jmp	sieg1

cseg	at 0x000B
timer:
	clr	Tr0
	mov	R7, #1
	clr	P2.4
	reti

cseg	at 0x0013
isr1:
	cjne	R7, #1, sieg1
	jmp	sieg2

main:
	mov	SP, #0x70
	mov	P2, #0xFF
	clr	it0
	clr	it1
	SETB	EX0
	SETB	EX1
	clr	P2.4
	setb	P2.4
	MOV	R1, #0xFF
	jmp	time

time:
	mov	TMOD, 0x11	;
	mov	TH0, #0xFD	;(65536 - 100)%256;  // für Startwert 
	mov	TL0, #0x70	;(65536 - 100)%256;  // für Startwert 
	setb	ET0		;// Interrupt für Timer 0 aktivieren
	setb	TR0		;    // Timer 0 starten  - TR1 für Timer 1
	setb	EA		;    // Globalen Interrupt aktivieren -- ab jetzt geht's rund
	jmp	loop

sieg1:
	clr	P2.0
	jmp	loop

sieg2:
	clr	P2.1
	jmp	loop

loop:
	nop
	jmp	loop
	END