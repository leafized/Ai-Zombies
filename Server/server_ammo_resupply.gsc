GetAirdropPoint( )
{
sReturn = undefined;

    switch( getDvar("mapname") )
    {
    
        case "mp_afghan":
        sReturn = (1362,1247,76);
        break;
        
        case "mp_terminal":
        sReturn = (1183,3909,40);
        break;
        
        case "mp_quarry":
        sReturn = (-3275, 978, -99);
        break;
        
        case "mp_rust":
        sReturn = (1283, 1336, -105);
        break;
        
        case "mp_derail":
        sReturn = (427, -312, -15);
        break;
        
        case "mp_highrise":
        sReturn = (-2274, 6062, 2912);
        break;
        
        case "mp_brecourt":
        sReturn = (1619, -2115, 68);
        break;
        
        case "mp_boneyard":
        sReturn = (714, 384, -122);
        break;
        
        case "mp_underpass":
        sReturn = (1244, 1588, 377);
        break;
        
        case "mp_nightshift":
        sReturn = (-1574, -848, 3);
        break;
        
        case "mp_estate":
        sReturn = (778, 1675, 146);
        break;
        
        case "mp_favela":
        sReturn = (103, -57, 5);
        break;
        
        case "mp_invasion":
        sReturn = (-370, -1819, 275);
        break;
        
        case "mp_checkpoint":
        sReturn = (1109, 626, 11);
        break;
        
        case "mp_subbase":
        sReturn = (291, -595, 99);
        break;
        
        case "mp_rundown":
        sReturn = (214, -1059, 23);
        
    }

return sReturn;
}


monitorIconOrigin( entity )
{
    self endon("crate_gone");
    for(;;)
    {
        entity.x = self.origin[0];
        entity.y = self.origin[1];
        entity.z = self.origin[2] + 50;
        wait 0.05;
    }
}


killCrate( ent )
{
    level waittill("crate_gone");

    if ( isDefined( self.objIdFriendly ) )
        _objective_delete( self.objIdFriendly );

    self notify("crate_gone");
    self KillEnt(ent, 0);
}

giveAmmo()
{
    level endon("crate_gone");

    for(;;)
    {
        foreach( player in level.players )
        {
            if(!isDefined(player.ammoing))
            player.ammoing = false;
        
            if(distancesquared(self.origin, player.origin) <= 9732 && !player.ammoing)
            {
            if(player.sessionstate != "playing")
            continue;
            
            player thread ammoWaitThread();
            
            player playlocalsound("weap_pickup");

            player giveMaxAmmo(player getCurrentWeapon());
            }
        }

        wait 0.05;
    }
}

getFlyHeightOffset( dropSite )
{
    lbFlyHeight = 850;
    
    heightEnt = GetEnt( "airstrikeheight", "targetname" );
    
    if ( !isDefined( heightEnt ) )
    {
        if ( isDefined( level.airstrikeHeightScale ) )
        {   
            if ( level.airstrikeHeightScale > 2 )
            {
                lbFlyHeight = 1500;
                return( lbFlyHeight * (level.airStrikeHeightScale ) );
            }
            
            return( lbFlyHeight * level.airStrikeHeightScale + 256 + dropSite[2] );
        }
        else
            return ( lbFlyHeight + dropsite[2] );   
    }
    else
    {
        return heightEnt.origin[2];
    }
    
}

c130Setup( owner, pathStart, pathGoal )
{
    forward = vectorToAngles( pathGoal - pathStart );
    c130 = spawnplane( owner, "script_model", pathStart, "compass_objpoint_c130_friendly", "compass_objpoint_c130_enemy" );
    c130 setModel( "vehicle_ac130_low_mp" );
    
    if ( !isDefined( c130 ) )
        return;

    c130.owner = owner;
    c130.team = "allies";
    level.c130 = c130;
    
    return c130;
}

createAirDropCrate( owner, dropType, crateType, startPos )
{
    dropCrate = spawn( "script_model", startPos );
    
    dropCrate.curProgress = 0;
    dropCrate.useTime = 0;
    dropCrate.useRate = 0;
    dropCrate.team = self.team;
    
    if ( isDefined( owner ) )
        dropCrate.owner = owner;
    else
        dropCrate.owner = undefined;

    dropCrate.targetname = "care_package";
    dropCrate setModel( "com_plasticcase_friendly" );
    
    //dropCrate CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    
    return dropCrate;
}

dropTheCrate( dropPoint, dropType, lbHeight, dropImmediately, crateOverride, startPos )
{
    dropCrate = [];
    self.owner endon ( "disconnect" );
        
    dropCrate = createAirDropCrate( self.owner, dropType, undefined, startPos );

    dropCrate LinkTo( self, "tag_ground" , (64,32,-128) , (0,0,0) );

    dropCrate.angles = (0,0,0);
    dropCrate show();
    dropSpeed = self.veh_speed;

    self waittill ( "drop_crate" );

    dropCrate Unlink();
    dropCrate PhysicsLaunchServer( (0,0,0), (0,0,0) );
    dropCrate setModel( "com_bomb_objective" );
    dropCrate hide();
    
    ammodrop = spawn("script_model", dropCrate.origin - (0, 0, 15));
    ammodrop setModel("com_bomb_objective");
    ammodrop.classname = "ammoDrop";
    ammodrop linkTo(dropCrate);
    ammodrop thread killCrate( ammodrop );

    ammodrop.trigger = spawn("trigger_radius", ammodrop.origin,0,120,120);
    ammodrop.trigger thread giveAmmo();
    ammodrop thread monitorOrigin( ammodrop.trigger );
    ammodrop thread killCrate( ammodrop.trigger );

    curObjID = maps\mp\gametypes\_gameobjects::getNextObjID();  
    objective_add( curObjID, "invisible", (0,0,0) );
    objective_position( curObjID, ammodrop.origin );
    objective_state( curObjID, "active" );
    objective_team( curObjID, ammodrop.team );
    objective_icon( curObjID, "compass_objpoint_ammo_friendly" );
    ammodrop.objIdFriendly = curObjID;
    ammodrop thread killCrate( ammodrop.objIdFriendly );

    ammodrop.headIcon = newHudElem();
    ammodrop.headIcon.x = ammodrop.origin[0];
    ammodrop.headIcon.y = ammodrop.origin[1];
    ammodrop.headIcon.z = ammodrop.origin[2] + 50;
    ammodrop.headIcon.alpha = 0.85;
    ammodrop.headIcon setShader( "waypoint_ammo_friendly", 10,10 );
    ammodrop.headIcon setWaypoint( true, true, false );
    ammodrop thread monitorIconOrigin( ammodrop.headIcon );
    ammodrop thread killCrate( ammodrop.headIcon );
    
    wait 5;
    
    ammodrop Unlink();
    dropCrate Unlink();
    dropCrate destroy();

}

C130FlyBy()
{
    owner             = GetHost();
    dropSite          = GetHost().origin;
    planeHalfDistance = 24000;
    planeFlySpeed     = 2000;
    yaw               = vectorToYaw( dropsite );
    
    direction = ( 0, yaw, 0 );
    
    flyHeight = self getFlyHeightOffset( dropSite );
    
    pathStart = dropSite + vector_multiply( anglestoforward( direction ), -1 * planeHalfDistance );
    pathStart = pathStart * ( 1, 1, 0 ) + ( 0, 0, flyHeight );

    pathEnd = dropSite + vector_multiply( anglestoforward( direction ), planeHalfDistance );
    pathEnd = pathEnd * ( 1, 1, 0 ) + ( 0, 0, flyHeight );
    
    d = length( pathStart - pathEnd );
    flyTime = ( d / planeFlySpeed );
    
    c130 = c130Setup( owner, pathStart, pathEnd );
    c130.veh_speed = planeFlySpeed;
    c130 playloopsound( "veh_ac130_dist_loop" );

    c130.angles = direction;
    forward = anglesToForward( direction );
    c130 moveTo( pathEnd, flyTime, 0, 0 ); 
    
    minDist = distance2D( c130.origin, dropSite );
    boomPlayed = false;
    
    for(;;)
    {
        dist = distance2D( c130.origin, dropSite );

        if ( dist < minDist )
            minDist = dist;
        else if ( dist > minDist )
            break;
        
        if ( dist < 256 )
        {
            break;
        }
        else if ( dist < 768 )
        {
            earthquake( 0.15, 1.5, dropSite, 1500 );
            if ( !boomPlayed )
            {
                c130 playSound( "veh_ac130_sonic_boom" );
                boomPlayed = true;
            }
        }   
        
        wait ( .05 );   
    }   
    
    wait( 0.05 );
    c130 thread dropTheCrate( dropSite, undefined, flyHeight, false, undefined , pathStart );
    wait ( 0.05 );
    c130 notify ( "drop_crate" );

    wait 4.30;

    c130 delete();
}
ammoWaitThread()
{
self endon("death");
self endon("disconnect");

self.ammoing = true;
wait 0.75;
self.ammoing = false;
}