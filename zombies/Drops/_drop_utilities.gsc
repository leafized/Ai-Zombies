
init_drop_information()
{
    level.drop_setting["frequency"] = 1;
    level.drop_setting["glow"] = 0;
    
    level.drop_list = ["Nuke", "Ammo","Sale", "InstaKill"];
    
    level.default_drop_model = "com_plasticcase_friendly";
    level.nuke_drop_model    = "";
    
    level.drop_icon["Nuke"] = "cardicon_tacticalnuke";
    level.drop_icon["Ammo"] = "cardicon_bulletcase";
    level.drop_icon["Sale"] = "cardicon_treasurechest";
    level.drop_icon["InstaKill"] = "cardicon_skull_black";
    
    level.drop_action["Nuke"] = ::nukeZombies;
    level.drop_action["Ammo"] = ::maxAmmo;
    level.drop_action["Sale"] = ::fireSale;
    level.drop_action["InstaKill"] = ::instaKill;

    
    foreach(shader in level.drop_icon) precacheShader(shader);
    
}

spawnDrop()
{
    drop = level.drop_list[RandomInt( level.drop_list.size )];
   if(!isDefined(level.dropped[drop]))
   {
       level endon("stop_drops");
       level.dropped[drop] = spawn("script_model", self.origin + (0,0,30));
       level.dropped[drop] setModel(level.default_drop_model);
       wait .025;
       level.dropped[drop] SetEntHeadIcon((0,0,45),level.drop_icon[drop],true);
       foreach(player in level.players) player thread monitorDrop(drop);
       level.dropped[drop] rotateEntYaw(360,10);
       level.dropped[drop] hide();
       wait 2;
       level.dropped[drop] show();
       wait 1.5;
       level.dropped[drop] hide();
       wait 1;
       level.dropped[drop] show();
       wait .8;
       level.dropped[drop] hide();
       wait .6;
       level.dropped[drop] show();
       wait .4;
       level.dropped[drop] hide();
       wait .2;
       level.dropped[drop] hide();
       wait .2;
       level.dropped[drop] hide();
       wait .2;
       level.dropped[drop] hide();
       wait .2;
       level.dropped[drop] hide();
       wait .2;
       level.dropped[drop] hide();
       wait .2;
       level.dropped[drop] hide();
       wait .2;
       level notify("stop_drop"+drop);  
       
       level.dropped[drop].headIcon destroy();
       level.dropped[drop] delete();
       level notify("stop_drops");
   }
}
monitorDrop(drop)
{
    self endon("stop_drop"+drop );
    for(;;)
    {
        if(Distance( self.origin, level.dropped[drop].origin ) < 50)
        {level.dropped[drop].fx delete();
            level.dropped[drop].headIcon destroy();
            level.dropped[drop] delete();
            level thread [[level.drop_action[drop]]](level.dropped[drop]);
            self notify("stop_drop"+drop);
        }
        wait .25;
    }
}

