#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;------------------------------
;hotkeys for my mouse with 12 buttons on the side
;only in use while RunAllCondensed.ahk is also running, but not always
;this basically exists so I can use my mouse as a controller without a keyboard
;CONTROLS:	see below
;------------------------------
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
;| refresh   | prev song | screen    |
;| spotify   | on spotify| dimmer    |
;+-----------+-----------+-----------+
;| 0         | -         | =         |
;| minimize/ | minimize  | maximize  |
;| maximize  | all       | all       |
;| tachiyomi |           |           |
;+-----------+-----------+-----------+

SetTitleMatchMode, 2
;with RunAllCondensed.ahk running, this stuff turns pages/minimizes/etc...
MButton::Numpad5
1::Numpad2	;page left
2::Numpad3	;page right
3::
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
4::Numpad4	;move discord/spotify to left
5::run, C:\Program files\Common Files\microsoft shared\ink\tabtip.exe ;open on-screen keyboard
6::Numpad6	;move discord/spotify to right
7::Numpad7	;pause/refresh spotify
8::Numpad8	;skip song / prev song
9::
{
run, E:\Users\Jem Dad\Downloads\tigerlily's Screen Dimmer.exe
sleep 1400
WinMove, tigerlily's Screen Dimmer, , 1913, -475, 600, 600
return
}
0::NumpadAdd	;minimize/maximize/resize tachiyomi
-::^Numpad4
=::^NumpadAdd
{
WinActivate, Vivaldi
WinActivate, ahk_exe Discord.exe
spotifyHwnd := getSpotifyHwnd()
WinActivate, ahk_id %spotifyHwnd%
return
}

DetectHiddenWindows, On
; Get the HWND of the Spotify main window.
getSpotifyHwnd() {
	WinGet, spotifyHwnd, ID, ahk_exe spotify.exe
	; We need the app's third top level window, so get next twice.
	spotifyHwnd := DllCall("GetWindow", "uint", spotifyHwnd, "uint", 2)
	spotifyHwnd := DllCall("GetWindow", "uint", spotifyHwnd, "uint", 2)
	Return spotifyHwnd
}