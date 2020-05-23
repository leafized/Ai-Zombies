spawnPerkBox(origin,angles, index, perk, name)
{
    level.perkBox[index]       = spawn( "script_model", origin + (0,0,5) );
    level.perkBox[index].angles = angles;
    level.perkBox[index] setModel( "com_plasticcase_friendly" );
    level.perkBox[index] thread SetEntHeadIcon((0,0,45),level.shader_store[name],true);//SetEntHeadIcon(offset,shader,keepPosition)
    level.perkBox[index].itemName = perk;
    level.perkBox[index].price = level.store_item_price_perk[name];
    level.perkBox[index].name = name;

}
perkMonitor()
{
    for(;;)
    {
        foreach(perk in level.perkBox)
        {
            wait 0.2;
            if(distance(self.origin, perk.origin) <100)
            {
                
                self setLowerMessage(perk.itemName +"getPerk", "Press ^3[{+activate}] ^7for ^5"+perk.name+" ^7(^2$^3"+perk.price+"^7)",undefined,0);
                if(self usebuttonpressed())
                {
                    self tryBuying(perk.itemName, "perk", perk.price);
                    wait 1;
                }
            }
            else if(distance(self.origin, perk.origin) > 100)
            {
                self clearLowerMessage(perk.itemName +"getPerk");
            }
        }
        wait .2;
    }
}
setPerkEdit(perk)
{
    if(perk == "specialty_fastreload")
    {
        setDvar("perk_weapRateMultiplier", ".25");
        setDvar("perk_weapReloadMultiplier", ".25");
        setDvar("perk_fireproof", ".25");
        setDvar("cg_weaponSimulateFireAnims", ".25");
    }
}