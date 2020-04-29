ZombieMarkers()
{

for(;;)
{
    if(ZombieCount() <= level.BotsForIcons && level.RealSpawnedBots > level.BotsForIcons)
        for(i = 0; i < level.BotsForWave; i++)
        {
            if((isDefined(level.zombies[i])) && (isDefined(level.zombies[i].crate1.health)) && (level.zombies[i].crate1.health > 0) && (!level.zombies[i].hasMarker))
            {
                if ( isdefined( self.lastDeathIcon ) )
                    level.zombies[i].lastDeathIcon destroy();
    
                newdeathicon = newHudElem();
                newdeathicon.x = level.zombies[i].origin[0];
                newdeathicon.y = level.zombies[i].origin[1];
                newdeathicon.z = level.zombies[i].origin[2] + 54;
                newdeathicon.alpha = .61;
                newdeathicon.archived = true;
                newdeathicon setShader("headicon_dead", 5, 5);
                newdeathicon setwaypoint( true, false );
    
                level.zombies[i].lastDeathIcon = newdeathicon;
                level.zombies[i].hasMarker = true;
                level.zombies[i] thread MoveIcon(level.zombies[i].lastDeathIcon);
                level.zombies[i] thread BotDestroyOnDeath(level.zombies[i].lastDeathIcon);
            }
        }
        
    else if(ZombieCount() > level.BotsForIcons)
        for(i = 0; i < level.BotsForWave; i++)
        {
            if((isDefined(level.zombies[i])) && (isDefined(level.zombies[i].crate1.health)) && (level.zombies[i].crate1.health > 0) && (level.zombies[i].hasMarker))
            {
                if ( isdefined( self.lastDeathIcon ) )
                    level.zombies[i].lastDeathIcon destroy();

                level.zombies[i].hasMarker = false;
                level.zombies[i] notify("noicon");
            }
        }

    wait 0.1;
    }

}

MoveIcon(icon)
{
self endon("bot_death");
self endon("noicon");

for(;;)
{
    icon.x = self.origin[0];
    icon.y = self.origin[1];
    icon.z = self.origin[2] + 54;

wait 0.05;
}

}