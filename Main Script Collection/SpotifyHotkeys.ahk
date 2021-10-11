#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;------------------------------
;spotify hotkeys
;CONTROLS: 	Numpad7 - single tap: pause/play, double tap: refresh
;			Numpad8 - single tap: skip song,  double tap: previous song
;			Ctrl+Numpad7 - spotify volume up
;			Ctrl+Numpad8 - spotify volume down
;Issues: 	-when spotify search bar is visible, pause/play doesn't work due to it sending the input in the search bar
;------------------------------

DetectHiddenWindows, On

Numpad7::pauserefresh()	;play/pause/refresh spotify

Numpad8::skipsong()		;skip song/go back a song

^Numpad7::volumeup()	;volume up

^Numpad8::volumedown()	;volume down



;----functions----

pauserefresh()
{
	DetectHiddenWindows On
    KeyWait, Numpad7			; wait for Numpad7 to be released
    KeyWait, Numpad7, D T0.1	; and pressed again within 0.1 seconds
    if ErrorLevel 				; timed-out (only a single press)
        playpause()			;play/pause
    Else
	{
		;spotify has some unique properties, so this checks if the window is active first
		; and sends the input to a "different" place, which is still spotify
        WinGet, style, Style, ahk_class Chrome_WidgetWin_0
		if WinActive("ahk_class Chrome_WidgetWin_0")
			Send, ^+R			;refresh spotify
		else
			spotifyKey("^+R")	;refresh spotify
	}
Return
}

playpause()
{
	DetectHiddenWindows On
	WinGet, style, Style, ahk_class Chrome_WidgetWin_0

	if WinActive("ahk_class Chrome_WidgetWin_0")
		Send, {Space}
	else
		spotifyKey("{Space}")
	Return
}


skipsong()
{
	DetectHiddenWindows On
    KeyWait, Numpad8			; wait for Numpad8 to be released
    KeyWait, Numpad8, D T0.2	; and pressed again within 0.2 seconds
    if ErrorLevel 				; timed-out (only a single press)
	{
        WinGet, style, Style, ahk_class Chrome_WidgetWin_0
		if WinActive("ahk_class Chrome_WidgetWin_0")
			Send, ^{Right}
		else
			spotifyKey("^{Right}")	;skip to next song
	}
    Else
	{
        WinGet, style, Style, ahk_class Chrome_WidgetWin_0
		if WinActive("ahk_class Chrome_WidgetWin_0")
			Send, ^{Left}
		else
			spotifyKey("^{Left}")	;go back a song
	}
Return
}

volumeup()
{
	WinGet, style, Style, ahk_class Chrome_WidgetWin_0

	if WinActive("ahk_class Chrome_WidgetWin_0")
		Send, ^{Up}
	else
		spotifyKey("^{Up}")
	Return
}

volumedown()
{
	WinGet, style, Style, ahk_class Chrome_WidgetWin_0

	if WinActive("ahk_class Chrome_WidgetWin_0")
		Send, ^{Down}
	else
		spotifyKey("^{Down}")
	Return
}


; Get the HWND of the Spotify main window.
getSpotifyHwnd() {
	WinGet, spotifyHwnd, ID, ahk_exe spotify.exe
	; We need the app's third top level window, so get next twice. - edit: this was changed for some reason, no longer needed
	;spotifyHwnd := DllCall("GetWindow", "uint", spotifyHwnd, "uint", 2)
	;spotifyHwnd := DllCall("GetWindow", "uint", spotifyHwnd, "uint", 2)
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