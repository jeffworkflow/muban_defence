-- local ui            = require 'ui.client.util'
-- local game          = require 'ui.base.game'

local sendmsg = {}

local game_ui = japi.GetGameUI()
--魔兽的提示框
local tsk = japi.FrameGetTooltip()

class.sendmsg = extends(class.panel){
    create = function ()
        local panel = class.panel.create('',1226,834,694,246)
        panel.__index = class.sendmsg
        panel:set_alpha(0.4)

        
        --6个物品栏按钮
        for i=0,2 do
            local y = 44 + i * 58 + i * 11
            for n=0,1 do
                local x = 12 + n * 78 + n * 18
                panel:set_itembutton(x,y,78,58)
            end
        end
        
        --12个技能栏
        local slotid = 0
        for i=0,2 do
            local y = 9 + i * 70 + i * 8
            for n=0,3 do
                local x = 257 + n * 94 + n * 11
                local button = panel:set_skillbutton(x,y,94,70)
                slotid = slotid + 1
                button.slot_id = slotid
            end
        end
        return panel
    end,

    --物品栏按钮
    set_itembutton = function(self,x,y,w,h)
        local button = self:add_button('',x,y,w,h)
        button.type = '物品栏'
        --鼠标进入
        button.on_button_mouse_enter = function()
            japi.FrameSetPoint(tsk,8,game_ui,8,0,0.16)  --还原魔兽自带的位置 

        end
        --鼠标离开
        button.on_button_mouse_leave = function()
            
        end
        return button
    end,

    set_skillbutton = function(self,x,y,w,h)
        local button = self:add_button('',x,y,w,h)
        button.type = '技能栏'
        
        --鼠标进入
        button.on_button_mouse_enter = function()
            mtp_tip.set_skill_tip(button)
            button.timer_trg = ac.loop(1000,function()
                mtp_tip.set_skill_tip(button)
            end)
        end

        --鼠标离开
        button.on_button_mouse_leave = function()
            mtp_tip.hide_skill_tip(button)
            button.timer_trg:remove()
        end
        return button
    end,
}

class.sendmsg.create()
