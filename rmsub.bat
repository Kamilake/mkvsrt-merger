@REM Encoding: EUC-KR .. 자막 제거용 도구입니다.
ffmpeg -i "%~1" -c copy -map 0 "%~p1%~n1.copy%~x1"
FOR /R %1 %%X IN (*.mkv *.mp4) DO (ffmpeg -i "%%X" -c copy -map 0 "%%~pX%%~nX.copy%%xX")
pause
