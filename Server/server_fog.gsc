createFog()
{
    level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter( level.spawnMins, level.spawnMaxs );
    level._effect[ "FOW" ] = loadfx( "dust/nuke_aftermath_mp" );
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 0 , 0 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 0 , 3000 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 0 , -3000 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 3000 , 0 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 3000 , 3000 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 3000 , -3000 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( -3000 , 0 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( -3000 , 3000 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( -3000 , -3000 , 500 ));
}

