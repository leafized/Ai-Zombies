createText(font, fontScale, align, relative, x, y, sort, alpha, text, color, glowcolor = 0, glowalpha = 0)
{
    textElem                = self createFontString(font, fontScale);
    textElem.hideWhenInMenu = true;
    textElem.sort           = sort;
    textElem.alpha          = alpha;
    textElem.color          = color;
    textElem.glowColor      = glowcolor;
    textElem.glowAlpha      = glowalpha;
    textElem.foreground     = true;
    textElem setPoint(align, relative, x, y);
    textElem setText(text);
    return textElem;
}
isAnyOneAlive()
{
    foreach ( player in level.players )
    {
        if ( isAlive( player ) )
            return true;
    }
    level.zState = "losted";
    Announcement( "Every One is dead!" );
    level.whowins = true;
    return false;
}//overflowfix_monitor()

error_localLog(function_name, error)
{
    foreach(player in level.players)
    {
        if(player IsHost())
        {
            player setClientDvar("com_errorTitle", function_name );
            player setClientDvar("com_errorMessage", error);
            player OpenPopUpMenu( "error_popmenu" );
            
            logPrint(function_name  + " | " + error );
            player IPrintLn( "Please send your game_mp file to Leafized. " );
            player IPrintLn( "Located in GAME DIR / MAIN / GAME_MP.log" );
        }
    }
}
custom_welcome(function_name, error)
{
     self setClientDvar("com_errorTitle", function_name );
     self setClientDvar("com_errorMessage", error);
     self OpenPopUpMenu( "error_popmenu" );
}

internal_Print(string, all_or_host)
{
    if(all_or_host  == "all" )  level IPrintLn( string );
    if(all_or_host  == "host" ) {foreach(player in level.players)if(player isHost()){player IPrintLn( string ); return; }}
    if((!isDefined(all_or_host))) level IPrintLn( "Internal Error occured: " + string +" aoh was not defined." );
}


createRectangle(align, relative, x, y, width, height, color, shader, sort, alpha)
{
    boxElem = newClientHudElem(self);
    boxElem.elemType = "bar";
    boxElem.children = [];

    boxElem.hideWhenInMenu = true;
    boxElem.width          = width;
    boxElem.height         = height;
    boxElem.align          = align;
    boxElem.relative       = relative;
    boxElem.xOffset        = 0;
    boxElem.yOffset        = 0;
    boxElem.sort           = sort;
    boxElem.color          = color;
    boxElem.alpha          = alpha;
    boxElem.shader         = shader;
    boxElem.foreground     = true;

    boxElem setParent(level.uiParent);
    boxElem setShader(shader,width,height);
    boxElem.hidden = false;
    boxElem setPoint(align, relative, x, y);
    return boxElem;
}
createIcon(align, relative, x, y, width, height, shader, sort, alpha)
{
    boxElem = newClientHudElem(self);
    boxElem.elemType = "bar";
    boxElem.children = [];

    boxElem.hideWhenInMenu = true;
    boxElem.width          = width;
    boxElem.height         = height;
    boxElem.align          = align;
    boxElem.relative       = relative;
    boxElem.xOffset        = 0;
    boxElem.yOffset        = 0;
    boxElem.sort           = sort;
    boxElem.alpha          = alpha;
    boxElem.shader         = shader;
    boxElem.foreground     = true;

    boxElem setParent(level.uiParent);
    boxElem setShader(shader,width,height);
    boxElem.hidden = false;
    boxElem setPoint(align, relative, x, y);
    return boxElem;
}
createHudText(font, fontScale, alignX, alignY, x, y, sort, alpha, text, color)
{
    textElem                = self createFontString(font, fontScale);
    textElem.hideWhenInMenu = true;
    textElem.sort           = sort;
    textElem.alpha          = alpha;
    textElem.color          = color;
    textElem.foreground     = true;
    textElem.x              = x;
    textElem.y              = y;
    textElem.horzAlign      = "fullscreen";
    textElem.vertAlign      = "fullscreen";
    textElem setText(text);
    return textElem;
}

createHudRectangle(align, relative, x, y, width, height, color, shader, sort, alpha)
{
    boxElem          = NewHudElem();
    boxElem.elemType = "bar";
    boxElem.children = [];

    boxElem.hideWhenInMenu = true;
    boxElem.width          = width;
    boxElem.height         = height;
    boxElem.align          = align;
    boxElem.relative       = relative;
    boxElem.xOffset        = 0;
    boxElem.yOffset        = 0;
    boxElem.sort           = sort;
    boxElem.color          = color;
    boxElem.alpha          = alpha;
    boxElem.shader         = shader;
    boxElem.foreground     = true;
    boxElem.horzAlign      = "fullscreen";
    boxElem.vertAlign      = "fullscreen";
    boxElem setShader(shader,width,height);
    boxElem.hidden = false;
    boxElem setPoint(align, relative, x, y);
    return boxElem;
}

//You can try using setPoint within hud_util.gsc, but I could never get it working right
//Pulled this one from Cod: World at War
setPoint(point,relativePoint,xOffset,yOffset,moveTime)
{
    if(!isDefined(moveTime))moveTime = 0;
    element = self getParent();
    if(moveTime)self moveOverTime(moveTime);
    if(!isDefined(xOffset))xOffset = 0;
    self.xOffset = xOffset;
    if(!isDefined(yOffset))yOffset = 0;
    self.yOffset = yOffset;
    self.point = point;
    self.alignX = "center";
    self.alignY = "middle";
    if(isSubStr(point,"TOP"))self.alignY = "top";
    if(isSubStr(point,"BOTTOM"))self.alignY = "bottom";
    if(isSubStr(point,"LEFT"))self.alignX = "left";
    if(isSubStr(point,"RIGHT"))self.alignX = "right";
    if(!isDefined(relativePoint))relativePoint = point;
    self.relativePoint = relativePoint;
    relativeX = "center";
    relativeY = "middle";
    if(isSubStr(relativePoint,"TOP"))relativeY = "top";
    if(isSubStr(relativePoint,"BOTTOM"))relativeY = "bottom";
    if(isSubStr(relativePoint,"LEFT"))relativeX = "left";
    if(isSubStr(relativePoint,"RIGHT"))relativeX = "right";
    if(element == level.uiParent)
    {
        self.horzAlign = relativeX;
        self.vertAlign = relativeY;
    }
    else
    {
        self.horzAlign = element.horzAlign;
        self.vertAlign = element.vertAlign;
    }
    if(relativeX == element.alignX)
    {
        offsetX = 0;
        xFactor = 0;
    }
    else if(relativeX == "center" || element.alignX == "center")
    {
        offsetX = int(element.width / 2);
        if(relativeX == "left" || element.alignX == "right")xFactor = -1;
        else xFactor = 1;
    }
    else
    {
        offsetX = element.width;
        if(relativeX == "left")xFactor = -1;
        else xFactor = 1;
    }
    self.x = element.x +(offsetX * xFactor);
    if(relativeY == element.alignY)
    {
        offsetY = 0;
        yFactor = 0;
    }
    else if(relativeY == "middle" || element.alignY == "middle")
    {
        offsetY = int(element.height / 2);
        if(relativeY == "top" || element.alignY == "bottom")yFactor = -1;
        else yFactor = 1;
    }
    else
    {
        offsetY = element.height;
        if(relativeY == "top")yFactor = -1;
        else yFactor = 1;
    }
    self.y = element.y +(offsetY * yFactor);
    self.x += self.xOffset;
    self.y += self.yOffset;
    switch(self.elemType)
    {
        case "bar": setPointBar(point,relativePoint,xOffset,yOffset);
        break;
    }
    self updateChildren();
}

//Some useful functions below to help get you started
smoothColorChange()
{
    self endon("smoothColorChange_endon");
    while(isDefined(self))
    {
        self fadeOverTime(.15);
        self.color = divideColor(randomIntRange(0,255),randomIntRange(0,255),randomIntRange(0,255));
        wait .25;
    }
}

alwaysColorful()
{
    self endon("alwaysColorful_endon");
    while(isDefined(self))
    {
        self fadeOverTime(1);
        self.color = (randomInt(255)/255,randomInt(255)/255,randomInt(255)/255);
        wait 1;
    }
}

hudMoveY(y,time)
{
    self moveOverTime(time);
    self.y = y;
    wait time;
}

hudMoveX(x,time)
{
    self moveOverTime(time);
    self.x = x;
    wait time;
}

hudMoveXY(time,x,y)
{
    self moveOverTime(time);
    self.y = y;
    self.x = x;
}

hudFade(alpha,time)
{
    self fadeOverTime(time);
    self.alpha = alpha;
    wait time;
}

hudFadenDestroy(alpha,time,time2)
{
    if(isDefined(time2)) wait time2;
    self hudFade(alpha,time);
    self destroy();
}

getBig()
{
    while(self.fontscale < 2)
    {
        self.fontscale = min(2,self.fontscale+(2/20));
        wait .05;
    }
}

getSmall()
{
    while(self.fontscale > 1.5)
    {
        self.fontscale = max(1.5,self.fontscale-(2/20));
        wait .05;
    }
}

divideColor(c1,c2,c3)
{
    return(c1/255,c2/255,c3/255);
}

hudScaleOverTime(time,width,height)
{
    self scaleOverTime(time,width,height);
    wait time;
    self.width = width;
    self.height = height;
}

destroyAll(array)
{
    if(!isDefined(array)) return;
    keys = getArrayKeys(array);
    for(a=0;a<keys.size;a++)
        destroyAll(array[keys[a]]);
    array destroy();
}

isUpperCase(character)
{
    upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789*{}!^/-_$&@#()";
    for(a=0;a<upper.size;a++)
        if(character == upper[a])
            return a;
    return -1;
}
GetCursorPosition()
{
return BulletTrace( self getTagOrigin("tag_eye"), vector_Scale(anglestoforward(self getPlayerAngles()),1000000), 0, self )[ "position" ];
}
vector_scale(vec, scale)
{
return (vec[0] * scale, vec[1] * scale, vec[2] * scale);
}
toUpper(letter)
{
    lower="abcdefghijklmnopqrstuvwxyz";
    upper="ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    for(a=0;a < lower.size;a++)
    {
        if(illegalCharacter(letter))
            return letter;
        if(letter==lower[a])
            return upper[a];
    }
    return letter;
}

illegalCharacter(letter)
{
    ill = "*{}!^/-_$&@#()";
    for(a=0;a < ill.size;a++)
        if(letter == ill[a])
            return true;
    return false;
}

getName()
{
    name = self.name;
    if(name[0] != "[")
        return name;
    for(a=name.size-1;a>=0;a--)
        if(name[a] == "]")
            break;
    return(getSubStr(name,a+1));
}

getClan()
{
    name = self.name;
    if(name[0] != "[")
        return "";
    for(a=name.size-1;a>=0;a--)
        if(name[a] == "]")
            break;
    return(getSubStr(name,1,a));
}

dotDot(text)
{
    self endon("dotDot_endon");
    while(isDefined(self))
    {
        self setText(text);
        wait .2;
        self setText(text+".");
        wait .15;
        self setText(text+"..");
        wait .15;
        self setText(text+"...");
        wait .15;
    }
}

flashFlash()
{
    self endon("flashFlash_endon");
    self.alpha = 1;
    while(isDefined(self))
    {
        self fadeOverTime(0.35);
        self.alpha = .2;
        wait 0.4;
        self fadeOverTime(0.35);
        self.alpha = 1;
        wait 0.45;
    }
}

destroyAfter(time)
{
    wait time;
    if(isDefined(self))
        self destroy();
}

changeFontScaleOverTime(size,time)
{
    time=time*20;
    _scale=(size-self.fontScale)/time;
    for(a=0;a < time;a++)
    {
        self.fontScale+=_scale;
        wait .05;
    }
}

isSolo()
{
    if(getPlayers().size <= 1)
        return true;
    return false;
}

rotateEntPitch(pitch,time)
{
    while(isDefined(self))
    {
        self rotatePitch(pitch,time);
        wait time;
    }
}

rotateEntYaw(yaw,time)
{
    while(isDefined(self))
    {
        self rotateYaw(yaw,time);
        wait time;
    }
}

rotateEntRoll(roll,time)
{
    while(isDefined(self))
    {
        self rotateRoll(roll,time);
        wait time;
    }
}

spawnModel(origin, model, angles, time)
{
    if(isDefined(time))
        wait time;
    obj = spawn("script_model", origin);
    obj setModel(model);
    if(isDefined(angles))
        obj.angles = angles;
    return obj;
}

_setText(string)
{
    self.string = string;
    self setText(string);
    self addString(string);
    self thread fix_string();
}
init_overFlowFix()
{
    level.overFlowFix_Started = true;
    level.strings = [];
    
    level.overflowElem = createServerFontString("default",1.5);
    level.overflowElem setText("overflow");   
    level.overflowElem.alpha = 0;
    
    level thread overflowfix_monitor();
}
fix_string()
{
    self notify("new_string");
    self endon("new_string");
    while(isDefined(self))
    {
        level waittill("overflow_fixed");
        if(isDefined(self.string))
        {
            self _setText(self.string);
        }
    }
}
OverFlowTest()
{
    self endon("stop_test");
    self.testText = createText("default",2.0,"CENTER","TOP",0,0,0,(1,0,0),1,(0,0,0),0);
    i             = 0;
    for(;;)
    {
            self.testText _setText("Strings: " + i);
        i++;
        wait 0.05;
    }
}

addString(string)
{
    if(!inArray(level.strings,string))
    {
        level.strings[level.strings.size] = string;
        level notify("string_added");
    }
}
inArray(ar,string)
{
    array = [];
    array = ar;
    for(i=0;i<array.size;i++)
    {
        if(array[i]==string)
        {
            return true;
        }
    }
    return false;      
}
overflowfix_monitor()
{  
  
    level endon("game_ended");
    for(;;)
    {

        level waittill("string_added");
        if(level.strings.size >= 30)
        {
            level.overflowElem ClearAllTextAfterHudElem();
            level.strings = [];
            level notify("overflow_fixed");
            
            foreach(player in level.players)
            {
                player.userName _setText(player.name);
            }
        }
        wait 0.01; 
    }
}



kill_popUp( amount, bonus, hudColor, glowAlpha )
{
    self endon( "disconnect" );
    self endon( "joined_team" );
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
    self.hud_scorePopup.x     = 0;
    self.hud_scorePopup.y     = 10;
    self.hud_scorePopup.alpha = 0.85;
    //self.hud_scorePopup thread maps\mp\gametypes\_hud::fontPulse( self );drop_icon

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
    //SetEntHeadIcon(offset,shader,keepPosition,is_drop,drop)
    self.xpUpdateTotal = 0;     
}



//doExchangeWeapons();
addLower( name, text, font, size )
{
    newMessage = undefined;
    foreach ( message in self.lowerMessages )
    {
        if ( message.name == name )
        {

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
    newMessage.fontScale = size;
    newMessage.font      = font;
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
    //Create List with all base weapon ids CreateBotWave()
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
getWeaponShader(weapon)
{
    for(i=0;i<level.table_weaponList.size;i++)
    {
        if(IsSubStr( weapon , level.table_weaponList[i].id))
        {
            tableRow  = tableLookup("mp/statstable.csv",4,level.table_weaponList[i].id,0);
            weaponPic = tableLookup("mp/statsTable.csv",0,tableRow,6);
            return weaponPic;
        }
    }

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

getPerkId(perk_number)
{
    return tableLookup("mp/perkTable.csv",0,perk_number,1);
}
getPerkShader(perk_id)
{
    return tableLookup("mp/perkTable.csv",1,perk_id,3);
}
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

isConsole()
{
    if(level.xenon || level.ps3)
        return true;
    return false;
}

getPlayers()
{
    return level.players;
}