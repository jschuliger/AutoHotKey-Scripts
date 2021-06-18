#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;-------------------------------
;fast forward/rewind youtube while window is unfocused (tab open)
;CONTROLS:	Numpad5 - tap once to pause, twice to rewind 10 seconds
;			Ctrl+Numpad5 - fast forward 10 seconds
;-------------------------------

DetectHiddenWindows, on
SetTitleMatchMode, 2
browser = Vivaldi	;change to either "Google Chrome" or "Vivaldi"

Numpad5::	;fast forward/rewind youtube while window is unfocused
{
    KeyWait, %A_ThisHotkey%			; wait for hotkey to be released
    KeyWait, %A_ThisHotkey%, D T0.2	; and pressed again within 0.2 seconds
    if ErrorLevel{				; timed-out (only a single press)
		ControlGet, controlID, Hwnd,,Chrome_RenderWidgetHostHWND1, %browser%
		ControlFocus,,ahk_id %controlID%
		ControlSend, Chrome_RenderWidgetHostHWND1, K, %browser%
		return
		}
    Else{
		ControlGet, controlID, Hwnd,,Chrome_RenderWidgetHostHWND1, %browser%
		ControlFocus,,ahk_id %controlID%
		ControlSend, Chrome_RenderWidgetHostHWND1, J, %browser%
		return
	}
Return
}

^Numpad5::
{
ControlGet, controlID, Hwnd,,Chrome_RenderWidgetHostHWND1, %browser%
ControlFocus,,ahk_id %controlID%
ControlSend, Chrome_RenderWidgetHostHWND1, L, %browser%
return
}


/*
Numpad5::	;fast forward/rewind youtube while window is unfocused
{
    KeyWait, %A_ThisHotkey%			; wait for hotkey to be released
    KeyWait, %A_ThisHotkey%, D T0.2	; and pressed again within 0.2 seconds
    if ErrorLevel{				; timed-out (only a single press)
		ControlGet, controlID, Hwnd,,Chrome_RenderWidgetHostHWND1, %browser%
		ControlFocus,,ahk_id %controlID%
		ControlSend, Chrome_RenderWidgetHostHWND1, K, %browser%
		return
		}
    Else{
		KeyWait, %A_ThisHotkey%			; wait for hotkey to be released
		KeyWait, %A_ThisHotkey%, D T0.2	; and pressed again within 0.2 seconds
		if ErrorLevel{
			ControlGet, controlID, Hwnd,,Chrome_RenderWidgetHostHWND1, %browser%
			ControlFocus,,ahk_id %controlID%
			ControlSend, Chrome_RenderWidgetHostHWND1, L, %browser%
			return
		}
		Else{
			ControlGet, controlID, Hwnd,,Chrome_RenderWidgetHostHWND1, %browser%
			ControlFocus,,ahk_id %controlID%
			ControlSend, Chrome_RenderWidgetHostHWND1, J, %browser%
			return
		}
	}
Return
}
*/