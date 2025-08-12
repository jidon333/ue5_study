@echo off

call msbuild_run.bat msb_main_client.xml /p:GlobalConfig=Development /t:Package_Client

pause
