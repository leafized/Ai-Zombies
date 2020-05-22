
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
