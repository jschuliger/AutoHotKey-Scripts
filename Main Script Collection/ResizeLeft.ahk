﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;WinMove, WinTitle, (WinText), x-coord, y-coord, window length, window height
;WinMove, WinTitle, WinText, X, Y [, Width, Height, ExcludeTitle, ExcludeText]

;-------------------------------
;move discord and spotify to left monitor
;CONTROLS: Numpad4 - move windows to left monitor
;-------------------------------
Numpad4::	;keybind key (runs everything until return)
{
DetectHiddenWindows, On

; Get the HWND of the Spotify main window.
getSpotifyHwnd() {
	WinGet, spotifyHwnd, ID, ahk_exe spotify.exe
	; We need the app's third top level window, so get next twice.
	spotifyHwnd := DllCall("GetWindow", "uint", spotifyHwnd, "uint", 2)
	spotifyHwnd := DllCall("GetWindow", "uint", spotifyHwnd, "uint", 2)
	Return spotifyHwnd
}

spotifyHwnd := getSpotifyHwnd()
WinActivate, ahk_id %spotifyHwnd%
WinMove, ahk_id %spotifyHwnd%, , -1920, 0, 992, 1040

WinActivate, ahk_exe Discord.exe
WinMove, ahk_exe Discord.exe, , -940, 0, 940, 1040

;WinMove, HakuNeko, , 1913, -475, 1094, 1602

;WinMove, BlueStacks, , 1920, -498, 1094, 1602
return
}