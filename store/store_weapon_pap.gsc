spawnPapMachine(origin, angles)
{
    level.papMachine = spawn( "script_model", origin + (0,0,5) );
    level.papMachine setModel( "com_plasticcase_friendly" );
    level.papMachine thread SetEntHeadIcon((0,0, 40), level.shader_store["PAP"] , true);
    level.papMachine.angles = angles;


    level.papMachine2 = spawn( "script_model", origin + (0,0,5) );
    level.papMachine2 setModel( "com_plasticcase_friendly" );
    level.papMachine2.angles = angles;
}
papMonitor()
{
    for(;;)
    {
        wait 0.2;
        if(!isDefined(self.isPacked[self GetCurrentWeapon()])) self.isPacked[self GetCurrentWeapon()] = 0;
        if(isDefined(level.papMachine))
        {
            if(distance(self.origin, level.papMachine.origin ) <100)
            {
                
                self setLower("pap", "Press ^3[{+activate}] ^7for ^5Pack-A-Punch ^7(^2$^3"+(level.store_item_price_pap + (self.isPacked[self GetCurrentWeapon()] * 3))+"^7)",undefined,0);
                if(self usebuttonpressed() && self.isPacked[self GetCurrentWeapon()] != 225)
                {
                    self tryBuying(self GetCurrentWeapon(), "pap", (level.store_item_price_pap + (self.isPacked[self GetCurrentWeapon()] * 3)));//tryBuying(item,type,price,parent_entity)
                    wait 1;
                }
            }
            else if(distance(self.origin, level.papMachine.origin) > 100)
            {
                self clearLower("pap");
            }
        }
        wait .2;
    }
}
