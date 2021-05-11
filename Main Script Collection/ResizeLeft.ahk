#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;WinMove, WinTitle, (WinText), x-coord, y-coord, window length, window height
;WinMove, WinTitle, WinText, X, Y [, Width, Height, ExcludeTitle, ExcludeText]

Numpad4::
DetectHiddenWindows On
PostMessage 0x319,, 0xE0000,, ahk_exe spotify.exe ; msg = WM_APPCOMMAND; lParam = APPCOMMAND_MEDIA_PLAY_PAUSE
Sleep, 100
WinMove, Spotify Premium, , -1920, 0, 992, 1040
Sleep, 100
DetectHiddenWindows On
PostMessage 0x319,, 0xE0000,, ahk_exe spotify.exe ; msg = WM_APPCOMMAND; lParam = APPCOMMAND_MEDIA_PLAY_PAUSE

WinMove, ahk_exe Discord.exe, , -940, 0, 940, 1040

WinMove, HakuNeko, , 1913, -475, 1094, 1602

WinMove, BlueStacks, , 1920, -498, 1094, 1602
return