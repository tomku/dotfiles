@echo off
pushd %cd%
%~d0
cd %~dp0
cd ..

if exist %USERPROFILE%\_vimrc goto GVIMRC
echo set rtp+=%CD%\dotfiles\vim> %USERPROFILE%\_vimrc
echo set rtp+=%CD%\.vim>> %USERPROFILE%\_vimrc

REM echo let ^&runtimepath = printf('%%s,%%s', '%CD%\.vim\vimfiles', ^&runtimepath) >> %USERPROFILE%\_vimrc
echo source %CD%\dotfiles\vim\vimrc >> %USERPROFILE%\_vimrc

:GVIMRC
if exist %USERPROFILE%\_gvimrc goto END
echo source %CD%\dotfiles\vim\gvimrc > %USERPROFILE%\_gvimrc

:END
popd

