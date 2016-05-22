.
#
'----------------------------------------------------------------------------------
'Author:Andrew Blokzyl
'Contact:drew@linuxkids.com
'
'Description:New workstation setup script
'----------------------------------------------------------------------------------
 
' *** INITIALIZE COMMON OBJECTS ***
'------------------------------------------------------------------------------------
Dim FileSystemObject
 
Set WshShell = CreateObject("Wscript.Shell")
Set FileSystemObject = CreateObject("Scripting.FileSystemObject")
'------------------------------------------------------------------------------------
 
' *** SETTING WINDOWS THEME TO WINDOWS CLASSIC ***
'------------------------------------------------------------------------------------
WshShell.Run "rundll32.exe Shell32.dll,Control_RunDLL desk.cpl desk,@Themes /Action:OpenTheme /File:""c:\windows\resources\themes\windows classic.theme""", 1
Wscript.Sleep 1600
WshShell.Sendkeys "{ENTER}"
WScript.Sleep 10000
'-------------------------------------------------------------------------------------
 
' *** TURN ON THE QUICKLAUNCH BAR ***
'-------------------------------------------------------------------------------------
WshShell.Run("rundll32.exe shell32.dll,Options_RunDLL 1")
WScript.Sleep 200
 
WshShell.AppActivate "Taskbar and Start Menu Properties"
WshShell.SendKeys "%Q"
WScript.Sleep 200
 
WshShell.AppActivate "Taskbar and Start Menu Properties"
WshShell.Sendkeys"%A"
WScript.Sleep 100
 
WshShell.AppActivate "Taskbar and Start Menu Properties"
WshShell.Sendkeys"{ENTER}"
WScript.Sleep 2000
'-------------------------------------------------------------------------------------
 
' *** SHOW DEFAULT DESKTOP ICONS ***
'-------------------------------------------------------------------------------------
' HIDDEN OR VISIBLE
' 1 = HIDDEN
' 0 = VISIBLE
' My Documents: "{450D8FBA-AD25-11D0-98A8-0800361B1103}"
' My Computer:  "{20D04FE0-3AEA-1069-A2D8-08002B30309D}"
' My Network Places: "{208D2C60-3AEA-1069-A2D7-08002B30309D}"
' Internet Explorer: "{871C5380-42A0-1069-A2EA-08002B30309D}"
' Recycle Bin: "{645FF040-5081-101B-9F08-00AA002F954E}"
 
sroot = "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel\"
WshShell.RegWrite sroot & "{450D8FBA-AD25-11D0-98A8-0800361B1103}", "00000000", "REG_DWORD"
WshShell.RegWrite sroot & "{20D04FE0-3AEA-1069-A2D8-08002B30309D}", "00000000", "REG_DWORD"
WshShell.RegWrite sroot & "{208D2C60-3AEA-1069-A2D7-08002B30309D}", "00000000", "REG_DWORD"
WshShell.RegWrite sroot & "{871C5380-42A0-1069-A2EA-08002B30309D}", "00000000", "REG_DWORD"
WshShell.RegWrite sroot & "{645FF040-5081-101B-9F08-00AA002F954E}", "00000000", "REG_DWORD"
'-------------------------------------------------------------------------------------
 
' *** DISABLE WINDOWS TOUR AND PASSPORT POP-UPS ***
'-------------------------------------------------------------------------------------
WshShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Applets\Tour\RunCount", 0, "REG_DWORD"
WshShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\MessengerService\PassportBalloon", 10, "REG_BINARY"
'-------------------------------------------------------------------------------------
 
' *** DIABLE WINDOWS FIREWALL ***
'-----------------------------------------------------------------------------------
Set objFirewall = CreateObject("HNetCfg.FwMgr")
Set objPolicy = objFirewall.LocalPolicy.CurrentProfile
 
objPolicy.FirewallEnabled = FALSE
'-----------------------------------------------------------------------------------
 
' *** TURN ON AUTOMATIC UPDATES ***
'-----------------------------------------------------------------------------------
WshShell.Run "rundll32.exe Shell32.dll,Control_RunDLL sysdm.cpl sysdm,5", 1
WScript.Sleep 1000
 
WshShell.Sendkeys"{TAB}"
WshShell.Sendkeys"{ }"
WScript.Sleep 1000
 
WshShell.Sendkeys"{ENTER}"
WScript.Sleep 2000
'-----------------------------------------------------------------------------------
 
' *** SHOW NETWORK CONNECTION IN SYSTEM TRAY ***
'-----------------------------------------------------------------------------------
WshShell.Run "rundll32.exe Shell32.dll,Control_RunDLL ncpa.cpl", 1
WScript.Sleep 1000
 
WshShell.Sendkeys"{ }"
WshShell.Sendkeys"%F"
WScript.Sleep 250
 
WshShell.Sendkeys"{r}"
Wscript.Sleep 250
 
WshShell.Sendkeys"{TAB}"
WshShell.Sendkeys"{TAB}"
WshShell.Sendkeys"{TAB}"
WshShell.Sendkeys"{TAB}"
WshShell.Sendkeys"{ }"
WScript.Sleep 250
 
WshShell.Sendkeys"{TAB}"
WshShell.Sendkeys"{TAB}"
WshShell.Sendkeys"{ENTER}"
WScript.Sleep 1000
 
WshShell.Sendkeys"%F"
WshShell.Sendkeys"c"
WScript.Sleep 2000
'-----------------------------------------------------------------------------------
 
' *** SET POWER MANAGEMENT TO ALWAYS ON ***
'-----------------------------------------------------------------------------------
WshShell.Run "rundll32.exe Shell32.dll,Control_RunDLL powercfg.cpl", 1
WScript.Sleep 1000
 
WshShell.Sendkeys"{TAB}"
WshShell.Sendkeys"{TAB}"
WshShell.Sendkeys"{TAB}"
WshShell.Sendkeys"{TAB}"
WshShell.Sendkeys"{TAB}"
WshShell.Sendkeys"n"
Wscript.Sleep 250
 
WshShell.Sendkeys"{ENTER}"
WScript.Sleep 2000
'-----------------------------------------------------------------------------------
 
' *** COPY i386 FOLDER TO C:\ IF IT ISNT ALREADY THERE***
'-------------------------------------------------------------------------------------
If (FileSystemObject.FolderExists( "d:\i386" )) Then
  If (FileSystemObject.FolderExists( "c:\i386" )) Then
    WshShell.Run "rd /s /q c:\i386
    WScript.Sleep 15000
    WshShell.Run "xcopy /e /c /y d:\i386 c:\i386\"
    WScript.Sleep 180000
  Else
    WshShell.Run "xcopy /e /c /y d:\i386 c:\i386\"
    WScript.Sleep 180000
  End If
End If
'-------------------------------------------------------------------------------------
 
' *** INSTALL RECOVERY CONSOLE ***
'-------------------------------------------------------------------------------------
If (FileSystemObject.FileExists("c:\i386\winnt32.exe")) Then
  WshShell.Run "c:\i386\winnt32.exe /cmdcons", 1
  WScript.Sleep 10000
  WshShell.Sendkeys "{ENTER}"
  WScript.Sleep 30000
  WshShell.Sendkeys "{ENTER}"
  WScript.Sleep 2000
End If
'-------------------------------------------------------------------------------------
 
' *** SETTING STARTUP OPTIONS ***
'-------------------------------------------------------------------------------------
WshShell.Run "rundll32.exe Shell32.dll,Control_RunDLL sysdm.cpl sysdm,3", 1
WScript.Sleep 1000
 
WshShell.Sendkeys"{TAB}"
WshShell.Sendkeys"{TAB}"
WshShell.Sendkeys"{ENTER}"
WScript.Sleep 1000
 
WshShell.Sendkeys"{TAB}"
WshShell.Sendkeys"{TAB}"
WshShell.Sendkeys"5"
 
WshShell.Sendkeys"{TAB}"
WshShell.Sendkeys"{TAB}"
WshShell.Sendkeys"{TAB}"
WshShell.Sendkeys"{TAB}"
WshShell.Sendkeys"{TAB}"
WshShell.Sendkeys"{TAB}"
WshShell.Sendkeys"{ }"
WScript.Sleep 1000
 
WshShell.Sendkeys"{ENTER}"
WScript.Sleep 1000
 
WshShell.Sendkeys"{ESC}"
'-----------------------------------------------------------------------------------
 
Wscript.Echo "All Finished!"
