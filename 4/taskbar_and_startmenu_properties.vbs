'

Set WshShell = CreateObject("Wscript.Shell")

Set oShell = CreateObject("Shell.Application")
' *can also be run by "rundll32.exe SHELL32.DLL,Options_RunDLL 1"
oShell.TrayProperties

' we depend on that object very deeply, so lets create it for the first also
Set wnd_ctrls = CreateObject("Wnd_controls.WndCtrls")

While Not WshShell.AppActivate("Taskbar and Start Menu Properties")
  WScript.Sleep 10
Wend
WScript.Sleep 100

' "Lock the taskbar"
WshShell.Sendkeys "%L"
' off
WshShell.Sendkeys "-"
' "Auto-hide the taskbar"
WshShell.Sendkeys "%U"
' off
WshShell.Sendkeys "-"
' "Keep the taskbar on top of other windows"
WshShell.Sendkeys "%T"
' on
WshShell.Sendkeys "="
' "Group similar taskbar buttons"
WshShell.Sendkeys "%G"
' off
WshShell.Sendkeys "-"
' "Show Quick Launch"
WshShell.Sendkeys "%Q"
' on
WshShell.Sendkeys "="

' "Show the clock"
WshShell.Sendkeys "%K"
' on
WshShell.Sendkeys "="
' non-admin user (or maybe due to some other reasons - maybe because I am now trying on non-fresh-installed OS) requires to sleep here 2 or more ms, while originaly no sleep had been necessary here
WScript.Sleep 100
' "Hide inactive icons"
WshShell.Sendkeys "%H"
' off
WshShell.Sendkeys "-"
' test
'WshShell.Sendkeys "="
'WshShell.Sendkeys "{+}"

' navigate to "Start Menu" tab
' "Lock the taskbar"
' no, it changes the option
If 0 Then
WshShell.Sendkeys "%L"
WshShell.Sendkeys "+{tab}"
Else
WshShell.Sendkeys "{tab}"
WshShell.Sendkeys "{tab}"
WshShell.Sendkeys "{tab}"
WshShell.Sendkeys "{tab}"
End If
WshShell.Sendkeys "{right}"

' "Classic Start menu"
WshShell.Sendkeys "%M"

' *can't set it by normal way :  these checkboxes are only toggleable, but not settable
' it requires some wrapper to read their current value
If 1 Then
' "Customize..."
WshShell.Sendkeys "%C"

While Not WshShell.AppActivate("Customize Classic Start Menu")
  WScript.Sleep 10
Wend
' must sleep >= 2 ms
' but sometimes 100 ms is insufficient
'WScript.Sleep 100
WScript.Sleep 500

' go into the list
WshShell.Sendkeys "%T"
' in its end
WshShell.Sendkeys "{end}"
End If

' now have to acces at 'DLG_STARTMENU_CONFIG -> IDC_STARTMENUSETTINGS', which requires very special code, since it is a "SysTreeView32", with TVS_HASBUTTONS flag

' *sometimes bugs, even with 'Sleep 100', and gives button "Ad&vanced" instead
' nah, still bugs, if close "Customize Classic Start Menu" window, and try for the second time (but not first or third)
'WScript.Sleep 1000
'wnd_ctrls.Test
wnd_ctrls.ChooseWindowByName("Customize Classic Start Menu")
'WScript.Sleep 1000
'WScript.Sleep 500
wnd_ctrls.ChooseFocusedControl
' this one is also against "Wnd_controls.WndCtrls.1" error
' need to sleep >= 2 ms
'WScript.Sleep 500
'WScript.Sleep 1000
WScript.Sleep 100
' nope, such window is not present (there are no subwindows inside of this "SysTreeView32")
'wnd_ctrls.FocusSubwindowByName("Show Small Icons in Start menu")
'wnd_ctrls.FocusSubwindowByName("StartMenuSe&ttings")
'wnd_ctrls.GetCheckboxState(state)
'Dim image_ix
'Dim image_ix As Integer
'Dim image_ix As dword
'Dim image_ix As int
'Dim image_ix As Long
'wnd_ctrls.GetTreeViewItemImageIx(image_ix)
'wnd_ctrls.GetTreeViewItemImageIx(byref image_ix As Long)
' now, after setting a proper sleeps, it mostly works, but still sometimes is giving "Wnd_controls.WndCtrls.1", "80004005"
' ok, one more sleep was added, and now this error is eliminated
wnd_ctrls.GetTreeViewItemImageIx image_ix
'WScript.Sleep 500
'wnd_ctrls.GetTreeViewItemImageIx ByRef image_ix
'WScript.Echo "image ix is " & image_ix
'Dim state
'state = (Not image_ix) And 1
state = Not CBool(image_ix)
'WScript.Echo "button state is " & state

If state Then
WshShell.Sendkeys " "
End If

WshShell.Sendkeys "{UP}"

wnd_ctrls.GetTreeViewItemImageIx image_ix
state = Not CBool(image_ix)

If Not state Then
WshShell.Sendkeys " "
End If

' push Enter
WshShell.Sendkeys "~"

While WshShell.AppActivate("Customize Classic Start Menu")
  WScript.Sleep 10
Wend
WScript.Sleep 100

' push Enter
WshShell.Sendkeys "~"

' wait for close (otherwise it will not remember the changes)
While WshShell.AppActivate("Taskbar and Start Menu Properties")
  WScript.Sleep 10
Wend
WScript.Sleep 100

WScript.Quit



' by post of "mr_unreliable"
' *this requires an additional DLL, and since I am already using own DLL, I can make the code to be much shorter

' *requires Dynawrap
If 0 Then
Dim oDW : Set oDW = WScript.CreateObject("DynamicWrapper") ' no events
End If

If 0 Then
Dim hActWin
hActWin = GetActiveWindow()
End If


If 0 Then
Function GetActiveWindow()
Set oDW = nothing ' clear any previous instance
Set oDW = CreateObject("DynamicWrapper") ' start over...
' register (declare) this flavor of api call...
' (note: no parameters, so LEAVE OUT "i=" argument)...
oDW.Register "USER32.DLL", "GetActiveWindow", "f=s", "r=h"
GetActiveWindow = oDW.GetActiveWindow()
End Function

Function GetWindowText(hWnd, lpString, cch)
Set oDW = nothing ' clear any previous instance
Set oDW = CreateObject("DynamicWrapper") ' start over...
' register (declare) this flavor of api call...
' (note: string passed byref to allow for proper return address)...
oDW.Register "USER32.DLL", "GetWindowTextA", "i=lrl", "f=s", "r=h"
GetWindowText = oDW.GetWindowTextA(hWnd, lpString, cch)
End Function
End If

