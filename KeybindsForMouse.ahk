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
;| page left | page right| Enter     |
;|           |           |           |
;|           |           |           |
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
;| minimize/ | Left      | Right     |
;| maximize  |           |           |
;| tachiyomi |           |           |
;+-----------+-----------+-----------+


;with RunAllCondensed.ahk running, this stuff turns pages/minimizes/etc...
1::Numpad2	;page left
2::Numpad3	;page right
3::Enter
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
0::Numpad0	;minimize/maximize tachiyomi
-::Left
=::Right

;WinMove, HakuNeko, , 1913, -475, 1094, 1602

;WinMove, BlueStacks, , 1920, -475, 1094, 1602