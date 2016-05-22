' constructed by a post of "mr_unreliable"

Set WshShell = CreateObject("Wscript.Shell")

' open folder "C:\"
'WshShell.Run "explorer.exe ""c:\""", 1
' "C:\" is not being shown on a fresh XP; use something different
WshShell.Run "explorer.exe ""C:\Documents and Settings""", 1

'While Not WshShell.AppActivate("Local Disk (C:)")
While Not WshShell.AppActivate("Documents and Settings")
  WScript.Sleep 100
Wend

' toggle Statusbar (expecting that it will be enabled as a result, but ...)
WshShell.Sendkeys "%(VB)"
' go View -> List
WshShell.Sendkeys "%(VL)"
' go View -> Details
'WshShell.Sendkeys "%(VD)"
' go Tools -> Options
WshShell.Sendkeys "%(TO)"

While Not WshShell.AppActivate("Folder Options")
  WScript.Sleep 100
Wend

' go to tabs
WshShell.Sendkeys "+{TAB}"
' go one tab to the right
WshShell.Sendkeys "{RIGHT}"
' "Apply to All Folders"
WshShell.Sendkeys "%L"
' "Yes"
WshShell.Sendkeys "%Y"
' close the options
WshShell.Sendkeys "{ESC}"

' wait for close
While WshShell.AppActivate("Folder Options")
  WScript.Sleep 100
Wend

' close the folder
WshShell.Sendkeys "%{F4}"

' wait for close
'While WshShell.AppActivate("Local Disk (C:)")
While WshShell.AppActivate("Documents and Settings")
  WScript.Sleep 100
Wend

