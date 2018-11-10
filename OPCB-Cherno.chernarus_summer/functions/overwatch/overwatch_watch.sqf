missionNamespace setVariable ["overwarch_taken",1,true];
_player = _this select 0;

waitUntil {
  sleep 1;

  !alive _player || (pc5 distance _player) > 10
};
missionNamespace setVariable ["overwarch_taken",0,true];