spawnArmourBox(origin, angles)
{
    level.armorBox       = spawn( "script_model", origin + (0,0,5) );
    level.armorBox.angles = angles;
    level.armorBox setModel( "com_plasticcase_friendly" );
    level.armorBox thread SetEntHeadIcon((0,0,45),level.shader_store["ARMOR"],true);
}
ArmourBoxMonitor()
{
    for(;;)
    {
        wait 0.2;
        if(isDefined(level.armorBox))
        {
            if(distance(self.origin, level.armorBox.origin) <100)
            {
                
                self setLowerMessage("getArmor", "Press ^3[{+activate}] ^7for ^5Armor ^7(^2$^3"+level.store_item_price_armor+"^7)",undefined,0);
                if(self usebuttonpressed())
                {
                    self tryBuying(self.health, "armor", level.store_item_price_armor);
                    wait 1;
                }
            }
            else if(distance(self.origin, level.armorBox.origin) > 100)
            {
                self clearLowerMessage("getArmor");
            }
        }
        wait .2;
    }
}//doTest()
monitorArmor()
{
    self endon("armor_gone");
    for(;;)
    {
        if(self.health < 150 && self.health > 99)
        {
            self.maxhealth = self.health;
            if(self.maxhealth <= 100)
            {
                self.maxhealth = 100;
                self.health    = self.maxhealth;
                self.hasShield = false;
                self notify("armor_gone");
            }
        }
        wait .15;
    }
}