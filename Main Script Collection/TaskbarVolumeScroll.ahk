#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

; ------------------------------------------------------
;change volume using scroll wheel over taskbar, mute by clicking in mouse wheel
Hotkey, WheelUp, VolumeUp       ; volume up
Hotkey, WheelDown, VolumeDown   ; volume down
Hotkey, MButton, VolumeMute     ; volume mute
; ------------------------------------------------------
return
; source: http://www.autohotkey.net/~Lexikos/AutoHotkey_L/docs/commands/_If.htm

#If MouseIsOver("ahk_class Shell_TrayWnd") or MouseIsOver("ahk_class Shell_SecondaryTrayWnd")

VolumeUp:
    Send {Volume_Up}
    return

VolumeDown:
    Send {Volume_Down}
    return

VolumeMute:
    Send {Volume_Mute}
    return


; -------------------- functions --------------------
MouseIsOver(WinTitle) {
    MouseGetPos,,, Win
    return WinExist(WinTitle . " ahk_id " . Win)
}