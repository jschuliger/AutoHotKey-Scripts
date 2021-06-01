#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;-------------------------------
;hotkeys for tachiyomi app on bluestacks android emulator
;CONTROLS:	Numpad0 - single tap: minimize tachiyomi, double tap: maximize tachiyomi
;			Numpad2 - turn page left
;			Numpad3 - turn page right
;-------------------------------

Numpad2::	;turn page forwards (left)
wintitleBS := "BlueStacks ahk_exe Bluestacks.exe"
ControlFocus,WindowsForms10.Window.8.app.0.2fc056_r6_ad11 , % wintitleBS
ControlSend,WindowsForms10.Window.8.app.0.2fc056_r6_ad11 ,{Left}, % wintitleBS
return

Numpad3::	;turn page backwards (right)
wintitleBS := "BlueStacks ahk_exe Bluestacks.exe"
ControlFocus,WindowsForms10.Window.8.app.0.2fc056_r6_ad11 , % wintitleBS
ControlSend,WindowsForms10.Window.8.app.0.2fc056_r6_ad11 ,{Right}, % wintitleBS
return

Numpad0::	;minimize/maximize tachiyomi
    KeyWait, Numpad0			; wait for Numpad0 to be released
    KeyWait, Numpad0, D T0.1	; and pressed again within 0.1 seconds
    if ErrorLevel{				; timed-out (only a single press)
        wintitleBS := "BlueStacks ahk_exe Bluestacks.exe"	;minimize BlueStacks
		WinMinimize % wintitleBS
		return
		}
    Else{
        wintitleBS := "BlueStacks ahk_exe Bluestacks.exe"	;maximize BlueStacks
		WinMaximize % wintitleBS
		WinMove, BlueStacks, , 1920, -498, 1094, 1602
		return
		}