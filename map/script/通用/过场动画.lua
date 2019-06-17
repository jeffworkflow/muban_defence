
--过场动画 
-- @持续时长，默认有淡入浅出动画
-- @回调函数
local function skip_animation(time,f)
    local p = ac.player.self
    p:hideInterface(0.3)
    ac.wait(0.3*1000,function()
        --设置镜头属性 --升到高空
        p:setCameraField('CAMERA_FIELD_ANGLE_OF_ATTACK', 0)
        p:setCameraField('CAMERA_FIELD_ZOFFSET', 3200)
        p:setCameraField('CAMERA_FIELD_TARGET_DISTANCE', 500)
    end)
    local unit = ac.player(13):create_unit('民兵',ac.point(0,0))
    jass.SetCinematicScene(jass.GetUnitTypeId(unit.handle), PLAYER_COLOR_RED, '', '地图资源加载中...', tonumber(time), tonumber(time))
    -- print(tonumber(time),f)
    ac.wait(tonumber(time)*1000, function()
        p:showInterface(0.5)
        --设置镜头属性 --恢复
        p:setCameraField('CAMERA_FIELD_TARGET_DISTANCE', 1500)
        p:setCameraField('CAMERA_FIELD_ANGLE_OF_ATTACK', 304)
        p:setCameraField('CAMERA_FIELD_ZOFFSET', 0)
        p:setCameraField('CAMERA_FIELD_ROTATION', 90)
        if f then f()end
    end)
end    
ac.skip_animation = skip_animation

-- class.anima = extends(class.panel){
--     create = function ()
--         local hero = ac.player.self.hero
--         local panel = class.panel.create('',205,916,838,60)
--         panel.__index = class.anima 

--         panel.ani_txt = panel:add_text('|cff00ff00地图加载中。。|r',0,0,600,60,14,'auto_newline')
--         panel.ani_per = panel:add_text('|cff00ff000|r',180,0,30,60,14,'auto_newline')

--         panel:hide()

--         return panel
--     end,
--     jump_animation = function (self)
--         local i = 1
--         game.timer(330,100,function (timer)
--             self.ani_per:set_text('|cff00ff00'..i..'%')
--             i = i + 1
--         end)
--     end,
    
-- }
-- local panel
-- ac.wait(10,function ()
--     panel = class.anima.get_instance()
--     panel:show()
--     panel:jump_animation()
-- end)
