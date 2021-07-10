
pMain()
{
self endon("respawn");
self endon("death");
self endon("disconnect");

self notifyonplayercommand("lal", "+actionslot 1");
for(;;)
{

    if(level.IntermissionTime <= 0)
    {
        self.pers["botKillstreak"] = 0;
        self.pers["lastKillstreak"] = "";
        self playLocalSound( game["music"]["winning_allies"] );
        self freezeControls(false);
        self maps\mp\perks\_perks::givePerk("specialty_bulletaccuracy");
        self maps\mp\perks\_perks::givePerk("specialty_bulletdamage");
        self maps\mp\perks\_perks::givePerk("specialty_bulletpenetration");
        self maps\mp\perks\_perks::givePerk("specialty_exposeenemy");
        self maps\mp\perks\_perks::givePerk("specialty_extendedmags");
        self maps\mp\perks\_perks::givePerk("specialty_fastreload");
        self maps\mp\perks\_perks::givePerk("specialty_fastsnipe");
        self maps\mp\perks\_perks::givePerk("specialty_marathon");
        self maps\mp\perks\_perks::givePerk("specialty_quieter");
        if( self.beentold == 0 )
        {
            self doMain();
            self.beentold++;
        }
        
    break;
    }

wait 0.05;
}
}
doMain()
{
    self TakeAllWeapons();
    self.primaryWeapon   = map_gun;
    self.secondaryWeapon = undefined;
    self GiveWeapon( map_gun, 0 );
    self SetWeaponAmmoClip( map_gun, ammo_clip_count );
    self SetWeaponAmmoStock( map_gun, ammo_stock_count );
    self SwitchToWeapon( map_gun );
    self notify("starting_zombies");
}

precacheItems()
{
    precacheMenu("error_popmenu");
    game["strings"]["MP_HORDE_BEGINS_IN"] = "Zombie's spawning In";
    game["strings"]["MP_CUR_WAVE"] = "Current Wave:";
    game["strings"]["MP_LEFT_TO_SPAWN"] = "Left To Spawn:";
    game["strings"]["MP_ZOMBIES"] = "Zombies:";
    game["strings"]["MP_HEALTH"] = "Health:\nMoney:";
    precacheString(game["strings"]["MP_HORDE_BEGINS_IN"]);
    precacheString(game["strings"]["MP_CUR_WAVE"]);
    precacheString(game["strings"]["MP_LEFT_TO_SPAWN"]);
    precacheString(game["strings"]["MP_ZOMBIES"]);
    precacheString(game["strings"]["MP_HEALTH"]);
    precacheString(game["strings"]["MP_NV"]["1"]);
    precacheString(game["strings"]["MP_NV"]["2"]);
    precacheShader("hudsoftline");
    precacheShader("hud_grenadeicon");
    for(i=0;i<49;i++)
    {
        precacheShader(getPerkShader(getPerkId(i)));
    }
}

FuncsMain()
{
    setDvar("g_hardcore", 1);
    level.SpawnTrigger = ::SpawnTrigger;
    level.SpawnWeapon  = ::SpawnWeapon;
    level.SpawnClient  = maps\mp\gametypes\_playerlogic::spawnPlayer;
}

GiveWeaponAndAmmo( WeaponName, CamoID, Akimbo )
{
    self giveWeapon( WeaponName, CamoID, Akimbo );
    self GiveMaxAmmo( WeaponName );
}

setAC130Options( FlareAmount, UseDuration )
{
    level.ac130_use_duration = UseDuration;
    level.ac130_num_flares   = FlareAmount;
}

setRecoilScale( scale )
{
    self player_recoilScaleOn( scale );
}

VectorScale(vec, scale)
{
    vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
    return vec;
}

GetHost( )
{

    foreach( player in level.players )
    {
        if(player isHost())
            return player;
    }
    
    return 0;
}

DestroyOnDeath( hudElem )
{
    self waittill ( "death" );
    hudElem destroy();
}

BotDestroyOnDeath( icon )
{
    self waittill("bot_death");
    icon destroy();
}

KillEnt( ent, time )
{
    ent StartRagDoll();
    ent NotSolid();
    wait time;
    ent delete();
    ent destroy();
}

ZombieCount()
{
zombCount = 0;

        for(i = 0; i < level.BotsForWave; i++)
        {
            if((isDefined(level.zombies[i])) && (level.zombies[i].crate1.health > 0))
                zombCount++;
        }
        
return zombCount;
}

SpawnTrigger(Torigin, gotoOrigin, width, height, map_name)
{
    trig = spawn("trigger_radius", Torigin,0,width,height);
    trig.goto = gotoOrigin;
    trig thread waitfortrig(map_name);    
    return trig;
}

waitfortrig(map_name)
{ 
    while(getdvar("mapname") == map_name)
    {
        self waittill("trigger",player);

        if(player.sessionstate != "playing")
        continue;
        player iPrintlnBold("Anti-Glitch");
        
wait 0.05;
    }
}



SpawnWeapon(weapName, coords, angles)
{
    point = spawn("script_origin", coords);
    weap  = SpawnWeap(weapName, point.origin);
    if(isDefined(angles))
        weap.angles = angles;
    weap linkto( point );
    return point;
}

SpawnWeap(weapName, coords)
{
    return spawn( "weapon_" + weapName, coords + (0,0,5) );
}

BotMain()
{
    CreateBotWave( );
}






