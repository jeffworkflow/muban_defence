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

--无尽怪物改变所有属性
local base_attr = {
    ['攻击'] = 1000000000,
    ['护甲'] = 45000,
    ['魔抗'] = 45000,
    ['生命上限'] = 2800000000,
    ['魔法上限'] = 1000000,
    ['移动速度'] = 519,
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
local function change_attr(unit,index,factor)

    --设置搜敌范围 因子
    unit:set_search_range(1000)
    local point = ac.map.rects['主城']:get_point()
    unit:issue_order('attack',point)

    local degree_attr_mul = ac.get_difficult(ac.g_game_degree_attr)
    local endless_attr_mul = ac.get_difficult(index,1.15)
    local boss_mul = factor or 1
    -- print('难度系数',degree_attr_mul)
    -- print('无尽系数',endless_attr_mul)
    --设置属性
    for key,value in sortpairs(base_attr) do 
        if finds('攻击 护甲 魔抗 生命上限 暴击加深',key) then 
            unit:set(key, value * degree_attr_mul * endless_attr_mul*boss_mul)
        else
            unit:set(key, value)
        end    
    end    
    -- unit:set('移动速度', base_attr['移动速度'] + index*10) 
    if unit:get_name() =='毁灭者' then 
        unit:set('攻击减甲',0)
    end    
    

    --掉落概率
    unit.fall_rate = 0
    --掉落金币和经验
    unit.gold = 0
    unit.exp = 467

    --难度 12 （斗破苍穹） 增加技能
    if ac.rand_skill_name then 
        unit:add_skill(ac.rand_skill_name,'隐藏')
    end    
end    

ac.change_attr = change_attr


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
        -- self.creeps_datas = '火凤凰*20'
        self:set_creeps_datas()
        --难度 12 （斗破苍穹） 增加技能
        if ac.rand_skill_name then 
            ac.player.self:sendMsg('本波怪物特性： '..ac.rand_skill_name)
        end   
    end
    --改变怪物
    function mt:on_change_creep(unit,lni_data)
        change_attr(unit,self.index)
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
    end   

end    



--无尽技能
ac.game:event '游戏-回合开始'(function(trg,index, creep) 
    if creep.name ~= '刷怪-无尽1' then
        return
    end    
    if ac.g_game_degree_attr >=12 then 
        ac.rand_skill_name = ac.skill_list[math.random(#ac.skill_list)]  
    end    
end)

--注册boss进攻事件
ac.game:event '游戏-回合开始'(function(trg,index, creep) 
    if creep.name ~= '刷怪-无尽1' then
        return
    end    
    if ac.g_game_degree_attr <=12 then 
        return 
    end    
    --取余数
    -- local value = ac.creep['刷怪-无尽1'].index % 5
    -- if value == 0 then 
    local point = ac.map.rects['进攻点']:get_point()
    --最后一波时，发布最终波数
    local boss = ac.player.com[2]:create_unit(ac.attack_boss[math.random(#ac.attack_boss)],point)
    boss.unit_type = '精英'
    change_attr(boss,creep.index,1.5) --普通怪倍数

    boss:add_buff '攻击英雄' {}
    boss:add_skill('无敌','英雄')
    boss:add_skill('撕裂大地','英雄')
    boss:add_skill('酒桶','英雄')
    
    -- boss:add('免伤',1.5 * ac.get_difficult(ac.g_game_degree_attr))
    -- boss:add('物理伤害加深',1.45 * ac.get_difficult(ac.g_game_degree_attr))
    -- end    
end)    

ac.game:event '游戏-无尽开始'(function(trg) 
    --删除商店
    local del_shop = [[练功师]]
    for key,unit in pairs(ac.shop.unit_list) do 
		if finds(del_shop,unit:get_name()) then 
			unit:remove()
		end	
    end	
    
    -- --练功房 自动刷怪停止
    for i=1,10 do 
        local p = ac.player(i)
        if p:is_player() then 
            p.current_creep = nil  
        end
    end     

    -- 关闭所有刷怪并清除怪物
    for name,crep in  pairs(ac.all_creep) do 
        if crep and crep.has_started then 
            crep:finish(true)
        end    
    end    
    -- 野怪刷新开关 ，true 关闭,清理所有场上敌对怪物
    ac.flag_endless = true 
    for key,unit in pairs(ac.unit.all_units) do 
		if unit:is_alive() and unit.category =='进攻怪' then 
			unit:remove()
		end	
    end	

    --无尽后，地上技能120秒自动消失
    local mt = ac.skill['学习技能']
    mt.time_removed = 120 --自动消失时间
    local t_time = 30 --倒计时

    ac.wait(5*1000,function()
        ac.player.self:sendMsg('|cffff0000'..mt.time_removed..'秒|r后，清理地上技能',10)
        --倒计时清理地上技能
        ac.wait((mt.time_removed-t_time)*1000,function()
            ac.timer(1*1000,t_time,function(t)
                t_time = t_time -1
                ac.player.self:sendMsg('|cffff0000'..t_time..'秒|r后，清理地上技能',2)
                if t_time <= 0 then 
                    --开始清理
                    for _,v in pairs(ac.item.item_map) do
                        if not v.owner and v.cus_type =='技能' then 
                            v:item_remove()
                        end
                    end    
                end    
            end)
        end)
    end)
    
    --游戏开始后 刷怪时间  
    local time = force_cool
    BJDebugMsg("|cffffe799【系统消息】|r|cffff0000无尽挑战开始|r |cff00ffff 第一波妖怪 |r|cff00ff00在".. time .. "秒后开始进攻！|r|cffff0000(部分精英怪对所有真伤型技能免疫)",10)
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

    --特殊处理卡怪问题
    ac.loop(1000,function(t)
        for i=1,3 do 
            local crep = ac.creep['刷怪-无尽'..i]
            for i,u in ipairs(crep.group) do 
                if u:is_in_range(ac.point(0,0),500) then 
                    print(u:get_name(),'是否活着：',u:is_alive(),u:get_point())
                    u:kill()
                end	
            end	
        end	
    end)   

end)    
