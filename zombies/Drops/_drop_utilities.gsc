
init_drop_information()
{
    level.drop_setting["frequency"] = 1;
    level.drop_setting["glow"] = 0;
    
    level.drop_list = ["Nuke", "Ammo","Sale", "InstaKill"];
    
    level.default_drop_model = "com_plasticcase_friendly";
    level.nuke_drop_model    = "";
    
    level.drop_icon["Nuke"] = "cardicon_radiation";
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
       level endon("stop_drop_spawn");
       level.dropped[drop] = spawn("script_model", self.origin + (0,0,30));
       level.dropped[drop] setModel("");
       wait .025;
       level.dropped[drop].headIcon = drop_icon((0,0,20),level.drop_icon[drop], drop);//SetEntHeadIcon(offset,shader,keepPosition,is_drop,drop)
       foreach(player in level.players) player thread monitorDrop(drop);
       level.dropped[drop] thread rotateEntYaw(360,10);
       wait 11; 
       level notify("stop_drop"+drop);  
       level.dropped[drop].headIcon destroy();
       level.dropped[drop] delete();
       level notify("stop_drop_spawn");
   }
   else if(level.developer_mode == true) internal_print(drop + " has not been dropped, as it is currently spawned.", "host");
}
monitorDrop(drop)
{
    self endon( "stop_drop" + drop );
    for(;;)
    {
        if(isDefined(level.dropped[drop]))
        {//MonitorBotHealth(int)
            if(Distance( self.origin, level.dropped[drop].origin ) < 50)
            {
                level thread [[level.drop_action[drop]]](level.dropped[drop]);
                level.dropped[drop].fx delete();
                level.dropped[drop].headIcon destroy();
                level.dropped[drop] delete();
                self notify( "stop_drop" + drop);
            } 
        }
        wait .25;
    }
}

drop_icon(offset,shader, drop)
{
    self.entityHeadIconOffset = offset;
    headIcon                  = NewHudElem(self);
    headIcon.archived         = true;
    headIcon.x                = self.origin[0] + self.entityHeadIconOffset[0];
    headIcon.y                = self.origin[1] + self.entityHeadIconOffset[1];
    headIcon.z                = self.origin[2] + self.entityHeadIconOffset[2];
    headIcon.alpha            = 0.8;
    headIcon setShader(shader,10,10);
    headIcon setWaypoint(true,true);
    self thread maps\mp\_entityheadicons::keepIconPositioned();
    return headIcon;
}