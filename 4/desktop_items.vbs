'

Set WshShell = CreateObject("Wscript.Shell")

' we depend on that object very deeply, so lets create it for the first also
Set wnd_ctrls = CreateObject("Wnd_controls.WndCtrls")

' run "Display Properties" -> "Desktop"
WshShell.Run "RUNDLL32.EXE SHELL32.DLL,Control_RunDLL desk.cpl,,0", 1

'Wscript.Sleep 5000
'WshShell.AppActivate("Desktop Properties")
'WshShell.AppActivate("Display Properties")
'WshShell.Sendkeys "%FC"
'WshShell.Sendkeys "{F4}"

While Not WshShell.AppActivate("Display Properties")
  WScript.Sleep 100
Wend

WshShell.SendKeys "%D"

While Not WshShell.AppActivate("Desktop Items")
  WScript.Sleep 100
Wend

If 0 Then
WScript.Echo "if-disabled"
' My Documents
WshShell.SendKeys "%D"
WScript.Sleep 100
' on
' oops !  +/- keys do not work for these controls here
WshShell.SendKeys "="
WScript.Quit
' My Computer
WshShell.SendKeys "%M"
' My Network Places
WshShell.SendKeys "%N"
' Internet Explorer
WshShell.SendKeys "%I"
End If

'wnd_ctrls.Test
wnd_ctrls.ChooseWindowByName("Desktop Items")

' too long
If 0 Then
WScript.Echo "if-disabled"
' My Documents
WshShell.SendKeys "%D"
' need to give some time to process that message
' *Sleep(10) is always sufficient
WScript.Sleep 100
wnd_ctrls.ChooseFocusedControl
'wnd_ctrls.GetCheckboxState is_on
is_on = wnd_ctrls.GetCheckboxState
'WScript.Echo "is_on is " & is_on
If is_on Then
WshShell.SendKeys "%D"
End If

' My Computer
'wnd_ctrls.ChooseSubwindowByNames "Button", "&My Computer"
WshShell.SendKeys "%M"
WScript.Sleep 100
wnd_ctrls.ChooseFocusedControl
is_on = wnd_ctrls.GetCheckboxState
If is_on Then
WshShell.SendKeys "%M"
End If

' My Network Places
'wnd_ctrls.ChooseSubwindowByNames "Button", "My &Network Places"
WshShell.SendKeys "%N"
WScript.Sleep 100
wnd_ctrls.ChooseFocusedControl
is_on = wnd_ctrls.GetCheckboxState
If is_on Then
WshShell.SendKeys "%N"
End If

' Internet Explorer
'wnd_ctrls.ChooseSubwindowByNames "Button", "&Internet Explorer"
WshShell.SendKeys "%I"
WScript.Sleep 100
wnd_ctrls.ChooseFocusedControl
is_on = wnd_ctrls.GetCheckboxState
If is_on Then
WshShell.SendKeys "%I"
End If
End If

' still too long
If 0 Then
' My Documents
' nah, FindWindowEx looks like doesn't recurse
'wnd_ctrls.ChooseSubwindowByNames "Button", "My &Documents"
'wnd_ctrls.ChooseSubwindowByNames vbNullString, "My &Documents"
WshShell.SendKeys "%D"
' need to give some time to process that message
' *Sleep(10) is always sufficient
WScript.Sleep 100
wnd_ctrls.ChooseFocusedControl
wnd_ctrls.SetCheckboxState 1

' My Computer
'wnd_ctrls.ChooseSubwindowByNames "Button", "&My Computer"
WshShell.SendKeys "%M"
WScript.Sleep 100
wnd_ctrls.ChooseFocusedControl
wnd_ctrls.SetCheckboxState 1

' My Network Places
'wnd_ctrls.ChooseSubwindowByNames "Button", "My &Network Places"
WshShell.SendKeys "%N"
WScript.Sleep 100
wnd_ctrls.ChooseFocusedControl
wnd_ctrls.SetCheckboxState 0

' Internet Explorer
'wnd_ctrls.ChooseSubwindowByNames "Button", "&Internet Explorer"
WshShell.SendKeys "%I"
WScript.Sleep 100
wnd_ctrls.ChooseFocusedControl
wnd_ctrls.SetCheckboxState 0
End If

' My Documents
wnd_ctrls.ChooseSubwindowByNames "Button", "My &Documents"
'wnd_ctrls.ChooseSubwindowByNames vbNullString, "My &Documents"
wnd_ctrls.SetCheckboxState 1

' My Computer
wnd_ctrls.ChooseSubwindowByNames "Button", "&My Computer"
wnd_ctrls.SetCheckboxState 1

' My Network Places
wnd_ctrls.ChooseSubwindowByNames "Button", "My &Network Places"
wnd_ctrls.SetCheckboxState 0

' hmmm, there is no IE checkbox here, in WinXP SP3
If 0 Then
' Internet Explorer
wnd_ctrls.ChooseSubwindowByNames "Button", "&Internet Explorer"
wnd_ctrls.SetCheckboxState 0
End If

' Run Desktop Cleanup Wizard every 60 days
' *for this control, +/- keys do work
WshShell.SendKeys "%U"
WshShell.SendKeys "-"

' Enter
WshShell.SendKeys "~"

Do
  WScript.Sleep 100
Loop While WshShell.AppActivate ("Desktop Items")

' Enter
WshShell.SendKeys "~"

Do
  WScript.Sleep 100
Loop While WshShell.AppActivate ("Display Properties")

WScript.Quit

