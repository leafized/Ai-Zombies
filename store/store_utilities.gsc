SetEntHeadIcon(offset,shader,keepPosition)
{
    if(isDefined(offset)) 
    {
        self.entityHeadIconOffset = offset;
    }
    else
    {
        self.entityHeadIconOffset = (0,0,0);
    }
    headIcon          = NewHudElem(player);
    headIcon.archived = true;
    headIcon.x        = self.origin[0] + self.entityHeadIconOffset[0];
    headIcon.y        = self.origin[1] + self.entityHeadIconOffset[1];
    headIcon.z        = self.origin[2] + self.entityHeadIconOffset[2];
    headIcon.alpha    = 0.8;
    headIcon setShader(shader,10,10);
    headIcon setWaypoint(true,true);
    self.entityHeadIcon = headIcon;
    if(isdefined(keepPosition)&&keepPosition==true)
    {
        self thread maps\mp\_entityheadicons::keepIconPositioned();
    }
}

tryBuying( item, type, price)
{
    itemN = item;
    if(self.score > price)
    {
        self setCustomMessage("tst", "^2ENJOY YOUR PURCHASE" );
        self.score -= price;
        if(type == "weapon")
        {
            level.packRB.user = self.name;
            self.isBuying     = true;
            self clearLowerMessage("getGun");
            level.packRB.isBusy = true;
            level.wep MoveTo( level.packRB.origin + (0,0,30), 2 );
            wait 2;
            level.stopSec = true;
            itemN         = level.wepInfo;
            wait 3;
    //Max weapons check
            list = self getWeaponsListPrimaries();
            if(list.size>1)
            {
                self takeWeapon(self getCurrentWeapon());
            }
            
            //Give Weapon
            self giveWeapon(itemN);
            self giveMaxAmmo(itemN);
            self SwitchToWeapon(itemN);
            level.stopSec = false;
            level.wep MoveTo(level.packRB.origin - (0,0,40), 3);
            self.isBuying         = false;
            wait 3;
            level.packRB.isBusy = false;
            level.packRB.user   = undefined;
        }
            
        if(type == "ammo")
        {
            self giveMaxAmmo(item);
        }
        
        if(type == "armor")
        {
            if(self.hasShield == false)
            {
                self.maxhealth = 150;
                self.health    = 150;
                self.hasShield = true;
                self thread monitorArmor();
            }
            if(self.hasShield == true)
            {
                self IPrintLnbold( "You already own this item." );
            }
        }
        
        if(type == "perk")
        {
            if(self.hasItem[item])
            {
                self IPrintLnBold( "^1YOU ALREADY OWN THIS ITEM" );
            }
            self setPerk(item);
            setPerkEdit(item);
        }
        
        self clearCustomMessage("tst");
    }
    else self IPrintLnbold( "^1You don't have enough money!" );
}