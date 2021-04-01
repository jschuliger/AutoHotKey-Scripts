#SingleInstance Force
#NoEnv
SendMode Input
SetTitleMatchMode 2

;******************************************************************************
; This is a random selection of utilities. All are activated by holding 
; "Application Key" (left of right Ctrl) and pressing some other key. 
; Some of them have a second function activated by holding Shift at the 
; same time. Hopefully you will find some of the useful. Feel free to 
; modify, reuse or share any of this.
;
; F4 plus - Result

;   Arrow Keys - Move the mouse with the arrow keys.
;                For use when you need pixel-precise control.
;    Caps Lock - Opens a context menu with commands to change the case of
;                the selected text, reverse it or "fix" Unix style newlines.
;            A - Makes the active window "Always On Top".
;                This will be indicated on it's title bar with a †.
;      SHIFT A - Makes the active window NOT "Always On Top".
;            T - Makes the active window 50% transpartent.
;      SHIFT T - Makes the active window opaque again.

; BROWSER CONFIG
; This should be the full path to your preferred web browser.
; Example: C:\Program Files\Mozilla Firefox\Firefox.exe

BrowserPath = 

;******************************************************************************

GroupAdd All

Menu Case, Add, &UPPERCASE, CCase
Menu Case, Add, &lowercase, CCase
Menu Case, Add, &Title Case, CCase
Menu Case, Add, &Sentence case, CCase
Menu Case, Add
Menu Case, Add, &Fix Linebreaks, CCase
Menu Case, Add, &Reverse, CCase

;******************************************************************************

F4::
;Keep F4 working (mostly) normally.
Send {F4}
Return

F4 & Left::MouseMove, -1, 0, 0, R
F4 & Right::MouseMove, 1, 0, 0, R
F4 & Up::MouseMove, 0, -1, 0, R
F4 & Down::MouseMove, 0, 1, 0, R

F4 & CapsLock::
GetText(TempText)
If NOT ERRORLEVEL
   Menu Case, Show
Return

F4 & a::
If NOT IsWindow(WinExist("A"))
   Return
WinGetTitle, TempText, A
If GetKeyState("shift")
{
   WinSet AlwaysOnTop, Off, A
   If (SubStr(TempText, 1, 2) = "† ")
      TempText := SubStr(TempText, 3)
}
else
{
   WinSet AlwaysOnTop, On, A
   If (SubStr(TempText, 1, 2) != "† ")
      TempText := "† " . TempText ;chr(134)
}
WinSetTitle, A, , %TempText%
Return

F4 & t::
If NOT IsWindow(WinExist("A"))
   Return
If GetKeyState("shift")
   Winset, Transparent, OFF, A
else
   Winset, Transparent, 128, A
Return


;******************************************************************************
CCase:
If (A_ThisMenuItemPos = 1)
   StringUpper, TempText, TempText
Else If (A_ThisMenuItemPos = 2)
   StringLower, TempText, TempText
Else If (A_ThisMenuItemPos = 3)
   StringLower, TempText, TempText, T
Else If (A_ThisMenuItemPos = 4)
{
   StringLower, TempText, TempText
   TempText := RegExReplace(TempText, "((?:^|[.!?]\s+)[a-z])", "$u1")
} ;Seperator, no 5
Else If (A_ThisMenuItemPos = 6)
{
   TempText := RegExReplace(TempText, "\R", "`r`n")
}
Else If (A_ThisMenuItemPos = 7)
{
   Temp2 =
   StringReplace, TempText, TempText, `r`n, % Chr(29), All
   Loop Parse, TempText
      Temp2 := A_LoopField . Temp2
   StringReplace, TempText, Temp2, % Chr(29), `r`n, All
}
PutText(TempText)
Return

;******************************************************************************

; Handy function.
; Copies the selected text to a variable while preserving the clipboard.
GetText(ByRef MyText = "")
{
   SavedClip := ClipboardAll
   Clipboard =
   Send ^c
   ClipWait 0.5
   If ERRORLEVEL
   {
      Clipboard := SavedClip
      MyText =
      Return
   }
   MyText := Clipboard
   Clipboard := SavedClip
   Return MyText
}

; Pastes text from a variable while preserving the clipboard.
PutText(MyText)
{
   SavedClip := ClipboardAll 
   Clipboard =              ; For better compatability
   Sleep 20                 ; with Clipboard History
   Clipboard := MyText
   Send ^v
   Sleep 100
   Clipboard := SavedClip
   Return
}

;This makes sure sure the same window stays active after showing the InputBox.
;Otherwise you might get the text pasted into another window unexpectedly.
SafeInput(Title, Prompt, Default = "")
{
   ActiveWin := WinExist("A")
   InputBox OutPut, %Title%, %Prompt%,,, 120,,,,, %Default%
   WinActivate ahk_id %ActiveWin%
   Return OutPut
}

;This checks if a window is, in fact a window.
;As opposed to the desktop or a menu, etc.
IsWindow(hwnd) 
{
   WinGet, s, Style, ahk_id %hwnd% 
   return s & 0xC00000 ? (s & 0x80000000 ? 0 : 1) : 0
   ;WS_CAPTION AND !WS_POPUP(for tooltips etc) 
}