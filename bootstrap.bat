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
if exist %USERPROFILE%\_gvimrc goto EMACS_DIR
echo Installing _gvimrc
echo source %CD%\vim\gvimrc > %USERPROFILE%\_gvimrc

:EMACS_DIR
if exist %USERPROFILE%\.emacs.d goto EMACS
mkdir %USERPROFILE%\.emacs.d

:EMACS
if exist %USERPROFILE%\.emacs.d\init.el goto END
echo Installing init.el
set CD_SLASHED=%CD:\=/%
echo (load "%CD_SLASHED%/emacs/init.el") > %USERPROFILE%\.emacs.d\init.el

:END
echo Done!
popd

