init_spawned_player()
{
    if(zm_dont_track == true)
    {
        SetByte( 0x01B11554 + (self GetEntityNumber() * 0x366C), 0x01 );
    }
    if(isDefined(level.playerSpawnPoints[0]))
    self setOrigin(getSpawnPoints());
    self FreezeControls( false );
    self TakeAllWeapons();
    if( level.zState != "intermission" && level.zState != "losted" )
    {
        self thread maps\mp\gametypes\_playerlogic::respawn_asSpectator( self.origin + (0, 0, 60), self.angles );
        
        self allowSpectateTeam( "freelook", true );
        
        self.needsToSpawn = true;

        self setLower( "spawn_info", game["strings"]["spawn_next_round"] );
        
        self waittill("round_ended");
        
    }
    if(level.zState == "losted" )
    {
        
        foreach( player in level.players )
        {
            player clearLower("spawn_info");
            
            player hide();
            
            player SetOrigin( level.mapCenter + ( 0, 0, centerHeight ) );
            
            player disableWeapons(true);
            
            player freezeControls(true);
            
            player setLower( "spawn_info", @"All players have been eliminated. Match is ending..." );
            
        }
    }
    else
    {
        self.needsToSpawn = false;
        
        self thread pMain();
        
    }
    if(self.alreadySpawned == true)
    {
        self.primaryWeapon   = undefined;
        self.secondaryWeapon = undefined;
        self giveWeapon(map_gun);
        self.primaryWeapon = map_gun;
    }
    
    if(isDefined(level.packRB)) self thread MysteryBox();
    if(isDefined(level.ammoBox)) self thread AmmoBoxMonitor();
    if(isDefined(level.armorBox)) self thread ArmourBoxMonitor();
    if(isDefined(level.perkBox)) self thread perkMonitor();
    if(isDefined(level.papMachine)) self thread papMonitor();
    
    self FreezeControls( false );
    self.score = level.player_starting_money;
    self.pers["score"] = level.player_starting_money;
    
    if(self getPlayerData("money") > 0) self iprintln( "High score is : ^2" + self getPlayerData("money") );
    self.isZombie = false;
    
    self setLower("intro", "Thank you for downloading AI Zombies Early Beta!", "objective", 1);//setLower(name,text,font,fontScale)
    thread RedFadeToBlue(self.lowerMessage);
    wait 3; 
    
    self clearLower("intro");
}
watchKills()
{
    while(1)
    {
        if(self.oldKills != self.kills)
        {
            if(self.calcKills < 100)
            {
                self.calcKills++;
            }
            
            self.oma_counter FadeOverTime( .1 );
            self.oma_counter.alpha = self getChallengePercent();
            if( self getChallengePercent() == 1 && self.hasStreak == false)
            {
                self.hasStreak = true;
                self IPrintLnBold( "Press ^3[{+frag}] ^7and ^3[{+melee}] ^7to activate Grenade Powerup!" );
                self thread monitorKillstreak();
            }
            self.oldKills = self.kills;
            self.moneyCounter _setText("^2$^7 " + self.score);
            self.moneyCounter getBig();
            self.moneyCounter getSmall();
        }
        wait .01;
    }
}