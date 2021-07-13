loadMap(type)
{
    level.map_list     = ["mp_nightshift", "mp_subbase","mp_rust", "mp_underpass", "mp_terminal", "mp_highrise"];
    level.map_function = [::map_mp_nightshift, ::map_mp_subbase, ::map_mp_rust, ::map_mp_underpass, ::map_mp_terminal, ::map_mp_highrise];
    currentMap         = getDvar("mapname");
    
    DeathBarriers = GetEntArray("trigger_hurt", "classname");
    foreach(Barrier in DeathBarriers)
    {
        Barrier.savedOrigin = Barrier.origin;
        Barrier.origin      = (0,0,9999999);
    }
        
    for(i=0;i<level.map_list.size;i++)
    {
        if(level.map_list[i]==currentMap)
        {
            if(isDefined(level.map_function[i]))
            {
                level thread [[level.map_function[i]]]();
                level.init_zombies_mode = true;
                return true;
            }
        }
        else
        {
            level.init_zombies_mode = false;
            foreach(player in level.players)
            {
                player setLower("test","This map is unsupported.");
                wait 10;
                player clearLower("test");
            }
        }
    }
}

loadUtilities()
{
    setDvar("scr_tdm_timelimit", 999999);
     init_zm_developer_settings();
     thread init_drop_information();
 }//addLower(name,text,font,size)