MonitorBotHealth()
{
    pTemp = "";
    
    for(;;)
    {

        self.crate1 waittill("damage", damage, attacker, direction, point, type, tagName,i1,i2,i3,sWeapon);
        attacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback(tagName);
       
        if(level.instaKillActive == true) self.crate1.health -= damage +level.damage_scaler;
        else self.crate1.health -= damage;
        
        self.crate1.health -= is_packed( attacker );
        attacker.score+= level.zombie_hit_points;
        attacker.pers["score"]+= level.zombie_hit_points;
        
        attacker thread kill_popUp( level.zombie_hit_points, 0,(1,1,0.2), 0 );
        if( (self.crate1.health <= 0) && (self.name != pTemp) )
        {   
            
            self notify("zombie_stop");
            attacker thread kill_popUp( level.zombie_kill_points, 0,(1,1,0.2), 0 );
            self notify("bot_death");
            self.crate1 notify("bot_death");
            self thread killEnt(self.head, 2);
            self thread killEnt(self, 2);
            attacker playLocalSound( level.deathSounds[RandomInt( 15 )], self.origin );
            self.crate1 thread killEnt(self.crate1, 2);
            if(RandomInt( 40 ) == 1)
            self thread spawnDrop();
            attacker thread kill_popUp( level.zombie_hit_points, 0, (1,1,0.2), 0 );
            attacker.kills++;
            attacker.pers["kills"] = attacker.kills;
            attacker.score += level.zombie_kill_points;
            attacker.pers["score"] = attacker.score;
            pTemp = self.name;
            return;
        }
        


    wait 0.05;
    }
}
is_packed(client)
{
    if(isDefined(client.isPacked[client getcurrentWeapon()]))
    {
        return client.isPacked[client getcurrentWeapon()];
    }
    return 0;
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