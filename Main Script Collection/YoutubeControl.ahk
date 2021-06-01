#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;-------------------------------
;fast forward/rewind youtube while window is unfocused (tab open)
;CONTROLS:	Numpad5 - tap once to pause, twice to fast forward 10 seconds, three times to rewind 10 seconds
;-------------------------------

DetectHiddenWindows, on
SetTitleMatchMode, 2
browser = Vivaldi	;change to either "Google Chrome" or "Vivaldi"

Numpad5::	;fast forward/rewind youtube while window is unfocused
    KeyWait, Numpad5			; wait for Numpad5 to be released
    KeyWait, Numpad5, D T0.1	; and pressed again within 0.1 seconds
    if ErrorLevel{				; timed-out (only a single press)
		ControlGet, controlID, Hwnd,,Chrome_RenderWidgetHostHWND1, %browser%
		ControlFocus,,ahk_id %controlID%
		ControlSend, Chrome_RenderWidgetHostHWND1, K, %browser%
		return
		}
    Else{
		KeyWait, Numpad5			; wait for Numpad5 to be released
		KeyWait, Numpad5, D T0.2	; and pressed again within 0.1 seconds
		if ErrorLevel{
			ControlGet, controlID, Hwnd,,Chrome_RenderWidgetHostHWND1, %browser%
			ControlFocus,,ahk_id %controlID%
			ControlSend, Chrome_RenderWidgetHostHWND1, L, %browser%
		}
		Else{
			ControlGet, controlID, Hwnd,,Chrome_RenderWidgetHostHWND1, %browser%
			ControlFocus,,ahk_id %controlID%
			ControlSend, Chrome_RenderWidgetHostHWND1, J, %browser%
			return
			}
		}
Return