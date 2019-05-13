--[[

    只有客户端 没有服务端的界面
    玩家控制台底部，友军面板，敌人面板

]]
local ui            = require 'ui.client.util'
local game          = require 'ui.base.game'
local console = {}

local controls = {}

--=================================================================================================================
--                                      控制台
--=================================================================================================================
local kzt = {}
kzt.event = {
     --进攻提示
     up_jingong_title = function(title)
        kzt.jingong.title:set_text(title)
        if not kzt.jingong.old_x then 
            kzt.jingong.old_x,kzt.jingong.old_y = kzt.jingong:get_position()
        end
        kzt.jingong:set_position(kzt.jingong.old_x,kzt.jingong.old_y)
        kzt.jingong:show()
        
        kzt.trg_timer_jf = ac.wait(3*1000,function()
            kzt.jingong:set_position(kzt.jingong.x,50)
        end)
    end,
    
}


--============================================================
--                          进攻提示
--============================================================
local jingong = {}
jingong = extends(panel_class,{
    create = function ()
        local panel = panel_class.create('image\\控制台\\jingong.tga',(1920-700)/2,300,700,250)
        local title = panel:add_text('',(panel.w-260)/2,(panel.h-40)/2-30,260,40,15,4)
        panel.title = title
        return panel
    end
})

local F2_home = {}
F2_home = extends(panel_class,{
    create = function ()
        local panel = panel_class.create('image\\控制台\\F2_home.blp',10,140,84,84)
        local title = panel:add_text('',(panel.w-260)/2,(panel.h-40)/2-30,260,40,15,4)
        panel.title = title
        return panel
    end
})

local F3_xiaoheiwu = {}
F3_xiaoheiwu = extends(panel_class,{
    create = function ()
        local panel = panel_class.create('image\\控制台\\F3_xiaoheiwu.blp',10,234,84,84)
        local title = panel:add_text('',(panel.w-260)/2,(panel.h-40)/2-30,260,40,15,4)
        panel.title = title
        return panel
    end
})

-- kzt.on_key_down = function(code)
--     -- print(code)
--     if japi.GetChatState() then
--         return
--     end

--     if code == KEY.F2 then
--         print('F2')

--         -- ranking.ui:show()
--         return
--     end

--     if code == KEY.F3 then
--         print('F3')
--         -- ranking.ui:show()
--         return
--     end
-- end

local function initialize()

    --进攻提示
    kzt.jingong = jingong.create()
    kzt.jingong:hide()

    --练功房
    kzt.F2_home = F2_home.create()
    kzt.F2_home:hide()
    kzt.F3_xiaoheiwu = F3_xiaoheiwu.create()
    kzt.F3_xiaoheiwu:hide()
    

    ui.register_event('kzt',kzt.event)
    game.register_event(kzt)
end
c_ui.kzt = kzt
initialize()

return kzt
