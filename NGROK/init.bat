@echo off
chcp 65001 >nul
setlocal

REM Config
set "CRED_USER=acquaadmin2025"
set "CRED_PASS=eliziario12"
set "NGROK_EXE=%~dp0ngrok.exe"

echo ==== START NGROK ====
echo Pasta do script: %~dp0
echo.

if not exist "%NGROK_EXE%" (
    echo ERRO: ngrok.exe nao encontrado
    pause
    exit /b 1
)

REM Lê ip.txt
set "TARGET="
for /f "usebackq tokens=* delims=" %%B in ("%~dp0ip.txt") do (
    if not defined TARGET set "TARGET=%%~B"
)
set "TARGET=%TARGET:"=%"

if "%TARGET%"=="" (
    echo ERRO: ip.txt vazio ou invalido
    pause
    exit /b 1
)

echo Iniciando ngrok para %TARGET% com basic-auth...
"%NGROK_EXE%" http "%TARGET%" --basic-auth="%CRED_USER%:%CRED_PASS%"

echo.
echo NGROK encerrou. Pressione qualquer tecla para fechar.
pause
endlocal
