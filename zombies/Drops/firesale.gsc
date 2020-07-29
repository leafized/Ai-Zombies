
fireSale(drop)
{
    if(!isdefined(level.oldPrices))
    {
        level.oldPrices       = true;
        level.oldPrice_weapon = level.store_item_price_weapon;
        level.oldPrice_perk   = level.store_item_price_perk;
        level.oldPrice_ammo   = level.store_item_price_ammo;
        level.oldPrice_armor  = level.store_item_price_armor;
    }
    level.store_item_price_weapon = 100;
    level.store_item_price_ammo   = 100;
    level.store_item_price_perk   = 100;
    level.store_item_price_armor  = 100;

    Announcement( "^3FIRESALE STARTED" );
    time             = 30;
    Timer            = NewHudElem();
    Timer.align      = "BOTTOM";
    Timer.relative   = "BOTTOM";
    Timer.foreground = true;
    Timer.fontScale  = 1;
    Timer.color      = ( 175/255, 34/255, 34/255 );
    Timer.font       = "objective";
    Timer.alpha      = 1;
    Timer SetTimer(time);
    clockObject = spawn( "script_origin", (0,0,0) );
    clockObject hide();
    clockObject endon("stop_drop_action");
    for(i=0; i<=time; i++)
    {
            clockObject playSound( "ui_mp_suitcasebomb_timer" );
            wait 1;
    }
    Timer destroy();
    
    level.store_item_price_weapon = level.oldPrice_weapon;
    level.store_item_price_ammo   = level.oldPrice_ammo;
    level.store_item_price_perk   = level.oldPrice_perk;
    level.store_item_price_armor  = level.oldPrice_armor;
    level.droppedAction[drop].active = false;
}