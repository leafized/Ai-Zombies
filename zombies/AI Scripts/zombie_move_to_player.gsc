
GetBestPlayerAndMoveTo( )
{
    
    self endon("bot_death");
    self scriptModelPlayAnim(getMoveAnimation()); 
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
        self MoveTo(pTarget.origin, getMoveSpeed(pTarget));
        //self MoveTo(pTarget.origin, (distancesquared(self.origin, pTarget.origin) / 40000));
        wait .01;
    }

}
/*
GetBestPlayerAndMoveTo( )
{
self endon("bot_death");

    for(;;)
    {
        TmpDist = 999999999;
        pTarget = undefined;

        foreach( player in level.players )
        {   
            if(!isAlive(player))
                continue;
                
            if(level.teamBased && self.team == player.pers["team"])
                continue;
                
            if( !bulletTracePassed( self getTagOrigin( "j_head" ), player getTagOrigin( "j_head" ), false, self ) ) 
            continue;
            
            if(player.sessionstate != "playing")
                continue;
                
            if(distance(self.origin, player.origin) < TmpDist)
            {
                TmpDist = distance(self.origin, player.origin);
                pTarget = player;
            }
        }

        movetoLoc = VectorToAngles( pTarget getTagOrigin("j_head") - self getTagOrigin( "j_head" ) );
        self.angles = (0, movetoLoc[1], 0);
        
        self MoveTo(pTarget.origin, getMoveSpeed(pTarget));
        //self MoveTo(pTarget.origin, (distancesquared(self.origin, pTarget.origin) / 40000));
        
    wait 0.08;
    }

}
*/
getMoveSpeed(target)
{
    if(level.Wave < 5) return 7;
    if(level.Wave >= 5 < 10 ) return 4;
    if(level.Wave >= 10 < 15 ) return 3;
    else return 4;
    //(distance(self.origin, target.origin) / 200)
}

getMoveAnimation()
{
    if(level.Wave < 5) return "pb_run_fast";
    if(level.Wave >= 5 ) return "pb_run_fast";
}
