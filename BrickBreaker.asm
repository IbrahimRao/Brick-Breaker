.model small
.stack 100h
.data

;Display Screen Variables
gamename db 		"x BRICK BREAKER x$"

names db 20 dup (' ')
filename db "file.txt", 0
handler dw 0
buffer db 20 dup(0), '$'

user db 			"Enter Username:$"
newgame db 			"Start New Game$"
highscore db 		"HighScore$"
instruction db 		"Instructions$"
exiting db 				"Exit$"


hi_score db 		"HighScore Display$"


insman db 			"Instructions:$"

insman2 db 0ah, 0dh,"        It is a single player game"
		db 0ah, 0dh,"                                "
		db 0ah, 0dh,"    Do not let the Ball fall through"
		db 0ah, 0dh,"                                "
		db 0ah, 0dh,"  Use the Arrow Keys to move the slider"
		db 0ah, 0dh,"                                "
		db 0ah, 0dh,"   Break all the bricks that are shown"
		db 0ah, 0dh,"                                "
		db 0ah, 0dh,"        Preserve your chances to win"
		db 0ah, 0dh,"                                "
		db 0ah, 0dh,"              Good Luck :)$"
		
;Exit Display
exstring db 		"EXITED$"
exstring2 db 		"Thank you for playing :)$"

;For Underlines
line dw 105
hiline dw 96
insline dw 108
userline dw 102

copyrights db 		"Copyrights Reserved$"

xAxis dw 4
yAxis dw 7
pixel db 0

;Movement of keyboard
UpDown db 65
;x-y coordinates for pixel
xpix dw 85
ypix dw 75

s1 dw 30
;initial_brick dw 0

levels db 			"LEVEL 1:$"
newstr db 			"Press Enter To Play$"

BGColour db 05h
GameSpeed dw 10000
; Score dw 0

;------------------welcome page 

pname db 20 DUP(0)
XX dw 25
initial_brick dw 0
initial_brick_stx dw 0

;------------------ level 1
showLevel1 db 				"Level 1$"
showLevel2 db 				"Level 2$"
showLevel3 db 				"Level 3$"
scorestr db 				"SCORE:$"


chances db 3
count db 0

x dw 100
y dw 180


x_start dw 100			;150       
y_start dw 100       	;150

brick_x dw 0
brick_y dw 0

Variable_score dw 0

volume_ball dw 5h     

velocity_ball_y dw 02h  


velocity_ball_x dw 02h  

ball_movement dw 155    
ball_movement_ dw 02h
prev_time db 0       

screenlength dw 313     ; window's width 
screenbreadth dw 196      ; window's screenbreadth 
screen DW 6 


x_bar DW 150                    ;current X position of the left paddle
y_bar DW 180                     ;current Y position of the left paddle
bar_length DW 50                  ;default paddle width
bar_breadth DW 10                 ;default paddle screenbreadth
bar_speed DW 0FH               ;default paddle velocity
win_size DW 0C8h                ;the screenbreadth of the window (200 pixels)



h_brick dw 19
w_brick dw 49

x_life dw 0
y_life dw 1

brick1complete db 		"YOU HAVE PASSED LEVEL ONE $"
brick2complete db 		"YOU HAVE PASSED LEVEL TWO $"
level_done db 				"level_doneRAGULATIONS $"
next_to_2 db 				"PRESS ENTER TO START LEVEL TWO $"
next_to_3 db 				"PRESS ENTER TO START LEVEL THREE $"

passing_1 	db 0ah, 0dh,"               Great Job."
			db 0ah, 0dh,"                                "
			db 0ah, 0dh,"                                "
			db 0ah, 0dh,"   You have successfully Passed Level 1"
			db 0ah, 0dh,"                                "
			db 0ah, 0dh,"                                "
			db 0ah, 0dh,"      Please press Enter to continue $"
			
passing_2 	db 0ah, 0dh,"                Amazing."
			db 0ah, 0dh,"                                "
			db 0ah, 0dh,"                                "
			db 0ah, 0dh,"   You have successfully Passed Level 2"
			db 0ah, 0dh,"                                "
			db 0ah, 0dh,"                                "
			db 0ah, 0dh,"      Please press Enter to continue $"
			
passing_3 	db 0ah, 0dh,"             level_donearatulations."
			db 0ah, 0dh,"                                "
			db 0ah, 0dh,"                                "
			db 0ah, 0dh," You have successfully passed all Levels"
			db 0ah, 0dh,"                                "
			db 0ah, 0dh,"                                "
			db 0ah, 0dh,"      Please press Enter to continue $"


funcEnd dw 0
Hittler dw 0

brick1 dw 0
brick2 dw 0
brick3 dw 0
brick4 dw 0
brick5 dw 0
brick6 dw 0
brick7 dw 0
brick8 dw 0
brick9 dw 0
brick10 dw 0
brick11 dw 0
brick12 dw 0
brick13 dw 0
brick14 dw 0
brick15 dw 0
brick16 dw 0
brick17 dw 0
brick18 dw 0
brick19 dw 0
brick20 dw 0
brick21 dw 0
brick22 dw 0

.code

jmp main

Page1 Proc

;BG Color
	mov ah, 06h
	mov al, 0
	mov cx, 0
	mov dh, 80
	mov dl, 80
	mov bh, 0h
	int 10h
	
;Sitaray

	mov bx, 0
Sitaray:

	cmp bx, 100
	je cursoo
	mov ah, 0ch
	mov al, 0dh
	mov cx, xAxis
	mov dx, yAxis
	int 10h
	inc bx

	add xAxis, 7
	
	sub yAxis, 12
	
jmp Sitaray

cursoo:
	mov xAxis, 4
	mov yAxis, 7
;CURSOR POSITION
	mov ah, 02h
	mov bx, 0
	mov dh, 100	;(X) ;rows 
	mov dl, 100	;(Y) ;columns
	int 10h

;straight line
	mov ah, 0ch
	mov al, 4h
	mov cx, 320	;colss
	mov dx, 15	;rowss
	int 10h 

		.while (cx != 0)
		dec cx
		int 10h
		.endw

	mov ax, 0
	mov bx, 0
	mov cx, 0
	mov dx, 0

;straight line
	mov ah, 0ch
	mov al, 4h
	mov cx, 320	;colss
	mov dx, 590	;rowss
	int 10h 

		.while (cx != 0)
		dec cx
		int 10h
		.endw

	mov ax, 0
	mov bx, 0
	mov cx, 0
	mov dx, 0

;Vertical line
	mov bx, 0

k2:

	mov ah, 0ch  
	mov al, 4h  		
	mov cx, 15  		
	mov dx, initial_brick  		
	int 10h				
	inc initial_brick
	inc bx
	cmp bx, 200 		
	je end1
	jne k2

end1:
			
	mov ax, 0
	mov bx, 0
	mov cx, 0
	mov dx, 0
	mov initial_brick, 0

;Vertical line
k3:

	mov ah, 0ch  
	mov al, 4h 			
	mov cx, 305 		
	mov dx, initial_brick  		
	int 10h 			
	inc initial_brick
	inc bx
	cmp bx, 200 		
	je end2
	jne k3

end2:
	
	mov ax, 0
	mov bx, 0
	mov cx, 0
	mov dx, 0
	mov initial_brick, 0

k4:

	mov ah, 0ch  
	mov al, 15 			
	mov cx, userline 	
	mov dx, 113			
	int 10h 			
	inc userline
	inc bx
	cmp bx, 120 		
	je end3
	jne k4

end3:

	mov userline, 102
	
	mov ah, 02h
	mov bx, 0
	mov dh, 3
	mov dl, 12
	int 10h
	
		mov dx, offset gamename
		mov ah, 09h
		int 21h


;CURSOR POSITION
	mov ah, 02h
	mov bx, 0
	mov dh, 11	;(X) ;rows 
	mov dl, 13	;(Y) ;columns
	int 10h

		mov dx, offset user
		mov ah, 09h
		int 21h
		
	mov ah, 02h
	mov bx, 0
	mov dh, 22
	mov dl, 11
	int 10h
	
		lea dx, offset copyrights
		mov ah, 09h
		int 21h

;Cursor Position
	mov ah, 02h
	mov bx, 0
	mov dh, 13	;(X) ;rows 
	mov dl, 13	;(Y) ;columns
	int 10h



	mov dx, offset names
	mov ah, 03fh
	int 21h


call Page2
ret
Page1 endp
			file_banao:

			mov ah, 3ch
			mov cx,0
			lea dx, filename
			int 21h

			file_kholo:

			mov ah, 3dh
			mov al,  2
			lea dx, filename
			int 21h
			mov handler, ax

			file_likho:

			mov cx, 0
			mov dx, 0
			mov bx, handler
			mov ah, 42h
			mov al, 2 
			int 21h
			mov bx, handler
			mov cx, lengthof names
			lea dx, names
			mov ah, 40h
			int 21h

			mov ah, 3eh
			mov bx, handler
			int 21h

			mov ah, 3dh
			mov al,  2
			lea dx, filename
			int 21h
			mov handler, ax


			file_parho:

			mov ah, 03fh
			mov bx, handler
			mov cx, 50
			lea dx, buffer 
			int 21h

			mov ah, 09h
			lea dx, buffer
			int 21h

			close:

			mov ah, 3eh
			mov bx, handler
			int 21h
			exit1:

Page2 Proc

;BG COLOR
	mov ah, 06h
	mov al, 0
	mov cx, 0
	mov dh, 80
	mov dl, 80
	mov bh, 0h
	int 10h
	
	
	mov bx, 0
Sitaray1:

	cmp bx, 100
	je cursoo1
	mov ah, 0ch
	mov al, 0dh
	mov cx, xAxis
	mov dx, yAxis
	int 10h
	inc bx

	add xAxis, 7
	
	sub yAxis, 12

jmp Sitaray1

cursoo1:
	mov xAxis, 4
	mov yAxis, 7
	
	mov ah, 02h
	mov bx, 0
	mov dh, 3	;(X) ;rows 
	mov dl, 11	;(Y) ;columns
	int 10h

		mov dx, offset gamename
		mov ah, 09h
		int 21h


;Cursor Position
	mov ah, 02h
	mov bx, 0
	mov dh, 9
	mov dl, 13
	int 10h

		lea dx, newgame
		mov ah, 09h
		int 21h

;Cursor Position
	mov ah, 02h
	mov bx, 0
	mov dh, 11
	mov dl, 16 	 
	int 10h

		lea dx, highscore
		mov ah, 09h
		int 21h

;Cursor Position
	mov ah, 02h
	mov bx, 0
	mov dh, 13
	mov dl, 14
	int 10h

		lea dx, instruction
		mov ah, 09h
		int 21h

;Cursor Position
	mov ah, 02h
	mov bx, 0
	mov dh, 15
	mov dl, 18
	int 10h

		lea dx, exiting
		mov ah, 09h
		int 21h

	mov ah, 02h
	mov bx, 0
	mov dh, 22
	mov dl, 11
	int 10h
	
		lea dx, offset copyrights
		mov ah, 09h
		int 21h
		
		
	mov ax, 0
	mov dx, 0
	mov cx, 0
	mov bx, 0
	

;Horizontal line
Line1:

	mov ah, 0ch
	mov al, 4h
	mov cx, line
	mov dx, 35
	int 10h
	inc line
	inc bx
	cmp bx, 103
	je endline
	jne Line1


endline:

	mov line, 105


Coordinates:

	mov ah, 0ch
	mov al, 15    
	mov cx, xpix     
	mov dx, ypix
	int 10h

Condition:

	mov ah, 01h
	int 16h

	mov ah, 00h
	int 16h

	mov pixel, ah 

	cmp ah, 50h
	je Downwards


	cmp ah, 48h
	je Upwards

	cmp al, 13
	je nextScreen	
	cmp al, 27
	je exit

Upwards:

	mov ah, 0Ch
	mov al, 00h   
	mov cx, xpix  
	mov dx, ypix
	int 10h
		
	sub ypix, 17
		
	cmp ypix, 58
	je Initial

	jmp Coordinates
		
Downwards:

	mov ah, 0Ch
	mov al, 00h   ;initial position
	mov cx, xpix 
	mov dx, ypix
	
	int 10h

	add ypix, 17
		
	cmp ypix, 143
		
	je Initial ;this will move my cursor bak to option 1
		
	jmp Coordinates
		

Initial:

	mov ypix, 75
	mov xpix, 85
	jmp Coordinates
		

nextScreen:
	
	mov ah, 06h
	mov al, 0
	mov cx, 0
	mov dh, 80
	mov dl, 80
	mov bh, 0h
	int 10h
	
cmp ypix, 75
je New_Game
	
cmp ypix, 92
je High_Score
	
cmp ypix, 109
je InsManual

cmp ypix, 126
je Exitscreen

New_Game:

	mov ah, 06h
	mov al, 0
	mov cx, 0
	mov dh, 80
	mov dl, 80
	mov bh, 0h
	int 10h
	
	;Cursor Position
	mov ah, 02h
	mov bx, 0
	mov dh, 5	;(X) ;rows 
	mov dl, 15	;(Y) ;columns
	int 10h

		mov dx, offset levels
		mov ah, 09h
		int 21h
		
	mov ah, 02h
	mov bx, 0
	mov dh, 12	;(X) ;rows 
	mov dl, 10	;(Y) ;columns
	int 10h
	
	lea dx, newstr
	mov ah, 09h
	int 21h
	
	mov ah, 02h
	mov bx, 0
	mov dh, 22
	mov dl, 11
	int 10h
	
		lea dx, offset copyrights
		mov ah, 09h
		int 21h
	
	
	mov ah, 01h
	int 16h
	
	mov ah, 00h
	int 16h
	
	cmp al, 13
	je First_one
	
	cmp al, 08h
	je Jumps

	jmp exit

High_Score:

	mov ah, 06h
	mov al, 0
	mov cx, 0
	mov dh, 80
	mov dl, 80
	mov bh, 0h
	int 10h
	
	mov bx, 0
Sitaray3:

	cmp bx, 100
	je cursoo2
	mov ah, 0ch
	mov al, 04h
	mov cx, xAxis
	mov dx, yAxis
	int 10h
	inc bx

	add xAxis, 7

	sub yAxis, 12

jmp Sitaray3

cursoo2:
	mov xAxis, 4
	mov yAxis, 7

	mov ah, 02h
	mov bx, 0
	mov dh, 3	;(X) ;rows 
	mov dl, 11	;(Y) ;columns
	int 10h
	
	lea dx, hi_score
	mov ah, 09h
	int 21h
	
	mov ah, 02h
	mov bx, 0
	mov dh, 22
	mov dl, 11
	int 10h
	
		lea dx, offset copyrights
		mov ah, 09h
		int 21h

	
Line2:

	mov ah, 0ch
	mov al, 4h
	mov cx, hiline
	mov dx, 35
	int 10h
	inc hiline
	inc bx
	cmp bx, 118
	je endline1
	jne Line2
	
endline1:

	mov hiline, 96
	
	mov ah, 01h
	int 16h
	
	mov ah, 00h
	int 16h

	cmp al, 08h
	je Jumps
	
	jmp exit

InsManual:

	mov ah, 06h
	mov al, 0
	mov cx, 0
	mov dh, 80
	mov dl, 80
	mov bh, 0h
	int 10h
	
		mov bx, 0
Sitaray4:

	cmp bx, 100
	je cursoo3
	mov ah, 0ch
	mov al, 03h
	mov cx, xAxis
	mov dx, yAxis
	int 10h
	inc bx

	add xAxis, 7
	
	sub yAxis, 12

jmp Sitaray4

cursoo3:

	mov xAxis, 4
	mov yAxis, 7
	
	mov ah, 02h
	mov bx, 0
	mov dh, 3
	mov dl, 13
	int 10h
	
		lea dx, insman
		mov ah, 09h
		int 21h

	
	mov ah, 02h
	mov bx, 0
	mov dh, 7	;(X) ;rows 
	mov dl, 11	;(Y) ;columns
	int 10h
	
	lea dx, insman2
	mov ah, 09h
	int 21h
	
	mov ah, 02h
	mov bx, 0
	mov dh, 22
	mov dl, 11
	int 10h
	
		lea dx, offset copyrights
		mov ah, 09h
		int 21h
	
Line3:

	mov ah, 0ch
	mov al, 4h
	mov cx, insline
	mov dx, 35
	int 10h
	inc insline
	inc bx
	cmp bx, 90
	je endline2
	jne Line3
	
endline2:

	mov insline, 108
	
	mov ah, 01h
	int 16h
	
	mov ah, 00h
	int 16h
	
	cmp al, 08h
	je Jumps
	
	jmp exit
	
Exitscreen:

	mov ah, 06h
	mov al, 0
	mov cx, 0
	mov dh, 80
	mov dl, 80
	mov bh, 0h
	int 10h
	
	mov bx, 0
Sitaray5:

	cmp bx, 100
	je cursoo4
	mov ah, 0ch
	mov al, 15
	mov cx, xAxis
	mov dx, yAxis
	int 10h
	inc bx

	add xAxis, 7

	sub yAxis, 12

jmp Sitaray5

cursoo4:
	mov xAxis, 4
	mov yAxis, 7
	
	mov ah, 02h
	mov bx, 0
	mov dh, 5	;(X) ;rows 
	mov dl, 16	;(Y) ;columns
	int 10h
	
	lea dx, exstring
	mov ah, 09h
	int 21h
	
	mov ah, 02h
	mov bx, 0
	mov dh, 12	;(X) ;rows 
	mov dl, 8	;(Y) ;columns
	int 10h
	
	lea dx, exstring2
	mov ah, 09h
	int 21h
	
	mov ah, 02h
	mov bx, 0
	mov dh, 22
	mov dl, 11
	int 10h
	
		lea dx, offset copyrights
		mov ah, 09h
		int 21h
	
	mov ah, 01h
	int 16h
	
	mov ah, 00h
	int 16h
	
	mov ah, 02h
	mov bx, 0
	mov dh, 20	;(X) ;rows 
	mov dl, 0	;(Y) ;columns
	int 10h
	
	
	
	jmp exit

ret
Page2 endp

First_one proc
   
   mov ah, 06h
   mov al, 0 
   mov cx, 0
   mov dh, 80
   mov dl, 80
   mov bh, 0h
   int 10h
    call Lives_Func
    call First_level
    call SCORE   
    call boxes   
	
TIMEX:
    mov ah, 2ch     ; get system time
    int 21h

    cmp dl, prev_time
    je TIMEX
    
    mov prev_time, dl
    
    call clearBALL
    call lightningMcQueen
    call BALL
    
    call move_BAR_again
    call move_BAR
    call BAR
    
    call SCORE
    
    .if (chances == 0)
        mov funcEnd, 1
        jmp First_One_End
    .endif
    
    .if (brick7 ==1 && brick8 ==1 && brick10 ==1 && brick11 ==1 && brick13 ==1 && brick14 ==1 && brick15 ==1 && brick16 ==1 && brick18 ==1 && brick19 ==1 && brick20 ==1 && brick21 ==1 && brick22 ==1)
    jmp First_One_End
    .endif
    
jmp TIMEX

First_One_End:
ret 
First_one endp

;------------------------------level 2

Second_one proc

   mov ah, 06h
   mov al, 0 
   mov cx, 0
   mov dh, 80
   mov dl, 80
   mov bh, 0h
   
   int 10h
   
    call Lives_Func
    call Second_level
    call SCORE   
    call boxes 
    
    mov bar_length, 35                   
    mov velocity_ball_y, 03h  
    mov velocity_ball_x, 03h       
    
TIMEX:
    mov ah, 2ch    
    int 21h

    cmp dl, prev_time
    je TIMEX
    
    mov prev_time, dl
    
    call clearBALL
    call lightningMcQueen
    call BALL
    
    
    call move_BAR_again
    call move_BAR
    call BAR
    
    call SCORE
    
    .if (chances == 0)
        mov funcEnd, 1
        jmp Second_One_End
    .endif
    
    .if (brick7 ==2 && brick8 ==2  && brick10 ==2 && brick11 ==2 && brick13 ==2 && brick14 ==2 && brick15 ==2 && brick16 ==2 && brick18 ==2 && brick19 ==2 && brick20 ==2 && brick21 ==2 && brick22 ==2)
    jmp Second_One_End
    .endif
    
jmp TIMEX

Second_One_End:
ret 
Second_one endp

Third_one proc

   mov ah, 06h
   mov al, 0 
   mov cx, 0
   mov dh, 80
   mov dl, 80
   mov bh, 0h
   int 10h
   
    call Lives_Func
    call Third_level
    call SCORE   
    call boxes 
    
    mov bar_length, 25                                  
    mov velocity_ball_y, 04h  
    mov velocity_ball_x, 04h  
    
TIMEX:
    mov ah, 2ch     
    int 21h

    cmp dl, prev_time
    je TIMEX
    
    mov prev_time, dl
    
    call clearBALL
    call lightningMcQueen
    call BALL
    
    
    call move_BAR_again
    call move_BAR
    call BAR
    
    call SCORE
    
    .if (chances == 0)
        mov funcEnd, 1
        jmp Third_One_End
    .endif
    
    .if (brick7 ==3 && brick8 ==3 && brick10 ==3 && brick11 ==3 && brick13 ==3 && brick14 ==3 && brick15 ==3 && brick16 ==3 && brick18 ==3 && brick19 ==3 && brick20 ==3 && brick21 ==3 && brick22 ==3)
    jmp Third_One_End
    .endif
    
jmp TIMEX

Third_One_End:
ret 
Third_one endp

Heart_White proc
  
    cmp chances, 1
    je one
    cmp chances, 2
    je two
	cmp chances, 3
    je three
	
	three:
	mov ah, 02h
	mov bx, 0
	mov dh, 2	;(X) ;rows 
	mov dl, 32	;(Y) ;columns
	int 10h
	
	mov ah,09       
	mov al,03       
	mov bl, 0fh		
	mov cx,01       
	int 10h
	
	one:
	mov ah, 02h
	mov bx, 0
	mov dh, 2	;(x) ;rows 
	mov dl, 33	;(y) ;columns
	int 10h
	
	mov ah,09       
	mov al,03       
	mov bl, 0fh		
	mov cx,01       
	int 10h
	
	two:
	mov ah, 02h
	mov bx, 0
	mov dh, 2	;(x) ;rows 
	mov dl, 34	;(y) ;columns
	int 10h
	
	mov ah,09       
	mov al,03       
	mov bl, 0fh		
	mov cx,01       
	int 10h
    
ret
Heart_White endp


BALL proc

    mov cx, x_start   
    mov dx, y_start   
    
    straight:
    mov ah, 0ch
    mov al, 0Fh      
    mov bh, 00h  
    int 10h
        
    inc cx         
    mov ax, cx
    sub ax, x_start
    cmp ax, volume_ball
    jng straight  
    
    mov cx, x_start
    inc dx
    mov ax, dx
    sub ax, y_start
    cmp ax, volume_ball
    jng straight

ret
BALL endp


clearBALL proc

    mov cx, x_start   ; x axis 
    mov dx, y_start   ; y axis 
    
 straight_sec:
    mov ah, 0ch
    mov al, 0h      ; color
    mov bh, 00h  
    int 10h
        
    inc cx         
    mov ax, cx
    sub ax, x_start
    cmp ax, volume_ball
    jng straight_sec  
    
    mov cx, x_start
    inc dx
    mov ax, dx
    sub ax, y_start
    cmp ax, volume_ball
    jng straight_sec

ret
clearBALL endp


remove_brick proc

    mov cx, brick_x   ; x axis 
    mov dx, brick_y   ; y axis 
    
 straight_brick:
    mov ah, 0ch
    mov al, 0h      ; color
    mov bh, 00h  
    int 10h
        
    inc cx         ; inc x axis
    mov ax, cx
    sub ax, brick_x
    cmp ax, w_brick
    jng straight_brick  ; if size not equal then go back to straight
    
    mov cx, brick_x
    inc dx
    mov ax, dx
    sub ax, brick_y
    cmp ax, h_brick
    jng straight_brick

ret
remove_brick endp


change_brick_color proc

    mov cx, brick_x   ; x axis 
    mov dx, brick_y   ; y axis 
    
 straight_brick:
    mov ah, 0ch
    mov al, 02h      
    mov bh, 00h  
    int 10h
        
    inc cx         		
    mov ax, cx
    sub ax, brick_x
    cmp ax, w_brick
    jng straight_brick  	
    
    mov cx, brick_x
    inc dx
    mov ax, dx
    sub ax, brick_y
    cmp ax, h_brick
    jng straight_brick

ret
change_brick_color endp

change_brick_color3 proc

    mov cx, brick_x   ; x axis 
    mov dx, brick_y   ; y axis 
    
 straight_2_brick:
    mov ah, 0ch
    mov al, 03h      	
    mov bh, 00h  
    int 10h
        
    inc cx         	
    mov ax, cx
    sub ax, brick_x
    cmp ax, w_brick
    jng straight_2_brick  
    
    mov cx, brick_x
    inc dx
    mov ax, dx
    sub ax, brick_y
    cmp ax, h_brick
    jng straight_2_brick

ret
change_brick_color3 endp


move_BAR_again proc

	mov cx,x_bar 			
	mov dx,y_bar 			 

make_straight:
	
	mov ah,0ch 					
	mov al,0h 					
	mov bh,00h 					 
	int 10h    					
	
	add cx, 1	
	    				 	
	mov ax,cx         			
	sub ax,x_bar
	cmp ax,bar_length
	jng make_straight
			
	mov cx,x_bar 
	add dx, 1	
	mov ax,dx            	    
	sub ax,y_bar
	cmp ax,bar_breadth
	jng make_straight

ret
move_BAR_again ENDP


BAR PROC 
		
	mov cx,x_bar 			
	mov dx,y_bar 			 
		
left_bar:
			
	mov ah,0ch 					 
	mov al,0fh 					
	mov bh,00h 					 
	int 10h    					 
			
	add cx, 1     				 	
	mov ax,cx 
	sub ax,x_bar
	cmp ax,bar_length
	jng left_bar
			
	mov cx,x_bar 		    
	add dx, 1       				 
			
	mov ax,dx            	     
	sub ax,y_bar
	cmp ax,bar_breadth
	jng left_bar
ret
BAR ENDP


move_BAR PROC               
			
	mov ah,01h
	int 16h
	jz exit_bar                                 
		                                    	
	mov ah,00h
	int 16h
		                                         
	cmp ah,4bh                              
	je move_bar_left
		                                 
	cmp ah,4dh                            
	je move_bar_right
	jmp exit_bar
		
		
move_bar_left:

	mov ax,bar_speed
	sub x_bar,ax
			
	cmp x_bar, 3
	jl bar_stop
	jmp exit_bar
			
bar_stop:
    mov x_bar, 3
    jmp exit_bar
			
move_bar_right:

	mov AX,bar_speed
	add x_bar,AX
			
	.if (Hittler == 0)
	cmp x_bar, 270
	jg bar_stop_
	
	jmp exit_bar
	.else 
	cmp x_bar, 290
	jg bar_stop_
	jmp exit_bar
			
.endif

bar_stop_:
mov x_bar, 265
jmp exit_bar
		
exit_bar:	
ret
move_BAR ENDP


lightningMcQueen proc

    mov ax, velocity_ball_x   
    add x_start , ax
	
    cmp x_start, 01h      
    jl neg_x
    
    mov ax, screenlength         
    cmp x_start, ax
    jg neg_x
    
    
    mov ax, velocity_ball_y    
    add y_start , ax
	
    cmp y_start, 28
    jl neg_y
    
    mov ax, screenbreadth
    cmp y_start, ax
    jg neg_y
    
    mov ax, ball_movement_
    add ball_movement, ax

    mov ax, y_start
    add ax, volume_ball
    cmp ax, y_bar
    jng collide_condition
   
    mov ax, x_bar
    add ax, bar_length
    cmp x_start, ax
    jg collide_condition
    
    mov ax, x_start
    add ax,volume_ball
    cmp ax, x_bar
    jng collide_condition
    neg velocity_ball_y 
    
collide_condition:
	
    .if(Hittler == 0)
        call col_1
    .elseif(Hittler == 1) 
        call col_2
	.else
		call col_3
    .endif
    
     mov ax, y_start
     add ax, volume_ball
    .if (ax > 197)
        call chime
        dec chances
        neg velocity_ball_y
    .endif    
    
    .if (chances == 2)
    mov x_life, 35
    mov y_life, 8
    call Heart_White
    .endif
    
    .if (chances == 1)
    mov x_life, 20
    mov y_life, 8
    call Heart_White
    .endif
    
    .if (chances == 0)
    mov x_life, 5
    mov y_life, 8
    call Heart_White
    .endif
    
ret
    neg_x:
    neg velocity_ball_x
    ret
    
    neg_y:
    neg velocity_ball_y
    neg ball_movement_
    ret
    
lightningMcQueen endp


col_1 proc

    .if (brick18 == 0)
        mov bx, x_start 
        mov ax, bx    
        add ax, volume_ball 
        mov dx, y_start 
        mov cx, dx
        add cx, volume_ball
        .if ( ax > 30 && bx < 80 && cx>30 && dx<50)
             neg velocity_ball_y
             mov brick_x, 30
             mov brick_y, 30
             call remove_brick
             add Variable_score, 10
              mov brick18, 1
              call chime
        .endif
    .endif
    
    .if (brick19 == 0)
        mov ax, x_start
        mov bx, ax    
        add bx, volume_ball 
        mov cx, y_start 
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 81 && ax < 131 && dx>30 && cx<50)
             neg velocity_ball_y
             mov brick_x, 81
             mov brick_y, 30
             call remove_brick
             add Variable_score, 20
              mov brick19, 1
              call chime
        .endif
    .endif
    
    .if (brick20 == 0)
        mov ax, x_start 
        mov bx, ax      
        add bx, volume_ball 
        mov cx, y_start   
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 132 && ax < 182 && dx>30 && cx<50)
             neg velocity_ball_y
             mov brick_x, 132
             mov brick_y, 30
             call remove_brick
             add Variable_score, 30
              mov brick20, 1
              call chime
        .endif
    .endif
    
    
    .if (brick21 == 0)
        mov ax, x_start   
        mov bx, ax       
        add bx, volume_ball 
        mov cx, y_start  
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 183 && ax < 233 && dx>30 && cx<50)
             neg velocity_ball_y
             mov brick_x, 183
             mov brick_y, 30
             call remove_brick
             add Variable_score, 10
              mov brick21, 1
              call chime
        .endif
    .endif
    
    .if (brick22 == 0)
        mov ax, x_start  
        mov bx, ax      
        add bx, volume_ball  
        mov cx, y_start   
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 234 && ax < 284 && dx>30 && cx<50)
             neg velocity_ball_y
             mov brick_x, 234
             mov brick_y, 30
             call remove_brick
             add Variable_score, 20
              mov brick22, 1
              call chime
        .endif
    .endif
    
    .if (brick13 == 0)
        mov ax, x_start   
        mov bx, ax      
        add bx, volume_ball 
        mov cx, y_start   
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 56 && ax < 106 && dx>51 && cx<71)
             neg velocity_ball_y
             mov brick_x, 56
             mov brick_y, 51
             call remove_brick
             add Variable_score, 10
              mov brick13, 1
              call chime
        .endif
    .endif
    
    .if (brick14 == 0)
        mov ax, x_start 
        mov bx, ax        
        add bx, volume_ball  
        mov cx, y_start   
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 107 && ax < 157 && dx>51 && cx<71)
             neg velocity_ball_y
             mov brick_x, 107
             mov brick_y, 51
             call remove_brick
             add Variable_score, 30
              mov brick14, 1
              call chime
        .endif
    .endif
    
    .if (brick15 == 0)
        mov ax, x_start  
        mov bx, ax        
        add bx, volume_ball 
        mov cx, y_start   
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 158 && ax < 208 && dx>51 && cx<71)
             neg velocity_ball_y
             mov brick_x, 158
             mov brick_y, 51
             call remove_brick
             add Variable_score, 10
              mov brick15, 1
              call chime
        .endif
    .endif
    
    .if (brick16 == 0)
        mov ax, x_start   
        mov bx, ax       
        add bx, volume_ball 
        mov cx, y_start    
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 209 && ax < 259 && dx>51 && cx<71)
             neg velocity_ball_y
             mov brick_x, 209
             mov brick_y, 51
             call remove_brick
             add Variable_score, 20
              mov brick16, 1
              call chime
        .endif
    .endif
	
	     .if (brick7 == 0)
        mov ax, x_start     
        mov bx, ax      
        add bx, volume_ball 
        mov cx, y_start    
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 30 && ax < 80 && dx>72 && cx<92)
             neg velocity_ball_y
             mov brick_x, 30
             mov brick_y, 72
             call remove_brick
             add Variable_score, 30
              mov brick7, 1
              call chime
        .endif
    .endif
    
    .if (brick8 == 0)
        mov ax, x_start    
        mov bx, ax        
        add bx, volume_ball   
        mov cx, y_start    
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 81 && ax < 131 && dx>72 && cx<92)
             neg velocity_ball_y
             mov brick_x, 81
             mov brick_y, 72
             call remove_brick
             add Variable_score, 10
              mov brick8, 1
              call chime
        .endif
    .endif
    
    .if (brick10 == 0)
        mov ax, x_start   
        mov bx, ax          
        add bx, volume_ball  
        mov cx, y_start    
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 183 && ax < 233 && dx>72 && cx<92)
             neg velocity_ball_y
             mov brick_x, 183
             mov brick_y, 72
             call remove_brick
             add Variable_score, 30
              mov brick10, 1
              call chime
        .endif
    .endif
	
	    .if (brick11 == 0)
        mov ax, x_start    
        mov bx, ax       
        add bx, volume_ball  
        mov cx, y_start   
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 234 && ax < 284 && dx>72 && cx<92)
             neg velocity_ball_y
             mov brick_x, 234
             mov brick_y, 72
             call remove_brick
             add Variable_score, 10
              mov brick11, 1
              call chime
        .endif
    .endif
    
ret
col_1 endp

col_2 proc

 .if (brick18 != 2)
        mov ax, x_start    
        mov bx, ax       
        add bx, volume_ball   
        mov cx, y_start     
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 30 && ax < 80 && dx>30 && cx<53)
             neg velocity_ball_y
             inc brick18
             mov brick_x, 30
             mov brick_y, 30
             .if(brick18==2)
                call remove_brick
                add Variable_score, 10
                call chime
            .else
                call change_brick_color
            .endif
        .endif
    .endif
    
    .if (brick19 != 2)
        mov ax, x_start    
        mov bx, ax       
        add bx, volume_ball 
        mov cx, y_start      
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 81 && ax < 131 && dx>30 && cx<53)
             neg velocity_ball_y
             inc brick19
             mov brick_x, 81
             mov brick_y, 30
             .if(brick19==2)
                call remove_brick
                add Variable_score, 30
                call chime
            .else
                call change_brick_color
            .endif
        .endif
    .endif
    
    .if (brick20 != 2)
        mov ax, x_start  
        mov bx, ax       
        add bx, volume_ball  
        mov cx, y_start   
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 132 && ax < 182 && dx>30 && cx<53)
             neg velocity_ball_y
             inc brick20
             mov brick_x, 132
             mov brick_y, 30
             .if(brick20==2)
                call remove_brick
                add Variable_score, 10
                call chime
            .else
                call change_brick_color
            .endif
        .endif
    .endif
    
    
    .if (brick21 != 2)
        mov ax, x_start   
        mov bx, ax         
        add bx, volume_ball   
        mov cx, y_start    
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 183 && ax < 233 && dx>30 && cx<53)
             neg velocity_ball_y
             inc brick21
             mov brick_x, 183
             mov brick_y, 30
             .if(brick21==2)
                call remove_brick
                add Variable_score, 10
                call chime
            .else
                call change_brick_color
            .endif
        .endif
    .endif
    
    .if (brick22 != 2)
        mov ax, x_start    
        mov bx, ax         
        add bx, volume_ball  
        mov cx, y_start   
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 234 && ax < 284 && dx>30 && cx<53)
             neg velocity_ball_y
             inc brick22
             mov brick_x, 234
             mov brick_y, 30
             .if(brick22==2)
                call remove_brick
                add Variable_score, 10
                call chime
            .else
                call change_brick_color
            .endif
        .endif
    .endif
    
    .if (brick13 != 2)
        mov ax, x_start      
        mov bx, ax          
        add bx, volume_ball  
        mov cx, y_start    
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 56 && ax < 106 && dx>51 && cx<74)
             neg velocity_ball_y
             inc brick13
             mov brick_x, 56
             mov brick_y, 51
             .if(brick13==2)
                call remove_brick
                add Variable_score, 10
                call chime
            .else
                call change_brick_color
            .endif
        .endif
    .endif
    
    .if (brick14 != 2)
        mov ax, x_start   
        mov bx, ax        
        add bx, volume_ball 
        mov cx, y_start    
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 107 && ax < 157 && dx>51 && cx<74)
             neg velocity_ball_y
             inc brick14
             mov brick_x, 107
             mov brick_y, 51
             .if(brick14==2)
                call remove_brick
                add Variable_score, 30
                call chime
            .else
                call change_brick_color
            .endif
        .endif
    .endif
    
    .if (brick15 != 2)
        mov ax, x_start    
        mov bx, ax      
        add bx, volume_ball   
        mov cx, y_start      
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 158 && ax < 208 && dx>51 && cx<74)
             neg velocity_ball_y
             inc brick15
             mov brick_x, 158
             mov brick_y, 51
             .if(brick15==2)
                call remove_brick
                add Variable_score, 20
                call chime
            .else
                call change_brick_color
            .endif
        .endif
    .endif
    
    .if (brick16 != 2)
        mov ax, x_start   
        mov bx, ax          
        add bx, volume_ball   
        mov cx, y_start     
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 209 && ax < 259 && dx>51 && cx<74)
             neg velocity_ball_y
             inc brick16
             mov brick_x, 209
             mov brick_y, 51
             .if(brick16==2)
                call remove_brick
                add Variable_score, 10
                call chime
            .else
                call change_brick_color
            .endif
        .endif
    .endif
    
	 .if (brick7 != 2)
        mov ax, x_start     
        mov bx, ax         
        add bx, volume_ball 
        mov cx, y_start    
        mov dx, cx
        add dx, volume_ball
		
		
        .if ( bx > 30 && ax < 80 && dx>72 && cx<95)
             neg velocity_ball_y
             inc brick7
             mov brick_x, 30
             mov brick_y, 72
             .if(brick7==2)
                call remove_brick
                add Variable_score, 30
                call chime
            .else
                call change_brick_color
            .endif
        .endif
    .endif
    
    .if (brick8!= 2)
        mov ax, x_start     
        mov bx, ax        
        add bx, volume_ball 
        mov cx, y_start   
        mov dx, cx
        add dx, volume_ball
		
        .if ( bx > 81 && ax < 131 && dx>72 && cx<95)
             neg velocity_ball_y
             inc brick8
             mov brick_x, 81
             mov brick_y, 72
             .if(brick8==2)
                call remove_brick
                add Variable_score, 10
                call chime
            .else
                call change_brick_color
            .endif
        .endif
    .endif
    
    .if (brick10 != 2)
        mov ax, x_start   
        mov bx, ax      
        add bx, volume_ball 
        mov cx, y_start   
        mov dx, cx
        add dx, volume_ball
		
        .if ( bx > 183 && ax < 233 && dx>72 && cx<95)
             neg velocity_ball_y
             inc brick10
             mov brick_x, 183
             mov brick_y, 72
             .if(brick10==2)
                call remove_brick
                add Variable_score, 10
                call chime
            .else
                call change_brick_color
            .endif
        .endif
    .endif
    
    .if (brick11 != 2)
        mov ax, x_start     
        mov bx, ax       
        add bx, volume_ball  
        mov cx, y_start     
        mov dx, cx
        add dx, volume_ball
		
        .if ( bx > 234 && ax < 284 && dx>72 && cx<95)
            inc brick11
             neg velocity_ball_y
             mov brick_x, 234
             mov brick_y, 72
             .if(brick11==2)
                call remove_brick
                add Variable_score, 10
                call chime
            .else
                call change_brick_color
            .endif
        .endif
    .endif
   
ret

col_2 endp

col_3 proc

    mov bx, 0
    mov initial_brick, 72
    mov initial_brick_stx, 132
l017:
    mov bx, initial_brick_stx  
    mov XX, bx          
    mov bx, 0
    
l117:
    mov ah, 0Ch
    mov al, 0fh			
    mov cx, XX         
    mov dx, initial_brick          
    int 10h
    
    inc XX
    inc bx
    cmp bx,50
    je l217
    jne l117
    
l217:
    inc initial_brick
    cmp initial_brick, 92
    je s17
    jne l017
    
    s17:
	
	    .if (brick18 != 3)
        mov ax, x_start   
        mov bx, ax       
        add bx, volume_ball   
        mov cx, y_start   
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 30 && ax < 80 && dx>30 && cx<53)
             neg velocity_ball_y
             inc brick18
             mov brick_x, 30
             mov brick_y, 30
             .if(brick18==3)
                call remove_brick
                add Variable_score, 10
                call chime
             .elseif(brick18 == 2)
                call change_brick_color
			.else 
				call change_brick_color3
            .endif
        .endif
    .endif
    
    .if (brick19 != 3)
        mov ax, x_start    
        mov bx, ax        
        add bx, volume_ball   
        mov cx, y_start   
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 81 && ax < 131 && dx>30 && cx<53)
             neg velocity_ball_y
             inc brick19
             mov brick_x, 81
             mov brick_y, 30
             .if(brick19==3)
                call remove_brick
                add Variable_score, 30
                call chime
             .elseif(brick19 == 2)
                call change_brick_color
			.else 
				call change_brick_color3
            .endif
        .endif
    .endif
    
    .if (brick20 != 3)
        mov ax, x_start     
        mov bx, ax         
        add bx, volume_ball   
        mov cx, y_start   
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 132 && ax < 182 && dx>30 && cx<53)
             neg velocity_ball_y
             inc brick20
             mov brick_x, 132
             mov brick_y, 30
             .if(brick20==3)
                call remove_brick
                add Variable_score, 10
                call chime
             .elseif(brick20 == 2)
                call change_brick_color
			.else 
				call change_brick_color3
            .endif
        .endif
    .endif
    
    
    .if (brick21 != 3)
        mov ax, x_start     
        mov bx, ax        
        add bx, volume_ball  
        mov cx, y_start    
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 183 && ax < 233 && dx>30 && cx<53)
             neg velocity_ball_y
             inc brick21
             mov brick_x, 183
             mov brick_y, 30
             .if(brick21==3)
                call remove_brick
                add Variable_score, 10
                call chime
             .elseif(brick21 == 2)
                call change_brick_color
			.else 
				call change_brick_color3
            .endif
        .endif
    .endif
    
    .if (brick22 != 3)
        mov ax, x_start   
        mov bx, ax          
        add bx, volume_ball  
        mov cx, y_start    
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 234 && ax < 284 && dx>30 && cx<53)
             neg velocity_ball_y
             inc brick22
             mov brick_x, 234
             mov brick_y, 30
             .if(brick22==3)
                call remove_brick
                add Variable_score, 10
                call chime
             .elseif(brick22 == 2)
                call change_brick_color
			.else 
				call change_brick_color3
            .endif
        .endif
    .endif
   
    
    .if (brick13 != 3)
        mov ax, x_start   
        mov bx, ax        
        add bx, volume_ball  
        mov cx, y_start  
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 56 && ax < 106 && dx>51 && cx<74)
             neg velocity_ball_y
             inc brick13
             mov brick_x, 56
             mov brick_y, 51
             .if(brick13==3)
                call remove_brick
                add Variable_score, 10
                call chime
             .elseif(brick13 == 2)
                call change_brick_color
			.else 
				call change_brick_color3
            .endif
        .endif
    .endif
    
    .if (brick14 != 3)
        mov ax, x_start    
        mov bx, ax         
        add bx, volume_ball 
        mov cx, y_start    
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 107 && ax < 157 && dx>51 && cx<74)
             neg velocity_ball_y
             inc brick14
             mov brick_x, 107
             mov brick_y, 51
             .if(brick14==3)
                call remove_brick
                add Variable_score, 30
                call chime
             .elseif(brick14 == 2)
                call change_brick_color
			.else 
				call change_brick_color3
            .endif
        .endif
    .endif
    
    .if (brick15 != 3)
        mov ax, x_start      
        mov bx, ax        
        add bx, volume_ball   
        mov cx, y_start    
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 158 && ax < 208 && dx>51 && cx<74)
             neg velocity_ball_y
             inc brick15
             mov brick_x, 158
             mov brick_y, 51
             .if(brick15==3)
                call remove_brick
                add Variable_score, 20
                call chime
             .elseif(brick15 == 2)
                call change_brick_color
			.else 
				call change_brick_color3
            .endif
        .endif
    .endif
    
    .if (brick16 != 3)
        mov ax, x_start     
        mov bx, ax         
        add bx, volume_ball  
        mov cx, y_start    
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 209 && ax < 259 && dx>51 && cx<74)
             neg velocity_ball_y
             inc brick16
             mov brick_x, 209
             mov brick_y, 51
             .if(brick16==3)
                call remove_brick
                add Variable_score, 10
                call chime
             .elseif(brick16 == 2)
                call change_brick_color
			.else 
				call change_brick_color3
            .endif
        .endif
    .endif
	
	 .if (brick7 != 3)
        mov ax, x_start     
        mov bx, ax          
        add bx, volume_ball   
        mov cx, y_start      
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 30 && ax < 80 && dx>72 && cx<95)
             neg velocity_ball_y
             inc brick7
             mov brick_x, 30
             mov brick_y, 72
             .if(brick7==3)
                call remove_brick
                add Variable_score, 30
                call chime
             .elseif(brick7 == 2)
                call change_brick_color
			.else 
				call change_brick_color3
            .endif
        .endif
    .endif
    
    .if (brick8!= 3)
        mov ax, x_start    
        mov bx, ax          
        add bx, volume_ball  
        mov cx, y_start     
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 81 && ax < 131 && dx>72 && cx<95)
             neg velocity_ball_y
             inc brick8
             mov brick_x, 81
             mov brick_y, 72
             .if(brick8==3)
                call remove_brick
                add Variable_score, 10
                call chime
             .elseif(brick8 == 2)
                call change_brick_color
			.else 
				call change_brick_color3
            .endif
        .endif
    .endif
    
    .if (brick9 == 0)
        mov ax, x_start     
        mov bx, ax      
        add bx, volume_ball   
        mov cx, y_start   
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 132 && ax < 182 && dx>72 && cx<95)
             neg velocity_ball_y
             mov brick_x, 132
             mov brick_y, 72

        .endif
    .endif
    
    .if (brick10 != 3)
        mov ax, x_start    
        mov bx, ax         
        add bx, volume_ball  
        mov cx, y_start      
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 183 && ax < 233 && dx>72 && cx<95)
             neg velocity_ball_y
             inc brick10
             mov brick_x, 183
             mov brick_y, 72
             .if(brick10==3)
                call remove_brick
                add Variable_score, 10
                call chime
             .elseif(brick10 == 2)
                call change_brick_color
			.else 
				call change_brick_color3
            .endif
        .endif
    .endif
    
    .if (brick11 != 3)
        mov ax, x_start      
        mov bx, ax       
        add bx, volume_ball 
        mov cx, y_start
        mov dx, cx
        add dx, volume_ball
        .if ( bx > 234 && ax < 284 && dx>72 && cx<95)
            inc brick11
             neg velocity_ball_y
             mov brick_x, 234
             mov brick_y, 72
             .if(brick11==3)
                call remove_brick
                add Variable_score, 10
                call chime
             .elseif(brick11 == 2)
                call change_brick_color
			.else 
				call change_brick_color3
            .endif
        .endif
    .endif
    
ret

col_3 endp


chime proc

        mov     al, 182
        out     43h, al         
        mov     ax, 150         
        out     42h, al         
        mov     al, ah          
        out     42h, al 
        in      al, 61h         
        or      al, 011b   
        out     61h, al 
		mov bx, 1
gap:
        mov     cx, 65535
gaps:
        dec     cx
        jne     gaps
        dec     bx
        jne     gap
        in      al, 61h         
        and     al, 11111100b   
        out     61h, al         
        ret
chime endp


background proc

    mov ah, 06h
    mov al, 0       ;  background 
    mov cx, 0
    mov dx, 50000	; 50000
    mov bh, 0h		; 52h   ;   color
    int 10h

ret
background endp


Lives_Func proc
    ;--------------------------hearts/Lives_Func
	
	mov ah, 02h
	mov bx, 0
	mov dh, 2	;(X) ;rows 
	mov dl, 34	;(Y) ;columns
	int 10h

	MOV AH, 09h       ;FUNCTION 9
	MOV AL, 03       ;HEART ASCII
	mov bl, 4h		;BL is for color, BH is for page number
	MOV CX, 01       ;Printing 1 CHARACTER
	INT 10H         
	
	mov ah, 02h
	mov bx, 0
	mov dh, 2	;(X) ;rows 
	mov dl, 33	;(Y) ;columns
	int 10h
	
	MOV AH,09       
	MOV AL,03       
	mov bl, 4h		
	MOV CX,01       
	INT 10H  
	
	mov ah, 02h
	mov bx, 0
	mov dh, 2	;(X) ;rows 
	mov dl, 32	;(Y) ;columns
	int 10h
	
	MOV AH,09       ;FUNCTION 9
	MOV AL,03       ;HEART ASCII
	mov bl, 4h		;BL is for color, BH is for page number
	MOV CX,01       ;Printing 1 CHARACTER
	INT 10H

ret
Lives_Func endp

  

First_level proc
    
    mov ah,02h   
    mov bx,0
    mov dh,2   
    mov dl, 17  
    int 10h
    
    lea dx, showLevel1       
    mov ah, 09h
    int 21h    


	
    mov ah,02h   
    mov bx,0
    mov dh,2  
    mov dl, 3  
    int 10h
    
    lea dx, scorestr        
    mov ah, 09h
    int 21h  

ret
First_level endp



Second_level proc
    
    mov ah,02h   
    mov bx,0
    mov dh,2   
    mov dl, 17   
    int 10h
    
    lea dx, showLevel2      
    mov ah, 09h
    int 21h  

    
    mov ah,02h   
    mov bx,0
    mov dh,2   
    mov dl, 3   
    int 10h	
	
    lea dx, scorestr     
    mov ah, 09h
    int 21h 

ret
Second_level endp



Third_level proc
    
    mov ah,02h   
    mov bx,0
    mov dh,2  
    mov dl, 17   
    int 10h
    
    lea dx, showLevel3       
    mov ah, 09h
    int 21h  


    
    mov ah,02h  
    mov bx,0
    mov dh,2   
    mov dl, 3   
    int 10h	
	
    lea dx, scorestr        
    mov ah, 09h
    int 21h 

ret
Third_level endp


SCORE proc
  
    
    mov ah,02h   ; for cursor 
    mov bx,0
    mov dh,2   ; y-axis
    mov dl, 9   ; x - axis
    int 10h
    
    mov bx, 0
    mov cx, 0
    mov ax, 0
    mov dx, 0
    
    mov ax, Variable_score
	
   MOV BX, 10     ;Initializes divisor
   MOV DX, 0000H    ;Clears DX
   MOV CX, 0000H    ;Clears CX
   
   
    ;SCORE PRINTING
scoreprint1: 
   mov dx, 0000H
   div bx 
   push dx
   inc cx 
   cmp ax, 0 
   jne scoreprint1 
    
scoreprint2: 
   pop dx 
   add dx, 30h
   mov ah, 02h     
   int 21h 
   loop scoreprint2
   
ret
SCORE endp

boxes proc
     
    mov bx, 0
    mov initial_brick, 30
    mov initial_brick_stx, 30
	
l04:
    mov bx, initial_brick_stx  
    mov XX, bx         
    mov bx, 0
    
l14:
    mov ah, 0Ch
    mov al, 0Ah			
    mov cx, XX          
    mov dx, initial_brick            
    int 10h
    
    inc XX
    inc bx
    cmp bx,50
    je l24
    jne l14
    
l24:
    inc initial_brick
    cmp initial_brick, 50
    je s4
    jne l04
    
    s4:
    
  
    
    mov bx, 0
    mov initial_brick, 30
    mov initial_brick_stx, 81
l05:
    mov bx, initial_brick_stx  
    mov XX, bx         
    mov bx, 0
    
l15:
    mov ah, 0Ch
    mov al, 0Ah			
    mov cx, XX         
    mov dx, initial_brick        
    int 10h
    
    inc XX
    inc bx
    cmp bx,50
    je l25
    jne l15
    
l25:
    inc initial_brick
    cmp initial_brick, 50
    je s5
    jne l05
    
    s5:
    
    
  
    
    mov bx, 0
    mov initial_brick, 30
    mov initial_brick_stx, 132
l06:
    mov bx, initial_brick_stx  
    mov XX, bx        
    mov bx, 0
    
l16:
    mov ah, 0Ch
    mov al, 0Ah			
    mov cx, XX          
    mov dx, initial_brick        
    int 10h
    
    inc XX
    inc bx
    cmp bx,50
    je l26
    jne l16
    
l26:
    inc initial_brick
    cmp initial_brick, 50
    je s6
    jne l06
    
    s6:
    
   
    
    mov bx, 0
    mov initial_brick, 30
    mov initial_brick_stx, 183
l07:
    mov bx, initial_brick_stx  
    mov XX, bx        
    mov bx, 0
    
l17:
    mov ah, 0Ch
    mov al, 0Ah			
    mov cx, XX         
    mov dx, initial_brick       
    int 10h
    
    inc XX
    inc bx
    cmp bx,50
    je l27
    jne l17
    
l27:
    inc initial_brick
    cmp initial_brick, 50
    je s7
    jne l07
    
    s7:
    
    mov bx, 0
    mov initial_brick, 30
    mov initial_brick_stx, 234
l08:
    mov bx, initial_brick_stx  
    mov XX, bx        
    mov bx, 0
    
l18:
    mov ah, 0Ch
    mov al, 0Ah			
    mov cx, XX          
    mov dx, initial_brick        
    int 10h
    
    inc XX
    inc bx
    cmp bx,50
    je l28
    jne l18
    
l28:
    inc initial_brick
    cmp initial_brick, 50
    je s8
    jne l08
    
    s8:
    
 
    mov bx, 0
    mov initial_brick, 51
    mov initial_brick_stx, 56
l010:
    mov bx, initial_brick_stx  
    mov XX, bx         
    mov bx, 0
    
l110:
    mov ah, 0Ch
    mov al, 0Ah			
    mov cx, XX         
    mov dx, initial_brick        
    int 10h
    
    inc XX
    inc bx
    cmp bx,50
    je l210
    jne l110
    
l210:
    inc initial_brick
    cmp initial_brick, 71
    je s10
    jne l010
    
    s10:
    
   
    mov bx, 0
    mov initial_brick, 51
    mov initial_brick_stx, 107
l011:
    mov bx, initial_brick_stx  
    mov XX, bx         
    mov bx, 0
    
l111:
    mov ah, 0Ch
    mov al, 0Ah			
    mov cx, XX         
    mov dx, initial_brick        
    int 10h
    
    inc XX
    inc bx
    cmp bx,50
    je l211
    jne l111
    
l211:
    inc initial_brick
    cmp initial_brick, 71
    je s11
    jne l011
    
    s11:
    
    
  
    mov bx, 0
    mov initial_brick, 51
    mov initial_brick_stx, 158
l012:
    mov bx, initial_brick_stx  
    mov XX, bx         
    mov bx, 0
    
l112:
    mov ah, 0Ch
    mov al, 0Ah			
    mov cx, XX         
    mov dx, initial_brick         
    int 10h
    
    inc XX
    inc bx
    cmp bx,50
    je l212
    jne l112
    
l212:
    inc initial_brick
    cmp initial_brick, 71
    je s12
    jne l012
    
    s12:
    
   
    mov bx, 0
    mov initial_brick, 51
    mov initial_brick_stx, 209
l013:
    mov bx, initial_brick_stx  
    mov XX, bx        
    mov bx, 0
    
l113:
    mov ah, 0Ch
    mov al, 0Ah			
    mov cx, XX         
    mov dx, initial_brick       
    int 10h
    
    inc XX
    inc bx
    cmp bx,50
    je l213
    jne l113
    
l213:
    inc initial_brick
    cmp initial_brick, 71
    je s13
    jne l013
    
    s13:
    
    mov bx, 0
    mov initial_brick, 72
    mov initial_brick_stx, 30
l015:
    mov bx, initial_brick_stx  
    mov XX, bx         
    mov bx, 0
    
l115:
    mov ah, 0Ch
    mov al, 0Ah			
    mov cx, XX         
    mov dx, initial_brick        
    int 10h
    
    inc XX
    inc bx
    cmp bx,50
    je l215
    jne l115
    
l215:
    inc initial_brick
    cmp initial_brick, 92
    je s15
    jne l015
    
    s15:
    
    mov bx, 0
    mov initial_brick, 72
    mov initial_brick_stx, 81
l016:
    mov bx, initial_brick_stx  
    mov XX, bx         
    mov bx, 0
    
l116:
    mov ah, 0Ch
    mov al, 0Ah			
    mov cx, XX         
    mov dx, initial_brick        
    int 10h
    
    inc XX
    inc bx
    cmp bx,50
    je l216
    jne l116
    
l216:
    inc initial_brick
    cmp initial_brick, 92
    je s16
    jne l016
    
    s16:
    
    mov bx, 0
    mov initial_brick, 72
    mov initial_brick_stx, 183
l018:
    mov bx, initial_brick_stx  
    mov XX, bx        
    mov bx, 0
    
l118:
    mov ah, 0Ch
    mov al, 0Ah			
    mov cx, XX         
    mov dx, initial_brick        
    int 10h
    
    inc XX
    inc bx
    cmp bx,50
    je l218
    jne l118
    
l218:
    inc initial_brick
    cmp initial_brick, 92
    je s18
    jne l018
    
    s18:
    
    mov bx, 0
    mov initial_brick, 72
    mov initial_brick_stx, 234
l019:
    mov bx, initial_brick_stx  
    mov XX, bx         
    mov bx, 0
    
l119:
    mov ah, 0Ch
    mov al, 0Ah			
    mov cx, XX         
    mov dx, initial_brick
    int 10h
    
    inc XX
    inc bx
    cmp bx,50
    je l219
    jne l119
    
l219:
    inc initial_brick
    cmp initial_brick, 92
    je s19
    jne l019
    
    s19:
 
ret
boxes endp


endfirstlevel proc

    mov ah, 06h
    mov al, 0         ;  background 
    mov cx, 0
    mov dx, 50000
    mov bh, 0h     ;   color
    int 10h
    
	mov ah, 02h
	mov bx, 0
	mov dh, 7	;(X) ;rows 
	mov dl, 6	;(Y) ;columns
	int 10h
	
	lea dx, passing_1
	mov ah, 09h
	int 21h
	
mov bx, 0
Sitarayend:

	cmp bx, 100
	je cursooend
	mov ah, 0ch
	mov al, 0dh
	mov cx, xAxis
	mov dx, yAxis
	int 10h
	inc bx

	add xAxis, 7

	sub yAxis, 12

	
jmp Sitarayend

cursooend:
	mov xAxis, 4
	mov yAxis, 7
;CURSOR POSITION
	mov ah, 02h
	mov bx, 0
	mov dh, 100	;(X) ;rows 
	mov dl, 100	;(Y) ;columns
	int 10h
	
label_enter:

    mov al, 0
    mov ah, 00
    int 16h
	
    mov ah, 02
    cmp al, 13
    jne label_enter

ret
endfirstlevel endp


endsecondlevel proc
		
	mov ah, 06h
    mov al, 0         ;  background 
    mov cx, 0
    mov dx, 50000
    mov bh, 0h     ;   color
    int 10h
    
	mov ah, 02h
	mov bx, 0
	mov dh, 7	;(X) ;rows 
	mov dl, 6	;(Y) ;columns
	int 10h
	
	lea dx, passing_2
	mov ah, 09h
	int 21h
	
mov bx, 0
Sitarayend2:

	cmp bx, 100
	je cursooend2
	mov ah, 0ch
	mov al, 0dh
	mov cx, xAxis
	mov dx, yAxis
	int 10h
	inc bx
	
	add xAxis, 7
	sub yAxis, 12
	
jmp Sitarayend2

cursooend2:
	mov xAxis, 4
	mov yAxis, 7
;CURSOR POSITION
	mov ah, 02h
	mov bx, 0
	mov dh, 100	;(X) ;rows 
	mov dl, 100	;(Y) ;columns
	int 10h
		
label_enter_:
    mov al, 0
    mov ah, 00
    int 16h
    mov ah, 02
    cmp al, 13
    jne label_enter_

ret
endsecondlevel endp

endthirdlevel proc
		
	mov ah, 06h
    mov al, 0         ;  background 
    mov cx, 0
    mov dx, 50000
    mov bh, 0h     ;   color
    int 10h
    
	mov ah, 02h
	mov bx, 0
	mov dh, 7	;(X) ;rows 
	mov dl, 4	;(Y) ;columns
	int 10h
	
	lea dx, passing_3
	mov ah, 09h
	int 21h
	
mov bx, 0
Sitarayend3:

	cmp bx, 100
	je cursooend3
	mov ah, 0ch
	mov al, 0dh
	mov cx, xAxis
	mov dx, yAxis
	int 10h
	inc bx
	
	add xAxis, 7
	sub yAxis, 12
	
jmp Sitarayend3

cursooend3:
	mov xAxis, 4
	mov yAxis, 7
;CURSOR POSITION
	mov ah, 02h
	mov bx, 0
	mov dh, 100	;(X) ;rows 
	mov dl, 100	;(Y) ;columns
	int 10h
		
label_enter_:
    mov al, 0
    mov ah, 00
    int 16h
    mov ah, 02
    cmp al, 13
    jne label_enter_

ret
endthirdlevel endp

set_zero proc

mov brick1, 0
mov brick2,0 
mov brick3,0 
mov brick4 , 0 
mov brick5 ,0 
mov brick6 ,0
mov brick7, 0
mov brick8,0
mov brick9 ,0
mov brick10, 0
mov brick11, 0
mov brick12, 0 
mov brick13, 0
mov brick14 ,0
mov brick15 , 0
mov brick16 , 0
mov brick17 , 0
mov brick18 , 0
mov brick19 , 0
mov brick20 , 0 
mov brick21 ,0
mov  brick22 , 0
mov chances, 3

ret
set_zero endp


main proc

mov ax, @data
mov ds, ax

;Video Mode
mov ah, 00h
mov al, 13h
int 10h

CALL Page1          
CALL First_one
    cmp funcEnd, 1   
    je exit
	
mov Hittler, 1
CALL endfirstlevel

CALL set_zero    
CALL Second_one
    cmp funcEnd, 1
    je exit
	
	mov Hittler, 2
CALL endsecondlevel
	
	CALL set_zero
	CALL Third_one
	cmp funcEnd, 2
	je exit 
CALL endthirdlevel

main endp

Jumps:

	CALL Page2

exit::
mov ah, 4ch
int 21h
end
