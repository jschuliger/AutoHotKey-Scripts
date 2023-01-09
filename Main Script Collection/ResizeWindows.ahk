#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
DetectHiddenWindows, on
SetTitleMatchMode, 2
#SingleInstance force
SetWinDelay, 1	;comment out if having issues


; ------------------------------------------------------
; manipulates windows by moving or hiding/showing them
Hotkey, Numpad4, MoveWinLeft	; move specific windows to left monitor
Hotkey, Numpad6, MoveWinRight	; move specific windows to right monitor
Hotkey, ^Numpad3, MoveToCenter	; move active window to middle monitor
Hotkey, ^Numpad4, ToggleWindows	; toggle visibility of specific windows
; ------------------------------------------------------

; creating 4 basic positions for windows
x1 := -1920, y1 := 0, w1 := 984, h1 := 1040   ; left monitor, left side
x2 := -940, y2 := 0, w2 := 940, h2 := 1040    ; left monitor, right side
x3 := 1920, y3 := -760, w3 := 1080, h3 := 915 ; right monitor, top right
x4 := 1920, y4 := 155, w4 := 1080, h4 := 965  ; right monitor, bottom right
return

MoveWinLeft:
; moves spotify+discord to left monitor, making sure they are visible
{
	MoveWindow("ahk_exe spotify.exe", x1, y1, w1, h1)
	MoveWindow("ahk_exe Discord.exe", x2, y2, w2, h2)
	return
}

MoveWinRight:
; moves spotify+discord to right monitor, making sure they are visible
{
	MoveWindow("ahk_exe spotify.exe", x3, y3, w3, h3)
	MoveWindow("ahk_exe Discord.exe", x4, y4, w4, h4)
	return
}

MoveToCenter:
; moves active window to center monitor and maximizes it
; alternatively, just use Win+Shift+Right/Left
{
	; disallows minimizing things that shouldn't be minimized, like the task bar and desktop
	if (WinActive("ahk_class Progman") || WinActive("ahk_Class DV2ControlHost") || (WinActive("Start") && WinActive("ahk_class Button")) || WinActive("ahk_class Shell_TrayWnd"))
		return
	WinGetActiveTitle, title
	WinRestore, %title%
	WinMove, %title%, , 50, 50, 1000, 800
	WinMaximize, %title%
	WinActivate, %title%
	return
}

ToggleWindows:
; toggle visibility of specific windows
{
	ToggleVisibility("ahk_exe spotify.exe")
	ToggleVisibility("ahk_exe Discord.exe")
	ToggleVisibility("Vivaldi")
	return
}


; -------------------- functions --------------------
MoveWindow(window, x, y, w, h) {
; moves window to desired coordinates, guaranteeing visibility
	WinRestore, %window%
	WinSet, AlwaysOnTop, on, %window%
	WinMove, %window%,, %x%, %y%, %w%, %h%
	WinSet, AlwaysOnTop, off, %window%
}

ToggleVisibility(window) {
; toggles the visibility of the given window
	WinGet, style, Style, %window%
	if (style & 0x10000000) ; WS_VISIBLE
		WinHide, %window%
	else
		WinShow, %window%
}
