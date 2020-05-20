
GetBestPlayerAndMoveTo( )
{
    
    self endon("bot_death");
    self scriptModelPlayAnim(level.zombie_debug_anim); 
    for(;;)
    {
        TmpDist = undefined;
        pTarget = undefined;
        
        foreach( player in level.players )
        {   
            if(!isAlive(player))
            continue;
            if(level.teamBased && self.team == player.pers[@"team"])
                continue;
  
            if((!isdefined(TmpDist)) || distance(self.origin, player.origin) < TmpDist)
            {
                TmpDist = distance(self.origin, player.origin);
                pTarget = player;
            }
        }

        movetoLoc   = VectorToAngles( pTarget getTagOrigin(@"j_spine4") - self getTagOrigin(@"j_spine4" ) );
        self.angles = (0, movetoLoc[1], 0);
        self MoveTo(pTarget.origin, (distance(self.origin, pTarget.origin) / 200));
        //self MoveTo(pTarget.origin, (distancesquared(self.origin, pTarget.origin) / 40000));
        wait .01;
    }

}
