@echo off
chcp 65001 > nul
@REM [This file encoding = UTF-8]
@REM 아래에서 원하는 옵션을 켜고 끄거나 설정하세요.

@REM 언어 선택(kor,eng,jpn etc..)
SET Kamiconv_Language=kor

@REM 기존에 파일이 있을 때 덮어쓸까요? (y/n)
SET Kamiconv_Overwrite=n

@REM .smi 자막을 발견하면 자동으로 .srt로 변환 (y/n)
SET Kamiconv_SAMI_to_SubRip=y

@REM 자막 인코딩 (auto, cp949, EUC-KR, UTF-8 etc...)
SET Kamiconv_Encoding=auto
@REM SET Kamiconv_Encoding=-sub_charenc UTF-8

@REM ================================================================================
@REM ================================================================================
@REM ================================================================================
@REM ================================================================================
@REM ================================================================================

IF "%Kamiconv_Encoding%" == "auto" goto Kamiconv_Encoding_Auto
IF "%Kamiconv_Encoding%" == "AUTO" goto Kamiconv_Encoding_Auto
@REM 자동이 아니면 플래그로 지정
SET Kamiconv_Encoding=-sub_charenc %Kamiconv_Encoding%
goto Kamiconv_Encoding_Auto_End
:Kamiconv_Encoding_Auto
@REM 자동이면 공백으로 (주의! 공백 필수)
SET Kamiconv_Encoding= 
:Kamiconv_Encoding_Auto_End

echo ==MKV/MP4 SRT 병합 스크립트 2021.05.09==
echo ==Kamilake 제작==
setlocal

IF "%~1" == "" GOTO NOFILE_HELP
IF "%~2" == "" GOTO ONEFILE
IF "%~3" == "" GOTO TWOFILE
IF "%~4" == "" GOTO THREEFILE
GOTO NOFILE_HELP
:NOFILE_HELP
echo ====도움말====
echo 사용법: conv ^<파일 또는 폴더^> [파일] [출력] [/R]
echo.
echo         conv ^<비디오^> ^<자막^> [^<^출력할 파일명^>.^<확장자^>]
echo         또는
echo         conv ^<폴더^> [/R]
echo         또는
echo         conv ^<비디오^>
echo         (^* 비디오만 선택한다면 자막은 같은 이름을 가지고 .srt .ko.srt .kor.srt .ko.kor.srt .smi.srt .smi.ko.srt .smi.kor.srt .smi.ko.kor.srt .ass .ko.ass .kor.ass .ko.kor.ass .smi.ass .smi.ko.ass .smi.kor.ass .smi.ko.kor.ass 확장자를 가지고 있어야 합니다.)
echo.
GOTO END


============================================
============================================
============================================
============================================

:ONEFILE
IF EXIST %1\* GOTO ONEFILE_ONEDIR
echo 파일 1개 선택됨
IF "%Kamiconv_SAMI_to_SubRip%" == "n" GOTO ONEFILE_ENDSMITOSRT
IF EXIST "%~p1%~n1.smi" (ffmpeg %Kamiconv_Encoding% -i "%~p1%~n1.smi" "%~p1%~n1.srt" -%Kamiconv_Overwrite%)
:ONEFILE_ENDSMITOSRT


 IF EXIST "%~p1%~n1.srt" (ffmpeg -i "%~1" -f srt -i "%~p1%~n1.srt" -map 0 -map 1 -c:v copy -c:a copy -c:s srt -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%~p1%~n1_subs.mkv")
 IF EXIST "%~p1%~n1.ko.srt" (ffmpeg -i "%~1" -f srt -i "%~p1%~n1.ko.srt" -map 0 -map 1 -c:v copy -c:a copy -c:s srt -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%~p1%~n1_subs.mkv")
 IF EXIST "%~p1%~n1.kor.srt" (ffmpeg -i "%~1" -f srt -i "%~p1%~n1.kor.srt" -map 0 -map 1 -c:v copy -c:a copy -c:s srt -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%~p1%~n1_subs.mkv")
 IF EXIST "%~p1%~n1.ko.kor.srt" (ffmpeg -i "%~1" -f srt -i "%~p1%~n1.ko.kor.srt" -map 0 -map 1 -c:v copy -c:a copy -c:s srt -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%~p1%~n1_subs.mkv")

 IF EXIST "%~p1%~n1.ass" (ffmpeg -i "%~1" -f srt -i "%~p1%~n1.ass" -map 0 -map 1 -c:v copy -c:a copy -c:s ass -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%~p1%~n1_subs.mkv")
 IF EXIST "%~p1%~n1.ko.ass" (ffmpeg -i "%~1" -f srt -i "%~p1%~n1.ko.ass" -map 0 -map 1 -c:v copy -c:a copy -c:s ass -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%~p1%~n1_subs.mkv")
 IF EXIST "%~p1%~n1.kor.ass" (ffmpeg -i "%~1" -f srt -i "%~p1%~n1.kor.ass" -map 0 -map 1 -c:v copy -c:a copy -c:s ass -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%~p1%~n1_subs.mkv")
 IF EXIST "%~p1%~n1.ko.kor.ass" (ffmpeg -i "%~1" -f srt -i "%~p1%~n1.ko.kor.ass" -map 0 -map 1 -c:v copy -c:a copy -c:s ass -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%~p1%~n1_subs.mkv")


GOTO END
:ONEFILE_ONEDIR
echo 폴더 1개 선택됨
@REM 출력파일명 "%%~pX%%~nX_subs%%~xX"

IF "%Kamiconv_SAMI_to_SubRip%" == "n" GOTO ONEFILE_ONEDIR_ENDSMITOSRT
FOR /R %1 %%X IN (*.smi) DO (ffmpeg %Kamiconv_Encoding% -i "%%X" "%%~pX%%~nX.srt" -%Kamiconv_Overwrite%)
:ONEFILE_ONEDIR_ENDSMITOSRT



@REM not recursive walk를 원한다면 /r %1을 제거하고 cd %1로 폴더에 들어가야 한다.
FOR /R %1 %%X IN (*.mp4 *.mkv) DO (
 IF EXIST "%%~pX%%~nX.SVP%%~xX" (

  IF EXIST "%%~pX%%~nX.srt" (ffmpeg -i "%%~pX%%~nX.SVP%%~xX" -f srt -i "%%~pX%%~nX.srt" -map 0 -map 1 -c:v copy -c:a copy -c:s srt -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pX%%~nX_subs.mkv")
  IF EXIST "%%~pX%%~nX.ko.srt" (ffmpeg -i "%%~pX%%~nX.SVP%%~xX" -f srt -i "%%~pX%%~nX.ko.srt" -map 0 -map 1 -c:v copy -c:a copy -c:s srt -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pX%%~nX_subs.mkv")
  IF EXIST "%%~pX%%~nX.kor.srt" (ffmpeg -i "%%~pX%%~nX.SVP%%~xX" -f srt -i "%%~pX%%~nX.kor.srt" -map 0 -map 1 -c:v copy -c:a copy -c:s srt -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pX%%~nX_subs.mkv")
  IF EXIST "%%~pX%%~nX.ko.kor.srt" (ffmpeg -i "%%~pX%%~nX.SVP%%~xX" -f srt -i "%%~pX%%~nX.ko.kor.srt" -map 0 -map 1 -c:v copy -c:a copy -c:s srt -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pX%%~nX_subs.mkv")
  
  IF EXIST "%%~pX%%~nX.ass" (ffmpeg -i "%%~pX%%~nX.SVP%%~xX" -f srt -i "%%~pX%%~nX.ass" -map 0 -map 1 -c:v copy -c:a copy -c:s ass -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pX%%~nX_subs.mkv")
  IF EXIST "%%~pX%%~nX.ko.ass" (ffmpeg -i "%%~pX%%~nX.SVP%%~xX" -f srt -i "%%~pX%%~nX.ko.ass" -map 0 -map 1 -c:v copy -c:a copy -c:s ass -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pX%%~nX_subs.mkv")
  IF EXIST "%%~pX%%~nX.kor.ass" (ffmpeg -i "%%~pX%%~nX.SVP%%~xX" -f srt -i "%%~pX%%~nX.kor.ass" -map 0 -map 1 -c:v copy -c:a copy -c:s ass -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pX%%~nX_subs.mkv")
  IF EXIST "%%~pX%%~nX.ko.kor.ass" (ffmpeg -i "%%~pX%%~nX.SVP%%~xX" -f srt -i "%%~pX%%~nX.ko.kor.ass" -map 0 -map 1 -c:v copy -c:a copy -c:s ass -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pX%%~nX_subs.mkv")
 ) ELSE (
  IF EXIST "%%~pX%%~nX.srt" (ffmpeg -i "%%X" -f srt -i "%%~pX%%~nX.srt" -map 0 -map 1 -c:v copy -c:a copy -c:s srt -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pX%%~nX_subs.mkv")
  IF EXIST "%%~pX%%~nX.ko.srt" (ffmpeg -i "%%X" -f srt -i "%%~pX%%~nX.ko.srt" -map 0 -map 1 -c:v copy -c:a copy -c:s srt -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pX%%~nX_subs.mkv")
  IF EXIST "%%~pX%%~nX.kor.srt" (ffmpeg -i "%%X" -f srt -i "%%~pX%%~nX.kor.srt" -map 0 -map 1 -c:v copy -c:a copy -c:s srt -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pX%%~nX_subs.mkv")
  IF EXIST "%%~pX%%~nX.ko.kor.srt" (ffmpeg -i "%%X" -f srt -i "%%~pX%%~nX.ko.kor.srt" -map 0 -map 1 -c:v copy -c:a copy -c:s srt -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pX%%~nX_subs.mkv")
  
  IF EXIST "%%~pX%%~nX.ass" (ffmpeg -i "%%X" -f srt -i "%%~pX%%~nX.ass" -map 0 -map 1 -c:v copy -c:a copy -c:s ass -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pX%%~nX_subs.mkv")
  IF EXIST "%%~pX%%~nX.ko.ass" (ffmpeg -i "%%X" -f srt -i "%%~pX%%~nX.ko.ass" -map 0 -map 1 -c:v copy -c:a copy -c:s ass -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pX%%~nX_subs.mkv")
  IF EXIST "%%~pX%%~nX.kor.ass" (ffmpeg -i "%%X" -f srt -i "%%~pX%%~nX.kor.ass" -map 0 -map 1 -c:v copy -c:a copy -c:s ass -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pX%%~nX_subs.mkv")
  IF EXIST "%%~pX%%~nX.ko.kor.ass" (ffmpeg -i "%%X" -f srt -i "%%~pX%%~nX.ko.kor.ass" -map 0 -map 1 -c:v copy -c:a copy -c:s ass -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pX%%~nX_subs.mkv")
 )

 echo .
)




GOTO END


:TWOFILE
echo 파일 2개 선택됨 (아직 구현 안했어용)
GOTO END

:THREEFILE
echo 파일 3개 선택됨 (아직 구현 안했어용)
GOTO END

:END
echo 종료하려면 아무 키나 누르십시오...
pause > nul
exit

메모장

Ctrl+H
-map 0:0 -map 0:1 -map 1:0
-map 0
-map 0 -map 1:v -map 0:a
%~xI
ffmpeg -i input.mp4 -f srt -i input.srt \
 -map 0 -c:v copy -c:a copy \
 -c:s srt  output.mkv
 ffmpeg -i "input"\
 -f srt -i "srt"\
 -map 0 -c:v copy -c:a copy -c:s srt\
 -metadata:s:s:0 language=kor output.mkv


해결책
특정 변수 수정자를 사용해야합니다. 다음은 작동하는 예입니다.

if "%~x1" == ".ext" (echo File extension matches.)
사용 가능한 수정자
%~I         - expands %I removing any surrounding quotes (")
%~fI        - expands %I to a fully qualified path name
%~dI        - expands %I to a drive letter only
%~pI        - expands %I to a path only
%~nI        - expands %I to a file name only
%~xI        - expands %I to a file extension only
%~sI        - expanded path contains short names only
%~aI        - expands %I to file attributes of file
%~tI        - expands %I to date/time of file
%~zI        - expands %I to size of file
%~$PATH:I   - searches the directories listed in the PATH
               environment variable and expands %I to the
               fully qualified name of the first one found.
               If the environment variable name is not
               defined or the file is not found by the
               search, then this modifier expands to the
               empty string


               FOR /R [경로] %%변수 IN (집합) DO 명령어