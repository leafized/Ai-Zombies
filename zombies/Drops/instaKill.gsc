instaKill(drop)
{
    defined               = 50;
    level.instaKillActive = true;
    level.damage_scaler   = 10000;
    Announcement( "^1INSTAKILL STARTED" );
    level.instaKilltime  = 30;
    level.instaKillTimer = NewHudElem();
    Timer.alignX         = "left";
        Timer.alignY    = "top";
        Timer.horzAlign = "left";
        Timer.vertAlign = "top";
    level.instaKillTimer.foreground = true;
    level.instaKillTimer.fontScale  = 1.4;
    level.instaKillTimer.color      = ( 1,1,1 );
    level.instaKillTimer.font       = "objective";
    level.instaKillTimer.alpha      = 1;
    level.instaKillTimer SetTimer(time);
    level.instaKillclockObject = spawn( "script_origin", (0,0,0) );
    level.instaKillclockObject hide();
    for(instaKilltime=0; instaKilltime<level.instaKilltime;instaKilltime++)
    {
        level.instaKillclockObject playSound( "ui_mp_suitcasebomb_timer" );
        wait 1;
    }
    level.instaKillTimer destroy();
    level.damage_scaler   = 1;
    level.instaKillActive = false;
    
    
}