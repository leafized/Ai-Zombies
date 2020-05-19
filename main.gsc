#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;


/* 

    NON DEVELOPERS PLEASE READ!!!!
    THIS MOD IS IN ALPHA STAGES, AND MAY HAVE BUGS. CURRENTLY THE ONLY SUPPORTED MAP IS RUST.
    MORE MAPS WILL BE MADE AVAILABLE SOON. THIS CODE IS GOING TO SLOWLY GET COMPLETELY OVERHAULED.

*/

#define map_gun = "usp_xmags_mp";
#define ammo_clip_count = 40;
#define ammo_stock_count = 280;
#define vision_constant = "cobra";
 init()
{
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
                thread init_spawned_player();
        }
}
visionConstant()
{
    for(;;)
    {
        self VisionSetNakedForPlayer( vision_constant , 0 );
        wait .25;
    }
}
printLoc(ent = self)
{
    self endon("stop_printing");
    for(;;)
    {
        self waittill("menuresponse");
        
        self maps\mp\gametypes\_class::giveloadout(self.team,self.class); 
        
        self iprintlnBold("");
        
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
 