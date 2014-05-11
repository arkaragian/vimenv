@echo off
title Uninstall LatexSuite

set /p var=Do you really want to delete LatexSuite(Y/N):%=%
@echo %var%

if /i "%var%"=="y" (
	echo to be implemented 
	goto :eof) 
