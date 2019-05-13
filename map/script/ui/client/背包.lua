

local bag = {}
local bag_class = {}

bag_class = extends( panel_class,{
    create = function()
        --创建底层面板
        local panel = panel_class.create('image\\背包\\bar_background.tga',0,0,365,519)
        --继承
        extends(bag_class,panel)
        --禁止鼠标穿透


    end,
})