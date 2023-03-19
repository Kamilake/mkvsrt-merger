@echo off
chcp 65001 > nul
setlocal
cls

@REM [The encoding of this file = UTF-8]
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

@REM 자동이 아니면 플래그로 지정
IF "%Kamiconv_Encoding%" == "auto" goto Kamiconv_Encoding_Auto
IF "%Kamiconv_Encoding%" == "AUTO" goto Kamiconv_Encoding_Auto

@REM 자동이 아닌 Manual일 시 Auto 구간 스킵
SET Kamiconv_Encoding=-sub_charenc %Kamiconv_Encoding%
goto Kamiconv_Encoding_Auto_End

:Kamiconv_Encoding_Auto
@REM 자동이면 공백으로 (주의! 공백 필수)
SET Kamiconv_Encoding= 
:Kamiconv_Encoding_Auto_End

echo ==MKV/MP4 SRT 병합 스크립트 2023.03.18==
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
IF EXIST "%~pn1.smi" (ffmpeg %Kamiconv_Encoding% -i "%~pn1.smi" "%~pn1.srt" -%Kamiconv_Overwrite%)

:ONEFILE_ENDSMITOSRT
IF EXIST "%~pn1.srt" (ffmpeg -i "%~1" -f srt -i "%~pn1.srt" -map 0 -map 1 -c:v copy -c:a copy -c:s srt -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%~pn1_subs.mkv")
IF EXIST "%~pn1.ko.srt" (ffmpeg -i "%~1" -f srt -i "%~pn1.ko.srt" -map 0 -map 1 -c:v copy -c:a copy -c:s srt -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%~pn1_subs.mkv")
IF EXIST "%~pn1.kor.srt" (ffmpeg -i "%~1" -f srt -i "%~pn1.kor.srt" -map 0 -map 1 -c:v copy -c:a copy -c:s srt -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%~pn1_subs.mkv")
IF EXIST "%~pn1.ko.kor.srt" (ffmpeg -i "%~1" -f srt -i "%~pn1.ko.kor.srt" -map 0 -map 1 -c:v copy -c:a copy -c:s srt -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%~pn1_subs.mkv")

IF EXIST "%~pn1.ass" (ffmpeg -i "%~1" -f ass -i "%~pn1.ass" -map 0 -map 1 -c:v copy -c:a copy -c:s ass -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%~pn1_subs.mkv")
IF EXIST "%~pn1.ko.ass" (ffmpeg -i "%~1" -f ass -i "%~pn1.ko.ass" -map 0 -map 1 -c:v copy -c:a copy -c:s ass -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%~pn1_subs.mkv")
IF EXIST "%~pn1.kor.ass" (ffmpeg -i "%~1" -f ass -i "%~pn1.kor.ass" -map 0 -map 1 -c:v copy -c:a copy -c:s ass -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%~pn1_subs.mkv")
IF EXIST "%~pn1.ko.kor.ass" (ffmpeg -i "%~1" -f ass -i "%~pn1.ko.kor.ass" -map 0 -map 1 -c:v copy -c:a copy -c:s ass -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%~pn1_subs.mkv")
GOTO END

:ONEFILE_ONEDIR
echo 폴더 1개 선택됨

@REM 출력파일명 "%%~pnF_subs%%~xF"
IF "%Kamiconv_SAMI_to_SubRip%" == "n" GOTO ONEFILE_ONEDIR_ENDSMITOSRT
FOR /R %1 %%F IN (*.smi) DO (ffmpeg %Kamiconv_Encoding% -i "%%F" "%%~pnF.srt" -%Kamiconv_Overwrite%)
:ONEFILE_ONEDIR_ENDSMITOSRT

@REM 폰트 체크
setlocal EnableDelayedExpansion
FOR /F "tokens=*" %%F IN ('powershell.exe -ExecutionPolicy Bypass -File .\fontfinder.ps1 %1') DO (
    SET "FILENAMES=!FILENAMES! "%%F""
)

IF NOT DEFINED FILENAMES GOTO ENCODE

IF NOT EXIST %1\fonts\* GOTO FONTFOLDERERR

@REM ASS에 있는 폰트들과 병합할 폰트들 체크
SETLOCAL EnableDelayedExpansion
SET FLG=0
SET MISSING=0
SET Kamiconv_FontEvaluator=
FOR %%N in (%FILENAMES%) DO (
  SET FLG=0
  SET BREAK=
  FOR /R %1\fonts %%F IN (*.ttf *.otf) DO IF NOT DEFINED BREAK (
    echo %%~nF | find /i %%N > nul
    IF NOT ERRORLEVEL 1 (
      SET "INCLUDEFONT=!INCLUDEFONT! -attach "%%~pnFF""
      SET FLG=1
      echo Include : %%N
      SET BREAK=YES
    )
  )
  IF !FLG! EQU 0 (
    SET "MISSINGFONT=!MISSINGFONT! %%N"
    SET MISSING=1
    echo Missing : %%N
  )
)

IF %MISSING% EQU 1 (
  echo.
  echo 경고: 현재 누락된 폰트가 있습니다^^!
  echo 누락된 모든 폰트는 다음과 같습니다: %MISSINGFONT%
  echo.
  GOTO SKIPQUES
) ELSE (
  echo.
  echo 모든 폰트가 준비 완료되었습니다^^!
  echo.
  GOTO ENCQUES
)

:SKIPQUES
SET /P YN=무시하고 진행하시겠습니까? (Y/N)? 
:CONFIRM
IF /I "%YN%" == "y" GOTO ENCODE
IF /I "%YN%" == "n" GOTO FONTPLZ
echo Y/y 또는 N/n만 입력해주세요!
GOTO CONFIRM

:ENCQUES
SET /P YN=진행하시겠습니까? (Y/N)? 
:CONFIRM
IF /I "%YN%" == "y" GOTO ENCODE
IF /I "%YN%" == "n" GOTO END
echo Y/y 또는 N/n만 입력해주세요!
GOTO CONFIRM

:ENCODE
@REM not recursive walk를 원한다면 /r %1을 제거하고 cd %1로 폴더에 들어가야 한다.
FOR /R %1 %%F IN (*.mp4 *.mkv) DO (
  IF EXIST "%%~pnF.SVP%%~xF" (
    IF EXIST "%%~pnF.srt" (ffmpeg -i "%%~pnF.SVP%%~xF" -f srt -i "%%~pnF.srt" -map 0 %INCLUDEFONT% -metadata:s:t mimetype=application/x-truetype-font -map 1 -c:v copy -c:a copy -c:s srt -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pnF_subs.mkv")
    IF EXIST "%%~pnF.ko.srt" (ffmpeg -i "%%~pnF.SVP%%~xF" -f srt -i "%%~pnF.ko.srt" -map 0 %INCLUDEFONT% -metadata:s:t mimetype=application/x-truetype-font -map 1 -c:v copy -c:a copy -c:s srt -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pnF_subs.mkv")
    IF EXIST "%%~pnF.kor.srt" (ffmpeg -i "%%~pnF.SVP%%~xF" -f srt -i "%%~pnF.kor.srt" -map 0 %INCLUDEFONT% -metadata:s:t mimetype=application/x-truetype-font -map 1 -c:v copy -c:a copy -c:s srt -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pnF_subs.mkv")
    IF EXIST "%%~pnF.ko.kor.srt" (ffmpeg -i "%%~pnF.SVP%%~xF" -f srt -i "%%~pnF.ko.kor.srt" -map 0 %INCLUDEFONT% -metadata:s:t mimetype=application/x-truetype-font -map 1 -c:v copy -c:a copy -c:s srt -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pnF_subs.mkv")
    
    IF EXIST "%%~pnF.ass" (ffmpeg -i "%%~pnF.SVP%%~xF" -f ass -i "%%~pnF.ass" -map 0 %INCLUDEFONT% -metadata:s:t mimetype=application/x-truetype-font -map 1 -c:v copy -c:a copy -c:s ass -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pnF_subs.mkv")
    IF EXIST "%%~pnF.ko.ass" (ffmpeg -i "%%~pnF.SVP%%~xF" -f ass -i "%%~pnF.ko.ass" -map 0 %INCLUDEFONT% -metadata:s:t mimetype=application/x-truetype-font -map 1 -c:v copy -c:a copy -c:s ass -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pnF_subs.mkv")
    IF EXIST "%%~pnF.kor.ass" (ffmpeg -i "%%~pnF.SVP%%~xF" -f ass -i "%%~pnF.kor.ass" -map 0 %INCLUDEFONT% -metadata:s:t mimetype=application/x-truetype-font -map 1 -c:v copy -c:a copy -c:s ass -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pnF_subs.mkv")
    IF EXIST "%%~pnF.ko.kor.ass" (ffmpeg -i "%%~pnF.SVP%%~xF" -f ass -i "%%~pnF.ko.kor.ass" -map 0 %INCLUDEFONT% -metadata:s:t mimetype=application/x-truetype-font -map 1 -c:v copy -c:a copy -c:s ass -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pnF_subs.mkv")
  ) ELSE (
    IF EXIST "%%~pnF.srt" (ffmpeg -i "%%F" -f srt -i "%%~pnF.srt" -map 0 %INCLUDEFONT% -metadata:s:t mimetype=application/x-truetype-font -map 1 -c:v copy -c:a copy -c:s srt -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pnF_subs.mkv")
    IF EXIST "%%~pnF.ko.srt" (ffmpeg -i "%%F" -f srt -i "%%~pnF.ko.srt" -map 0 %INCLUDEFONT% -metadata:s:t mimetype=application/x-truetype-font -map 1 -c:v copy -c:a copy -c:s srt -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pnF_subs.mkv")
    IF EXIST "%%~pnF.kor.srt" (ffmpeg -i "%%F" -f srt -i "%%~pnF.kor.srt" -map 0 %INCLUDEFONT% -metadata:s:t mimetype=application/x-truetype-font -map 1 -c:v copy -c:a copy -c:s srt -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pnF_subs.mkv")
    IF EXIST "%%~pnF.ko.kor.srt" (ffmpeg -i "%%F" -f srt -i "%%~pnF.ko.kor.srt" -map 0 %INCLUDEFONT% -metadata:s:t mimetype=application/x-truetype-font -map 1 -c:v copy -c:a copy -c:s srt -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pnF_subs.mkv")
    
    IF EXIST "%%~pnF.ass" (ffmpeg -i "%%F" -f ass -i "%%~pnF.ass" -map 0 %INCLUDEFONT% -metadata:s:t mimetype=application/x-truetype-font -map 1 -c:v copy -c:a copy -c:s ass -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pnF_subs.mkv")
    IF EXIST "%%~pnF.ko.ass" (ffmpeg -i "%%F" -f ass -i "%%~pnF.ko.ass" -map 0 %INCLUDEFONT% -metadata:s:t mimetype=application/x-truetype-font -map 1 -c:v copy -c:a copy -c:s ass -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pnF_subs.mkv")
    IF EXIST "%%~pnF.kor.ass" (ffmpeg -i "%%F" -f ass -i "%%~pnF.kor.ass" -map 0 %INCLUDEFONT% -metadata:s:t mimetype=application/x-truetype-font -map 1 -c:v copy -c:a copy -c:s ass -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pnF_subs.mkv")
    IF EXIST "%%~pnF.ko.kor.ass" (ffmpeg -i "%%F" -f ass -i "%%~pnF.ko.kor.ass" -map 0 %INCLUDEFONT% -metadata:s:t mimetype=application/x-truetype-font -map 1 -c:v copy -c:a copy -c:s ass -metadata:s:s:0 language=%Kamiconv_Language% -%Kamiconv_Overwrite% "%%~pnF_subs.mkv")
  )
)
GOTO END

:TWOFILE
echo 파일 2개 선택됨 (아직 구현 안했어용)
GOTO END

:THREEFILE
echo 파일 3개 선택됨 (아직 구현 안했어용)
GOTO END

:FONTPLZ
echo.
echo 모든 폰트 파일을 이름에 맞게 준비 후 %1fonts 안에 넣어주신 뒤 다시 실행해주세요^^!
GOTO END

:FONTFOLDERERR
echo.
echo 경고^^!
echo 폰트 폴더가 존재하지 않습니다. %~pn1fonts에 다음과 같은 폰트를 넣어주신 뒤 다시 실행해주세요.
echo 자막에서 요구되는 폰트는 다음과 같습니다:
FOR %%N in (%FILENAMES%) DO (
  echo %%N
)
GOTO END

:END
echo 종료하려면 아무 키나 누르십시오...
pause > nul
exit
