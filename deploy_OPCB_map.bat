@echo off


set mapName=Sahrani
set mapExtention=sara


























if exist mission-files\%mapName%\mission.sqm (

	echo Deploying %mapName%.%mapExtention%...
	
	mkdir OPCB-%mapname%.%mapExtention%
	echo Copying files
	xcopy OPCB "OPCB-%mapname%.%mapExtention%" /s /e /q
	echo Copying mission file
	copy "mission-files\%mapName%\mission.sqm" "OPCB-%mapname%.%mapExtention%\mission.sqm"
	
	echo Done!
	echo Remember to use the generated folder only for pbo deployment or testing in editor. Delete it before pushing commits to the repo!
	pause
	
) else (

	echo Error! Mission file for %mapName% doesn't exist in the mission-files folder! If you're creating a new OPCB map, create a new mission in the editor first, and then copy its mission.sqm into a new folder named %mapName% under mission-files
	pause
)