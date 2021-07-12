onplayerdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime )
{
    if(IsPlayer( eattacker ))
    einflictor.health = 100;
}
SetEntHeadIcon(offset,shader,keepPosition )
{
    if(isDefined(offset)) 
    {
        self.entityHeadIconOffset = offset;
    }
    else
    {
        self.entityHeadIconOffset = (0,0,0);
    }
    headIcon          = NewHudElem();//NewHudElem()
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
    self.hasItem = [];
    itemN        = item;
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
                        if(self GetCurrentWeapon() == self.primaryWeapon ){
                            self takeWeapon(self getCurrentWeapon());
                            self.primaryWeapon = undefined;
                            //self SwitchToWeapon( self.secondaryWeapon );
                        }
                        if(self GetCurrentWeapon() == self.secondaryWeapon ){
                            self TakeWeapon( self GetCurrentWeapon() );
                            self.secondaryWeapon = undefined;
                            //self SwitchToWeapon( self.secondaryWeapon );
                        }
                    }
                    
                    //Give Weapon
                    self giveWeapon(itemN);
                    if(!(isDefined(self.secondaryWeapon))) self.secondaryWeapon = itemN;
                    else if(!(isDefined(self.primaryWeapon))) self.primaryWeapon = itemN;
                    
                    self iprintln(self.primaryWeapon);
                    self IPrintLn( self.secondaryWeapon );
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
        
        if(type == "pap")
        {
            tOrigin = self getTagOrigin("j_spine4");
                self clearLower("pap");
                if(!isDefined(self.isPacked[item])) self.isPacked[item] = 25;
                else self.isPacked[item] += 25;
                level.papMachine.inUse = true;
                level.papMachine2 moveTo(level.papMachine.origin + ( 0, 0, 80 ), 2 );
                wait 2;
                self takeWeapon(item);
                level.papWeapon[item] = spawn("script_model", tOrigin );
                level.papWeapon[item].angles = level.papMachine.angles;
                level.papWeapon[item] setModel(getWeaponModel(item));
                level.papWeapon[item] moveto(level.papMachine.origin + (0,0,43), 2);
                wait 5;
                level.papWeapon[item] moveTo(tOrigin  , 1);
                for(i=0;i<10;i++)
                {
                    if(distance(self.origin, level.papWeapon.origin) < 120 ) self setLower("getPAP", "Press " +getUseButtonString() + "to get PaP Weapon!");
                    else self clearLower("getPAP" );  
                    if(self UseButtonPressed() && distance(self.origin, level.papWeapon.origin) < 120)
                    {
                        level.papMachine.inUse = false;
                        self giveweapon( item , papCamoValue(item) );//GiveWeapon( <weapon name>, <camo value> )
                        self iprintln(item + " ^2Given Back");
                        killEnt(level.papWeapon[item], 0) delete();//KillEnt(ent,time)
                        self SwitchToWeapon( item );
                        self clearLower("getPAP");
                        i = 11;
                    }
                    if(i == 10 && level.papMachine.inUse == true)
                    {
                        killEnt(level.papWeapon[item], 0) delete();//KillEnt(ent,time)
                        self iprintlnBold("^1You waited to long to get your weapon!");
                        self clearLower("getPAP");
                    }
                    
                    wait 1;
                }
                level.papMachine2 moveto(level.papMachine.origin, 1);
                level.papMachine.inUse = false;
                wait 1;//MoveTo( <point>, <time>, <acceleration time>, <deceleration time> )//Spawn( <classname>, <origin>, <flags>, <radius>, <height> )

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
            if(self.hasItem[item] != true)
            {
                self setPerk(item);
                setPerkEdit(item);
                self.hasItem[item] = true;
                return;
            }
            else if(self.hasItem[item] == true)
            {
                self IPrintLnBold("You already own this item." );
                return;
            }
            error_localLog("^1ERROR:^7 tryBuying type = perk","self.hasItem was NOT defined. This caused an interal error.");
            wait .1;
        }
    }
    else{ self IPrintLnBold("Come back when you have ^2" + price ); }
}


papCamoValue(item)
{
    value = self.isPacked[item];
    if(value == 25 ) return 1;
    if(value == 50 ) return 2;
    if(value == 75 ) return 3;
    if(value == 100 ) return 4;
    if(value == 125 ) return 5;
    if(value == 150 ) return 6;
    if(value == 175 ) return 7;
    if(value == 200 ) return 8;
    if(value == 225 ) return 9;
}