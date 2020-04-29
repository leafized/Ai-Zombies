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
        self.Hud.LowerMessage setSafeText(string);
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
    id.color        = (1,0,0);
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
