

spawnWeaponBox(origin, angles)
{
    level.packRB        = spawn( "script_model", origin + (0,0,5) );
    level.packRB.angles = angles;
    level.packRB setModel( "com_plasticcase_friendly" );
    
    level.packTop        = spawn( "script_model" , origin + (0,0,5) );
    level.packTop.angles = angles;
    level.packTop setModel( "com_plasticcase_friendly" );
    
    level.packRB.isBusy  = false;
    
    level.wep        = spawn("script_model",level.packRB.origin);
    level.wep.angles = angles  ;
    level.packRB thread SetEntHeadIcon((0,0,30),level.shader_store["BOX"],true);
    
    level thread boxChange();
}
boxChange()
{
    while(1)
    {


        if(level.stopSec == true)
        {
            wait 3;
            level.stopSec = false;
        }
        model = level.weaponList[RandomInt( level.weaponList.size)];
        level.wep setModel(GetWeaponModel(model));
        level.wepInfo = model;
        wait .2;
    }
}
MysteryBox()
{
    for(;;)
    {
        wait 0.2;
        if(isDefined(level.packRB))
        {
            if(distance(self.origin, level.packRB.origin) <80 && self.isBuying == false && level.packRB.isBusy == false)
            {
                
                self setLower("getGun", "Press ^3[{+activate}] ^7for ^5Mystery Box^7(^2$^3"+level.store_item_price_weapon+"^7)",undefined,0);
                if(self usebuttonpressed() && self.isBuying == false)
                {
                    self tryBuying( level.wepInfo , "weapon" , level.store_item_price_weapon , level.packRB );
                    wait 1;
                }
            }
            else if(distance(self.origin, level.packRB.origin) <80 && level.packRB.isBusy == true && self.name != level.packRB.user)
            {
                
                self setLower("getGun", "^1Sorry, this box is currently in use by! ^3"+level.packRB.user);
            }
            else if(distance(self.origin, level.packRB.origin) > 80)
            {
                self clearLower("getGun");
            }
        }
        wait .2;
    }
}
