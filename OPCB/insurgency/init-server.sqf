#include "defines.sqf"
#include "common\initserver-common.sqf"

"insurgencyMarkerUpdate" addPublicVariableEventHandler {
		Hz_pers_var_insurgencyClearedMarkers pushBackUnique insurgencyMarkerUpdate;
		
		// check if we progressed a tier and update
		_newTier = (ceil (10 - ((1 min ((count Hz_pers_var_insurgencyClearedMarkers) / ins_halfMarkerCount))*10))) - 1;
		if (_newTier != OPCB_econ_currentTier) then {
			OPCB_econ_currentTier = _newTier;
			publicVariable "OPCB_econ_currentTier";
		};
		
};