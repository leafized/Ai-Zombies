ClampToGround()
{
    self endon("bot_death");
    self endon("crate_gone");

    while(1)
    {
            trace = bulletTrace(self.origin + (0,0,50), self.origin + (0,0,-40), false, self);
            if(isdefined(trace["entity"]) && isDefined(trace["entity"].targetname) && trace["entity"].targetname == "bot")
                trace = bulletTrace(self.origin + (0,0,50), self.origin + (0,0,-40), false, trace["entity"]);

            self.origin = (trace["position"]);
            self.currentsurface = trace["surfacetype"];
            if(self.currentsurface == "none")
                self.currentsurface = "default";
                

        wait .5;
    }
}

    /*
    addZombieAnimation("default","idle","pb_stand_alert");
    addZombieAnimation("default","walk","pb_walk_forward_shield");
    addZombieAnimation("default","walk","pb_combatwalk_forward_loop_pistol");
    addZombieAnimation("default","walk","pb_walk_forward_mg");
    addZombieAnimation("default","walk","pb_walk_forward_akimbo");
    addZombieAnimation("default","run","pb_run_fast");
    addZombieAnimation("default","run","pb_pistol_run_fast");
    addZombieAnimation("default","sprint","pb_sprint_akimbo");
    addZombieAnimation("default","sprint","pb_sprint_pistol");
    addZombieAnimation("default","death","pb_stand_death_leg_kickup");
    addZombieAnimation("default","death","pb_stand_death_shoulderback");
    addZombieAnimation("default","death","pb_death_run_stumble");
    addZombieAnimation("default","melee","pt_melee_pistol_1",0.5);
    addZombieAnimation("default","melee","pt_melee_pistol_2",1);
    addZombieAnimation("default","melee","pt_melee_pistol_3",0.6);
    addZombieAnimation("default","melee","pt_melee_pistol_4",0.5);
    */