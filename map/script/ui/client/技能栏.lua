local unit_class    = (require 'ui.client.unit').unit_class
local ui            = require 'ui.client.util'
local game          = require 'ui.base.game'

local skillcolumn = {}
local skillcolumn_class = {}

skillcolumn_class = extends( panel_class,{
    create = function()
        --创建底层面板
        local panel = panel_class.create('',715,880,406,54)
        --继承
        extends(skillcolumn_class,panel)
        --禁止鼠标穿透

        --创建7个技能栏
        local key = {'Q','W','E','R','D','F','T'}
        local button_list = {}
        local y = 0
        for n=0,6 do
            local x = n * 5 + n * 54
            local button = panel:add_button('image\\控制台\\gezi.tga',x,0,54,54)
            button.texture = button:add_texture('',2,2,50,50)
            button.name = '技能栏'
            table.insert(button_list,button)
            button.slot_id = #button_list

            --快捷键文字
            local kjj_bj = button:add_texture('image\\控制台\\heise.tga',2,2,15,15)
            local text = kjj_bj:add_text(key[n+1],0,0,15,15,9,4)
        end

        panel.name = '技能栏'
        panel.button_list = button_list
        return panel
    end,

})

skillcolumn.event = {
    --服务端添加技能
    add_skill = function(name,unit_handle,slot)
        local unit = unit_class.unit_map[unit_handle]
        --创建一个物品
        local item = c_ui.create_item(name,unit)
        local map = unit:get_skillcolumn()
        map[slot] = item

        --修改图标
        local art = item:get_art()
        local button = c_ui.skl.button_list[slot]
        button.texture:set_normal_image(art)
        print(art)
    end,
}


ui.register_event('skillcolumn',skillcolumn.event)
game.register_event(skillcolumn)
c_ui.skl = skillcolumn_class.create()