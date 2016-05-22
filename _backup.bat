del _.zip
"C:\Program Files\7-Zip\7z.exe" a -tzip _.zip -mx9 -r "*.bat" "*.txt" "*.reg" "*.xml" "*.ini" "*.vbs" "4/*.dll" "4/*.zip" ".gitignore" "LICENSE"
if %errorlevel% neq 0 pause
