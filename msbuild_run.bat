@echo off

set VSWHERE_PATH="%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
rem echo %VSWHERE_PATH%

if exist %VSWHERE_PATH% (
    for /f "usebackq tokens=*" %%i in (`%VSWHERE_PATH% -latest -products * -requires Microsoft.Component.MSBuild -property installationPath`) do (
        set MSBUILD_FOLDER=%%i
    )
) 

rem echo folder: %MSBUILD_FOLDER%
rem echo "%MSBUILD_FOLDER%\MSBuild\15.0\Bin\MSBuild.exe"

if exist "%MSBUILD_FOLDER%\MSBuild\15.0\Bin\MSBuild.exe" (
    rem VS2017
    set MSBUILD_PATH="%MSBUILD_FOLDER%\MSBuild\15.0\Bin\MSBuild.exe"
) else if exist "%MSBUILD_FOLDER%\MSBuild\Current\Bin\MSBuild.exe" (
    rem VS2019
    set MSBUILD_PATH="%MSBUILD_FOLDER%\MSBuild\Current\Bin\MSBuild.exe"
) else (
    rem use VS2015's msbuild path
    set MSBUILD_PATH="%ProgramFiles(x86)%\MSBuild\14.0\Bin\MSBuild.exe"
)

echo using msbuild: %MSBUILD_PATH%
%MSBUILD_PATH%  %*

exit /B %errorlevel%
