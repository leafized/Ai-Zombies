
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
    
    self.roundCounter        = createText("objective", 1.5,"LEFT", "BOTTOMRIGHT",0,0,1,1,level.Wave + 1,(1,1,1),(.4,.4,.4),1);
    self.weaponAmmo          = createText("objective",1.2,"LEFT","BOTTOMRIGHT",-130,-35,1,1,"",(1,1,1), (.1,.1,.1), 1);//createText(font,fontScale,align,relative,x,y,sort,alpha,text,color)
    self.weaponAmmoStock     = createText("objective",.9,"LEFT","BOTTOMRIGHT",-110,-35,1,1,"",(1,1,1), (.1,.1,.1), 1);//createText(font,fontScale,align,relative,x,y,sort,alpha,text,color)
    self.weaponShaderPrimary = CREATEICON("RIGHT","BOTTOMRIGHT", -30,-35,70, 16,"",3,1);
    self.weaponShader        = createRectangle("CENTER","BOTTOMRIGHT",-80,-35,120, 30,(.4,.4,.4),"hudsoftline",0,.7);//CREATEREC
    self.weaponShaderBG      = createRectangle("CENTER","BOTTOMRIGHT",-80,-35,120, 30,(0,0,0),"white",0,.7);//CREATEREC
    
    self.weaponShader2   = createRectangle("CENTER","BOTTOMRIGHT",-80,-20,120, 2,(.4,.4,.4),"white",2,1);//CREATEREC
    self.weaponShader2BG = createRectangle("CENTER","BOTTOMRIGHT",-80,-50,120, 2,(.4,.4,.4),"white",2,1);//CREATEREC
    //createRectangle(align,relative,x,y,width,height,color,shader,sort,alpha)
    self.moneyShader2   = createRectangle("CENTER","BOTTOMRIGHT",-80, 15,120, 2,(.4,.4,.4),"white",0,1);//CREATEREC
    self.moneyShader2BG = createRectangle("CENTER","BOTTOMRIGHT",-80,-15,120, 2,(.4,.4,.4),"white",0,1);//CREATEREC
    
    self.moneyShader   = createRectangle("CENTER","BOTTOMRIGHT",-80,0,120, 30,(.4,.4,.4),"hudsoftline",1,.7);//CREATEREC
    self.moneyShaderBG = createRectangle("CENTER","BOTTOMRIGHT",-80,0,120, 30,(0,0,0),"white", 0, .7);//CREATEREC
    
    self.moneyCounter            = createText("default",1.4,"CENTER","BOTTOMRIGHT",-80, 0,4,1,"",(1,1,1),(.4, .4, .4), 1);
    self.moneyCounter.foreground = true;
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
       
        self.weaponShaderPrimary SetShader( getWeaponShader(self GetCurrentWeapon() ), 64, 24 );
        self.weaponAmmo _setText(self GetWeaponAmmoClip( self GetCurrentWeapon() ));
        self.weaponAmmoStock _setText(self GetWeaponAmmoStock( self GetCurrentWeapon() ));
        self.moneyCounter _setText("^2$^7 " + self.score);
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