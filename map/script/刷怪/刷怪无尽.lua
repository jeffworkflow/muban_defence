-- 顺序： 加载脚本 → 选择难度 → 注册英雄 → 游戏-开始 → 开始刷兵
-- 规则：
-- 3分钟一波，25波=75分钟，10分钟可以减3分钟，一局最多75+21=96分钟
-- 每5波一只挑战boss，额外出。
-- ac.special_boss = {
-- '挑战怪10','挑战怪20','挑战怪30','挑战怪40','挑战怪50','挑战怪60','挑战怪70','挑战怪80','挑战怪90','挑战怪100'
-- }
-- ac.attack_unit = {
--     '民兵','甲虫','镰刀手','剪刀手','狗头人','步兵','长牙兽','骷髅战士','巨魔','食人鬼战士','骑士',
--     '牛头人','混沌骑士','屠夫','德鲁伊','娜迦暴徒','龙卵领主','潮汐','血恶魔','火凤凰','九头怪','黑龙',
--     '蜥蜴领主','地狱火','末日'
-- }
-- ac.attack_boss = {
--     '肉山','梦魇','戈登的激情','焰皇','毁灭者'
-- }  
local force_cool = 60
if global_test then 
    force_cool = 60
end    
local skill_list = ac.skill_list
for i =1,3 do 
    local mt = ac.creep['刷怪-无尽'..i]{    
        region = 'cg'..i,
        creeps_datas = '',
        force_cool = force_cool,
        creep_player = ac.player.com[2],
        create_unit_cool = 0.5,
        -- tip ="|cffff0000怪物开始进攻！！！|r"

    }
    --进攻怪刷新时的初始化
    function mt:on_start()
        local rect = require 'types.rect'
        if i == 1 then 
            self.timer_ex_title ='（无尽）距离 第'..(self.index+2)..'波 怪物进攻'
         end   
    end

    function mt:on_next()
        if i == 1 then 
           self.timer_ex_title ='（无尽）距离 第'..(self.index+2)..'波 怪物进攻'
        end   
        --进攻提示
        if self.name =='刷怪-无尽1' then
            local panel = class.screen_animation.get_instance()
            if panel then panel:up_jingong_title(' 第 '..self.index..' 波 （无尽）') end
        end    
        --小地图ping
        ac.player.self:pingMinimap(self.region,3,255,0,0)
        ac.player.self:pingMinimap(self.region,3,255,0,0)
        -- if ac.ui then ac.ui.kzt.up_jingong_title(' 第 '..self.index..' 波 ') end

        ac.player.self:sendMsg("|cffff0000 （无尽） 第"..self.index.."波 怪物开始进攻！！！|r",5)
        -- local index = self.index
        self.creeps_datas = ac.attack_unit[math.random(#ac.attack_unit)]..'*20'
        self:set_creeps_datas()

    end

    --改变怪物
    function mt:on_change_creep(unit,lni_data)
        --设置搜敌范围
        unit:set_search_range(1000)
        local point = ac.map.rects['主城']:get_point()
        unit:issue_order('attack',point)

        --无尽怪物改变所有属性
        local base_attr = {
            ['攻击'] = 1000000000,
            ['护甲'] = 45000,
            ['魔抗'] = 45000,
            ['生命上限'] = 2800000000,
            ['魔法上限'] = 1000000,
            ['移动速度'] = 470,
            ['攻击间隔'] = 0.75,
            ['生命恢复'] = 281902,
            ['魔法恢复'] = 10000,
            ['攻击距离'] = 200,
            ['攻击速度'] = 300,
            ['暴击几率'] = 20,
            ['暴击加深'] = 20000,
            ['会心几率'] = 20,
            ['会心伤害'] = 200,
        }
        local degree_attr_mul = ac.get_difficult(ac.g_game_degree)
        local endless_attr_mul = ac.get_difficult(self.index,1.15)
        -- print('难度系数',degree_attr_mul)
        -- print('无尽系数',endless_attr_mul)
        --设置属性
        
        for key,value in sortpairs(base_attr) do 
            if finds('攻击 护甲 魔抗 生命上限 暴击加深',key) then 
                -- print(key)
                unit:set(key, value * degree_attr_mul * endless_attr_mul )
            end    
        end     

        --掉落概率
        unit.fall_rate = 0
        --掉落金币和经验
        unit.gold = 0
        unit.exp = 467


    end
    --每3秒刷新一次攻击目标 原地不动才发起攻击
    function mt:attack_hero() 
        self.attack_hero_timer = ac.loop(3 * 1000 ,function ()
            -- print('野怪区的怪数量',#mt.group)
            local point = ac.map.rects['主城']:get_point()
            for _, unit in ipairs(self.group) do
                if unit:is_alive() then 
                    if unit.last_point then 
                        local distance =  unit.last_point * unit:get_point()
                        local hero = ac.find_hero(unit)
                        local hero_distance = 0
                        if hero then 
                            hero_distance = hero:get_point() * unit:get_point()
                        end    
                        if hero_distance <= 10 then
                            --1500码内，优先攻击英雄，英雄死亡则攻向基地点
                            unit:issue_order('attack',point)
                        elseif hero_distance <= 1500  then
                            unit:issue_order('attack',hero)
                        else    
                            unit:issue_order('attack',point)
                        end      
                    end  
                    unit.last_point = unit:get_point()
                end   
            end 
        end) 
        self.attack_hero_timer:on_timer()
    end    

    --刷怪结束
    function mt:on_finish()  
        if self.key_unit_trg then 
            self.key_unit_trg:remove()
        end    
        if self.mode_timer then 
            self.mode_timer:remove()
        end    
        if self.attack_hero_timer then 
            self.attack_hero_timer:remove()
        end  
        -- ac.game:event_dispatch('游戏-最终boss',self.index,self)
    end   
end    






--注册boss进攻事件
-- ac.game:event '游戏-回合开始'(function(trg,index, creep) 
--     if creep.name ~= '刷怪-无尽1' then
--         return
--     end    
--     --取余数
--     local value = ac.creep['刷怪-无尽1'].index % 5
--     if value == 0 then 
--         local point = ac.map.rects['进攻点']:get_point()
--         --最后一波时，发布最终波数
--         local boss = ac.player.com[2]:create_unit(ac.attack_boss[math.random(#ac.attack_boss)],point)
--         -- table.insert(ac.creep['刷怪-无尽1'].group,boss)
--         boss:add_buff '攻击英雄' {}
--         boss:add_skill('无敌','英雄')
--         boss:add_skill('撕裂大地','英雄')

--         boss:add('免伤',1.5 * ac.get_difficult(ac.g_game_degree))
--         boss:add('物理伤害加深',1.45 * ac.get_difficult(ac.g_game_degree))
--     end    
-- end)    

ac.game:event '游戏-无尽开始'(function(trg) 
    --删除商店
    -- local del_shop = [[练功师 异火 技能商店 新手任务]]
    -- for key,unit in pairs(ac.shop.unit_list) do 
	-- 	if finds(del_shop,unit:get_name()) then 
	-- 		unit:remove()
	-- 	end	
    -- end	
    
    -- --练功房 自动刷怪停止
    -- for i=1,10 do 
    --     local p = ac.player(i)
    --     if p:is_player() then 
    --         p.current_creep = nil  
    --     end
    -- end     

    -- 野怪刷新开关 ，true 关闭
    -- ac.flag_endless = true 
    
    --游戏开始后 刷怪时间  
    local time = force_cool
    BJDebugMsg("|cffffe799【系统消息】|r|cffff0000无尽挑战开始|r |cff00ffff 第一波修罗怪物 |r|cff00ff00在".. time .. "秒后开始进攻！",10)
    ac.timer_ex 
    {
        time = time,
        title = "（无尽）距离第一波怪物进攻",
        func = function ()
            --开始进行无尽刷怪
            for i=1 ,3 do 
                local creep = ac.creep['刷怪-无尽'..i] 
                creep:start()
                creep:attack_hero() 
            end  
        end,
    }

end)    
