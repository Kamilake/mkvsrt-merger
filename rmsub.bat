@REM Encoding: EUC-KR .. ÀÚ¸· Á¦°Å¿ë µµ±¸ÀÔ´Ï´Ù.
ffmpeg -i "%~1" -c copy -map 0:0 -map 0:1 "%~p1%~n1.copy%~x1"
FOR /R %1 %%X IN (*.mkv *.mp4) DO (ffmpeg -i "%%X" -c copy -map 0:0 -map 0:1 "%%~pX%%~nX.copy%%~xX")
pause
