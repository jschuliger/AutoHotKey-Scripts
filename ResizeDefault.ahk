#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;WinMove, WinTitle, (WinText), x-coord, y-coord, window length, window height
;WinMove, WinTitle, WinText, X, Y [, Width, Height, ExcludeTitle, ExcludeText]

DetectHiddenWindows On
PostMessage 0x319,, 0xE0000,, ahk_exe spotify.exe ; msg = WM_APPCOMMAND; lParam = APPCOMMAND_MEDIA_PLAY_PAUSE
Sleep, 80
WinMove, Spotify Premium, , 1920, -760, 1080, 915
Sleep, 80
DetectHiddenWindows On
PostMessage 0x319,, 0xE0000,, ahk_exe spotify.exe ; msg = WM_APPCOMMAND; lParam = APPCOMMAND_MEDIA_PLAY_PAUSE

WinMove, ahk_exe Discord.exe, , 1920, 155, 1080, 965

WinMove, HakuNeko, , 1843, -760, 1247, 1887