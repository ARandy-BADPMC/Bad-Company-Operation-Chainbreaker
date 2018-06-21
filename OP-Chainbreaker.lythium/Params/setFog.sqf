if (isServer) then
{
	_fog = param [0,0,[999]];

	If (_fog == 0) Then {0 setFog [0,0,0]};
	If (_fog == 1) Then {0 setFog [0.1,0.001,0]};
	If (_fog == 2) Then {0 setFog [0.3,0.001,0]};
	If (_fog == 3) Then {0 setFog [0.5,0.001,0]};
	If (_fog == 4) Then {0 setFog [0.8,0.001,0]};
};
