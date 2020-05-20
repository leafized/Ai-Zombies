map_rust()
{
    level waittill("pregame_over");
    
    game["strings"]["MP_STORY_INTRO"] = "We need to get the power on..";
    game["strings"]["MP_STORY_PART_1"] = "Where is the fucking power?";
    game["strings"]["MP_STORY_PART_2"] = "Left To Spawn:";
    game["strings"]["MP_STORY_PART_3"] = "Zombies:";
    game["strings"]["MP_STORY_PART_4"] = "Health:\nMoney:";
    //Not really needed, it has the icon for nightvision in the game and it shows it.
    /*
    game["strings"]["MP_NV"]["1"] = "[ ^3[{+actionslot 1}]^7 ]";
    game["strings"]["MP_NV"]["2"] = "[ ^3Nightvision^7 ]";
    */
    precacheString(game["strings"]["MP_STORY_INTRO"]);
    precacheString(game["strings"]["MP_STORY_PART_1"]);
    precacheString(game["strings"]["MP_STORY_PART_2"]);
    precacheString(game["strings"]["MP_STORY_PART_3"]);
    precacheString(game["strings"]["MP_STORY_PART_4"]);
    
    addBuildPart("teleporter",0,"com_plasticcase_friendly","Teleporter Base");
    wait 5;Announcement( game["strings"]["MP_STORY_INTRO"] );
    part_monitor();
}



addBuildPart(end_object , part_number , model , name , lower_message )
{
    level.story_buildPart[end_object] = SpawnStruct();
    level.story_buildPart[end_object][part_number] = spawn( "script_model", level.spawnpoints[(RandomInt( level.spawnpoints.size ))] + (0,0,5) );
    PreCacheModel( model );
    level.story_buildPart[end_object][part_number] SetModel( model );
    level.story_buildPart[end_object][part_number].lowerMessage = lower_message;
    level.story_buildPart[end_object][part_number].name = name;
}


spawnPart(origin)
{
    Spawn( "script_model", origin + (0,0,5) );
}


part_monitor()
{
    if(isConsole())
    button = "[{+usereload}]";
    else
    button = "[{+activate}]";
    
    level endon("game_ended");
    for(;;)
    {
        partList = level.story_buildPart["teleporter"];
        if(isDefined(level.story_buildPart["teleporter"]))
        {
            
            foreach(piece in partList.size)
            {
                
                foreach(player in level.players)
                {
                    
                    if(Distance( player, piece.origin ) < 120)
                    {
                        player setLowerMessage(piece.name+"_part", "Press ^3" + button + "^7 to pickup ^2" + piece.name,undefined,0);
                    }
                    if(Distance(player, piece.origin) > 120)
                    {
                        player clearLowerMessage(piece.name+"_part");
                    }
                    
                }
            
            }
        
        }
        wait .05;
    }
}