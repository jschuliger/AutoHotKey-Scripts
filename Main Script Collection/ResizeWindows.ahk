#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;WinMove, WinTitle, (WinText), x-coord, y-coord, window length, window height
;WinMove, WinTitle, WinText, X, Y [, Width, Height, ExcludeTitle, ExcludeText]

;-------------------------------
;move discord and spotify to specific monitor
;CONTROLS: 	Numpad4 - move windows to left monitor
;			Numpad6 - move windows to right monitor
;			Ctrl+Numpad3 - moves active window to middle monitor
;			Ctrl+Numpad4 - toggle hide/show specific windows
;-------------------------------

DetectHiddenWindows, On
SetWinDelay, 1	;comment out if having issues
SetTitleMatchMode, 2

^Numpad4::
{
	spotifyHwnd := getSpotifyHwnd()
	WinGet, style, Style, ahk_id %spotifyHwnd%
	if (style & 0x10000000) { ; WS_VISIBLE
		WinHide, ahk_id %spotifyHwnd%
	} Else {
		WinShow, ahk_id %spotifyHwnd%
		;WinActivate, ahk_id %spotifyHwnd%
	}
	WinGet, style, Style, ahk_exe Discord.exe
	if (style & 0x10000000) { ; WS_VISIBLE
		WinHide, ahk_exe Discord.exe
	} Else {
		WinShow, ahk_exe Discord.exe
		;WinActivate, ahk_exe Discord.exe
	}
	WinGet, style, Style, Vivaldi
	if (style & 0x10000000) { ; WS_VISIBLE
		WinHide, Vivaldi
	} Else {
		WinShow, Vivaldi
		;WinActivate, Vivaldi
	}
	Return
}


Numpad4::	;keybind key
{
spotifyHwnd := getSpotifyHwnd()
WinSet, AlwaysOnTop, on, ahk_id %spotifyHwnd%	;to bring this window to the front
;WinMove, ahk_id %spotifyHwnd%, , -1920, 0, 984, 1040
WinMove, ahk_exe Spotify.exe, , -1920, 0, 984, 1040
WinSet, AlwaysOnTop, off, ahk_id %spotifyHwnd%

WinGet, DiscordState, MinMax, ahk_exe Discord.exe
If (DiscordState = -1) ; If discord is minimized, then restore window
	WinRestore, ahk_exe Discord.exe
WinSet, AlwaysOnTop, on, ahk_exe Discord.exe
WinMove, ahk_exe Discord.exe, , -940, 0, 940, 1040
WinSet, AlwaysOnTop, off, ahk_exe Discord.exe

;WinMove, BlueStacks, , 1920, -498, 1094, 1602
return
}

Numpad6::	;keybind key
{
spotifyHwnd := getSpotifyHwnd()
WinGet, SpotifyState, MinMax, ahk_id %spotifyHwnd%
If (SpotifyState = -1) ; If spotify is minimized, then restore window
	WinRestore, ahk_id %spotifyHwnd%
WinSet, AlwaysOnTop, on, ahk_id %spotifyHwnd%
WinMove, ahk_id %spotifyHwnd%, , 1920, -760, 1080, 915
WinMove, ahk_exe Spotify.exe, , 1920, -760, 1080, 915
WinSet, AlwaysOnTop, off, ahk_id %spotifyHwnd%

WinGet, DiscordState, MinMax, ahk_exe Discord.exe
If (DiscordState = -1) ; If discord is minimized, then restore window
	WinRestore, ahk_exe Discord.exe
WinSet, AlwaysOnTop, on, ahk_exe Discord.exe
WinMove, ahk_exe Discord.exe, , 1920, 155, 1080, 965
WinSet, AlwaysOnTop, off, ahk_exe Discord.exe

;WinMove, BlueStacks, , 1920, -498, 1094, 1602
return
}

;(mostly unnecessary, just use Win+Shift+Right
^Numpad3::
{
if (WinActive("ahk_class Progman") || WinActive("ahk_Class DV2ControlHost") || (WinActive("Start") && WinActive("ahk_class Button")) || WinActive("ahk_class Shell_TrayWnd")) ; disallows minimizing things that shouldn't be minimized, like the task bar and desktop
	return
WinGetActiveTitle, Title

sleep, 100
WinMove, %Title%, , 50, 50, 1000, 800
sleep, 100
WinMaximize, %Title%
WinActivate, %Title%
return
}


DetectHiddenWindows, On
; Get the HWND of the Spotify main window.
getSpotifyHwnd() {
	WinGet, spotifyHwnd1, ID, ahk_exe spotify.exe
	; We need the app's third top level window, so get next twice. - edit: this was changed for some reason, no longer needed
	;spotifyHwnd1 := DllCall("GetWindow", "uint", spotifyHwnd1, "uint", 2)
	;spotifyHwnd1 := DllCall("GetWindow", "uint", spotifyHwnd1, "uint", 2)
	Return spotifyHwnd1
}

