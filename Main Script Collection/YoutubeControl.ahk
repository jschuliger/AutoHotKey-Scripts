#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
DetectHiddenWindows, on
SetTitleMatchMode, 2
#SingleInstance force


; ------------------------------------------------------
; receives hotkey and sends one of J, K, or L to the browser. This rewinds, pauses, or fast forwards youtube.
; only tested with chromium browsers (Google Chrome and Vivaldi), and likely only works on them.
Hotkey, Numpad5, PauseRewind	; tap once to pause, twice to rewind 10 seconds
Hotkey, ^Numpad5, FastForward	; fast forward 10 seconds
; ------------------------------------------------------

browser = Vivaldi	; change to "Google Chrome", "Vivaldi", etc. Only tested with chromium browsers.
return


PauseRewind:
; gets number of times hotkey is pressed and either pauses or rewinds 10 seconds, with tCLK below
	vCTR++
	SetTimer tCLK, 200	; 200ms between hotkey presses
	return
tCLK:
{
	if (vCTR=1) {	; number of hotkey presses
		ControlGet, controlID, Hwnd,, Chrome_RenderWidgetHostHWND1, %browser%
		ControlFocus,, ahk_id %controlID%
		ControlSend, Chrome_RenderWidgetHostHWND1, K, %browser%
	}
	else if (vCTR>=2) {
		ControlGet, controlID, Hwnd,, Chrome_RenderWidgetHostHWND1, %browser%
		ControlFocus,, ahk_id %controlID%
		ControlSend, Chrome_RenderWidgetHostHWND1, J, %browser%
	}
	vCTR:=0
	return
}

FastForward:
; skips forward 10 seconds by sending "L" to browser
{
	ControlGet, controlID, Hwnd,,Chrome_RenderWidgetHostHWND1, %browser%
	ControlFocus,,ahk_id %controlID%
	ControlSend, Chrome_RenderWidgetHostHWND1, L, %browser%
	return
}
