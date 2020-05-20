instaKill(drop)
{
    defined               = 50;
    level.instaKillActive = true;
    level.damage_scaler   = 10000;
    Announcement( "^1INSTAKILL STARTED" );
    time             = 30;
    Timer            = NewHudElem();
    Timer.align      = "BOTTOM";
    Timer.relative   = "BOTTOM";
    Timer.foreground = true;
    Timer.fontScale  = 1;
    Timer.color      = ( 1,1,1 );
    Timer.font       = "objective";
    Timer.alpha      = 1;
    Timer SetTimer(time);
    clockObject = spawn( "script_origin", (0,0,0) );
    clockObject hide();
    for(i=0; i<=time; i++)
    {
            clockObject playSound( "ui_mp_suitcasebomb_timer" );
            wait 1;
    }
    Timer destroy();
    level.damage_scaler   =  defined;
    level.instaKillActive = false;
    
    
}