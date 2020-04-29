
GetSpawnModel( )
{
rModel = "";

    switch( getDvar("mapname") )
    {
        case "mp_underpass":
        rModel = "mp_body_militia_smg_aa_wht";
        break;
        
        case "mp_quarry":
        rModel = "mp_body_militia_smg_aa_blk";
        break;
        
        case "mp_afghan":
        rModel = "mp_body_opforce_arab_shotgun_a";
        break;
        
        case "mp_rust":
        rModel = "mp_body_opforce_arab_shotgun_a";
        break;
        
        case "mp_boneyard":
        rModel = "mp_body_opforce_arab_shotgun_a";
        break;
        
        case "mp_derail":
        rModel = "mp_body_opforce_arctic_shotgun_c";
        break;
        
        case "mp_highrise":
        rModel = "mp_body_airborne_shotgun";
        break;
        
        case "mp_terminal":
        rModel = "mp_body_airborne_shotgun";
        break;
        
        case "mp_brecourt":
        rModel = "mp_body_airborne_shotgun_b";
        break;
        
        case "mp_nightshift":
        rModel = "mp_body_airborne_shotgun_c";
        break;
        
        case "mp_estate":
        rModel = "mp_body_airborne_shotgun_c";
        break;
        
        case "mp_favela":
        rModel = "mp_body_militia_smg_aa_blk";
        break;
        
        case "mp_invasion":
        rModel = "mp_body_opforce_arab_shotgun_a";
        break;
        
        case "mp_checkpoint":
        rModel = "mp_body_opforce_arab_shotgun_a";
        break;
        
        case "mp_subbase":
        rModel = "mp_body_opforce_arctic_shotgun_c";
        break;
        
        case "mp_rundown":
        rModel = "mp_body_militia_smg_aa_blk";
        break;
    }

return rModel;
}
addZombieModel(type,model)
{
    if(!isDefined(level.zombie_model[type]))
    level.zombie_model[type] = SpawnStruct();
}