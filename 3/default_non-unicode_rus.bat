rem Win XP (requires full path)
rem rundll32.exe shell32, Control_RunDLL intl.cpl,,/f:"user_locale_rus.ini"
rem rundll32.exe shell32, Control_RunDLL intl.cpl,,/f:"D:\reg\WinXP\after_install\user_locale_rus.ini"
rundll32.exe shell32, Control_RunDLL intl.cpl,,/f:"%CD%\data\user_locale_rus.ini"
rem note, that it is not visible as updated if run the panel, even if change it from the panel itself (and then close and open the panel)
rem pause
if %errorlevel% neq 0 pause
