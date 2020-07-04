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
                player.health -= level.zombie_base_dmg_modifier + level.round_dmg_modifier;

                if(player.health <= 0)
                {
                    player thread maps\mp\gametypes\_damage::finishPlayerDamageWrapper( self, self, 999999, 0, "MOD_MELEE", "none", player.origin, player.origin, "none", 0, 0 );
                    self.kills++;
                }
                wait .3;
            }
        }

    wait 0.07;
    }

}
