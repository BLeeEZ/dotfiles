@echo off

:: Commands
DOSKEY ls=dir /B $*
DOSKEY gst=git status

DOSKEY ..=cd ..
DOSKEY ...=cd ../../
DOSKEY ....=cd ../../../
DOSKEY .....=cd ../../../../