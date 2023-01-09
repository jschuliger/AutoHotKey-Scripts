#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

; ------------------------------------------------------
; hotkeys for tachiyomi app on bluestacks 5 android emulator
Hotkey, Numpad2, PageLeft	; turn page left
Hotkey, Numpad3, PageRight	; turn page right
Hotkey, NumpadAdd, WindowControl	; 1 tap to minimize, 2 to move to right monitor, 3 to move to center monitor
Hotkey, ^NumpadAdd, RefreshChap	; refresh chapter (if failed to load)
; ------------------------------------------------------

wintitleBS := "BlueStacks ahk_exe HD-Player.exe"
return


PageLeft:
; turn page forwards (left)
	ControlFocus, plrNativeInputWindowClass1, %wintitleBS%
	ControlSend, plrNativeInputWindowClass1, {Left}, %wintitleBS%
	return

PageRight:
;turn page backwards (right)
	ControlFocus, plrNativeInputWindowClass1, %wintitleBS%
	ControlSend, plrNativeInputWindowClass1, {Right}, %wintitleBS%
	return

WindowControl:
; minimize, maximize, and move to right or center monitor depending on number of times pressed
; works with tCLK, below
	vCTR++
	SetTimer tCLK, 200	; 200ms between hotkey presses
	return
tCLK:
{
	if (vCTR=1)	; number of hotkey presses
		WinMinimize %wintitleBS%
	else if (vCTR=2)
	{
		WinMaximize %wintitleBS%
		WinSet, AlwaysOnTop, on, %wintitleBS%
		WinMove, BlueStacks,, 1920, -498, 1080, 1602
		WinSet, AlwaysOnTop, off, %wintitleBS%
	}
	else if (vCTR>=3)
	{
		WinMaximize %wintitleBS%
		WinSet, AlwaysOnTop, on, %wintitleBS%
		WinMove, BlueStacks,, 1000, 0, 690, 1040
		WinSet, AlwaysOnTop, off, %wintitleBS%
	}
	vCTR:=0
	return
}

RefreshChap:
; refresh currently open chapter
{
	ControlFocus, plrNativeInputWindowClass1, % wintitleBS
	ControlSend, plrNativeInputWindowClass1, {Esc}, % wintitleBS
	sleep, 500
	WinGetPos, winX, winY, winWidth, winHeight, % wintitleBS
	X := winWidth * 0.92
	Y := winHeight * 0.95
	ControlClick, x%X% y%Y%, % wintitleBS
	return
}
