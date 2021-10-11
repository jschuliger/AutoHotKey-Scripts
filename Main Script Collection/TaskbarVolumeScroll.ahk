#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;-------------------------------
;change volume using scroll wheel over taskbar
;CONTROLS:	Mouse Wheel Up (over taskbar) - volume up
;			Mouse Wheel Down (over taskbar) - volume down
;			Mouse Wheel Button (over taskbar) - volume mute
;-------------------------------
; Source: http://www.autohotkey.net/~Lexikos/AutoHotkey_L/docs/commands/_If.htm

#If MouseIsOver("ahk_class Shell_TrayWnd") or MouseIsOver("ahk_class Shell_SecondaryTrayWnd")

WheelUp::
Send {Volume_Up}
return

WheelDown::
Send {Volume_Down}
return

MButton::
Send {Volume_Mute}
return

MouseIsOver(WinTitle) {
    MouseGetPos,,, Win
    return WinExist(WinTitle . " ahk_id " . Win)
}