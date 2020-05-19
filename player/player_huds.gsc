
hud_health()
{
    self notify("stop_healthbar_thread");
    self endon("disconnect");
    self endon("stop_healthbar_thread");

    widthofbar = 128;
    x = 10;
    y = 412;

    if(isDefined(self.healthword))
        self.healthword destroy();

    if(isDefined(self.healthnum))
        self.healthnum destroy();

    if(isDefined(self.healthbar))
        self.healthbar destroy();

    if(isDefined(self.healthbarback))
        self.healthbarback destroy();

    if(isDefined(self.healthwarning))
        self.healthwarning destroy();
        
    if(isDefined(self.intermissionTimer))
        self.intermissionTimer destroy();
        
    if(isDefined(self.intermissionTimer2))
        self.intermissionTimer2 destroy();

        
    self.intermissionTimer = self createFontString( "objective", 1.3 );
    self.intermissionTimer setPoint( "TOP", "TOP", 0, 150 );
    self.intermissionTimer.color = (1, 1, 1);
    
    self.intermissionTimer2 = self createFontString( "objective", 0.9 );
    self.intermissionTimer2 setPoint( "TOP", "TOP", 0, 165 );
    self.intermissionTimer2.color = (1, 1, 1);
    
    self.healthnum                = createHudText("default", 1.4, "left", "middle", x, 10, 1, "",(1,1,1));

    self.weaponAmmo  = createText("default",1.6,"RIGHT","BOTTOMRIGHT",0,-14,1,1,"",(1,1,1));
    self.weaponAmmo2 = createText("default",1.6,"RIGHT","BOTTOMRIGHT",0,0,1,1,"",(1,1,1));
    while(1)
    {
        if((isDefined(level.IntermissionTime)) && (level.IntermissionTime > 0))
        {
            self.intermissionTimer setText(game["strings"]["MP_HORDE_BEGINS_IN"]);
            self.intermissionTimer2 setValue(level.IntermissionTime);
            self.intermissionTimer.y  = -20;
            self.intermissionTimer2.y = 0;
        }
        else
        {
            self.intermissionTimer setText("");
            self.intermissionTimer2 setText("");
        }
    
        if(self.sessionstate != "playing" || !isDefined(self.health) || !isDefined(self.maxhealth))
        {
            self.healthword.alpha = 0;
            self.healthnum.alpha = 0;
            self.healthbar.alpha = 0;
            self.healthbarback.alpha = 0;
            self.healthwarning.alpha = 0;
            wait 0.05;
            continue;
        }
        self.healthnum.alpha = 1;
        self.healthbar.alpha = 1;
        self.healthbarback.alpha = 0.5;

        self.healthnum thread _setText(getPlayerScores());
        
        self.weaponAmmo thread _setText(getWeaponName(self GetCurrentWeapon()));
        self.weaponAmmo2 thread _setText(self GetWeaponAmmoClip( self GetCurrentWeapon() ) + "/"+self GetWeaponAmmoStock( self GetCurrentWeapon() ) + "\n");
        wait 0.05;
        
    }
}

getPlayerScores()
{
    string = "";
    for(i=0;i<level.players.size;i++)
    {
        player = level.players[i];
        string += (player.name + " ^2$^7" + player.score + "\n");
    }
    return string;
}