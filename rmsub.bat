@REM Encoding: EUC-KR .. �ڸ� ���ſ� �����Դϴ�.
ffmpeg -i "%~1" -c copy -map 0 "%~p1%~n1.copy%~x1"
FOR /R %1 %%X IN (*.mkv *.mp4) DO (ffmpeg -i "%%X" -c copy -map 0 "%%~pX%%~nX.copy%%xX")
pause
