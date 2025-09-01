params ["_amount", ["_msg",""]];
if (isNil "OPCB_econ_credits") then { OPCB_econ_credits = 0; };
OPCB_econ_credits = OPCB_econ_credits + _amount;
publicVariable "OPCB_econ_credits";

if (_msg isEqualTo "") then {
    hint format ["%1 C refunded.", _amount];
} else {
    hint format ["%1 (%2)", _amount, _msg];
};
