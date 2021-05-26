#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;vvv format for WinMove vvv
;WinMove, WinTitle, (WinText), x-coord, y-coord, window length, window height
;WinMove, WinTitle, WinText, X, Y [, Width, Height, ExcludeTitle, ExcludeText]

;------------------------------
;spotify hotkeys
;------------------------------
; SpotifyGlobalKeys.ahk:
; AutoHotkey script to control Spotify with global keyboard shortcuts
; Author: James Teh <jamie@jantrid.net>
; Copyright 2017-2018 James Teh
; License: GNU General Public License version 2.0

DetectHiddenWindows, On

; Get the HWND of the Spotify main window.
getSpotifyHwnd() {
	WinGet, spotifyHwnd, ID, ahk_exe spotify.exe
	; We need the app's third top level window, so get next twice.
	spotifyHwnd := DllCall("GetWindow", "uint", spotifyHwnd, "uint", 2)
	spotifyHwnd := DllCall("GetWindow", "uint", spotifyHwnd, "uint", 2)
	Return spotifyHwnd
}

; Send a key to Spotify.
spotifyKey(key) {
	spotifyHwnd := getSpotifyHwnd()
	; Chromium ignores keys when it isn't focused.
	; Focus the document window without bringing the app to the foreground.
	ControlFocus, Chrome_RenderWidgetHostHWND1, ahk_id %spotifyHwnd%
	ControlSend, , %key%, ahk_id %spotifyHwnd%
	Return
}

Numpad7::	;pause/refresh spotify
    KeyWait, Numpad7			; wait for Numpad7 to be released
    KeyWait, Numpad7, D T0.1	; and pressed again within 0.1 seconds
    if ErrorLevel 				; timed-out (only a single press)
        spotifyKey("{Space}")	;pause
    Else
        spotifyKey("^+R")	;refresh spotify
Return


Numpad8::	;skip song/go back a song
    KeyWait, Numpad8			; wait for Numpad8 to be released
    KeyWait, Numpad8, D T0.2	; and pressed again within 0.2 seconds
    if ErrorLevel 				; timed-out (only a single press)
        spotifyKey("^{Right}")	;skip to next song
    Else
        spotifyKey("^{Left}")	;go back a song
Return

;-------------------------------
;move discord and spotify to right monitor
;-------------------------------
Numpad6::	;keybind key (runs everything until return)
DetectHiddenWindows, On

spotifyHwnd1 := getSpotifyHwnd()
WinMove, ahk_id %spotifyHwnd1%, , 1920, -760, 1080, 915

WinMove, ahk_exe Discord.exe, , 1920, 155, 1080, 965

WinMove, HakuNeko, , 1913, -475, 1094, 1602

WinMove, BlueStacks, , 1920, -498, 1094, 1602
return

;-------------------------------
;move discord and spotify to left monitor
;-------------------------------
Numpad4::	;keybind key (runs everything until return)
DetectHiddenWindows, On

spotifyHwnd2 := getSpotifyHwnd()
WinMove, ahk_id %spotifyHwnd2%, , -1920, 0, 992, 1040

WinMove, ahk_exe Discord.exe, , -940, 0, 940, 1040

WinMove, HakuNeko, , 1913, -475, 1094, 1602

WinMove, BlueStacks, , 1920, -498, 1094, 1602
return

;-------------------------------
;turns page of tachiyomi app on bluestacks
;-------------------------------



NumpadDiv::	;turn page forwards (left)
wintitleBS := "BlueStacks ahk_exe Bluestacks.exe"
ControlFocus,WindowsForms10.Window.8.app.0.2fc056_r6_ad11 , % wintitleBS
ControlSend,WindowsForms10.Window.8.app.0.2fc056_r6_ad11 ,{Left}, % wintitleBS
return

Numpad2::	;turn page forwards (left)
wintitleBS := "BlueStacks ahk_exe Bluestacks.exe"
ControlFocus,WindowsForms10.Window.8.app.0.2fc056_r6_ad11 , % wintitleBS
ControlSend,WindowsForms10.Window.8.app.0.2fc056_r6_ad11 ,{Left}, % wintitleBS
return

NumpadMult::	;turn page backwards (right)
wintitleBS := "BlueStacks ahk_exe Bluestacks.exe"
ControlFocus,WindowsForms10.Window.8.app.0.2fc056_r6_ad11 , % wintitleBS
ControlSend,WindowsForms10.Window.8.app.0.2fc056_r6_ad11 ,{Right}, % wintitleBS
return

Numpad3::	;turn page backwards (right)
wintitleBS := "BlueStacks ahk_exe Bluestacks.exe"
ControlFocus,WindowsForms10.Window.8.app.0.2fc056_r6_ad11 , % wintitleBS
ControlSend,WindowsForms10.Window.8.app.0.2fc056_r6_ad11 ,{Right}, % wintitleBS
return


Numpad0::	;skip song/go back a song
    KeyWait, Numpad0			; wait for Numpad0 to be released
    KeyWait, Numpad0, D T0.1	; and pressed again within 0.1 seconds
    if ErrorLevel{				; timed-out (only a single press)
        wintitleBS := "BlueStacks ahk_exe Bluestacks.exe"	;minimize BlueStacks
		WinMinimize % wintitleBS
		return
		}
    Else{
        wintitleBS := "BlueStacks ahk_exe Bluestacks.exe"	;maximize BlueStacks
		WinMaximize % wintitleBS
		WinMove, BlueStacks, , 1920, -498, 1094, 1602
		return
		}
Return

;-------------------------------
;change volume using scroll wheel over taskbar
;-------------------------------
; Source: http://www.autohotkey.net/~Lexikos/AutoHotkey_L/docs/commands/_If.htm

#If MouseIsOver("ahk_class Shell_TrayWnd")

WheelUp::
{Send {Volume_Up}
return
}

WheelDown::
{Send {Volume_Down}
return
}

;MButton::
;Send {Volume_Mute}
;return

MouseIsOver(WinTitle) {
    MouseGetPos,,, Win
    return WinExist(WinTitle . " ahk_id " . Win)
}

