powercfg.exe -change "Always On" -monitor-timeout-ac 30
rem there is some problem in WinXP, so the disk never actually goes sleep
powercfg.exe -change "Always On" -disk-timeout-ac 60
powercfg.exe -change "Always On" -standby-timeout-ac 0
powercfg.exe -change "Always On" -hibernate-timeout-ac 0
powercfg.exe -hibernate off
powercfg.exe -setactive "Always On"
rem pause
if %errorlevel% neq 0 pause
