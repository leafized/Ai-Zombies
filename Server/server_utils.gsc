

kill_popUp( amount, bonus, hudColor, glowAlpha )
{
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );

    if ( amount == 0 )
        return;

    self notify( "scorePopup" );
    self endon( "scorePopup" );

    self.xpUpdateTotal += amount;
    self.bonusUpdateTotal += bonus;

    wait ( 0.05 );

    if ( self.xpUpdateTotal < 0 )
        self.hud_scorePopup.label = &"";
    else
        self.hud_scorePopup.label = &"MP_PLUS";

    self.hud_scorePopup.color     = hudColor;
    self.hud_scorePopup.glowColor = hudColor;
    self.hud_scorePopup.glowAlpha = glowAlpha;
    self.hud_scorePopup setValue(self.xpUpdateTotal);
    self.hud_scorePopup.x     = -220;
    self.hud_scorePopup.y     = -210;
    self.hud_scorePopup.alpha = 0.85;
    //self.hud_scorePopup thread maps\mp\gametypes\_hud::fontPulse( self );

    increment = max( int( self.bonusUpdateTotal / 20 ), 1 );
        
    if ( self.bonusUpdateTotal )
    {
        while ( self.bonusUpdateTotal > 0 )
        {
            self.xpUpdateTotal += min( self.bonusUpdateTotal, increment );
            self.bonusUpdateTotal -= min( self.bonusUpdateTotal, increment );
            
            self.hud_scorePopup setValue( self.xpUpdateTotal );
            
            wait ( 0.05 );
        }
    }   
    else
    {
        wait ( 1.0 );
    }

    self.hud_scorePopup fadeOverTime( 0.75 );
    self.hud_scorePopup.alpha = 0;
    
    self.xpUpdateTotal = 0;     
}




addLower( name, text, font, size )
{
    newMessage = undefined;
    foreach ( message in self.lowerMessages )
    {
        if ( message.name == name )
        {
            if ( message.text == text && message.priority == priority )
                return;

            newMessage = message;
            break;
        }
    }

    if ( !isDefined( newMessage ) )
    {
        newMessage = spawnStruct();
        self.lowerMessages[ self.lowerMessages.size ] = newMessage;
    }

    newMessage.name      = name;
    newMessage.text      = text;
    newMessage.time      = time;
    newMessage.fontScale = size;
    newMessage.font      = font;
    newMessage.priority  = 1;
}


removeLower( name )
{
    for ( i = 0; i < self.lowerMessages.size; i++ )
    {
        if ( self.lowerMessages[ i ].name != name )
            continue;

        message = self.lowerMessages[ i ];
        if ( i < self.lowerMessages.size - 1 )
            self.lowerMessages[ i ] = self.lowerMessages[ self.lowerMessages.size - 1 ];

        self.lowerMessages[ self.lowerMessages.size - 1 ] = undefined;
    }
}


getLower()
{
    return self.lowerMessages[ 0 ];
}


setLower( name, text, font , fontScale)
{
    self addLower( name, text, font, fontScale);
    self updateLower();
    //self notify( "lower_message_set" );
}


updateLower()
{
    message = self getLower();

    if ( !isDefined( message ) )
    {
        self.lowerMessage.alpha = 0;
        self.lowerTimer.alpha = 0;
        return;
    }

    self.lowerMessage setText( message.text );
    if ( isDefined( message.time ) && message.time > 0 )
        self.lowerTimer setTimer( max( message.time - ( ( getTime() - message.addTime ) / 1000 ), 0.1 ) );
    else
        self.lowerTimer setText( "" );
    
    self.lowerMessage.alpha = 0.85;
    self.lowerTimer.alpha   = 1;
}

clearLower( name, fadetime )
{
    self removeLower( name );
    self updateLower();
}




setCustomMessage(id, string)
{
    if(!isDefined(self.Hud.LowerMessage))
    { 
        //self.Hud.LowerMessage    = createText("hudbig",1.4,"BOTTOM","BOTTOMCENTER",0,0,0,(1,1,1),.8,0,0,string); 
        self.Hud.LowerMessage = createText("hudbig",1,"BOTTOM","BOTTOMCENTER",0,0,0,.8,string,(1,1,1));
        self.Hud.LMid         = id;
        self thread RedFadeToBlue(self.Hud.LowerMessage);
    }
    else if(isDefined(self.Hud.LowerMessage)) 
    {
        self.Hud.LMid = id;
        self.Hud.LowerMessage setText(string);
    }
}
clearCustomMessage(id)
{
    if(self.Hud.LMid == id)
    self.Hud.LowerMessage destroy();
}

RedFadeToBlue(id)
{
    if(isDefined(self.bannerFade))
        return;
    
    self endon("disconnect");
    
    self.bannerFade = true;
    id.color        = (1,.25,0);
    currColor       = "red";
    wait .05;
    
    while(1)
    {
        id FadeOverTime(.05);
        if(currColor == "red")
        {
            if(id.color[2] < 1)
                id.color = (id.color[0]-.01,id.color[1],id.color[2]+.01);
            else
                currColor = "blue";
        }
        else if(currColor == "blue")
        {
            if(id.color[0] < 1)
                id.color = (id.color[0]+.01,id.color[1],id.color[2]-.01);
            else
                currColor = "red";
        }
        
            wait .05;
    }
}

init_menu_weapons()
{
    //Create List with all base weapon ids
    level.table_weaponList = [];
    for(i=0;i<=149;i++)
    {
        weaponId    = tableLookup("mp/statsTable.csv",0,i,4);
        weaponClass = tableLookup("mp/statsTable.csv",0,i,2);
        
        //if weaponId exists + is in a weapon class
        if((weaponId!="") && isSubStr(weaponClass,"weapon_"))
        {
            addMenuWeapon(weaponId);
            precacheShader(getWeaponShader(weaponId));
        }
    }
    
    //Create Attachment List
    level.table_attachmentList = [];
    for(i=1;i<=17;i++)
    {
        attachmentId = tableLookup("mp/attachmentTable.csv",0,i,4);
        addMenuAttachment(attachmentId);
        precacheShader(getAttachmentShader(attachmentId));
    }
    
    //Create Camo List
    level.table_camoList = [];
    for(i=0;i<=8;i++)
    {
        camoId = tableLookup("mp/camoTable.csv",0,i,1);
        addMenuCamo(camoId);
        precacheShader(getCamoShader(camoId));
    }
}

//TableLookUp Stuff
getRankString(rank_num)
{
    return tableLookupIString("mp/rankTable.csv",0,rank_num,5);
}
getRankShader(rank_num)
{
    return tableLookup("mp/rankTable.csv",0,rank_num,6);
}
getPrestigeShader(pres_num)
{
    return tableLookup("mp/rankIconTable.csv",0,0,1+pres_num);
}
getWeaponShader(base_weapon)
{
    tableRow  = tableLookup("mp/statstable.csv",4,base_weapon,0);
    weaponPic = tableLookup("mp/statsTable.csv",0,tableRow,6);
    return weaponPic;
}
getWeaponNameString(base_weapon)
{
    tableRow         = tableLookup("mp/statstable.csv",4,base_weapon,0);
    weaponNameString = tableLookupIString("mp/statstable.csv",0,tableRow,3);
    return weaponNameString;
}
getAttachmentShader(attachmentId)
{
    tableRow      = tableLookup("mp/attachmentTable.csv",4,attachmentId,0);
    attachmentPic = tableLookup("mp/attachmentTable.csv",0,tableRow,6);
    return attachmentPic;
}
getAttachmentNameString(attachmentId)
{
    tableRow             = tableLookup("mp/attachmentTable.csv",4,attachmentId,0);
    attachmentNameString = tableLookupIString("mp/attachmentTable.csv",0,tableRow,3);
    return attachmentNameString;
}
getAttachmentList(base_weapon)
{
    list     = [];
    tableRow = tableLookup("mp/statstable.csv",4,base_weapon,0);
    for(i=0;i<10;i++)
    {
        attachment = tableLookup("mp/statsTable.csv",0,tableRow,11+i);
        for(l=0;l<level.table_attachmentList.size;l++)
        {
            if((attachment!="") && (attachment==level.table_attachmentList[l].id))
            {
                size = list.size;
                list[size] = attachment;
            }
        }
    }
    return list;
}
getCamoNumber(camoId)
{
    camoNumber = tableLookup("mp/camoTable.csv",1,camoId,0);
    return camoNumber;
}
getCamoShader(camoId)
{
    camoPic = tableLookup("mp/camoTable.csv",1,camoId,4);
    return camoPic;
}
getCamoNameString(camoId)
{
    camoNameString = tableLookupIString("mp/camoTable.csv",1,camoId,2);
    return camoNameString;
}
call_gWN(weapon){return getWeaponName(weapon);}

getWeaponName(current)
{
    for(i=0;i<level.table_weaponList.size;i++)
    {
        if(IsSubStr( current , level.table_weaponList[i].id))//Issub
         return getWeaponNameString(level.table_weaponList[i].id);
    }
}
addMenuWeapon(weaponId)
{
    i = level.table_weaponList.size;
    level.table_weaponList[i] = spawnStruct();
    level.table_weaponList[i].id = weaponId;
}
addMenuAttachment(attachmentId)
{
    i = level.table_attachmentList.size;
    level.table_attachmentList[i] = spawnStruct();
    level.table_attachmentList[i].id = attachmentId;
}
addMenuCamo(camoId)
{
    i = level.table_camoList.size;
    level.table_camoList[i] = spawnStruct();
    level.table_camoList[i].id = camoId;
}
