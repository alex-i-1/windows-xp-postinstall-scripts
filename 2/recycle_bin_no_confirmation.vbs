'

Set WshShell = CreateObject("Wscript.Shell")

Set oShell = CreateObject("Shell.Application")
Const CLSID = "::{645FF040-5081-101B-9F08-00AA002F954E}" ' (recycle bin clsid)
Set oRecycleBin = oShell.Namespace(0).ParseName(CLSID)
oRecycleBin.InvokeVerb "P&roperties" ' (english)

While Not WshShell.AppActivate("Recycle Bin Properties")
  WScript.Sleep 100
Wend

'oRecycleBin.InvokeVerb "&Display delete confirmation dialog" ' (english)
'oRecycleBin.AppActivate("&Display delete confirmation dialog") ' (english)
'oShell.AppActivate("&Display delete confirmation dialog") ' (english)
'WshShell.AppActivate("&Display delete confirmation dialog") ' (english)
'WshShell.AppActivate("Display delete confirmation dialog") ' (english)
'WScript.Sleep(1000)
' ensure "Use one settings for all drives" is active, otherwise the necessary checkbox will be grayed
WshShell.Sendkeys "%U"
' something here needs to be activated; 'Sleep(20)' is sometimes insufficient, 40 is always enough
WScript.Sleep(100)
' focus to "Display delete confirmation dialog"
WshShell.Sendkeys "%D"
' turn it off - push '-'
WshShell.Sendkeys "-"
'WScript.Sleep(1000)
' push Enter
WshShell.Sendkeys "~"
'WScript.Sleep(3000)

'' give some time for it to work
'WScript.Sleep(1000)
' wait for close (otherwise it will not remember the changes)
While WshShell.AppActivate("Recycle Bin Properties")
  WScript.Sleep 100
Wend

