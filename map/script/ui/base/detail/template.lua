load_fdf [[
IncludeFile "UI\FrameDef\Glue\StandardTemplates.fdf",
IncludeFile "UI\FrameDef\Glue\BattleNetTemplates.fdf",

Frame "TEXTBUTTON" "ChooBlankButtonTemplatetA" {
    ControlStyle "AUTOTRACK",
}

//背景模板
Frame "BACKDROP" "panel" {
	BackdropBackground  "Transparent.tga",
	//BackdropBlendAll,
}
//按钮模板
Frame "GLUETEXTBUTTON" "buttonAAA" {
  SetAllPoints,
}
//字
Frame "TEXT" "text" {
    LayerStyle "IGNORETRACKEVENTS",
    FrameFont "resource\fonts\mtp.ttf", 10, "", 
}


Frame "SPRITE" "model" {
    BackgroundArt "HeroShadowHunter2.mdx",
    //SetAllPoints,
}

Frame "TEXT" "old_text" {
    LayerStyle "IGNORETRACKEVENTS",
    FrameFont "MasterFont", 1, "", 
}

Frame "BACKDROP" "tooltip_backdrop" {
    UseActiveContext,
    BackdropTileBackground,
    BackdropBackground  "UI\widgets\BattleNet\bnet-tooltip-background.blp",
    BackdropCornerFlags "UL|UR|BL|BR|T|L|B|R",
    BackdropCornerSize  0.01,
    BackdropBackgroundInsets 0.001f 0.001f 0.001f 0.001f,
    BackdropEdgeFile  "UI\Widgets\BattleNet\bnet-inputbox-border.blp",
}

]]