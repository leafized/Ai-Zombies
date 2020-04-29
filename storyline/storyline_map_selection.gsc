storySetup()
{

    level.mapList = ["mp_boneyard","mp_rust","mp_derail","mp_highrise","mp_estate"];
    level.mapFunc = [::map_boneyard,::map_rust,::map_outpost, ::map_highrise, ::map_estate];
    currentMap    = getDvar("mapname");
    for(i=0;i<level.mapList.size;i++)
    {
        if(level.mapList[i]==currentMap)
        {
            if(isDefined(level.mapFunc[i]))
            {
                level thread [[level.mapFunc[i]]]();
            }
        }
    }
    return false;
}