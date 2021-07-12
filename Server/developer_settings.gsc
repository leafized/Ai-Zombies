init_zm_developer_settings()
{
    //getSpawnPoints();
    init_menu_weapons();// This is for the Weapon UI.
    if(isDefined(dev_mode))
    level.developer_mode = dev_mode; // Only use this if you are debugging.
    else level.developer_mode = false;
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
    level.IntermissionTimeStart = 30;//can change (is the beginning timer)
    level.IntermissionTime      = 30;//Genera
    level.timer_intermission    = 20;//Amount of time between rounds
    //Brightness --------------
    level.brightness = 0;
    ///Prices  ----------------
    level.store_item_price_weapon = 950;
    level.store_item_price_ammo   = 500;
    level.store_item_price_armor  = 2500;
    level.store_item_price_pap    = 5000;
    //Perk Prices
    level.store_item_price_perk["Reload"] = 3000;
    //Player Variables --------------
    if(level.developer_mode == true)
    level.player_starting_money = 9999999;
    else level.player_starting_money = 1250;
    //Shaders ------------------------
    level.shader_store["BOX"] = "cardicon_treasurechest";
    level.shader_store["AMMO"] = "cardicon_bullets_50cal";
    level.shader_store["ARMOR"] = "cardicon_juggernaut_1";
    level.shader_store["OMA2"] = "cardicon_laststand";
    level.shader_store["PAP"] = "cardicon_fmj";
    
    level.shader_store["Reload"] = "cardicon_redhand";//"specialty_fastreload";
    
    //precacheArray = [level.shader_store["BOX"],level.shader_store["AMMO"],level.shader_store["ARMOR"],level.shader_store["OMA2"],level.shader_store["Reload"]];
    foreach(shader in level.shader_store)
    PreCacheShader( shader );
    //Main Threads
    

    /* Tweakable */
    level.ZombieHealth = 100;//can change //Zombes / AI Scripts / zombie_monitor_health.gsc
    level.destructibleSpawnedEntsLimit += 10;
    level.zombie_kill_points       = 120;//Base points a player recieves when killing zombies
    level.zombie_hit_points        = 10;//Base hit points when a player damages a zombie.
    level.zombies_max_spawn        = 40;//Maximum zombies that can be spawned at onen time.
    level.zombie_speed_multiplier  = 1;//Zombie Speed Multiplier, change to make zombies move faster.
    level.run_animation            = @"pb_run_fast";//Animation used for running movement.
    level.walk_animation           = "pb_walk_forward_mg";//Animation used for walking movement.
    level.zombie_base_dmg_modifier = 30;//This is base damage for headshots.
    level.round_dmg_modifier       = 0;//this should always remain 0 unless packapunch is active on your weapon.
    level.zombie_hs_dmg_multiplier = 20;//This is the amount of damage that will be dealt in addition to the weapons damage for headshots
    PrecacheMpAnim( level.run_animation  );//zombies anim
    PrecacheMPAnim( level.walk_animation );//Zombie Walking Animation
    
    PreCacheModel( @"head_tf141_desert_d" );//zombies current models
    PreCacheModel( @"bc_ammo_box_762" );//drop model
    /* Spawn Anti-Glitch spots */
    [[level.SpawnTrigger]] ((1284, 2600, 167), (942, 2604, 51), 50, 100, @"mp_terminal");
    [[level.SpawnTrigger]] ((1803, 2502, 140), (1790, 2643, 51), 50, 100, @"mp_terminal");
    PreCacheShader( @"logo_iw" );//THis shows the infinity Loader logo on your screen, and IW on clients.
}