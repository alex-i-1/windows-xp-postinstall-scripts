rundll32.exe shell32, Control_RunDLL intl.cpl,,/f:"%CD%\data\keyboard_en_ru_lt_gr.ini"
rem pause
if %errorlevel% neq 0 pause
