instaKill(drop)
{
    defined               = 50;
    level.instaKillActive = true;
    level.damage_scaler   = 10000;
    Announcement( "^1INSTAKILL STARTED" );
    level.instaKilltime             = 30;
    level.instaKillTimer            = NewHudElem();
    level.instaKillTimer.align      = "TOPLEFT";
    level.instaKillTimer.relative   = "TOPLEFT";
    level.instaKillTimer.foreground = true;
    level.instaKillTimer.fontScale  = 1.5;
    level.instaKillTimer.color      = ( 1,1,1 );
    level.instaKillTimer.font       = "objective";
    level.instaKillTimer.alpha      = 1;
    level.instaKillTimer SetTimer(time);
    level.instaKillclockObject = spawn( "script_origin", (0,0,0) );
    level.instaKillclockObject hide();
    for(level.instaKilltime=0; level.instaKilltime<=level.instaKilltime; level.instaKilltime++)
    {
        level.instaKillclockObject playSound( "ui_mp_suitcasebomb_timer" );
            wait 1;
    }
    level.instaKillTimer destroy();
    level.damage_scaler   = 1;
    level.instaKillActive = false;
    
    
}