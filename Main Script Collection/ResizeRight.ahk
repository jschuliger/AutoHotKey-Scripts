#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;WinMove, WinTitle, (WinText), x-coord, y-coord, window length, window height
;WinMove, WinTitle, WinText, X, Y [, Width, Height, ExcludeTitle, ExcludeText]

Numpad6::
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
WinMove, ahk_id %spotifyHwnd%, , 1920, -760, 1080, 915

WinMove, ahk_exe Discord.exe, , 1920, 155, 1080, 965

WinMove, HakuNeko, , 1913, -475, 1094, 1602

WinMove, BlueStacks, , 1920, -498, 1094, 1602
return