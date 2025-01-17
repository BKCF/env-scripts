@echo off 
echo RUN THIS IN VS DEVELOPER POWERSHELL
set CWD=%CD%
set SCRIPT_DIR=%~dp0
cd %SCRIPT_DIR%

REM build LHM dependency and copy outputs to btop4win build folder
msbuild .\LHM-CPPExport\LHM-Exporter.sln /t:Clean;Build /m /p:Configuration=Release /p:Platform=x64 
REM I did
REM > vcpkg remove abseil
REM and there were no linker issues requiring the below flag when vs rebuilt it.
REM /p:AdditionalOptions="/FORCE:MULTIPLE"
REM rd .\btop4win\external /s /q
mkdir .\btop4win\external
copy .\LHM-CPPExport\x64\Release\*.dll .\btop4win\external
copy .\LHM-CPPExport\x64\Release\*.lib .\btop4win\external

REM build btop4win and copy it to bin as 'btop'
msbuild .\btop4win\btop4win.sln /p:Configuration=Release-LHM /p:Platform=x64
copy .\btop4win\x64\Release-LHM\btop4win.exe C:\dev\bin\btop.exe