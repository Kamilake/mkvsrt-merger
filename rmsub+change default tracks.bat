@REM Encoding: UTF-8.. 자막 제거용 도구입니다.
chcp 65001
ffmpeg -i "%~1" -c copy -map 0:0 -map 0:1 "%~p1%~n1.copy%~x1"
FOR /R %1 %%X IN (*.mkv *.mp4) DO (ffmpeg -i "%%X" -c copy -map 0:0 -map 0:2 -map 0:1 -disposition:a:0 default -disposition:a:1 none "%%~pX%%~nX.copy%%~xX")
pause
