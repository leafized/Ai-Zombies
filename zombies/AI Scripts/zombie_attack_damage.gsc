MonitorAttackPlayers( )
{
self endon("bot_death");
self endon("destroy_self");

    for(;;)
    {
        foreach( player in level.players )
        {
            if(distance(player.origin, self.origin) <= 50)
            {
                earthquake(0.4,1, self.origin + (0,0,40), 50);//Earthquake( <scale>, <duration>, <source>, <radius> )
                player.health--;

                if(player.health <= 0)
                {
                    player thread maps\mp\gametypes\_damage::finishPlayerDamageWrapper( self, self, 999999, 0, "MOD_MELEE", "none", player.origin, player.origin, "none", 0, 0 );
                    self.kills++;
                }
            }
        }

    wait 0.07;
    }

}

KillIfUnderMap( )
{
self endon("bot_death");

    for(;;)
    {
        if((self.origin[2] < 2000) && (getDvar("mapname") == "mp_highrise"))
        {

            self KillEnt(self, 0);
            self notify("bot_death");
            
        break;
        }
        
    wait 0.05;
    }
}