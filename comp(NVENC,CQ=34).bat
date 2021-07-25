@REM Encoding: UTF-8.. 
chcp 65001
ffmpeg -i "%~1" -preset slow -c:v hevc_nvenc -cq:v 34 -y "%~p1%~n1_저용량(NVENC)%~x1"
FOR /R %1 %%X IN (*.mkv *.mp4) DO (ffmpeg -i "%%X"  -preset slow -c:v hevc_nvenc -cq:v 34 -y "%%~pX%%~nX_저용량(NVENC)%%~xX")

pause