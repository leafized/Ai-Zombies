
GetBestPlayerAndMoveTo( )
{
    
    self endon("bot_death");
    self scriptModelPlayAnim(getMoveAnimation()); //This sets the zombies animation based on the round they're on.
    for(;;)
    {
        foreach( player in level.players )
        {   
            if(!isAlive(player))
            continue;
            
            if(level.teamBased && self.team == player.pers[@"team"])
                continue;
  
            if( !bulletTracePassed( self getTagOrigin( "j_head" ), player getTagOrigin( "j_head" ), false, self ) )
                continue;
            if(player.sessionstate != "playing")
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
        wait .08;
    }
}

getMoveSpeed(target)
{
    if(level.Wave < 5) return ((distance(self.origin, target.origin) / (120 + (level.Wave * 5) ) ) );
    if(level.Wave >= 5 < 10 ) return ((distance(self.origin, target.origin) / (140 + (level.Wave * 2) ) ) );
    else return ((distance(self.origin, target.origin) / (160 + (level.Wave * 2) ) ) );
}

getMoveAnimation()
{
    if(level.Wave < 5) return level.walk_animation;///level.walk_animation = "pb_walk_forward_mg";
    if(level.Wave >= 5 ) return level.run_animation;//level.run_animation = "pb_run_fast";

}
getZombieHealth(ent = self)
{
    return ent.health;
}
zombie_isAlive(ent = self)
{
    if(ent.health > 0) return true;
    if(ent.health <= 0) return false;
    return false;
}
zombie_move_away(ent)
{
    foreach(zombie in level.zombies)
    {
        if(zombie getZombieHealth()<=0||!zombie zombie_isAlive())
        {
            continue;
        }
        _distance = distance(zombie.origin,self.origin);    
        if(_distance<=50)
        {
            pushOutDir = VectorNormalize((self.origin[0],self.origin[1],0)-(zombie.origin[0],zombie.origin[1],0));
            trace      = bulletTrace(self.origin+(0,0,20),(self.origin+(0,0,20))+(pushOutDir*((50-_distance)+10)),false,self);
            if(trace["fraction"]==1)
            {
                pushoutPos  = self.origin+(pushOutDir*(50-_distance));
                self.origin = (pushoutPos[0],pushoutPos[1],self.origin[2]); 
            }
        }
    }
}
_breadCrumb_tracker()
{
    
}

_breadCrumb_drop()
{
    
}