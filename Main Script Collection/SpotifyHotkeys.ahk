#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
DetectHiddenWindows, on
#SingleInstance force


; ------------------------------------------------------
; spotify hotkeys
; NOTE: sometimes these hotkeys don't work when spotify is minimized,
;		likely due to spotify updates
Hotkey, Numpad7, PausePlay		; pause/play
Hotkey, Numpad8, SkipOrRewind	; single tap: skip song,  double tap: previous song
Hotkey, ^Numpad7, VolumeUp		; spotify volume up
Hotkey, ^Numpad8, VolumeDown	; spotify volume down
; ------------------------------------------------------
return


PausePlay:
{
	WinGet, style, Style, ahk_exe spotify.exe
	WinGet, state, MinMax, ahk_exe spotify.exe
	if !(style & 0x10000000)	; WS_VISIBLE
		Send, {Media_Play_Pause}
	else if (state = -1)	; minimized
		Send, {Media_Play_Pause}
	else if WinActive("ahk_class Chrome_WidgetWin_0")
		Send, {Space}
	else
		spotifyKey("{Space}")
	return
}

SkipOrRewind:
	vCTR++
	SetTimer tCLK, 200	; 200ms between hotkey presses
	return
tCLK:
{
	WinGet, style, Style, ahk_exe spotify.exe
	WinGet, state, MinMax, ahk_exe spotify.exe
	if (vCTR=1)	; number of hotkey presses
	{
		if !(style & 0x10000000)	; WS_VISIBLE
			Send, {Media_Next}
		else if (state = -1)	; minimized
			Send, {Media_Next}
		else if WinActive("ahk_exe spotify.exe")
			Send, ^{Right}
		else
			spotifyKey("^{Right}")	; skip to next song
	}
	else if (vCTR>=2)
	{
		if !(style & 0x10000000)	; WS_VISIBLE
			Send, {Media_Previous}
		else if (state = -1)	; minimized
			Send, {Media_Previous}
		else if WinActive("ahk_exe spotify.exe")
			Send, ^{Left}
		else
			spotifyKey("^{Left}")	; go back to previous song
	}
	vCTR:=0
	return
}

VolumeUp:
{
	if WinActive("ahk_exe spotify.exe")
		Send, ^{Up}
	else
		spotifyKey("^{Up}")
	return
}

VolumeDown:
{
	if WinActive("ahk_exe spotify.exe")
		Send, ^{Down}
	else
		spotifyKey("^{Down}")
	return
}


; -------------------- functions --------------------
spotifyKey(key) {
; send a key to spotify by focusing it without activating it, then send the input
; chromium ignores keys when it isn't focused
	ControlFocus, Chrome_RenderWidgetHostHWND1, ahk_exe spotify.exe
	ControlSend,, %key%, ahk_exe spotify.exe
	return
}
