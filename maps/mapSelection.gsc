loadMap(type)
{
    level.map_list     = ["mp_rust"];
    level.map_function = [::map_mp_rust];
    currentMap         = getDvar("mapname");
    
    
    for(i=0;i<level.map_list.size;i++)
    {
        if(level.map_list[i]==currentMap)
        {
            if(isDefined(level.map_function[i]))
            {
                level thread [[level.map_function[i]]]();
                return true;
            }
        }
        else
        {
            foreach(player in level.players)
            {
                player setCustomMessage("test","This map is unsupported.");
                wait 10;
                player clearCustomMessage("test");
            }
        }
    }
}