#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;-------------------------------
;hotkeys for tachiyomi app on bluestacks android emulator
;CONTROLS:	NumpadEnter - single tap: minimize tachiyomi, double tap: maximize tachiyomi
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

NumpadEnter::
{
    KeyWait, %A_ThisHotkey%			; wait for hotkey to be released
    KeyWait, %A_ThisHotkey%, D T0.1	; and pressed again within 0.1 seconds
    if ErrorLevel{				; timed-out (only a single press)
        wintitleBS := "BlueStacks ahk_exe Bluestacks.exe"	;minimize BlueStacks
		WinMinimize % wintitleBS
		return
		}
    Else{
		KeyWait, %A_ThisHotkey%			; wait for hotkey to be released
		KeyWait, %A_ThisHotkey%, D T0.2	; and pressed again within 0.2 seconds
		if ErrorLevel{
			wintitleBS := "BlueStacks ahk_exe Bluestacks.exe"	;maximize BlueStacks (right monitor)
			WinMaximize % wintitleBS
			WinSet, AlwaysOnTop, on, % wintitleBS
			WinMove, BlueStacks, , 1920, -498, 1094, 1602 	;have to call this twice for some weird
			WinMove, BlueStacks, , 1920, -498, 1094, 1602	;bluestacks-specific reason
			WinSet, AlwaysOnTop, off, % wintitleBS
			return
		}
		Else{
			wintitleBS := "BlueStacks ahk_exe Bluestacks.exe"	;maximize BlueStacks (center monitor)
			WinMaximize % wintitleBS
			WinSet, AlwaysOnTop, on, % wintitleBS
			WinMove, BlueStacks, , 1000, 0, 720, 1200	;have to call this twice for some weird
			WinMove, BlueStacks, , 1000, 0, 720, 1200	;bluestacks-specific reason
			WinSet, AlwaysOnTop, off, % wintitleBS
			return
		}
	}
return
}