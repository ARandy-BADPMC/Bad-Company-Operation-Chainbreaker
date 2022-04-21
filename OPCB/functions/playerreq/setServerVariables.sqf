
{
	_select = missionNamespace getVariable _x;
	[missionNamespace,[_x,_select]] remoteExec ["setVariable",remoteExecutedOwner];
} forEach ["MaxTanks","MaxAttackHelis","MaxTransHelis","MaxAPC","MaxStatic"];