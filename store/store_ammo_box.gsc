spawnAmmoBox(origin, angles)
{
    level.ammoBox       = spawn( "script_model", origin + (0,0,5) );
    level.ammoBox.angles = angles;
    level.ammoBox setModel( "com_plasticcase_friendly" );
    level.ammoBox thread SetEntHeadIcon((0,0,45),level.shader_store["AMMO"],true);
}
AmmoBoxMonitor()
{
    for(;;)
    {
        wait 0.2;
        if(isDefined(level.ammoBox))
        {
            if(distance(self.origin, level.ammoBox.origin) <100)
            {
                
                self setLowerMessage("getAmmo", "Press ^3[{+activate}] ^7for ^5Ammo Refill ^7(^2$^3"+level.store_item_price_ammo+"^7)",undefined,0);
                if(self usebuttonpressed())
                {
                    self tryBuying(self GetCurrentWeapon(), "ammo", level.store_item_price_ammo);
                    wait 1;
                }
            }
            else if(distance(self.origin, level.ammoBox.origin) > 100)
            {
                self clearLowerMessage("getAmmo");
            }
        }
        wait .2;
    }
}
