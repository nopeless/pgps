REM(){ :;};alias @echo=REM
@echo off
REM;alias echo.=echo;alias @exit=_exit;_exit(){ echo;exit "$2";};

REM '
where.exe gpg >nul || (
echo Installing GnuPG...
winget install -e --id GnuPG.GnuPG --source winget --accept-source-agreements
doskey "gpg=C:\Program Files\GnuPG\bin\gpg.exe $*"
)
REM '; which gpg >/dev/null || ( echo "gpg is not installed"; exit 1 )

REM '
IF "%~1"=="" ( REM '; [ "$1" = "" ] && (
  echo Privacy Guard Password Script
  echo. 
  echo Zip and encrypt, decrypt and unzip with ease
  echo.
  echo. - Usage: pgps.cmd PATH

  REM '
  echo.
  echo Drag the .pgps file onto this script to extract it, or drag a folder/file to create a .pgps file.
  echo.

  pause REM '

  @exit /B 2
)

REM '
GOTO :cmd REM '

if [ "${1%.pgps}" != "$1" ]; then
  gpg -o "$1.tar.gz" -d "$1" && \
  tar -xzf "$1.tar.gz" && \
  rm -f "$1.tar.gz"
else
  gpg -o "$1.pgps" -c "$1.tar.gz" && \
  tar -czf "$1.tar.gz" "$1"
  rm -f "$1.tar.gz"
fi

exit 0

:cmd

IF "%~x1"==".pgps" (
gpg -o "%~1.tar.gz" -d "%~1" &&^
tar -xzf "%~1.tar.gz" &&^
del "%~1.tar.gz" 2>nul
) ELSE (
tar -czf "%~1.tar.gz" "%~nx1" &&^
gpg -o "%~1.pgps" -c "%~1.tar.gz"
del "%~1.tar.gz" 2>nul
)

pause
