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

	echo "Creating mission folder links for %mapName%..."
	
	FOR /D %%A IN ("OPCB\*") DO (
		mklink /D "OPCB-%mapname%.%mapExtention%\%%~NA" "%%~A"
	)
	FOR %%A IN ("%OPCB%\*") DO (
		mklink "OPCB-%mapname%.%mapExtention%\%%~NXA" "%%~A"
	)
		
	mklink "OPCB-%mapname%.%mapExtention%\mission.sqm" "mission-files\%mapName%\mission.sqm"
	
	echo "Done!"
	pause
	
) else (

	echo "Error! Mission file for %mapName% doesn't exist in the mission-files folder!"
	pause
)