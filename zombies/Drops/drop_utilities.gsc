
init_drop_information()
{
    level.drop_setting["frequency"] = 1;
    level.drop_setting["glow"] = 0;
    
    level.drop_list = ["Nuke", "Ammo","Sale", "InstaKill"];
    
    level.drop_model["Nuke"] = "mil_tntbomb_mp";
    level.drop_model["Ammo"] = "com_plasticcase_friendly";
    level.drop_model["Sale"] = "prop_suitcase_bomb";
    level.drop_model["InstaKill"] = "prop_suitcase_bomb";
    
    level.drop_action["Nuke"] = ::nukeZombies;
    level.drop_action["Ammo"] = ::maxAmmo;
    level.drop_action["Sale"] = ::fireSale;
    level.drop_action["InstaKill"] = ::instaKill;
    
    modelList = [];
    modelList = [level.drop_model["Nuke"],level.drop_model["Ammo"],level.drop_model["Sale"]];
    foreach(model in modelList) precacheModel(model);
    
    level.tornadoFX      = loadfx("smoke/smoke_trail_white_heli");
    level.tornadoFXBlack = loadfx("smoke/smoke_trail_black_heli");
    level._effect["Red_Light"] = LoadFX("misc/aircraft_light_wingtip_red");
    level._effect["Green_Light"] = LoadFX("misc/aircraft_light_wingtip_green");
    level._effect["flesh_hit_body_fatal_exit"] = LoadFX("impacts/flesh_hit_body_fatal_exit");
    level._effect["tank_fire_engine"] = LoadFX("fire/tank_fire_engine");
    level._effect["tanker_explosion"] = LoadFX("explosions/tanker_explosion");
    level._effect["grenadeexp_water"] = LoadFX("explosions/grenadeexp_water");
    level._effect["large_waterhit"] = LoadFX("impacts/large_waterhit");
    level._effect["flare_ambient"] = LoadFX("misc/flare_ambient");
    level._effect["oxygen_tank_explosion"] = LoadFX("explosions/oxygen_tank_explosion");
    level._effect["javelin_explosion"] = LoadFX("explosions/javelin_explosion");
    level._effect["grenadeexp_default"] = LoadFX("explosions/grenadeexp_default");
    level.trailFX = loadfx("fire/fire_smoke_trail_L");
    level._effect["footstep_water"] = LoadFX("impacts/footstep_water");
    
}

spawnDrop()
{
    drop = level.drop_list[RandomInt( level.drop_list.size )];
   if(!isDefined(level.dropped[drop]))
   {
       level endon("stop_drops");
       level.dropped[drop] = spawn("script_model", self.origin + (0,0,30));
       level.dropped[drop] setModel(level.drop_model[drop]);
       foreach(player in level.players) player thread monitorDrop(drop);
       level.dropped[drop] rotateEntYaw(360,15);
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
       
       level.dropped[drop] delete();
       level notify("stop_drops");
   }
}
monitorDrop(drop_to_watch)
{
    self endon("stop_drop"+drop_to_watch );
    for(;;)
    {
        if(Distance( self.origin, level.dropped[drop_to_watch].origin ) < 50)
        {level.dropped[drop].fx delete();
            level.dropped[drop_to_watch] delete();
            level thread [[level.drop_action[drop_to_watch]]](level.dropped[drop_to_watch]);
            self notify("stop_drop"+drop_to_watch);
        }
        wait .25;
    }
}

