MonitorBotHealth(int )
{
pTemp = "";
    
    for(;;)
    {

        self.crate1 waittill("damage", damage, attacker, direction, point, type, tagName,i1,i2,i3,sWeapon);
        
        attacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback(tagName);
        if(isDefined(attacker.isUpgrade[attacker GetCurrentWeapon()]) || level.instaKillActive == true)
        self.crate1.health -= damage + level.damage_scaler;
        else
        self.crate1.health -= damage;
       
        attacker.score+= level.zombie_hit_points;
        attacker.pers["score"]+= level.zombie_hit_points;
        
        attacker thread kill_popUp( level.zombie_hit_points, 0,(1,1,0.2), 0 );
        if( (self.crate1.health <= 0) && (self.name != pTemp) )
        {   
            attacker thread kill_popUp( level.zombie_kill_points, 0,(1,1,0.2), 0 );
            self notify("bot_death");
            self.crate1 notify("bot_death");
            self thread killEnt(self.head, 2);
            self thread killEnt(self, 2);
            self PlaySoundAtPos( level.deathSounds[RandomInt( 15 )], self.origin );
            self.crate1 thread killEnt(self.crate1, 2);
            if(int == 1)
            self thread spawnDrop();
            
            attacker thread kill_popUp( level.zombie_hit_points, 0, (1,1,0.2), 0 );
            attacker.kills++;
            attacker.pers["kills"] = attacker.kills;
            attacker.score += level.zombie_kill_points;
            attacker.cash += level.zombie_kill_points;
            attacker.pers["score"] = attacker.score;
            pTemp = self.name;
            break;
        }
        
        //attacker PlayLocalSound( maps\mp\gametypes\_teams::getTeamVoicePrefix( attacker.team ) + "ac130_fco_thatsahit" );

    wait 0.05;
    }
}

monitorOrigin( entity )
{
    self endon("crate_gone");
    for(;;)
    {
        entity.origin = self.origin;
        wait 0.05;
    }

}