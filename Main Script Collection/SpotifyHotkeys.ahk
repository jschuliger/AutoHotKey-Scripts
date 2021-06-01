#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;------------------------------
;spotify hotkeys
;CONTROLS: 	Numpad7 - single tap: pause/play, double tap: refresh
;			Numpad8 - single tap: skip song,  double tap: previous song
;Issues: 	-when spotify search bar is open, the script doesn't work due to it sending the input in the search bar
;			-when spotify is active, trying to refresh (ctrl+shift+r) instead enables loop (ctrl+r) when using Numpad7
;------------------------------

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
{
    KeyWait, Numpad7			; wait for Numpad7 to be released
    KeyWait, Numpad7, D T0.1	; and pressed again within 0.1 seconds
    if ErrorLevel 				; timed-out (only a single press)
        spotifyKey("{Space}")	;pause
    Else
        spotifyKey("^+R")	;refresh spotify
Return
}

Numpad8::	;skip song/go back a song
{
    KeyWait, Numpad8			; wait for Numpad8 to be released
    KeyWait, Numpad8, D T0.2	; and pressed again within 0.2 seconds
    if ErrorLevel 				; timed-out (only a single press)
        spotifyKey("^{Right}")	;skip to next song
    Else
        spotifyKey("^{Left}")	;go back a song
Return
}