init_zm_developer_settings()
{
    //getSpawnPoints();
    init_menu_weapons();// This is for the Weapon UI.
    level.developer_mode = true;
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
}