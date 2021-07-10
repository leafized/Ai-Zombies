zoneEdits()
{
    black    = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3F ,0x80 ,0x00 ,0x00];
    pink     = [0x3F, 0x80, 0x00, 0x00, 0x3F, 0x80, 0x00, 0x00, 0x3F, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
    blue     = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x80, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00];
    normal   = [0x3F, 0x80, 0x00, 0x00, 0x3F, 0x80, 0x00, 0x00, 0x3F, 0x80, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00];
    babypink = [0x3F, 0x80, 0x80, 0x80, 0x3F, 0x3F, 0x00, 0x80, 0x3F, 0x80, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00];
    purple   = [0x3F, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00];
    red      = [0x3F, 0x00, 0x80, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00];
    white    = [0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F]; //TO GET WHITE JUST DONT Write THE BYTE COLOUR FOR IT

    WriteBytes( 0x33A7ED4F, purple );//Cloud 1
    WriteBytes( 0x33A7F017, purple );//Cloud 2
    WriteBytes( 0x33A7F8A3, purple );//glow Bottom Left 1
    WriteBytes( 0x33A7FB1B, black );//glow Bottom Left 2
    WriteBytes( 0x33A7F6B3, purple ); // Player Glow
    WriteBytes( 0x33A7FD83, pink ); //Glow side of menu
    WriteBytes( 0x33A805AB, purple ); //New icon, is black because it's gross
    WriteBytes( 0x33A80D67, black );//TopLine
    WriteBytes( 0x33A8118F, black );//Bottomline
    
    
    //Public Lobby
    
    WriteBytes( 0x33BD73C3 , purple ); //Cloud Overlay 1
    WriteBytes( 0x33BD723F , black); //Cloud Overlay 2
    WriteBytes( 0x33BD70C3 , purple); //Cloud Overlay 3
    
    WriteBytes( 0x33BD784F , pink); //Menu Top Glow
    WriteBytes( 0x33BD76CB , black); //Bottom Left Glow 1
    WriteBytes( 0x33BD7547 , black); //Bottom Left Glow 2
    
    WriteBytes( 0x33BD87EB , black ); //Top Line Split
    WriteBytes( 0x33BDAD2F , black ); //Bottom Line Split
    
    WriteBytes( 0x33BD79CF , black ); //Title
    
    //Leave Lobby
    
    WriteBytes(0x33C03C8B, black); //- Cloud Overlay 1 
    WriteBytes(0x33C0399B, purple); //- Cloud Overlay 2//
    
    //Private Match
    
    WriteString( 0x33CAD968, "Purple Lake! ");//Title

    WriteBytes(0x33C05D13, purple);// - Main Colour
    WriteBytes(0x33C05E8F, purple);// - Cloud Overlay 1 
    WriteBytes(0x33C06013, purple);// - Cloud Overlay 2
    WriteBytes(0x33C0649F, pink);// - Glow Side Of Menu

    WriteBytes(0x33C07BA3, black);// - Top Line Split
    WriteBytes(0x33C08A5F, black);// - Bottom Line Split
    
    WriteBytes(0x33C0631B, black);// - Glow Bottom Left 1
    WriteBytes(0x33C06197, purple);// - Glow Bottom Left 2

    WriteBytes(0x33C06197, black);// - Glow Bottom Left

    //    WriteBytes(--- Notify, color);// Box ---
    WriteBytes(0x33D014DB, purple);// - Cloud Overlay 
    WriteBytes(0x33D0104F, purple);// - Main Colour
    WriteBytes(0x33D023EE, purple);// - Title Colour 
    WriteBytes(0x33D025AF, purple);// - Text Colour
    
    //Pre-Game
    WriteBytes(0x33BE24FF , purple );//- Main Overlay
    WriteBytes(0x33BE2CF3 , purple );//- Cloud Overlay 1
    WriteBytes(0x33BE27EF , black);//- Cloud Overlay 2
    WriteBytes(0x33BE27F2 , black);//- Cloud Overlay 3

    WriteBytes(0x33BE3E67 , pink);//- Title BG
    WriteBytes(0x33BE3CEB , pink);//- Side Of Menu Glow

}
