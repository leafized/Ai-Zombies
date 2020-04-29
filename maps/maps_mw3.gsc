
map_mp_lockdown()
{
        thread spawnWeaponBox((-1475.53, 1095.78, 0.125002),0);
    thread spawnAmmoBox((-1472.45, 854.395, 0.124998),0);
    thread spawnArmourBox((-1681.12, 1496.32, -7.87505),0);
    level.zmSpawnPoints = [
    (-2262.53, 1234.15, 8.125),
    (-2262.53, 1234.15, 8.125),
    (-1406.55, 290.395, 8.125),
    (-1406.55, 290.395, 8.125),
    (-1445.12, 1839.94, 8.125),
    (-1928.60, 568.053, 8.125)];
    level.zmModels      = ["mp_body_delta_elite_smg_a"];
    level.zmHeads       = ["head_sas_a"];
    level.adPoint       = [(1283, 1336, -105)];
    IPrintLn( "RUST CREATED" );
    foreach(player in level.players)
    {
         self thread MysteryBox();
       self thread AmmoBoxMonitor();
            self thread ArmourBoxMonitor();
            //        self thread perkMonitor();
    }
}