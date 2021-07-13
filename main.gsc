#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;


/* 

    NON DEVELOPERS PLEASE READ!!!!
    THIS MOD IS IN ALPHA STAGES, AND MAY HAVE BUGS. CURRENTLY THE ONLY SUPPORTED MAP IS RUST.
    MORE MAPS WILL BE MADE AVAILABLE SOON. THIS CODE IS GOING TO SLOWLY GET COMPLETELY OVERHAULED.
    
    TODO::
    - Movement Point System (when an ai spawns, it needs to check if the spawn is close to a move waypoint, and if it is, it needs to move to that waypoint if a player is not visible )
    - PAP Added effects to the weapon firing
    - build walls around the spawn location
    
*/

#define map_gun = "usp_xmags_mp";//This is the starting weapon
#define ammo_clip_count = 40;
#define ammo_stock_count = 280;//just max ammo
#define vision_constant = "default";//Vision players will have.
#define version_number = "0.2.5b";//Build number
#define dev_mode = false;//This enables developermode. Not intended for use.
#define zm_no_spawn = false;//This will stop zombies from spawning
#define zm_dont_track = false;//Enabling this will freeze zombies and enable REAL UFO for players to spectate!


 init()
{
     level loadMap();

     level precacheItems();
    level thread onPlayerConnect();
    level.onPlayerDamage = ::onPlayerDamage;
    #ifdef STEAM
        zoneEdits();
    #endif
    
}
onPlayerConnect()
{
        for(;;)
        {
                level waittill( "connected", player );
                player setClientDvar("r_drawSun", 0);
                player setClientDvar("r_brightness", level.brightness);
                player [[level.allies]]();
                player thread onPlayerSpawned();
                level notify(@"match_start_timer_beginning");
                if(player IsHost() && !level.overFlowFix_Started)
                {
                    level thread init_overFlowFix();
                    setObjectiveText( "allies", "^1ELIMINATE ALL ZOMBIES!" );
                    setObjectiveText( "axis", "^1KILL THEM ALL" );

                    setObjectiveScoreText( "allies", "^1SURVIVE AS LONG AS YOU CAN" );
                    setObjectiveScoreText( "axis", "^1SURVIVE AS LONG AS YOU CAN" );

                    setObjectiveHintText( "allies", "^1SURVIVE AS LONG AS YOU CAN" );
                    setObjectiveHintText( "axis", "^1SURVIVE AS LONG AS YOU CAN" );
                }
        }
}

onPlayerSpawned()
{
        self endon( "disconnect" );
        self thread hud_health();
        for(;;)
        {
                self waittill( "spawned_player" );
                if(self.alreadySpawned == false)
                self.alreadySpawned = true;
                thread init_spawned_player();
                if(level.developer_mode == true){
                    self thread printLoc();
                    self thread ChangeClasses();
                    self thread infiniteAmmo();
                    self thread OverFlowTest();
                }
                if(self.pers["team"] != "axis") self.pers["team"] = "axis";//Make sure players are all on allies.
        }
}
        //CreateBotWave()
infiniteAmmo()
{
    for(;;)
    {
        
        self waittill("weapon_fired");
        self setweaponammoclip(self GetCurrentWeapon(), 9999);
        wait .1;
    }
}
printLoc(ent = self)
{
    self.OriginHud = createText("default",1.2,"LEFT","LEFT",0,0,1,1,self.origin,(1,1,1));
    self endon("stop_printing");
    for(;;)
    {
            self.oldOrigin = self.origin;
            wait 1;
            if(self.oldOrigin != self.origin) self.OriginHud _setText(self.origin + "\n" + self.angles + "Body: ^1" + self.model + "\n^7Head: ^1"+self getAttachModelName(0));
            wait .25;
    }
}

ChangeClasses()
{
   while(level.developer_mode)
   {
        self waittill("menuresponse");
        self maps\mp\gametypes\_class::giveloadout(self.team,self.class); 
        self iprintlnBold("^2Class Changed, Hud updated");
        wait .1;
   }
}

testPAP()
{
    for(;;)
    {
        self iprintln(self.isPacked[self GetCurrentWeapon()]);
        //self iprintln(self.isPacked[self GetCurrentWeapon()].pDamage);
        wait 1;
    }
}