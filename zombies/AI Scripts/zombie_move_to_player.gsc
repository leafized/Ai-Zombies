
GetBestPlayerAndMoveTo( )
{
    
    self endon("bot_death");
    self scriptModelPlayAnim(getMoveAnimation()); //This sets the zombies animation based on the round they're on.
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
        //self MoveTo(pTarget.origin, (distancesquared(self.origin, pTarget.origin) / 200));
        
    wait 0.08;
    }

}
*/
getMoveSpeed(target)
{
    if(level.Wave < 5) return 4;
    if(level.Wave >= 5 < 10 ) return 3;
    else return 2;
    //(distance(self.origin, target.origin) / 200)
}

getMoveAnimation()//MoveTo( <point>, <time>, <acceleration time>, <deceleration time> )
{
    if(level.Wave < 5) return level.walk_animation;///level.walk_animation = "pb_walk_forward_mg";
    if(level.Wave >= 5 ) return level.run_animation;//level.run_animation = "pb_run_fast";
}
