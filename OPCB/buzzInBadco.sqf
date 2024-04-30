fnc_buzzInOutBadco = 
{
	params ["_gate_obj"];
	_clanStatus = (squadparams player select 0) select 0;
    switch (_clanStatus) do { 
        case "B.A.D. PMC": {[_gate_obj] spawn fnc_buzzInOut;}; 
        case "Bad Co": {[_gate_obj] spawn fnc_buzzInOut;}; 
        default { 
              hint "Area access restricted to BadCO members only.";  
    }; 
  };
};
