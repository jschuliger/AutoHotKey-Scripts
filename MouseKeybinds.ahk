#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2
DetectHiddenWindows, on
#SingleInstance force

; ------------------------------------------------------
; hotkeys specifically for my mouse with 12 buttons on the side
; only in use while RunAllCondensed.ahk is also running
; this basically exists so I can use my mouse as a controller without a keyboard
; CONTROLS:	see below
; ------------------------------------------------------
;+-----------+-----------+-----------+
;| 1         | 2         | 3         |
;| page left | page right| move      |
;|           |           | vivaldi   |
;|           |           | right     |
;+-----------+-----------+-----------+
;| 4         | 5         | 6         |
;| move stuff| on-screen | move stuff|
;| left      | keyboard  | right     |
;|           |           |           |
;+-----------+-----------+-----------|
;| 7         | 8         | 9         |
;| pause/    | skip song/| open      |
;| play      | prev song | screen    |
;| spotify   | on spotify| dimmer    |
;+-----------+-----------+-----------+
;| 0         | -         | =         |
;| minimize/ | toggle    | youtube   |
;| maximize  | window    | control   |
;| tachiyomi | visibility|           |
;+-----------+-----------+-----------+


; with RunAllCondensed.ahk running, this stuff turns pages/minimizes/etc...
1::Numpad2	; page left
2::Numpad3	; page right
3::	; specific window layout
{
	WinMaximize BlueStacks
	WinSet, AlwaysOnTop, on, BlueStacks
	WinMove, BlueStacks, , 1920, -100, 850, 1220
	WinSet, AlwaysOnTop, off, BlueStacks
	WinActivate, Vivaldi
	WinSet, AlwaysOnTop, on, Vivaldi
	WinMove, Vivaldi,, 1920, -760, 1080, 700
	WinSet, AlwaysOnTop, off, Vivaldi
	return
}
4::Numpad4	; move discord/spotify to left monitor
5::run, C:\Program files\Common Files\microsoft shared\ink\tabtip.exe	; open on-screen keyboard
6::Numpad6	; move discord/spotify to right monitor
7::Numpad7	; pause/play spotify
8::Numpad8	; skip song / prev song
9::
{
	; https://github.com/tigerlily-dev/tigerlilys-Screen-Dimmer
	run, tigerlily's Screen Dimmer.exe
	WinWait, ahk_exe tigerlily's Screen Dimmer.exe
	WinMove, tigerlily's Screen Dimmer, , 1913, -475, 600, 600
	return
}
0::NumpadAdd	; minimize/maximize/resize tachiyomi
-::^Numpad4		; hide/show specific windows
=::Numpad5		; youtube control
