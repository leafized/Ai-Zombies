
hud_health()//CreateBotWave()
{
    self notify("stop_healthbar_thread");
    self endon("disconnect");
    self endon("stop_healthbar_thread");

    widthofbar = 128;
    x          = 10;
    y          = 412;

    if(isDefined(self.healthnum))
        self.healthnum destroy();
        
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
    
    self.healthnum = createHudText("default", 1.4, "left", "middle", x, 10, 1, "",(1,1,1));

    self.weaponAmmo            = createText("default",1.6,"RIGHT","BOTTOMRIGHT",-82,-14,1,1,"",(1,1,1));
    self.weaponAmmo2           = createText("default",1.6,"LEFT","BOTTOMRIGHT",-68,-14,1,1,"",(1,1,1));
    self.weaponShaderPrimary   = CREATEICON("RIGHT","BOTTOMRIGHT", -80,-35,50, 16,"",0,1);
    self.weaponShaderSecondary = CREATEICON("LEFT","BOTTOMRIGHT",-70,-35,30, 16,"",0,1);
    self.weaponShaderSeperate  = createRectangle("CENTER","BOTTOMRIGHT",-75,-35,60, 18,(.2,.2,.2),"white",0,.7);//CREATEREC
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
       

        self.healthnum thread _setText(getPlayerScores());
        if(isDefined(self.weaponShaderPrimary)){//Here we want to check and see if the primary weapon is defined
            self.weaponShaderPrimary SetShader( getWeaponShader(self.primaryWeapon), 64, 24 );
        } else self.weaponShaderPrimary setShader(getPerkShader(getperkid(0)), 64, 24);
        
        if(isDefined(self.secondaryWeapon)){//Here we want to check if the secondary weapon is defined
            self.weaponShaderSecondary SetShader( getWeaponShader(self.secondaryWeapon), 64, 24 );
        } else self.weaponShaderSecondary SetShader( getperkshader(getPerkId(0)), 64, 24 );
        
        
        if(self.primaryWeapon == self GetCurrentWeapon()) {
            self.weaponShaderPrimary.alpha = 1;
            self.weaponShaderPrimary FadeOverTime( .2 );
            self.weaponShaderSecondary.alpha = .6;
            self.weaponShaderSecondary FadeOverTime( .2 );
            } else if(self.secondaryWeapon == self GetCurrentWeapon()){
            self.weaponShaderPrimary.alpha = .6;
            self.weaponShaderPrimary FadeOverTime( .2 );
            self.weaponShaderSecondary.alpha = 1;
            self.weaponShaderSecondary FadeOverTime( .2 );
        }
        self.weaponAmmo thread _setText(self GetWeaponAmmoClip( self.primaryWeapon ) + "/"+self GetWeaponAmmoStock( self.primaryWeapon ));
        self.weaponAmmo2 thread _setText(self GetWeaponAmmoClip( self.secondaryWeapon ) + "/"+self GetWeaponAmmoStock( self.secondaryWeapon ) );
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