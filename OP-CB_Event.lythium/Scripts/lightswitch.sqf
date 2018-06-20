base_lights_on = 
{
light1 sethit ["light_1_hitpoint",0];
light1 sethit ["light_2_hitpoint",0];

};

base_lights_off =
{
light1 sethit ["light_1_hitpoint",1];
light1 sethit ["light_2_hitpoint",1];
};

jeff addaction ["Lights on", {[] call base_lights_on;}];
jeff addaction ["Lights off", {[] call base_lights_off;}];