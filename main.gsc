#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include AImod\_OtherFunctions;


#define map_gun = "usp_xmags_mp";
#define ammo_clip_count = 40;
#define ammo_stock_count = 280;
 init()
{
    init_menu_weapons();
    level.developer_mode = false;
    /* Global Vars */
    //Bots --------------------
    level.MaxWaves          = 50; //can change
    level.BotsForIcons      = 0; //can change
    level.SpawnedBots       = 0;
    level.RealSpawnedBots   = 0;
    level.BotsForWave       = 0;

    //Waves -------------------
    level.Wave = 0;
    //Game State --------------
    level.zState = "intermission";
    //Ammo Drop ---------------
    level.AmmoDrop = undefined;
    //Intermission Timer ------
    level.IntermissionTimeStart = 20;//can change
    level.IntermissionTime      = 20;
    level.timer_intermission    = 15;//Amount of time between rounds
    //Brightness --------------
    level.brightness = 0;
    ///Prices  ----------------
    level.store_item_price_weapon = 1000;
    level.store_item_price["JUGG"] = 2500;
    level.store_item_price_ammo  = 750;
    level.store_item_price_armor = 3000;
    
    //Perk Prices
    level.store_item_price_perk["Reload"] = 2000;
    //Player Variables --------------
    if(level.developer_mode == true)
    level.player_starting_money = 9999999;
    else level.player_starting_money = 750;
    //Shaders ------------------------
    level.shader_store["BOX"] = "cardicon_treasurechest";
    level.shader_store["AMMO"] = "cardicon_bullets_50cal";
    level.shader_store["ARMOR"] = "cardicon_juggernaut_1";
    level.shader_store["OMA2"] = "cardicon_laststand";
    
    level.shader_store["Reload"] = "cardicon_redhand";//"specialty_fastreload";
    
    precacheArray = [level.shader_store["BOX"],level.shader_store["AMMO"],level.shader_store["ARMOR"],level.shader_store["OMA2"],level.shader_store["Reload"]];
    foreach(shade in precacheArray)
        PreCacheShader( shade );
    //Main Threads
    

    /* Tweakable */
    level.ZombieHealth = 100;//can change //Zombes / AI Scripts / zombie_monitor_health.gsc
    level.destructibleSpawnedEntsLimit += 50;
    level.zombie_kill_points      = 50;//Base points a player recieves when killing zombies
    level.zombie_hit_points       = 10;//Base hit points when a player damages a zombie.
    level.zombies_max_spawn       = 20;//Maximum zombies that can be spawned at onen time.
    level.zombie_speed_multiplier = 1;//Zombie Speed Multiplier, change to make zombies move faster.
    level.zombie_debug_anim       = @"pb_run_fast";//Animation used for movement, will be updated when different zombies are introducted.
    
    PrecacheMpAnim( level.zombie_debug_anim  );//zombies anim
    PreCacheModel( @"head_tf141_desert_d" );//zombies current models
    PreCacheModel( @"bc_ammo_box_762" );//drop model
    /* Spawn Anti-Glitch spots */
    [[level.SpawnTrigger]] ((1284, 2600, 167), (942, 2604, 51), 50, 100, @"mp_terminal");
    [[level.SpawnTrigger]] ((1803, 2502, 140), (1790, 2643, 51), 50, 100, @"mp_terminal");
    PreCacheShader( @"logo_iw" );//THis shows the infinity Loader logo on your screen, and IW on clients.
    

   
     thread init_drop_information();
     level thread loadMap();//This function checks if the map is in the supported list.

     level thread precacheItems();
     //level thread IntermissionCountdown();
    //mapSetup();
    level thread onPlayerConnect();

}

loopAd()
{
    level endon("disconnect");
    for(;;)
    {
        IPrintLn( "^7Youtube.com/^1Leafized" );
        IPrintLn( "^5http://infinityloader.com" );
        
        wait 15;
    }
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
                player createIcon("RIGHT","TOPRIGHT",0,-10,120,60,"logo_iw",1,1);
                level notify(@"match_start_timer_beginning");
                if(player IsHost() && !level.overFlowFix_Started)
                {
                    level thread init_overFlowFix();
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
                
                self FreezeControls( false );
                self TakeAllWeapons();
                //self thread initMenu();
                if( level.zState != @"intermission" && level.zState != @"losted" )
                {
                    self thread maps\mp\gametypes\_playerlogic::respawn_asSpectator( self.origin + (0, 0, 60), self.angles );
                    self allowSpectateTeam( "freelook", true );
                    self.needsToSpawn = true;

                    self setLowerMessage( "spawn_info", game["strings"]["spawn_next_round"] );
                    self waittill("round_ended");
                    
                }
                if(level.zState == "losted" )
                {
                    centerHeight = self getFlyHeightOffset( level.mapCenter );
                    foreach( player in level.players )
                    {
                        player hide();
                        player SetOrigin( level.mapCenter + ( 0, 0, centerHeight ) );
                        player disableWeapons(true);
                        player freezeControls(true);
                        player setLowerMessage( "spawn_info", @"All players have been eliminated. Match is ending..." );
                    }
                }
                else
                {
                    self.needsToSpawn = false;
                    self thread pMain();
                }

                
            if(self.alreadySpawned == true)
            {
                self giveWeapon(map_gun);
            }
            self thread MysteryBox();
            self thread AmmoBoxMonitor();
            self thread ArmourBoxMonitor();
            self thread perkMonitor();
            self.score = level.player_starting_money;
            self.pers["score"] = level.player_starting_money;
            if(self getPlayerData("money") > 0) self iprintln( "High score is : ^2" + self getPlayerData("money") );
            self thread visionConstant();
            self.isZombie = false;
        }
}
visionConstant()
{
    for(;;)
    {
        self VisionSetNakedForPlayer( "cobra_sunset3", 0 );
        wait .25;
    }
}
printLoc(ent = self)
{
    self endon("stop_printing");
    for(;;)
    {
        if(level.developer_mode == true)
        {
            if(!isDefined(self.OriginHud))
            self.OriginHud = createText("default",1.2,"center","center",0,0,1,1,self.origin,(1,1,1));
        }
        if(isDefined(self.OriginHud))
        {
            self.oldOrigin = self.origin;
            wait .1;
            if(self.origin != self.oldOrigin)
            self.OriginHud _setText(self.origin + "\n" + "Body: ^1" + self.model + "\n^7Head: ^1"+self getAttachModelName(0));
        }
        wait .05;
    }
}
 