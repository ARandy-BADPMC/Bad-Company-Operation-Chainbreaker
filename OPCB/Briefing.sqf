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
Sgt. Levis [BadCo]
<br/>
Special thanks to our alpha-testers: L.Pastor [B.A.D. PMC], Artale and NOMAD
"]];

// ====================================================================================

// NOTES: Rules
// The code below creates the situation sub-section of notes.

_sit = player createDiaryRecord ["diary", ["Rules","
#1 Respect other players.
<br/>
#2 Intentionally and/or recklessly killing or wounding friendlies is strictly forbidden. This includes using vehicles and physical objects to cause harm (boxes, spare tires, chairs, trenches and other ACE interact-able objects that can be moved)..
<br/>
#3 Exploitation of game bugs/loopholes are considered cheating and strictly forbidden. Please report any exploits to the Server Development Team (e.g. using blacklisted items/items unavailable in the Arsenal).
<br/>
#4 Only use authorized mods from the ACE Public Modpack/Preset on the server and ensure that every mod is installed properly.
<br/>
#5 Communicate with other players.
<br/>
A - Important: Any outside communication (Steam chat, TS3 pings/chats, Whatsapp, etc...) besides the ACRE Radios and voice chat within the game are forbidden unless exigent circumstances occur (e.g. players unconscious, stuck, or trapped in Arma bullshitery/terrain and need admin intervention, etc...). Those who decide to stream must have their input audio muted from their audience. This rule is vital to promote immersion within the game.
<br/>
B - Every player is required to join our Teamspeak 3 server with ACRE enabled, have a working microphone, and are willing to communicate by voice while playing on the ACE public server.
<br/>
C - All players are required to carry a short-range radio at all times (343).
<br/>
D - Squad Leaders are required to carry a long-range radio at all times (148/152).
<br/>
E -> Pilots and Vehicle Crews are required to either carry a backpack radio (117) or utilize long-range radios via vehicle mounted racks.
<br/>
F - Utilize radios within their maximum effective range (as soon as players can hear each other clearly due to range or terrain interference).
<br/>
G - All players are required to communicate with each team/squad via radio in English to enhance cohesion and coordination.
<br/>
Foreign/native language communication is permissible within a team/squad with members who speak the same language. If there is a member who does not speak the foreign language within the team/squad, communication must be made in English when appropriate (don't outcast the member).
<br/>
#6 Players are required to play as a team. Lone-wolfing is forbidden unless exigent circumstances occur (e.g. Lone Survivor scenarios, lack of players on server during off-peak hours/days, low-risk side missions). *1
<br/>
#7 Players need to fulfill their respective roles to the best of their abilities (e.g. Leaders lead, machine gunners suppress, AT Rifleman prioritize armored targets, snipers/marksman engage deadly threats beyond the effective range of their team/squadmates, engineers/demolitionists sabotage, destroy, or build, medics prioritize and stabilize the wounded when applicable, etc...).
<br/>
#8 Players are required to use sensible and realistic loadouts (e.g. Under-barreled Grenade Launchers/Standalone Grenade Launchers with Heavy AT/AA (Javelin, NLAW, Dragon, Stinger, etc...), high-powered optics other than LPVOs on carbines/non-DMR/short-barrel rifles, or 'Machinegun-Sniper-Medics' are not allowed).
<br/>
A couple notes:
<br/>
Admins can kick or ban at their own discretion when any of these rules are broken. If you are banned, do not argue with the admins in-game or on Discord. Create a ban appeal using our forums
<br/>
While players are required to play as a team (Rule #6), they are allowed to split into smaller teams and go after different objectives. A team consists of at least (2)two players and (1)one of the players needs to be designated as teamleader (including the requirement of carrying a Long-Range Radio)
<br/>
In certain situations (like sustained firefights or unexpected contact with enemy armoured or air vehicles) players are allowed to pick up weapons/equipment that are not suited to their role or pre-selected loadout (Rule #7/#8).
<br/>
Players that respawn at base are allowed to pick up a Long-Range Radio and contact units in the field to organise a pickup or transport to the frontline.
<br/>
Always make sure to mark players, vehicles, and crates on the map for later retrieval/recovery in case they were left in the field with the type of asset and condition of asset within the marker (e.g. 'Pvt. Parts, Unc/Stable', 'Bradley, Yellow, missing R Track,' 'Ammo crate, empty,' etc... ).
<br/>
Vehicle crews (both air and ground) should always stick to their respective vehicles. In case the vehicle is destroyed, crew members must return to base when feasible. Also, appropriate gear is required (Rule #7/#8.).
<br/>
*1 Players are allowed to finish tasks alone if player numbers are low and/or one or more players are AFK while a task is active (Rule #6).
<br/>
Credits are our currency system and are shared between all players. Keep that in mind before you buy something. If you drain the credits by aimlessly buying vehicles, it might be considered misappropriation of funds, asset wasting, griefing and/or trolling and will lead to some form of punishment at an admin's discretion.
<br/>
Admins will decide on appropriate actions if the rules are broken. Do not take matter into your own hands as this may result in your own ban.
<br/>
Stating 'ignorance does not protect one from punishment' does not apply on the server. You are required to read the rules and regulations mentioned above before joining the server and should forward it to new/unfamiliar players to the ACE Pub server.
<br/>
As mentioned beforehand, any questions in relation to the ACE Public Server can be addressed to one of our ACE Public Developers (Alex K, A.Randy, D3fiance, JeyR, Sgt. Levis, and W.Frost), on our forums, or through our Discord channel (ace-pub).
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