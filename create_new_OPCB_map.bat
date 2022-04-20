@echo off


set mapName=Sahrani
set mapExtention=sara
























goto check_Permissions

:check_Permissions
    net session >nul 2>&1
    if not %errorLevel% == 0 (
			echo ERROR : The script must be run as Administrator!
			pause
			exit
    )
    
cd %~dp0

if exist mission-files\%mapName%\mission.sqm (

	echo "Creating mission folder link for %mapName%..."

	mklink /J OPCB-%mapname%.%mapExtention% OPCB
	mklink "OPCB-%mapname%.%mapExtention%\mission.sqm" "mission-files\%mapName%\mission.sqm"
	
	echo "Done!"
	pause
	
) else (

	echo "Error! Mission file for %mapName% doesn't exist in the mission-files folder!"
	pause
)