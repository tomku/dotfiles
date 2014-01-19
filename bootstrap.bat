@echo off
pushd %cd%
%~d0
cd %~dp0
echo Temporarily changing directory to %~dp0

if exist %USERPROFILE%\_vimrc goto GVIMRC
echo Installing _vimrc
echo set rtp+=%CD%\vim> %USERPROFILE%\_vimrc
echo source %CD%\vim\vimrc >> %USERPROFILE%\_vimrc

:GVIMRC
if exist %USERPROFILE%\_gvimrc goto END
echo Installing _gvimrc
echo source %CD%\vim\gvimrc > %USERPROFILE%\_gvimrc

:END
echo Done!
popd

