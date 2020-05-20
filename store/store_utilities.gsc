SetEntHeadIcon(offset,shader,keepPosition, is_drop, drop)
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
getUseButtonString()
{//isConsole()
    if(isConsole()) return "[{+usereload}]";
    return "^3[{+activate}]^7";
    return "^1This wasn't suppsed to occur.";
}
tryBuying( item, type, price, parent_entity)
{
    itemN = item;
    if(self.score > price)
    {
        self.score -= price;
        if(type == "weapon")
        {
            level.packRB.user = self.name;
            self.isBuying     = true;
            self clearLowerMessage("getGun");
            level.packRB.isBusy = true;
            level.packTop MoveTo( level.packTop.origin + (0,0, 80), 2 );
            level.wep MoveTo( level.packRB.origin + (0,0,40), 2 );
            wait 2;
            level.stopSec = true;
            itemN         = level.wepInfo;//getWeaponNAme
            itemName      = getWeaponName(level.wepInfo);//getWeaponNAme
            
            for(i=0;i<100;i++)
            {
                if(distance( parent_entity.origin , self.origin) < 130)
                {
                    self setLower("m", "Hold " + getUseButtonString() +" to take your weapon!" );
                }
                else self clearLower("m");
                wait .1;
                if(self UseButtonPressed() && distance( parent_entity.origin , self.origin) < 130)
                {
                    self clearLower("m", .2);
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
                    level.packTop MoveTo(level.packTop.origin - ( 0, 0, 80 ), 2);
                    self.isBuying       = false;
                    level.packRB.isBusy = false;
                    level.packRB.user   = undefined;
                    i                   = 0;
                    break;
                }
            }
            self clearLower("m", .2);
            level.wep MoveTo(level.packRB.origin - (0,0,40), 3);
            level.packTop MoveTo(level.packTop - ( 0, 0, 80 ), 2);
            
            level.stopSec       = false;
            self.isBuying       = false;
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
                self setLower("own", "You already own this item." );
                wait 1;
                self clearLower("own");
            }
        }
        
        if(type == "perk")
        {
            if(self.hasItem[item])
            {
                self setLower("nah", "^1YOU ALREADY OWN THIS ITEM" );
                wait .1; self clearLower("nah", .2);
            }
            self setPerk(item);
            setPerkEdit(item);
            wait .1;
        }
    }
    else{ self setLower( "nah", "Come back when you have ^2" + price ); wait 2; self clearLower( "nah" ); }
}