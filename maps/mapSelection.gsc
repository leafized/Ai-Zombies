loadMap(type)
{
    level.map_list     = ["mp_rust", "mp_underpass"];
    level.map_function = [::map_mp_rust, ::map_mp_underpass];
    currentMap         = getDvar("mapname");
    
    
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
                player setCustomMessage("test","This map is unsupported.");
                wait 10;
                player clearCustomMessage("test");
            }
        }
    }
}

loadUtilities()
{
     init_zm_developer_settings();
     thread init_drop_information();
}