
CreatePlate(corner1, corner2, arivee, angle, time)
{
    W = Distance((corner1[0], 0, 0), (corner2[0], 0, 0));
    L = Distance((0, corner1[1], 0), (0, corner2[1], 0));
    H = Distance((0, 0, corner1[2]), (0, 0, corner2[2]));
    CX = corner2[0] - corner1[0];
    CY = corner2[1] - corner1[1];
    CZ = corner2[2] - corner1[2];
    ROWS = roundUp(W/55);
    COLUMNS = roundUp(L/30);
    HEIGHT = roundUp(H/20);
    XA = CX/ROWS;
    YA = CY/COLUMNS;
    ZA = CZ/HEIGHT;
    center = spawn("script_model", corner1);
    for(r = 0; r <= ROWS; r++){
        for(c = 0; c <= COLUMNS; c++){
            for(h = 0; h <= HEIGHT; h++){
                block = spawn("script_model", (corner1 + (XA * r, YA * c, ZA * h)));
                block setModel("com_plasticcase_friendly");
                block.angles = (0, 0, 0);
                block Solid();
                block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
                block thread Escalatore((corner1 + (XA * r, YA * c, ZA * h)), (arivee + (XA * r, YA * c, ZA * h)), time);
                wait 0.01;
            }
        }
    }
    center.angles = angle;
    center thread Escalatore(corner1, arivee, time);
    center CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
}

Escalatore(depart, arivee, time)
{   
    while(1)
    {
                if(self.state == "open"){
                    self MoveTo(depart, time);
                    wait (time*2.5);
                    self.state = "close";
                    continue;
                }
                if(self.state == "close"){
                    self MoveTo(arivee, time);
                    wait (time*2.5);
                    self.state = "open";
                    continue;
                }
    }
}

CreateAsc(depart, arivee, angle, time)
{
    Asc = spawn("script_model", depart );
    Asc setModel("com_plasticcase_friendly");
    Asc.angles = angle;
    Asc Solid();
    Asc CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    
    Asc thread Escalator(depart, arivee, time);
}

Escalator(depart, arivee, time)
{
    while(1)
    {
                if(self.state == "open"){
                    self MoveTo(depart, time);
                    wait (time*1.5);
                    self.state = "close";
                    continue;
                }
                if(self.state == "close"){
                    self MoveTo(arivee, time);
                    wait (time*1.5);
                    self.state = "open";
                    continue;
                }
    }
}

CreateCircle(depart, pass1, pass2, pass3, pass4, arivee, angle, time)
{
    Asc = spawn("script_model", depart );
    Asc setModel("com_plasticcase_friendly");
    Asc.angles = angle;
    Asc Solid();
    Asc CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    
    Asc thread Circle(depart, arivee, pass1, pass2, pass3, pass4, time);
}

Circle(depart, pass1, pass2, pass3, pass4, arivee, time)
{
    while(1)
    {
                if(self.state == "open"){
                    self MoveTo(depart, time);
                    wait (time*1.5);
                    self.state = "op";
                    continue;
                }
                if(self.state == "op"){
                    self MoveTo(pass1, time);
                    wait (time);
                    self.state = "opi";
                    continue;
                }
                if(self.state == "opi"){
                    self MoveTo(pass2, time);
                    wait (time);
                    self.state = "opa";
                    continue;
                }
                if(self.state == "opa"){
                    self MoveTo(pass3, time);
                    wait (time);
                    self.state = "ope";
                    continue;
                }
                if(self.state == "ope"){
                    self MoveTo(pass4, time);
                    wait (time);
                    self.state = "close";
                    continue;
                }
                if(self.state == "close"){
                    self MoveTo(arivee, time);
                    wait (time);
                    self.state = "open";
                    continue;
                }
}
}

CreateElevator(enter, exit, angle)
{
    flag = spawn( "script_model", enter );
    flag setModel( level.elevator_model["enter"] );
    wait 0.01;
    efx = loadfx( "misc/flare_ambient" );
    playFx( efx, enter );
    flag showInMap();
    wait 0.01;
    flag = spawn( "script_model", exit );
    flag setModel( level.elevator_model["exit"] );
    wait 0.01;
    self thread ElevatorThink(enter, exit, angle);
}

showInMap()
{
    self endon ( "disconnect" ); 
    self endon ( "death" ); 
        curObjID = maps\mp\gametypes\_gameobjects::getNextObjID();  
        name = precacheShader( "compass_waypoint_panic" );  
        objective_add( curObjID, "invisible", (0,0,0) );
        objective_position( curObjID, self.origin );
        objective_state( curObjID, "active" );
        objective_team( curObjID, self.team );
        objective_icon( curObjID, name );
        self.objIdFriendly = curObjID;
}

CreateHFlag(enter, exit, angle)
{
    flag = spawn( "script_model", enter );
    flag setModel( level.elevator_model["enter"] );
    wait 0.01;
    flag = spawn( "tag_origin", exit );
    flag setModel( level.elevator_model["exit"] );
    wait 0.01;
    self thread ElevatorThink(enter, exit, angle);
}

ElevatorThink(enter, exit, angle)
{
    self endon("disconnect");
    while(1)
    {
        foreach(player in level.players)
        {
            if(Distance(enter, player.origin) <= 50){
                player SetOrigin(exit);
                player SetPlayerAngles(angle);
            }
        }
        wait .25;
    }
}

CreateTWall(enter, exit, radius)
{
    flag = spawn( "script_model", enter );
    flag setModel("tag_origin");
    wait 0.01;
    self thread TWallAct(enter, exit, radius);
}

TWallAct(enter, exit, radius)
{
    self endon("disconnect");
    while(1)
    {
        foreach(player in level.players)
        {
            if(Distance(enter, player.origin) <= radius){
                player SetOrigin(exit);
                playFX(level.fxex, exit);
                player playsound("mp_war_objective_lost");
            }
        }
        wait .25;
    }
}

CreateTurret(pos, angles)
{   mgTurret1 = spawnTurret( "misc_turret", pos , "pavelow_minigun_mp" ); 
    mgTurret1 setModel( "weapon_minigun" );
    mgTurret1.angles = (angles);
    mgTurret1 SetLeftArc(360);
    mgTurret1 SetRightArc(360);
    wait 0.1;
    mgTurret1 thread TurMovez(pos);
}
TurMovez(pos)
{   self endon("disconnect");
    while(1)
    {   foreach(player in level.players)
        {   if(player.team == "axis")   {
                if(Distance(pos, player.origin) < 65){
                    player SetStance( "prone" );
                    player thread TurBurn();
                }
            }
        }
        wait .1;
    }
}
TurBurn()
{   RadiusDamage(self.origin, 40, 40, 15);
}
        
CreateBlocks(pos, angle)
{
    block = spawn("script_model", pos );
    block setModel("com_plasticcase_friendly");
    block.angles = angle;
    block Solid();
    block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    wait 0.01;
}
CreateIBlock(pos, angle)
{
    block = spawn("script_model", pos );
    block setModel("tag_origin");
    block.angles = angle;
    block Solid();
    block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    wait 0.01;
}
CreateRamps(top, bottom)
{
    D = Distance(top, bottom);
    blocks = roundUp(D/30);
    CX = top[0] - bottom[0];
    CY = top[1] - bottom[1];
    CZ = top[2] - bottom[2];
    XA = CX/blocks;
    YA = CY/blocks;
    ZA = CZ/blocks;
    CXY = Distance((top[0], top[1], 0), (bottom[0], bottom[1], 0));
    Temp = VectorToAngles(top - bottom);
    BA = (Temp[2], Temp[1] + 90, Temp[0]);
    for(b = 0; b < blocks; b++){
        block = spawn("script_model", (bottom + ((XA, YA, ZA) * b)));
        block setModel("com_plasticcase_friendly");
        block.angles = BA;
        block Solid();
        block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
        wait 0.01;
    }
    block = spawn("script_model", (bottom + ((XA, YA, ZA) * blocks) - (0, 0, 5)));
    block setModel("com_plasticcase_friendly");
    block.angles = (BA[0], BA[1], 0);
    block Solid();
    block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    wait 0.01;
}

CreateGrids(corner1, corner2, angle)
{
    W = Distance((corner1[0], 0, 0), (corner2[0], 0, 0));
    L = Distance((0, corner1[1], 0), (0, corner2[1], 0));
    H = Distance((0, 0, corner1[2]), (0, 0, corner2[2]));
    CX = corner2[0] - corner1[0];
    CY = corner2[1] - corner1[1];
    CZ = corner2[2] - corner1[2];
    ROWS = roundUp(W/55);
    COLUMNS = roundUp(L/30);
    HEIGHT = roundUp(H/20);
    XA = CX/ROWS;
    YA = CY/COLUMNS;
    ZA = CZ/HEIGHT;
    center = spawn("script_model", corner1);
    for(r = 0; r <= ROWS; r++){
        for(c = 0; c <= COLUMNS; c++){
            for(h = 0; h <= HEIGHT; h++){
                block = spawn("script_model", (corner1 + (XA * r, YA * c, ZA * h)));
                block setModel("com_plasticcase_friendly");
                block.angles = (0, 0, 0);
                block Solid();
                block LinkTo(center);
                block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
                wait 0.01;
            }
        }
    }
    center.angles = angle;
}
CreateFire(pos)
{   Flam = spawn( "script_model", pos );
    Flam setModel("tag_origin");
    angles = (90,90,0);
    if(getDvar("mapname") == "mp_boneyard" || getDvar("mapname") == "mp_checkpoint" || getDvar("mapname") == "mp_compact")
    {
        foreach(fx in level.fxf)
        {   playFX(fx, pos);
        }
    }   else    {   
        Flam thread doAltfire(pos);
    }
    Flam thread FBurn(pos);
    Flam thread FTrig(pos);
}
doAltfire(pos)
{   self endon("disconnect");
    while(1)
    {   foreach(fx in level.fxx)
        {   playFX(fx, pos);
        }
        wait .5;
    }
}
FBurn(pos)
{   self endon("disconnect");
    while(1)
    {   self waittill ( "triggeruse" );
        self playLoopSound( "veh_mig29_dist_loop" );
        RadiusDamage( pos, 70, 15, 10);
        earthquake( 0.4, 0.75, self.origin, 512 );
        wait .4;
        self stopLoopSound( "veh_mig29_dist_loop" );
        continue;
    }
}
FTrig(pos)
{   self endon("disconnect");
    for(;;)
    {
        foreach(player in level.players)
        {   if(Distance(self.origin, player.origin) <= 100)
            {   if(player.team == "axis") self notify( "triggeruse" );
            }
        }
        wait .1;
    }
}
CreateWalls(start, end)
{
    D = Distance((start[0], start[1], 0), (end[0], end[1], 0));
    H = Distance((0, 0, start[2]), (0, 0, end[2]));
    blocks = roundUp(D/55);
    height = roundUp(H/30);
    CX = end[0] - start[0];
    CY = end[1] - start[1];
    CZ = end[2] - start[2];
    XA = (CX/blocks);
    YA = (CY/blocks);
    ZA = (CZ/height);
    TXA = (XA/4);
    TYA = (YA/4);
    Temp = VectorToAngles(end - start);
    Angle = (0, Temp[1], 90);
    for(h = 0; h < height; h++){
        block = spawn("script_model", (start + (TXA, TYA, 10) + ((0, 0, ZA) * h)));
        block setModel("com_plasticcase_friendly");
        block.angles = Angle;
        block Solid();
        block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
        wait 0.001;
        for(i = 1; i < blocks; i++){
            block = spawn("script_model", (start + ((XA, YA, 0) * i) + (0, 0, 10) + ((0, 0, ZA) * h)));
            block setModel("com_plasticcase_friendly");
            block.angles = Angle;
            block Solid();
            block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
            wait 0.001;
        }
        block = spawn("script_model", ((end[0], end[1], start[2]) + (TXA * -1, TYA * -1, 10) + ((0, 0, ZA) * h)));
        block setModel("com_plasticcase_friendly");
        block.angles = Angle;
        block Solid();
        block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
        wait 0.001;
    }
}

CreateIWall(start, end)
{
    D = Distance((start[0], start[1], 0), (end[0], end[1], 0));
    H = Distance((0, 0, start[2]), (0, 0, end[2]));
    blocks = roundUp(D/55);
    height = roundUp(H/30);
    CX = end[0] - start[0];
    CY = end[1] - start[1];
    CZ = end[2] - start[2];
    XA = (CX/blocks);
    YA = (CY/blocks);
    ZA = (CZ/height);
    TXA = (XA/4);
    TYA = (YA/4);
    Temp = VectorToAngles(end - start);
    Angle = (0, Temp[1], 90);
    for(h = 0; h < height; h++){
        block = spawn("script_model", (start + (TXA, TYA, 10) + ((0, 0, ZA) * h)));
        block setModel("tag_origin");
        block.angles = Angle;
        block Solid();
        block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
        wait 0.001;
        for(i = 1; i < blocks; i++){
            block = spawn("script_model", (start + ((XA, YA, 0) * i) + (0, 0, 10) + ((0, 0, ZA) * h)));
            block setModel("tag_origin");
            block.angles = Angle;
            block Solid();
            block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
            wait 0.001;
        }
        block = spawn("script_model", ((end[0], end[1], start[2]) + (TXA * -1, TYA * -1, 10) + ((0, 0, ZA) * h)));
        block setModel("tag_origin");
        block.angles = Angle;
        block Solid();
        block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
        wait 0.001;
    }
}

CreateCluster(amount, pos, radius)
{
    for(i = 0; i < amount; i++)
    {
        half = radius / 2;
        power = ((randomInt(radius) - half), (randomInt(radius) - half), 500);
        block = spawn("script_model", pos + (0, 0, 1000) );
        block setModel("com_plasticcase_friendly");
        block.angles = (90, 0, 0);
        block PhysicsLaunchServer((0, 0, 0), power);
        block Solid();
        block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
        block thread ResetCluster(pos, radius);
        wait 0.05;
    }
}
CreateDoors(open, close, angle, size, height, hp, range)
{
    offset = (((size / 2) - 0.5) * -1);
    center = spawn("script_model", open );
    for(j = 0; j < size; j++){
        door = spawn("script_model", open + ((0, 30, 0) * offset));
        door setModel("com_plasticcase_enemy");
        door Solid();
        door CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
        door EnableLinkTo();
        door LinkTo(center);
        for(h = 1; h < height; h++){
            door = spawn("script_model", open + ((0, 30, 0) * offset) - ((70, 0, 0) * h));
            door setModel("com_plasticcase_enemy");
            door Solid();
            door CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
            door EnableLinkTo();
            door LinkTo(center);
        }
        offset += 1;
    }
    center.angles = angle;
    center.state = "open";
    center.hp = hp;
    center.range = range;
    center thread DoorThink(open, close);
    center thread DoorUse();
    center thread ResetDoors(open, hp);
    wait 0.01;
}
DoorThink(open, close)
{
    while(1)
    {
        if(self.hp > 0){
            self waittill ( "triggeruse" , player );
            if(player.team == "allies"){
                if(self.state == "open"){
                    self MoveTo(close, level.doorwait);
                    wait level.doorwait;
                    self.state = "close";
                    continue;
                }
                if(self.state == "close"){
                    self MoveTo(open, level.doorwait);
                    wait level.doorwait;
                    self.state = "open";
                    continue;
                }
            }
            if(player.team == "axis"){
                if(self.state == "close"){
                    self.hp--;
                    player iPrintlnBold("HIT!");
                    player thread doDoorz();
                    wait 1;
                    continue;
                }
            }
        } else {
            if(self.state == "close"){
                self MoveTo(open, level.doorwait);
            }
            self.state = "broken";
            wait .5;
        }
    }
}

DoorUse()
{
    self endon("disconnect");
    while(1)
    {
        foreach(player in level.players)
        {
            if(Distance(self.origin, player.origin) <= self.range){
                if(player.team == "allies"){
                    if(self.state == "open"){
                        player.hint = "[{+melee}] ^1Closes ^7the door.";
                    }
                    if(self.state == "close"){
                        player.hint = "[{+melee}] ^2Opens the door. [{+breath_sprint}] Shows HP.";
                    }
                    if(self.state == "broken"){
                        player.hint = "Door is Broken";
                    }
                }
                if(player.team == "axis"){
                    if(self.state == "close"){
                        player.hint = "[{+melee}] ^1Damages ^7the door. [{+breath_sprint}] Shows HP.";
                    }
                    if(self.state == "broken"){
                        player.hint = "^1Door is Broken";
                    }
                }
                if(player.buttonPressed[ "+melee" ] == 1){
                    player.buttonPressed[ "+melee" ] = 0;
                    self notify( "triggeruse" , player);
                }
                if(player.buttonPressed[ "+breath_sprint" ] == 1){
                    player.buttonPressed[ "+breath_sprint" ] = 0;
                    player iPrintlnBold("^3" + self.hp + "^1:HP Left");
                }
            }
        }
        wait .045;
    }
}

ResetDoors(open, hp)
{
    while(1)
    {
        level waittill("RESETDOORS");
        self.hp = hp;
        self MoveTo(open, level.doorwait);
        self.state = "open";
    }
}

ResetCluster(pos, radius)
{
    wait 5;
    self RotateTo(((randomInt(36)*10), (randomInt(36)*10), (randomInt(36)*10)), 1);
    level waittill("RESETCLUSTER");
    self thread CreateCluster(1, pos, radius);
    self delete();
}

CreateInvisDoor(open, close, angle, size, height, hp, range)
{   level.fx_airstrike_afterburner = loadfx ("fire/jet_afterburner");
    level.chopper_fx["light"]["belly"] = loadfx( "misc/aircraft_light_red_blink" );
    level.harrier_afterburnerfx = loadfx ("fire/jet_afterburner_harrier");
    offset = (((size / 2) - 0.5) * -1);
    center = spawn("script_model", open );
    for(j = 0; j < size; j++){
        door = spawn("script_model", open + ((0, 30, 0) * offset));
        door setModel(level.spawnGlowModel["enemy"]);
        door Solid();
        door CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
        //playfx(level.chopper_fx["light"]["belly"], open + ((0, 30, 0) * offset));
        door EnableLinkTo();
        door LinkTo(center);
        for(h = 1; h < height; h++){
            door = spawn("script_model", open + ((0, 30, 0) * offset) - ((70, 0, 0) * h));
            door setModel(level.spawnGlowModel["enemy"]);
            door Solid();
            door CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
            door EnableLinkTo();
            door LinkTo(center);
            //playfx(level.chopper_fx["light"]["belly"], open + ((0, 30, 0) * offset) - ((70, 0, 0) * h)); 
        }
        offset += 1;
    }
    center.angles = angle;
    center.state = "open";
    center.hp = hp;
    center.range = range;
    center thread IDoorThink(open, close);
    center thread IDoorUse();
    center thread IDCEffect(open, close, angle);
    center thread ResetDoors(open, hp);
    wait 0.01;
}

IDCEffect(open, close, angle)
{   self endon("disconnect");
    //playfx(level.chopper_fx["light"]["belly"], open + (0, 20, 40));
    //playfx(level.chopper_fx["light"]["belly"], open + (0, -20, 40));
    //playfx(level.chopper_fx["light"]["belly"], open + (20, 0, 40));
    //playfx(level.chopper_fx["light"]["belly"], open + (-20, -20, 40));
    while(1)
    {   
        if(self.state == "close")
        {   self playLoopSound("cobra_helicopter_dying_layer");
            fxti = SpawnFx(level.fx_airstrike_afterburner, close + (0,0,25));
            fxti.angles = (270,0,0);
            fxtiii = SpawnFx(level.harrier_afterburnerfx, close );
            fxtiii.angles = (270,0,0);
            TriggerFX(fxti);
            TriggerFX(fxtiii);
            wait .5;
            self stopLoopSound("cobra_helicopter_dying_layer");
            self playLoopSound("emt_road_flare_burn");
            while(self.state == "close")
            {   wait .1;
            }
            self stopLoopSound("emt_road_flare_burn");
            if(self.state == "broken"){
                self playLoopSound("cobra_helicopter_crash");
                wait .5;
            }
            self playLoopSound("cobra_helicopter_dying_layer");
            wait .8;
            self stopLoopSound("cobra_helicopter_dying_layer");
            self stopLoopSound("cobra_helicopter_crash");
            fxti delete();
            fxtiii delete();
        }
        wait 2;
    }
}
IDoorUse()
{
    self endon("disconnect");
    while(1)
    {
        foreach(player in level.players)
        {
            if(Distance(self.origin, player.origin) <= self.range){
                if(player.team == "allies"){
                    if(self.state == "open"){
                        player.hint = "^1[{+melee}] ^7to ^2Activate ^3ForceField";
                    }
                    if(self.state == "close"){
                        player.hint = "^1[{+melee}] to ^2De-Activate ^3ForceField. [{+breath_sprint}] Shows Power Level.";  
                    }
                    if(self.state == "broken"){
                        player.hint = "^1ForceField is Down";
                    }
                }
                if(player.team == "axis"){
                    if(self.state == "close"){
                        player.hint = "^[{+melee}] ^7to ^1Drain ^3the ForceField. [{+breath_sprint}] Shows Power Level.";
                    }
                    if(self.state == "broken"){
                        player.hint = "^1ForceField is Down";
                    }
                }
                if(player.buttonPressed[ "+melee" ] == 1){
                    player.buttonPressed[ "+melee" ] = 0;
                    self notify( "triggeruse" , player);
                }
                if(player.buttonPressed[ "+breath_sprint" ] == 1){
                    player.buttonPressed[ "+breath_sprint" ] = 0;
                    player iPrintlnBold("^3" + self.hp + "^1:Power Left");
                }
            }
        }
        wait .045;
    }
}
IDoorThink(open, close)
{   self.waitz = 1;
    while(1)
    {
        if(self.hp > 0){
            self waittill ( "triggeruse" , player );
            if(player.team == "allies"){
                if(self.state == "open"){
                    self MoveTo(close, self.waitz);
                    wait 1;
                    self.state = "close";
                    continue;
                }
                if(self.state == "close"){
                    self MoveTo(open, self.waitz);
                    wait 1;
                    self.state = "open";
                    continue;
                }
            }
            if(player.team == "axis"){
                if(self.state == "close"){
                    self.hp--;
                    player iPrintlnBold("HIT!");
                    player thread doDoorz();
                    wait 1;
                    continue;
                }
            }
        } else {
            if(self.state == "close"){
                self MoveTo(open, self.waitz);
            }
            self.state = "broken";
            wait .5;
        }
    }
}
roundUp( floatVal )
{
    if ( int( floatVal ) != floatVal )
        return int( floatVal+1 );
    else
        return int( floatVal );
}

CreateTruck(depart, pass1, pass2, pass3, pass4, arivee, angle, time)
{
    Truck = spawn("script_model", depart );
    Truck setModel("vehicle_uaz_open_destructible");
    Truck.angles = angle;
    Truck Solid();
    Truck CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    Truck thread TrUse();
    Truck thread TrStop();
    Truck thread TrReset(depart);
    Truck thread TrMove(depart, pass1, pass2, pass3, pass4, arivee, angle, time);
}

TrMove(depart, pass1, pass2, pass3, pass4, arivee, angle, time)
{   self.statez = "stopped";
    self.state = "op";
    while(1)
    {           if(self.statez == "stopped"){
                    self waittill ( "triggeruse" );
                    self.statez = "moving";
                    wait .5;
                    continue;
                }
                if(self.state == "open"){
                    self MoveTo(depart, time);
                    self thread doTurnz(time);
                    wait (time);
                    self.state = "op";
                    self.statez = "stopped";
                    continue;
                }
                if(self.state == "op"){
                    self MoveTo(pass1, time);
                    self thread doTurnz(time);
                    wait (time);
                    self.state = "opi";
                    continue;
                }
                if(self.state == "opi"){
                    self MoveTo(pass2, time);
                    self thread doTurnz(time);
                    wait (time);
                    self.state = "opa";
                    continue;
                }
                if(self.state == "opa"){
                    self MoveTo(pass3, time);
                    self thread doTurnz(time);
                    wait (time);
                    self.state = "ope";
                    continue;
                }
                if(self.state == "ope"){
                    self MoveTo(pass4, time);
                    self thread doTurnz(time);
                    wait (time);
                    self.state = "close";
                    continue;
                }
                if(self.state == "close"){
                    self MoveTo(arivee, time);
                    self thread doTurnz(time);
                    wait (time);
                    self.state = "open";
                    continue;
                }
    }
}
doTurnz(time)
{   self.counterz = 10;
    while(self.counterz > 0)
    {   self.angles += (0,6,0);
        self.counterz--;
        wait 0.01;
    }
}
TrUse()
{
    self endon("disconnect");
    while(1)
    {
        foreach(player in level.players)
        {
            if(Distance(self.origin, player.origin) <= 70){
                if(player.team == "allies"){
                    if(self.statez == "stopped"){
                        player.hint = "Press ^3[{+breath_sprint}] ^7to ^2Start ^7the Truck Moving";
                    }
                    if(self.statez == "moving"){
                        player.hint = "Press ^3[{+breath_sprint}] ^7to ^2Stop ^7the Truck Moving";
                    }
                    if(player.buttonPressed[ "+breath_sprint" ] == 1){
                    player.buttonPressed[ "+breath_sprint" ] = 0;
                    self notify( "triggeruse" );
                    }
                }
            }
        }
        wait .045;
    }
}
TrStop()
{   while(1)
    {   if(self.statez == "moving")
        {   self waittill ( "triggeruse" );
            self.statez = "stopped";
        }
        wait 1;
    }
}
TrReset(depart)
{
    while(1)
    {
        level waittill("RESETDOORS");
        self SetOrigin(depart);
        self.statez = "stopped";
        self.state = "op";
    }
}

CreateZomSpawnPoint(pos1, pos2)
{   level.spawnz = 1;
    level.ZombieSpawnz = pos1;
    level.ZombieSpawnzs = pos2;
}

CreateKillIfBelow(z)
{   level thread KillBelow(z);
}

KillBelow(z)
{
    for(;;)
    {
        foreach(player in level.players)
        {
            if(player.origin[2] < z){
                RadiusDamage(player.origin,100,999999,999999);
            }
            wait .1;
        }
        wait .15;
    }
}

/* MAP FUNCTIONS END*/

doPerkCheck()
{
    self endon ( "disconnect" );
    self endon ( "death" );
    while(1)
    {
        if(self.perkz["steadyaim"] == 1){
            if(!self _hasPerk("specialty_bulletaccuracy")){
                self maps\mp\perks\_perks::givePerk("specialty_bulletaccuracy");
            }
        }
        if(self.perkz["steadyaim"] == 2){
            if(!self _hasPerk("specialty_bulletaccuracy")){
                self maps\mp\perks\_perks::givePerk("specialty_bulletaccuracy");
            }
            if(!self _hasPerk("specialty_holdbreath")){
                self maps\mp\perks\_perks::givePerk("specialty_holdbreath");
            }
        }
        if(self.perkz["sleightofhand"] == 1){
            if(!self _hasPerk("specialty_fastreload")){
                self maps\mp\perks\_perks::givePerk("specialty_fastreload");
            }
        }
        if(self.perkz["sleightofhand"] == 2){
            if(!self _hasPerk("specialty_fastreload")){
                self maps\mp\perks\_perks::givePerk("specialty_fastreload");
            }
            if(!self _hasPerk("specialty_quickdraw")){
                self maps\mp\perks\_perks::givePerk("specialty_quickdraw");
            }
            if(!self _hasPerk("specialty_fastsnipe")){
                self maps\mp\perks\_perks::givePerk("specialty_fastsnipe");
            }
        }
        if(self.perkz["sitrep"] == 1){
            if(!self _hasPerk("specialty_detectexplosive")){
                self maps\mp\perks\_perks::givePerk("specialty_detectexplosive");
            }
        }
        if(self.perkz["sitrep"] == 2){
            if(!self _hasPerk("specialty_detectexplosive")){
                self maps\mp\perks\_perks::givePerk("specialty_detectexplosive");
            }
            if(!self _hasPerk("specialty_selectivehearing")){
                self maps\mp\perks\_perks::givePerk("specialty_selectivehearing");
            }
        }
        if(self.perkz["stoppingpower"] == 1){
            if(!self _hasPerk("specialty_bulletdamage")){
                self maps\mp\perks\_perks::givePerk("specialty_bulletdamage");
            }
        }
        if(self.perkz["stoppingpower"] == 2){
            if(!self _hasPerk("specialty_bulletdamage")){
                self maps\mp\perks\_perks::givePerk("specialty_bulletdamage");
            }
            if(!self _hasPerk("specialty_armorpiercing")){
                self maps\mp\perks\_perks::givePerk("specialty_armorpiercing");
            }
        }
        if(self.perkz["coldblooded"] == 1){
            if(!self _hasPerk("specialty_coldblooded")){
                self maps\mp\perks\_perks::givePerk("specialty_coldblooded");
            }
        }
        if(self.perkz["coldblooded"] == 2){
            if(!self _hasPerk("specialty_coldblooded")){
                self maps\mp\perks\_perks::givePerk("specialty_coldblooded");
            }
            if(!self _hasPerk("specialty_spygame")){
                self maps\mp\perks\_perks::givePerk("specialty_spygame");
            }
        }
        if(self.perkz["ninja"] == 1){
            if(!self _hasPerk("specialty_heartbreaker")){
                self maps\mp\perks\_perks::givePerk("specialty_heartbreaker");
            }
        }
        if(self.perkz["ninja"] == 2){
            if(!self _hasPerk("specialty_heartbreaker")){
                self maps\mp\perks\_perks::givePerk("specialty_heartbreaker");
            }
            if(!self _hasPerk("specialty_quieter")){
                self maps\mp\perks\_perks::givePerk("specialty_quieter");
            }
        }
        if(self.perkz["lightweight"] == 1){
            if(!self _hasPerk("specialty_lightweight")){
                self maps\mp\perks\_perks::givePerk("specialty_lightweight");
            }
            self setMoveSpeedScale(1.2);
        }
        if(self.perkz["lightweight"] == 2){
            if(!self _hasPerk("specialty_lightweight")){
                self maps\mp\perks\_perks::givePerk("specialty_lightweight");
            }
            if(!self _hasPerk("specialty_fastsprintrecovery")){
                self maps\mp\perks\_perks::givePerk("specialty_fastsprintrecovery");
            }
            self setMoveSpeedScale(1.5);
        }
        wait 1;
    }
}

buildWeaponName( baseName, attachment1, attachment2 )
{
    if ( !isDefined( level.letterToNumber ) ){
        level.letterToNumber = makeLettersToNumbers();
    }
    
    if ( getDvarInt ( "scr_game_perks" ) == 0 )
    {
        attachment2 = "none";

        if ( baseName == "onemanarmy" ){
            return ( "beretta_mp" );
        }
    }

    weaponName = baseName;
    attachments = [];

    if ( attachment1 != "none" && attachment2 != "none" )
    {
        if ( level.letterToNumber[attachment1[0]] < level.letterToNumber[attachment2[0]] )
        {
            
            attachments[0] = attachment1;
            attachments[1] = attachment2;
            
        }
        else if ( level.letterToNumber[attachment1[0]] == level.letterToNumber[attachment2[0]] )
        {
            if ( level.letterToNumber[attachment1[1]] < level.letterToNumber[attachment2[1]] )
            {
                attachments[0] = attachment1;
                attachments[1] = attachment2;
            }
            else
            {
                attachments[0] = attachment2;
                attachments[1] = attachment1;
            }   
        }
        else
        {
            attachments[0] = attachment2;
            attachments[1] = attachment1;
        }       
    }
    else if ( attachment1 != "none" )
    {
        attachments[0] = attachment1;
    }
    else if ( attachment2 != "none" )
    {
        attachments[0] = attachment2;   
    }
    
    foreach ( attachment in attachments )
    {
        weaponName += "_" + attachment;
    }

    return ( weaponName + "_mp" );
}

isValidWeapon( refString )
{
    if ( !isDefined( level.weaponRefs ) )
    {
        level.weaponRefs = [];

        foreach ( weaponRef in level.weaponList ){
            level.weaponRefs[ weaponRef ] = true;
        }
    }

    if ( isDefined( level.weaponRefs[ refString ] ) ){
        return true;
    }

    //assertMsg( "Replacing invalid weapon/attachment combo: " + refString );
    
    return false;
}

makeLettersToNumbers()
{
    array = [];
    
    array["a"] = 0;
    array["b"] = 1;
    array["c"] = 2;
    array["d"] = 3;
    array["e"] = 4;
    array["f"] = 5;
    array["g"] = 6;
    array["h"] = 7;
    array["i"] = 8;
    array["j"] = 9;
    array["k"] = 10;
    array["l"] = 11;
    array["m"] = 12;
    array["n"] = 13;
    array["o"] = 14;
    array["p"] = 15;
    array["q"] = 16;
    array["r"] = 17;
    array["s"] = 18;
    array["t"] = 19;
    array["u"] = 20;
    array["v"] = 21;
    array["w"] = 22;
    array["x"] = 23;
    array["y"] = 24;
    array["z"] = 25;
    
    return array;
}


doExchangeWeapons()
{
    switch(self.exTo)
    {
        case "LMG":
            if(self.bounty >= level.itemCost["LMG"]){
                self.bounty -= level.itemCost["LMG"];
                self takeWeapon(self.current);
                self giveWeapon(level.lmg[self.randomlmg] + "_mp", 0, false);
                self GiveStartAmmo(level.lmg[self.randomlmg] + "_mp");
                self switchToWeapon(level.lmg[self.randomlmg] + "_mp");
                self iPrintlnBold("^2Light Machine Gun Bought!");
                
            } else {
                self iPrintlnBold("^1Need More ^3$$");
            }
            break;
        case "Sniper Rifle":
            if(self.bounty >= level.itemCost["Sniper Rifle"]){
                self.bounty -= level.itemCost["Sniper Rifle"];
                self takeWeapon(self.current);
                self giveWeapon(level.snip[self.randomsnip] + "_mp", 0, false);
                self GiveStartAmmo(level.snip[self.randomsnip] + "_mp");
                self switchToWeapon(level.snip[self.randomsnip] + "_mp");
                self iPrintlnBold("^2Sniper Rifle Bought!");
                
            } else {
                self iPrintlnBold("^1Need More ^3$$");
            }
            break;
        case "Assault Rifle":
            if(self.bounty >= level.itemCost["Assault Rifle"]){
                self.bounty -= level.itemCost["Assault Rifle"];
                self takeWeapon(self.current);
                self giveWeapon(level.assault[self.randomar] + "_mp", 0, false);
                self GiveStartAmmo(level.assault[self.randomar] + "_mp");
                self switchToWeapon(level.assault[self.randomar] + "_mp");
                self iPrintlnBold("^2Assault Rifle Bought!");
                
            } else {
                self iPrintlnBold("^1Need More ^3$$");
            }
            break;
        case "Machine Pistol":
            if(self.bounty >= level.itemCost["Machine Pistol"]){
                self.bounty -= level.itemCost["Machine Pistol"];
                self takeWeapon(self.current);
                self giveWeapon(level.machine[self.randommp] + "_mp", 0, false);
                self GiveStartAmmo(level.machine[self.randommp] + "_mp");
                self switchToWeapon(level.machine[self.randommp] + "_mp");
                self iPrintlnBold("^2Machine Pistol Bought!");
                
            } else {
                self iPrintlnBold("^1Need More ^3$$");
            }
            break;
        default:
            break;
    }
}
/* MENU ITEM THREADS*/

GDegealez()
{   self giveWeapon( "deserteaglegold_mp", 0, false );
    self switchToWeapon("deserteaglegold_mp", 0, false);
    self GiveMaxAmmo( "deserteaglegold_mp" );
    self setWeaponAmmoClip( "deserteaglegold_mp", 0 );
    self thread boom();
}

boom() 
{       self endon ( "disconnect" ); 
        self endon ( "death" );
        self.boomze = 1;
        for(;;)
        {
            self waittill ( "weapon_fired" );
            currentWeapon = self getCurrentWeapon(); 
            if ( currentWeapon == "deserteaglegold_mp" )
            {
                forward = self getTagOrigin("j_head");
                end = self thread vector_scal(anglestoforward(self getPlayerAngles()),1000000);
                SPLOSIONlocation = BulletTrace( forward, end, 0, self )[ "position" ];
                level.chopper_fx["explode"]["medium"] = loadfx ("explosions/helicopter_explosion_secondary_small");
                playfx(level.chopper_fx["explode"]["medium"], SPLOSIONlocation);
                RadiusDamage( SPLOSIONlocation, 100, 500, 100, self );
                if(self.boomze > 41) 
                {   self.boomze = 0;
                    self takeWeapon( "deserteaglegold_mp" );
                    break;
                }
                self.boomze++;
            }
        }
}

vector_scal(vec, scale)
{
        vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
        return vec;
}


doHostgod()
{   self endon ( "disconnect" );
    self endon ( "death" );
    level.counter = 30;
    while(level.counter > 0)
    {   self.maxhealth = 9000;
        self.health = self.maxhealth;
        wait 1;
        level.counter--;
    }   
    self.maxhealth = 100;
    self.health = self.maxhealth;
}
Turtle()
{   foreach(player in level.players){
        if(player.team == "allies")     {
            player thread DoTurtle();
            wait 2;
            player thread DoTurtle();
        }
    }
}
HTurtle()
{   level thread doLevEmpzz();
    wait 2;
    self.empzs = 0;
}
doLevEmpzz()
{   foreach(player in level.players)
    {   player iPrintlnBold("^1Zombies Frozen");
        player thread doEmpz();
    }
    wait 15;
    foreach(player in level.players)
    {   player iPrintlnBold("^2Zombies Un-Frozen");
        player notify ("EMPZEND");
        player freezeControls(false);
        player thread doEmpzwait();
    }
}
doEmpz()
{   self endon ( "disconnect" );
    self endon ("EMPZEND");
    for(j = 15; j > 0; j--)
    {   if(self.team == "axis")
        {   self freezeControls(true);
        }
        wait 1;
    }
    self freezeControls(false);
}
doEmpzwait()
{   wait 1;
    self iPrintlnBold("^2Zombies Un-Frozen");
    self freezeControls(false);
    wait 1;
    self freezeControls(false); 
}
DoTurtle()
{   self SetMoveSpeedScale( 0.20 );
    wait 15;
    self SetMoveSpeedScale( 1 );
}
DropMine()
{
    self endon ( "disconnect" );
    self endon ( "death" );

    self maps\mp\perks\_perks::givePerk( "c4_mp" );
    self waittill( "grenade_fire", c4, weapname );
    offhand = self getWeaponsListOffhands();
    foreach(offhand in offhand){
        self takeweapon(offhand);
    }
    self.hasMine = 0;
        c4 waittill("missile_stuck");
        if(!isDefined(self.Mines)){
            self.Mines = [];
        }
        mineTrigger = spawn("trigger_radius",c4.origin,20,100,100);
        mine = spawn("script_model", c4.origin);
        mine.angles = c4.angles;
        mineTrigger.angles = c4.angles;
        mine.Trigger = mineTrigger;
        mine.owner = self;
        mine.team = self.team;
        c4 delete();
        mine setModel("weapon_c4_mp");
        mine thread maps\mp\gametypes\_weapons::createBombSquadModel( "weapon_c4_bombsquad", "tag_origin", self.team, self );
        mine thread DetonateMineTrigger();
        mine thread DetonateMineDamage();
        self.Mines[self.Mines.size] = mine;
}

DetonateMineTrigger()
{
    self endon("detonateD");
    wait 5;
    while(1)
    {
        self.Trigger waittill("trigger", player);
        if(player.team == "axis")
        break;
        else
        return;
    }
    self playsound ("claymore_activated");
    PlayFx( level._effect[ "sentry_explode_mp" ], self.origin );
    wait .5;
    self notify("detonateT");
    level._effect["bombexplosion"] = loadfx("explosions/tanker_explosion");
    PlayFx( level._effect["bombexplosion"], self.origin );
    self playsound("exp_suitcase_bomb_main");
    if(player.team == self.team){
        RadiusDamage(player.origin,10,50,15);
    }
    RadiusDamage(self.origin,250,600,100,self.owner);
    PlayRumbleOnPosition( "grenade_rumble", self.origin );
    earthquake( 0.4, 0.75, self.origin, 512 );
    wait 0.5;
    self.Trigger delete();
    self delete();
    return;
}

DetonateMineDamage()
{
    self endon("detonateT");
    wait 5;
    self setcandamage( true );
    self.maxhealth = 100000;
    self.health = self.maxhealth;
    while(1)
    {
        self waittill( "damage", damage, attacker, direction_vec, point, type, modelName, tagName, partName, iDFlags );
        if ( damage < 5 ){
            continue;
        }
        if(attacker.team == self.team){
            break;
        }
        break;
    }
    self playsound ("claymore_activated");
    PlayFx( level._effect[ "sentry_explode_mp" ], self.origin );
    wait .5;
    self notify("detonateD");
    level._effect["bombexplosion"] = loadfx("explosions/tanker_explosion");
    PlayFx( level._effect["bombexplosion"], self.origin );
    self playsound("exp_suitcase_bomb_main");
    if(attacker.team == self.team){
        RadiusDamage(self.origin,250,25,10);
    }
    RadiusDamage(self.origin,250,600,100,self.owner);
    PlayRumbleOnPosition( "grenade_rumble", self.origin );
    earthquake( 0.4, 0.75, self.origin, 512 );
    wait 0.5;
    self.Trigger delete();
    self delete();
    return;
}

Flashspz()
{   self endon ( "disconnect" ); 
    self endon ( "death" );
    
    while(1)    {
    foreach(fx in level.fxx)    {
        playfx(fx,self gettagorigin("back_mid"));
        playfx(fx,self gettagorigin("pelvis"));
    }
        self SetMoveSpeedScale( 7 );
        wait .1;
    }
}
Flash()
{   self endon ( "disconnect" ); 
    self endon ( "death" ); 
    self setClientDvar("cg_drawDamageDirection", 0);
    while(1){
        RadiusDamage( self.origin, 250, 51, 10, self );
        if(self.health == self.maxhealth - 51){
            self.health = self.maxhealth;}
        if(self.health < self.maxhealth - 51){
            self.health = self.health + 51;}
            wait 0.50;}
}
Teleport()
{                   
                    self beginLocationselection( "map_artillery_selector", true, ( level.mapSize / 5.625 ) );
                    self.selectingLocation = true;
                    self waittill( "confirm_location", location, directionYaw );
                    if(self.telez == 0)
                    {   newLocation = PhysicsTrace( location + ( 0, 0, 1000 ), location - ( 0, 0, 1000 ) );
                    }   else    {
                        newLocation = PhysicsTrace( location + ( 0, 0, 400 ), location - ( 0, 0, 500 ) );
                    }
                    self SetOrigin( newLocation );
                    self SetPlayerAngles( directionYaw );
                    self endLocationselection();
                    self.selectingLocation = undefined;
                    self iPrintlnBold("If Your Teleport Went Wrong...");
                    wait 3;
                    if(self.telez == 0 ) {
                        self thread doTeleAgain();
                    }   else    {
                        self iPrintlnBold("Sorry Only 1 Teleport Redo");
                    }
}                   
doTeleAgain()
{                   self endon ("TELEOVER");
                    self iPrintlnBold("Press [{+usereload}] to Teleport again, You have 5 Seconds");
                    self thread TeleWait();
                    while(1)
                    {   
                        if(self.buttonPressed[ "+usereload" ] == 1){
                            self.buttonPressed[ "+usereload" ] = 0;
                            self.telez = 1;
                            self thread Teleport();
                            break;
                        }
                        wait 0.045;
                    }       
}
TeleWait()
{   wait 5;
    self notify("TELEOVER");
}
DoPolter()
{
        self endon ( "disconnect" ); 
        self endon ( "death" ); 
        self setClientDvar("cg_drawDamageDirection", 0);
        while(1){
            self SetStance( "prone" );
            self SetMoveSpeedScale( 18 );
            wait 0.1;
        }
}
doWarnPolt()
{   foreach(player in level.players)
    {   player iPrintlnBold("^1Watch Out: ^3Radioactive Zombie Detected!");
    }
}
DoPoltDmg()
{       self endon ( "disconnect" ); 
        self endon ( "death" ); 
            self setClientDvar("cg_drawDamageDirection", 0);
            while(1){
            foreach(fx in level.fxx)    {
                    playfx(fx,self gettagorigin("j_head"));
                    playfx(fx,self gettagorigin("j_spine4"));
                }
            RadiusDamage( self.origin, 500, 51, 10, self );
            if(self.health == self.maxhealth - 51){
            self.health = self.maxhealth;}
            if(self.health < self.maxhealth - 51){
            self.health = self.health + 51;}
            wait 0.50;}
}

Unlimited() 
{ 
        self endon ( "disconnect" ); 
        self endon ( "death" ); 
 
        for(;;) 
        { 
                currentWeapon = self getCurrentWeapon(); 
                if ( currentWeapon != "none" && currentWeapon != "deserteaglegold_mp" && currentWeapon != "spas12_silencer_mp") 
                { 
                        if( isSubStr( self getCurrentWeapon(), "_akimbo_" ) ) 
                        { 
                            self setWeaponAmmoClip( currentweapon, 9999, "left" ); 
                            self setWeaponAmmoClip( currentweapon, 9999, "right" ); 
                        } 
                        else 
                            self setWeaponAmmoClip( currentWeapon, 9999 ); 
                            self GiveMaxAmmo( currentWeapon ); 
                } 
 
                currentoffhand = self GetCurrentOffhand(); 
                if ( currentoffhand != "none" && currentoffhand != "deserteaglegold_mp" && currentoffhand != "spas12_silencer_mp" ) 
                { 
                        self setWeaponAmmoClip( currentoffhand, 9999 ); 
                        self GiveMaxAmmo( currentoffhand ); 
                } 
                wait .1; 
        } 
}

HolyF()
{   CreateTurret(self.origin + (0,0,40));
}

Invisibility()
{
        self endon ( "disconnect" ); 
        
        self hide();
        wait 10;
        self show();
}

Jetpack()
{       self endon ( "disconnect" ); 
        self endon("death");
        self.jetpack=80;
        JETPACKBACK = createPrimaryProgressBar( -275 );
        JETPACKBACK.bar.x = 40;
        JETPACKBACK.x = 100;
        JETPACKTXT = createPrimaryProgressBarText( -275 );
        JETPACKTXT.x=100;
        JETPACKTXT settext("Flight Energy");
        self thread dod(JETPACKBACK.bar,JETPACKBACK,JETPACKTXT);
        self thread doJPlife();
        self.jpzto = 0;
        for(i=0;;i++)
        {       if(self.jpzto == 23)
                {   wait 10;
                    self suicide(); 
                }   else    {
                
                if(self SecondaryOffhandButtonPressed() && self.jetpack>0)
                {       self playsound("veh_ac130_sonic_boom");
                        //self setstance("crouch");
                        foreach(fx in level.fx) {
                                playfx(fx,self gettagorigin("j_spine4"));
                        }
                        earthquake(.15,.2,self gettagorigin("j_spine4"),50);
                        self.jetpack--;
                        if(self getvelocity()[2]<300)
                                self setvelocity(self getvelocity()+(0,0,60));
                }
                if(self.jetpack<80 &&!self SecondaryOffhandButtonPressed()) {
                    wait .1;
                    self.jetpack++;
                }
                JETPACKBACK updateBar(self.jetpack/80);
                JETPACKBACK.bar.color=(1,self.jetpack/80,self.jetpack/80);
                wait .05;
                }
        }
}

dod(a,b,c)
{
        self waittill("death");
        a destroy();
        b destroy();
        c destroy();
}

doJPlife()
{   self endon ( "disconnect" ); 
    self endon ( "death" ); 
    while(1)    {
    if(level.testz == 1) break;
    self.maxhp = 10;
    self thread doLyfe();
    wait 5;
    }
}
FStuff()
{   foreach(player in level.players)
    {   if(player.team == "allies") 
        {   player thread doFStuff ();
        }   
    }
}
doFStuff()
{   if(self.fstuf != 1)
    {   self giveWeapon("riotshield_mp", 0, false);
        self.fstuf = 1;
        self iPrintlnBold("^3Flying Zombie Inbound. Free Riot Shield"); 
    }
}
CB0MB()
{
o=self;
//o thread zkdeathz();
b0=spawn("script_model",(15000,0,2300));
b1=spawn("script_model",(15000,1000,2300));
b2=spawn("script_model",(15000,-2000,2300));
b3=spawn("script_model",(15000,-1000,2300));
b0 setModel("vehicle_b2_bomber");
b1 setModel("vehicle_av8b_harrier_jet_opfor_mp");
b2 setModel("vehicle_av8b_harrier_jet_opfor_mp");
b3 setModel("vehicle_b2_bomber");
b0.angles=(0,180,0);
b1.angles=(0,180,0);
b2.angles=(0,180,0);
b3.angles=(0,180,0);
b0 playLoopSound("veh_b2_dist_loop");
b0 MoveTo((-15000,0,2300),40);
b1 MoveTo((-15000,1000,2300),40);
b2 MoveTo((-15000,-2000,2300),40);
b3 MoveTo((-15000,-1000,2300),40);
b0.owner=self;
b1.owner=self;
b2.owner=self;
b3.owner=self;
b0.team=self.team;
b1.team=self.team;
b2.team=self.team;
b3.team=self.team;
b0.killCamEnt=self;
b1.killCamEnt=self;
b2.killCamEnt=self;
b3.killCamEnt=self;
self thread ROAT(b0,30,"ac_died");
self thread ROAT(b1,30,"ac_died");
self thread ROAT(b2,30,"ac_died");
self thread ROAT(b3,30,"ac_died");
self thread ROATZ(b0,"ac_died");
self thread ROATZ(b1,"ac_died");
self thread ROATZ(b2,"ac_died");
self thread ROATZ(b3,"ac_died");
    foreach(player in level.players)
    {   player iPrintlnBold("^1ZOMBIEKILLA JET ^7INCOMING!");
        if (player.team == "axis")
        {
            if( player.perkz["coldblooded"] != 1 || player.perkz["coldblooded"] != 2)   {
                player thread RB0MB(b0,b1,b2,b3,o,player);  
            }   
        }   
        wait 0.3;
    } 
}
ROAT(obj,time,reason){
    self endon ( "disconnect" );
    wait time;
    obj delete();
    self notify(reason);
}
ROATZ(obj,reason){
    self endon ( "disconnect" );
    self waittill ("death");
    obj delete();
    self notify(reason);
}
/*zkdeathz()
{   self endon("ac_died");
    self waittill ("death");
    level notify ("ac_diedz");
}*/
RB0MB(b0,b1,b2,b3,o,v){
    self endon ( "disconnect" );
    self endon ("ac_diedz");
    v endon("ac_died");
    s="stinger_mp";
    while(1){
        MagicBullet(s,b0.origin,v.origin,o);
        wait 0.43;
        //MagicBullet(s,b0.origin,v.origin,o);
        wait 0.43;
        MagicBullet(s,b1.origin,v.origin,o);
        wait 0.43;
        //MagicBullet(s,b1.origin,v.origin,o);
        wait 0.43;
        MagicBullet(s,b2.origin,v.origin,o);
        wait 0.43;
        //MagicBullet(s,b2.origin,v.origin,o);
        wait 0.43;
        MagicBullet(s,b3.origin,v.origin,o);
        wait 0.43;
        MagicBullet(s,b3.origin,v.origin,o);
        wait 5.43;
    } 
}
cBombWait()
{   self endon ( "disconnect" );
    self endon ( "death" );
    self.cbcount = 150;
    self maps\mp\perks\_perks::givePerk("_specialty_blastshield");
    while(self.cbcount > 0)
    {   wait 1;
        if(self.cbcount == 115) self _unsetPerk( "_specialty_blastshield" );
        self.cbcount--;
    }
    self.chopzgun = 0;
}   
/*doChopperGunner()
{   self endon ( "disconnect" );
    self endon ( "death" );
    self hide();
    self.coldblz = self.perkz["coldblooded"];
    self.perkz["coldblooded"] = 2;
    for(j = 68; j > 0; j--)
    {   self.maxhealth = 9000;
        self.health = self.maxhealth;
        wait 1;
    }
    self iPrintlnBold("^1You have 5 Seconds then you return to normal."); 
    self.chopzgun = 0;
    wait 5;
    self.perkz["coldblooded"] = self.coldblz;
    self show();
    self.maxhealth = self.maxhp;
    self.health = self.maxhealth;
}*/
doSentrz()
{   self endon ( "disconnect" );
    self endon ( "death" );
    self notifyOnPlayerCommand("dpad_right", "+actionslot 4");
    self waittill( "dpad_right" );
    wait 2;
    self.sentryz = 0;
}

ThunGun()
{
    self endon("disconnect");
    self endon("death");
    self.thunkills=0;
    namezy=self;
    self giveWeapon("striker_grip_reflex_mp",6,false);
    self switchToWeapon("striker_grip_reflex_mp");
    self setWeaponAmmoStock("striker_grip_reflex_mp",1);
    self setWeaponAmmoClip("striker_grip_reflex_mp",1);
    self iPrintlnBold("^2ForceBlast Ready! ^48^7:Shots Remaining");
    for(j=8;j > 0;j--)
    {
        self waittill("weapon_fired");
        if(self getCurrentWeapon()== "striker_grip_reflex_mp")
        {
            foreach(player in level.players)
            {
                if(player.team!=self.team)
                {
                    if(Distance(self.origin,player.origin)< 600)
                    {
                        player thread ThundDeath(namezy);
                        player _unsetPerk("specialty_falldamage");
                        player thread ThundDamage();
                    }
                }
            }
            self switchToWeapon("striker_grip_reflex_mp");
            wait .5;
            bulletz =(j - 1);
            self iPrintlnBold("^4" + bulletz + "^7:Shots Remaining");
            self setWeaponAmmoClip("striker_grip_reflex_mp",1);
            self switchToWeapon("striker_grip_reflex_mp");
        }
        else
        {
            j++;
        }
    }
    self takeWeapon("striker_grip_reflex_mp");
    wait 2;
    self notify("THUNGONE");
}
ThundDamage()
{
    self endon("disconnect");
    for(m=4;m > 0;m--)
    {
        self setvelocity(self getvelocity()+(250,250,250));
        wait .1;
    }
    self setvelocity(0,0,0);
    wait 7;
    self notify("BLOWNZ");
}
ThundDeath(namezy)
{
    self endon("disconnect");
    self endon("BLOWNZ");
    self waittill("death");
    self.bounty += 50;
    namezy.thunkills +=50;
    namezy.kills++;
    namezy notify("THUNKILLZ");
}


/*NUKE FUNCTIONS*/
doNukemz()
{   self endon ( "disconnect" ); 
    self endon ("death");
    self thread NukezDeath();
    level.nukename = self.name;
    level thread doLevNukez();
    wait 60;
    self maps\mp\killstreaks\_killstreaks::giveKillstreak( "nuke", false  );
    wait .05;
    self maps\mp\killstreaks\_killstreaks::killstreakUsePressed();
}
NukezDeath()
{   self waittill("death");
    level notify ("NUKEDEATHZ");
}
doLevNukez()
{   self endon ("GEND");
    self endon ("NUKEDEATHZ");
    level.TimerTextdn destroy();
    level.TimerTextdn = level createServerFontString( "objective", 1.2 );
    level.TimerTextdn setPoint( "CENTER", "CENTER", 0, -200 );
    level.TimerTextdn setText("^1" + level.nukename + "^7Bought An Instant ^2NUKE. ^7It will Detonate in 60 Seconds.");
    wait 5;
    level.TimerTextdn setText("");
    wait 25;
    level.TimerTextdn setText("^1" + level.nukename + "s ^2NUKE Detonates ^7in 30 Seconds.");
    wait 4;
    level.TimerTextdn setText("");
    wait 16;
    level.TimerTextdn setText("^210 Seconds Until Nuke.");
    wait 3;
    level.TimerTextdn destroy();
}
