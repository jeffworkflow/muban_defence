local ui = require 'ui.client.util'
local message = require 'jass.message'
local order_id = require 'war3.order_id'

local game_event = {}

------操作栏----------------------
class.action_bar = extends(class.panel){
    create = function ()
        local width = 850
        local height = 40
        local panel = class.panel.create('image\\操作栏\\background.tga',1920/2-width/2,50,width,height)
        panel.__index = class.action_bar

        game.wait(100,function ()
            panel:update_normal_image()
        end)

        -------------------------按钮
        panel.button = panel:add_button('image\\操作栏\\buy.tga',20,-35,100,65,true)

        panel.round = panel:add_text('ROUND 0',200,-20,200,20,8,'left')
        panel.round:set_color(0xffb0b0b0)


        panel.target_button = panel:add_button('',150,10,100,20)
        panel.title1 = panel:add_text('准备中',140,10,200,20,16,'center')
        panel.title1:set_color(0xffb0b0b0)

        local start_time = 16 * 60 * 60

        panel.game_time = panel:add_text('00:19:38',panel.w / 2 - 200 / 2,-20,200,20,8,'center')
        panel.game_time:set_color(0xffb0b0b0)
        --计时器更新时间
        game.loop(1000,function ()
            start_time = start_time + 1
            panel.game_time:set_text(os.date('%H:%M:%S',start_time))
        end)

        panel.title2 = panel:add_text('准备回合',panel.w / 2 - 200 / 2,10,200,20,20,'center')
        panel.title2:set_color(0xffb0b020)

        panel.time = panel:add_text('40',panel.w / 2 - 200 / 2,50,200,50,30,'center')


        panel.chesses = panel:add_text('CHESSES',panel.w / 2 + 150,-20,200,20,8,'left')
        panel.chesses:set_color(0xffb0b0b0)

        panel.food_button = panel:add_button('',panel.w/ 2 + 142,0,100,50)
        panel:add_texture('image\\操作栏\\icon_food.blp',panel.w / 2 + 142,3,32,32)

        panel.food = panel:add_text('7 / 7',panel.w / 2 + 180,10,200,20,16,'left')

        panel.gold_title = panel:add_text('GOLD',panel.w / 2 + 310,-20,200,20,8,'left')
        panel.gold_title:set_color(0xffb0b0b0)

        panel.gold_button = panel:add_button('',panel.w/ 2 + 302,0,100,50)
        panel:add_texture('image\\操作栏\\icon_gold.blp',panel.w / 2 + 302,3,32,32)

        panel.gold = panel:add_text('51',panel.w / 2 + 340,10,200,20,14,'left')

        panel.select_panel = class.select_panel.create()

        return panel
    end,


    on_button_clicked = function (self,button)
        if button == self.button then
            --ac.player.self:play_sound([[Sound\Interface\MouseClick1.wav]])
            if self.select_panel.is_show then 
                self.select_panel:hide()
            else 
                self.select_panel:show()
            end 
        end
    end,

    on_button_mouse_enter = function (self,button)
        if button == self.button then 
            button:tooltip("招募棋子","点击或按 F2 打开关闭招募商店界面,消耗一定的资源招募相应的棋子作战。|n点击 X 按钮或按 Esc键可关闭",-1,nil,100)
        elseif button == self.food_button then 
            button:tooltip("棋子上限","你在场上的棋子的数量不能超过棋子上限。如果准备阶段暂时超员,在进入战斗阶段的时候回呗强制下场超员的棋子数量。",nil,nil,100)
        elseif button == self.gold_button then 
            local player = ac.player.self
            local str = '当前金币：' .. player:get_gold() .. '\n'
            str = str .. '收益：' .. player:get_battle_over_gold() .. '\n'
            str = str .. '(基础' .. player:get_battle_base_gold() .. '+连胜奖励' .. player:get_win_loss_gold() .. '+利息' .. player:get_cridit() .. '\n \n'
            str = str .. "金币是你在自走棋游戏中购买物品使用的唯一资源,每回合都会自动获得金币,汰换棋子也有可能回收一定数量的金币。\n你可以在招募棋子面板使用金币着迷棋子,也可以花费金币额外招募棋子或者研读棋谱。"
            button:tooltip("金币",str,nil,nil,100)
        elseif button == self.target_button then 
            button:tooltip("对战玩家","战斗回合的时候，这里是显示与你对战玩家的名字。",-1,200,100)
        end 
    end,
}

-------------选择界面------------
class.select_panel = extends(class.panel){
    create = function ()
        local panel = class.panel.create('',220,250,1500,200)
        local background = panel:add_texture('image\\操作栏\\store.tga',50,35,panel.w - 130,panel.h)
        local B = panel:add_texture('image\\操作栏\\store_B.tga',50,35,panel.w - 130,panel.h)
        --local right = panel:add_texture('image\\操作栏\\store_right.tga',panel.w - 80,35,50,panel.h)

        background:set_alpha(0.8)
        panel.__index = class.select_panel

        panel.close_button = background:add_button('image\\操作栏\\cross.blp',background.w - 64 / 2-5,5,32,32,true)

        panel.lock_button = background:add_button('image\\操作栏\\lock2.blp',20,background.h - 64,48,48)

        panel.rand_button = background:add_button('image\\操作栏\\icon_fresh_chess.blp',10,4,64,64)
        
        panel.actors = {}
        for i = 1, 5 do 
            local actor = panel:add_actor('', i * 250,80)
            panel.actors[i] = actor 
            actor.slot_id = i 

            local button = actor:add_button('',-120,-170,200,250)

            local name = actor:add_text(actor:get_title(),-100,40,200,30,16,'center')
            --name:set_color(0xffa0a0a0)

            local type = actor:add_text(actor:get_type_tip(),-100,70,200,30,12,'center')
            --type:set_color(0xff808080)

            local icon = actor:add_texture('image\\操作栏\\icon_gold.blp',-55,102,42,42)

            local gold = actor:add_text(actor:get_gold_tip(),0,110,200,30,16,'left')
            function actor:set_name(str)
                self.name = str 
                name:set_text(self:get_title())
                type:set_text(self:get_type_tip())
                gold:set_text(self:get_gold_tip())
                
            end 

            function button:on_button_mouse_enter()
                actor:set_size(1.3)
                actor:play_animation('attack')
                game.wait(2000,function ()
                    actor:play_animation('stand')
                end)
            end 
            function button:on_button_mouse_leave()
                actor:set_size(1)
            end 

            function button:on_button_clicked()
                local info = {
                    type = 'bar',
                    func_name = 'on_buy',
                    params = {
                        [1] = actor.slot_id,
                        [2] = ui.get_hash(actor.name), 
                    },
                }
                ui.send_message(info)
            end

            
        end 
       
        panel:set_relative_size(0.8)
        panel:set_position(350,220)
        panel:hide()
        return panel
    end,

    hide = function (self)
        class.panel.hide(self)
        for index,actor in ipairs(self.actors) do 
            actor:set_size(1)
        end 
    end,

    on_button_clicked = function (self,button)

        if button == self.close_button then 
            self:hide()
            game.wait(100,function ()
                self:remove_tooltip()
            end)
            --ac.player.self:play_sound([[Sound\Interface\MouseClick1.wav]])

        elseif button == self.lock_button then 
            if button.is_lock then 
                button:set_normal_image('image\\操作栏\\lock2.blp')
                button.is_lock = false 
                --ac.player.self:play_sound([[Sound\Interface\AutoCastButtonClick1.wav]])
            else 
                button:set_normal_image('image\\操作栏\\lock1.blp')
                button.is_lock = true  
                --ac.player.self:play_sound([[Sound\Interface\InGameChatWhat1.wav]])
            end 
            local info = {
                type = 'bar',
                func_name = 'on_lock',
                params = {
                    [1] = button.is_lock,
                },
            }
            ui.send_message(info)

        elseif button == self.rand_button then 
            local info = {
                type = 'bar',
                func_name = 'on_random',
            }
            ui.send_message(info)
        end     
        
    end,

    on_button_mouse_enter = function (self,button)
        if button == self.close_button then 
            button:tooltip("关闭","暂时关闭招募棋子面板,可以点击左上方的LOGO重新打开它",-1,nil,64)
        elseif button == self.lock_button then 
            button:tooltip("锁定","锁定状态:保留现有的招募棋子面板不被刷新。\n非锁定状态:招募棋子面板可以被刷新。",nil,nil,64)
        elseif button == self.rand_button then 
            local hero = ac.player.self:get_hero()
            if hero then 
                local skill = hero:find_skill('刷新商店','英雄')
                if skill then 
                    button:skill_tooltip(skill,1)
                end
            end
        end  
    end,
}

local action_bar = class.action_bar.create()

local select_panel = action_bar.select_panel

local player = ac.player.self
player.action_bar = action_bar
player.select_panel = select_panel

game_event.on_key_down = function (code)
    if code == KEY.F2 then 
        if select_panel.is_show then 
            select_panel:hide()
        else 
            select_panel:show()
        end 
    elseif code == KEY.ESC then 
        select_panel:hide()
    end 
end 

game.register_event(game_event)
