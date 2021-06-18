#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force
SetTimer, WatchPOV, 5
return

;------------------------------
;hotkeys for ps4 controller
;only in use while RunAllCondensed.ahk is also running, but not always
;CONTROLS:	see below
;------------------------------
/*
      _= 7 =_                               _= 8 =_
     / _ 5 _ \                             / _ 6 _ \
   +.-'_____'-.---------------------------.-'_____'-.+
  /   |     |  '.        S O N Y        .'  |     |   \
 / ___|POV0 |___ \         14          / ___|  4  |___ \
/ |             | ;     TOUCHPAD      ; |             | ;
|POV27000  POV9000|   9          10     | 1         3 | |
| |___       ___| ; SELECT      START ; |___       ___| ;
|\    POV18000   /  _              _   \    |  2  |    /|
| \   |_____|  .','" "',   13   ,'" "', '.  |_____|  .' |
|  '-.______.-' /       \  PS  /       \  '-._____.-'   |
|               |   11  |------|   12  |                |
|              /\       /      \       /\               |
|             /  '.___.'        '.___.'  \              |
|            /                            \             |
 \          /                              \           /
  \________/                                \_________/
  1: page left
  2: pause/play spotify
  3: page right
  4: next song/prev song on spotify
  6: minimize/maximize tachiyomi
  POV9000: move discord/spotify to right monitor
  POV18000: open screen dimmer
  POV27000: move discord/spotify to left monitor
*/

;with RunAllCondensed.ahk running, this stuff turns pages/minimizes/etc...
Joy1::Numpad2	;page left
Joy2::Numpad7	;pause/play spotify
Joy3::Numpad3	;page right
Joy4::Numpad8	;next song/prev song on spotify
Joy6::	;minimize/maximize tachiyomi
{
    KeyWait, Joy6			; wait for Numpad0 to be released
    KeyWait, Joy6, D T0.1	; and pressed again within 0.1 seconds
    if ErrorLevel{				; timed-out (only a single press)
        wintitleBS := "BlueStacks ahk_exe Bluestacks.exe"	;minimize BlueStacks
		WinMinimize % wintitleBS
		return
		}
    Else{
		KeyWait, Joy6			; wait for Numpad0 to be released
		KeyWait, Joy6, D T0.2	; and pressed again within 0.2 seconds
		if ErrorLevel{
			wintitleBS := "BlueStacks ahk_exe Bluestacks.exe"	;maximize BlueStacks (right monitor)
			WinMaximize % wintitleBS
			WinMove, BlueStacks, , 1920, -498, 1094, 1602 	;have to call this twice for some weird
			WinMove, BlueStacks, , 1920, -498, 1094, 1602	;bluestacks-specific reason
			return
		}
		Else{
			wintitleBS := "BlueStacks ahk_exe Bluestacks.exe"	;maximize BlueStacks (center monitor)
			WinMaximize % wintitleBS
			WinMove, BlueStacks, , 1000, 0, 720, 1200	;have to call this twice for some weird
			WinMove, BlueStacks, , 1000, 0, 720, 1200	;bluestacks-specific reason
			return
		}
	}
return
}


WatchPOV:
GetKeyState, POV, JoyPOV	; Get position of the POV control.
KeyToHoldDownPrev = %KeyToHoldDown%	; Prev now holds the key that was down before (if any).
; Some joysticks might have a smooth/continous POV rather than one in fixed increments.
; To support them all, use a range:
if POV < 0   ; No angle to report
    KeyToHoldDown =

;for dpad cardinal directions
;*******
else if POV = 0      ; 0 to 45 degrees: Up
    KeyToHoldDown = 
else if POV = 9000 ; 45 to 135 degrees: Right
    KeyToHoldDown = Numpad6	;move discord/spotify to right monitor
else if POV = 18000 ; 135 to 225 degrees: Down
	{
    KeyToHoldDown =
	run, E:\Users\Jem Dad\Downloads\tigerlily's Screen Dimmer.exe
	sleep 1400
	WinMove, tigerlily's Screen Dimmer, , 1913, -475, 600, 600
	return
	}
else if POV = 27000 ; 225 to 315 degrees: Left
    KeyToHoldDown = Numpad4	;move discord/spotify to left monitor
	
/*
;for dpad diagonals (unbound)
;****
else if POV between 9001 and 17999	;225 to 315 degrees: Left
    KeyToHoldDown = downright
SetKeyDelay -1
If KeyToHoldDownPrev = downright
{
  Send, {right up}{down up}
}
If KeyToHoldDown = downright
{
  Send, {right down}{down down}
  return
}


else if POV between 1 and 8999	;225 to 315 degrees: Left
    KeyToHoldDown = upright
SetKeyDelay -1
If KeyToHoldDownPrev = upright
{
  Send, {right up}{up up}
}
If KeyToHoldDown = upright
{
  Send, {right down}{up down}
  return
}


else if POV between 27001 and 35999	;225 to 315 degrees: Left
    KeyToHoldDown = upleft
SetKeyDelay -1
If KeyToHoldDownPrev = upleft
{
  Send, {left up}{up up}
}
If KeyToHoldDown = upleft
{
  Send, {left down}{up down}
  return
}

else if POV between 18001 and 26999	;225 to 315 degrees: Left
    KeyToHoldDown = downleft
SetKeyDelay -1
If KeyToHoldDownPrev = downleft
{
  Send, {left up}{down up}
}
If KeyToHoldDown = downleft
{
  Send, {left down}{down down}
  return
}
*/

if KeyToHoldDown = %KeyToHoldDownPrev%  ; the correct key is already down (or no key is needed).
return

; otherwise, release the previous key and press down the new key:
SetKeyDelay -1  ; Avoid delays between keystrokes.
if KeyToHoldDownPrev   ; There is a previous key to release.
    Send, {%KeyToHoldDownPrev% up}  ; Release it.
if KeyToHoldDown   ; There is a key to press down.
    Send, {%KeyToHoldDown% down}  ; Press it down.
return