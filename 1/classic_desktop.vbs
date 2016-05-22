' from Helen's post on stackoverflow.com

Set WshShell = CreateObject("Wscript.Shell")

WshShell.Run "rundll32.exe shell32.dll,Control_RunDLL desk.cpl desk,@Themes /Action:OpenTheme /File:""c:\windows\resources\themes\windows classic.theme""", 1

'Wscript.Sleep 5000
'WshShell.AppActivate("Desktop Properties")
'WshShell.AppActivate("Display Properties")
'WshShell.Sendkeys "%FC"
'WshShell.Sendkeys "{F4}"

While Not WshShell.AppActivate("Display Properties")
  WScript.Sleep 500
Wend

Do
  WshShell.SendKeys "~"
  WScript.Sleep 500
Loop While WshShell.AppActivate ("Display Properties")

