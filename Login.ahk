#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% 	; Ensures a consistent starting directory.

; =====================================================================
; License check
; =====================================================================
;LicFile:=A_Temp "" A_ScriptName ".api.tmp"
;URLDownloadtoFile , http://license.server.com %LicFile%
;
;FileRead LicSource , %LicFile%
;if LicSource contains = 596f7520617265207363726577656421203a2d29 (HEX)	
;{
;	Msgbox,,License, Good
;} else {
;	Msgbox,,License, Not working
;}

; =====================================================================
; Login GUI
; =====================================================================
Gui, Add, Picture, x172 y20 w64 h64 , ico.png
Gui, Add, GroupBox, x12 y90 w370 h130 , 
Gui, Add, Edit, x32 y130 w330 h20 vUsername, 
Gui, Add, Edit, x32 y180 w330 h20 Password vPassword, 
Gui, Add, Button, x12 y230 w370 h30 gLogin, Login
Gui, Show, x342 y134 h288 w397 Center, Login to Shell booter
Gui, Color, FFFFFF

Gui, Font, S8 CDefault Bold, Verdana
Gui, Add, Text, x32 y160 w100 h20 , Password:
Gui, Add, Text, x32 y110 w100 h20 , Username:
Return

; =====================================================================
; Login function
; =====================================================================
Login:
GuiControlGet , Username
GuiControlGet , Password
StringCaseSense, On
if Username contains admin
{	;Keep going if variable contains admin
	;GoSub, ReDirectToApplication
} else {
	GoSub, Error
	Return
}

if Password contains admin
{	;Keep going if variable contains admin
	;GoSub, ReDirectToApplication
} else {
	GoSub, Error
	Return
}

ReDirectToApplication:
run "Shell booter.ahk"
Return

Error:
Msgbox,0x30,Wrong username or password, Oops! Something went wrong.`n`nPlease verify your username and password.
Return

F12::Reload
GuiClose:
ExitApp