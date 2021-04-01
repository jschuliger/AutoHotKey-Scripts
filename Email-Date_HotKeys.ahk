#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;-----------
::]eml::jhschuliger@gmail.com

; Date/Time

; Date only
; Ex: 9/1/2005
::]d::
FormatTime, CurrentDate,, M/d/yyyy  
SendInput %CurrentDate%
return

; Date Only
; Ex: 1 September 2005
::]dd::
FormatTime, CurrentDate,, d MMMM yyyy
SendInput %CurrentDate%
return

; Date/Time
; Ex: 9/1/2005 3:53 PM
::]dt::
FormatTime, CurrentDateTime,, M/d/yyyy h:mm:ss tt  
SendInput %CurrentDateTime%
return

; Date Proper Format
; Ex: September 1, 2005
::]dp::
FormatTime, CurrentDate,, MMMM d, yyyy
SendInput %CurrentDate%
return

; Date Proper Format + Time
; Ex: September 1, 2005
::]dpt::
FormatTime, CurrentDateTime,, MMMM d, yyyy, HH:mm:ss
SendInput %CurrentDateTime%
return

; Time only (24-hr)
; Ex: 09:12
::]t::
FormatTime, Time,, HH:mm 
sendinput %Time%
return
;-----------