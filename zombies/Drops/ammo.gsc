maxAmmo(drop_to_destroy)
{
    level iprintln("AMMO STARTED");
    foreach(player in level.players)
    {
        if(player isHost())
        {
            Announcement(@"Current Weapon Ammo Filled!");
        }
        player givemaxammo(player GetCurrentWeapon());
    }
}
