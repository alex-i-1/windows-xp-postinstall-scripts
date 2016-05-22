'

Set WshShell = CreateObject("Wscript.Shell")

' run "Power Options Properties"
WshShell.Run "RUNDLL32.EXE SHELL32.DLL,Control_RunDLL powercfg.cpl", 1
'WshShell.Run "RUNDLL32.EXE SHELL32.DLL,Control_RunDLL powercfg.cpl,""Advanced"",0", 1
'WshShell.Run "RUNDLL32.EXE SHELL32.DLL,Control_RunDLL powercfg.cpl,,0", 1
'WshShell.Run "RUNDLL32.EXE SHELL32.DLL,Control_RunDLL powercfg.cpl powercfg,@Advanced", 1
'WshShell.Run "RUNDLL32.EXE SHELL32.DLL,Control_RunDLL powercfg.cpl @Advanced", 1
'WshShell.Run "RUNDLL32.EXE SHELL32.DLL,Control_RunDLL powercfg.cpl,0", 1
'WshShell.Run "RUNDLL32.EXE SHELL32.DLL,Control_RunDLL powercfg.cpl 0", 1
'WshShell.Run "RUNDLL32.EXE SHELL32.DLL,Control_RunDLL powercfg.cpl,,3", 1
'WshShell.Run "RUNDLL32.EXE SHELL32.DLL,Control_RunDLL powercfg.cpl powercfg,0", 1

While Not WshShell.AppActivate("Power Options Properties")
  WScript.Sleep 100
Wend

WshShell.Sendkeys "+{TAB}"
' Advanced
WshShell.Sendkeys "{RIGHT}"

WshShell.Sendkeys "%E"
WshShell.Sendkeys "{UP}"
WshShell.Sendkeys "{UP}"
WshShell.Sendkeys "{UP}"

WshShell.Sendkeys "%N"
WshShell.Sendkeys "{UP}"
WshShell.Sendkeys "{UP}"
WshShell.Sendkeys "{UP}"

' Enter
WshShell.SendKeys "~"

Do
  WScript.Sleep 100
Loop While WshShell.AppActivate ("Power Options Properties")

WScript.Quit

