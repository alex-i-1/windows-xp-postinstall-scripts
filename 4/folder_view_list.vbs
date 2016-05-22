'

Set WshShell = CreateObject("Wscript.Shell")

' we depend on that object very deeply, so lets create it for the first also
Set wnd_ctrls = CreateObject("Wnd_controls.WndCtrls")

' open folder "C:\"
'WshShell.Run "explorer.exe ""c:\""", 1
' "C:\" is not being shown on a fresh XP; use something different
WshShell.Run "explorer.exe ""C:\Documents and Settings""", 1

'While Not WshShell.AppActivate("Local Disk (C:)")
While Not WshShell.AppActivate("Documents and Settings")
  WScript.Sleep 100
Wend

' this is nearly impossible to get the status of "Status &Bar" checkbox; lets instead look - is the statusbar window visible or not
'wnd_ctrls.Test
wnd_ctrls.ChooseWindowByName("Documents and Settings")
'WScript.Sleep 500
'wnd_ctrls.ChooseFocusedControl
'wnd_ctrls.GetListViewItemImageIx image_ix
'WScript.Echo "gotten image_ix is " & image_ix
'wnd_ctrls.ChooseMenuItemByName "Status &Bar"
' STATUSCLASSNAME
'wnd_ctrls.ChooseSubwindowByClassname "msctls_statusbar32"
' '0' is converted to "0"
'wnd_ctrls.ChooseSubwindowByNames "msctls_statusbar32", 0
'wnd_ctrls.ChooseSubwindowByNames "msctls_statusbar32", Null
'wnd_ctrls.ChooseSubwindowByNames("msctls_statusbar32",)
'wnd_ctrls.ChooseSubwindowByNames("msctls_statusbar32", null)
' error: Type mismatch
'wnd_ctrls.ChooseSubwindowByNames "msctls_statusbar32", null
' this way it works :  the gotten 'BSTR' is 0
wnd_ctrls.ChooseSubwindowByNames "msctls_statusbar32", vbNullString
'is_visible = wnd_ctrls.IsWindowVisible
'is_visible = Not Not wnd_ctrls.IsWindowVisible
is_visible = CBool(wnd_ctrls.IsWindowVisible)
'WScript.Echo "is_visible is " & is_visible

If Not is_visible Then
'If is_visible = 0 Then
'WshShell.Sendkeys "%"
' focus Statusbar checkbox
'WshShell.Sendkeys "%(V)"
WshShell.Sendkeys "%(VB)"
'WshShell.Sendkeys "%(A)"
'WshShell.Sendkeys "{UP}"
'WshShell.Sendkeys "{DOWN}"
'WshShell.Sendkeys "{DOWN}"
'WshShell.Sendkeys "{DOWN}"
'WshShell.Sendkeys "{DOWN}"
End If

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

