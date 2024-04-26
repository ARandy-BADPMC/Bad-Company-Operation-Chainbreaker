if (!hasInterface) exitWith {};
waitUntil {!isNull player};


// ====================================================================================
// NOTES: Credits
// The code below creates the mission sub-section of notes.

_mis = player createDiaryRecord ["diary", ["Credits","
ACE Public Development Team:
<br/>
K.Hunter [B.A.D. PMC]
<br/>
A. Randy [B.A.D. PMC]
<br/>
Alex K. [B.A.D. PMC]
<br/>
W.Frost [BadCo]
<br/>
JeyR [BadCo]
<br/>
D3fiance [BadCo]
<br/>
Special thanks to our alpha-testers: L.Pastor [B.A.D. PMC], Sgt. Levis [BadCo], Artale and NOMAD
"]];

// ====================================================================================

// NOTES: Rules
// The code below creates the situation sub-section of notes.

_sit = player createDiaryRecord ["diary", ["Rules","
#1 Respect other players.
<br/>
#2 Shooting or wounding friendlies *for fun* is strictly forbidden. This includes using vehicles and physical objects (boxes, sparetires).
<br/>
#3 Exploitation of game bugs is considered cheating and strictly forbidden. Please report any exploits the the Server Development Team.
<br/>
#4 Only use authorized mods on the server and make sure, every mod is installed properly.
<br/>
#5 Communicate with other players.
<br/>
Every player…
<br/>
-- is requiered, to join our Teamspeak server with ACRE enabled, a working microphone and the willingness to communicate by voice while playing on the ACE public server.
<br/>
-- is requiered, to carry a shortrange-radio at all times (343).
<br/>
-- designated as squadleader is requiered, to carry a longrange radio at all times (148/152).
<br/>
-- designated as pilot or vehicle crew is requiered, to either carry a backpack radio (117) or make use of the vehicle mounted racks.
<br/>
--> Only use radios when appropriate (as soon as players can’t hear each other due to range).
<br/>
#6 Players are requiered to play as a team. Lone-wolfing is forbidden.
<br/>
#7 Players need to fullfill their respective roles to the best of their abilities.
<br/>
#8 Players are requiered to use sensible and realistic loadouts (e.g. Grenadelauncher and heavy AT or „Machinegun-Sniper-Medics“ are not allowed).
<br/>
A couple notes:
<br/>
Admins always have the last word. If you broke a rule, do not argue with the admins.
<br/>
While players are requiered to play as a team (Rule #6), they are also allowed to split into smaller teams and go after different objectives. A team consists of at least two players and one of them needs to be designated as teamleader (incl. the requirement of carrying a LR-radio)
<br/>
In certain situations, like sustained firefights or unexpected contact with armoured vehicles, players are allowed to pick up weapons, that are not suited to their role or preselected loadout (Rule #7/#8.).
<br/>
Players, that have respawned at base, are allowed to pick up a longrange radio and contact units in the field to organise a pickup or transport to the frontline.
<br/>
Always make sure to mark players, vehicles and crates on the map for later retrievement, in case they were left in the field.
<br/>
Vehiclecrews (both air and ground) should always stick to their respective vehicles and, in case the vehicle is destroyed, are requiered to return to base. Also, appropriate gear is requiered (Rule #7/#8.).
<br/>
Players are allowed to finish tasks alone, if playernumbers are low and/or one or more players are AFK while a task is active (Rule #6).
<br/>
Credits are shared between all players. Keep that in mind before you buy something. If you drain the credits by aimlessly buying vehicles, it might be considered griefing and will lead to some form of punishment.
<br/>
Make sure, to mark vehicles in the field, if you have to leave them behind for any reason. This will help other players recover them later.
<br/>
Admins will decide on appropriate actions, if the rules are broken.
Also, the saying *Ignorance does not protect one from punishment* does apply on the server. You are required to read this rule-set and should always forward it to players, that are unsure or new.
<br/>
"]];

// ====================================================================================

// NOTES: MISSION
// The code below creates the mission sub-section of notes.

_mis = player createDiaryRecord ["diary", ["Mission","
Your objective: liberate the region from enemy control. To achieve this, you and your team will clear enemy-occupied grids, earning credits through main and side tasks. These credits can be used to obtain vehicles, static weapons, and other resources to support your mission.
<br/>
Winning the Hearts and Minds of the local civilian population is crucial. Positive relations with civilians can lead to valuable intel on enemy positions and improvised explosive devices (IEDs), giving you a tactical edge. However, poor relations may result in riots, stone-throwing, or even IED attacks.
<br/>
Be aware that enemies will attempt to recapture grids from time to time. Stay vigilant and adapt to changing situations as you defend your hard-won ground.
<br/>
Operation Chainbreaker is more than a fight for territory; it's a mission to build trust and understanding. Balance your combat skills with diplomacy to bring lasting peace to the region. 


"]];

// ====================================================================================

// NOTES: Introduction
// The code below creates the Friendly Assets sub-section of notes.

_mis = player createDiaryRecord ["diary", ["Introduction","
Welcome to Operation Chainbreaker!
<br/>
Developed in-house by the members of the Bad Company clan, Operation Chainbreaker is an immersive and dynamic mission that challenges players to work together in a high-stakes combat environment. Featuring a persistency mod, the mission tracks and saves your character's position, health, gear, ammunition, as well as the locations of vehicles, static weapons, and supply crates. This persistent world allows you to leave your mark and pick up where you left off, creating a unique and engaging experience.
<br/>
To succeed in Operation Chainbreaker, you and at least one other player must coordinate your efforts to clear designated grids of enemy forces or complete various tasks. Completing tasks rewards your team with credits, which can be used to acquire essential resources like vehicles, static weapons, and Forward Operating Bases (FOBs). The credits are shared among all players, encouraging teamwork and strategy.
<br/>
Are you ready to break the chains and take on the mission? Gather your team, gear up, and embark on an unforgettable journey in Operation Chainbreaker. Good luck, soldier!
"]];

// ====================================================================================