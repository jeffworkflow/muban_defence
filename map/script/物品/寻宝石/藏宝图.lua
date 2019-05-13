local mt = ac.skill['藏宝图']

mt{
    --等久
    level = 1,
    
    --图标
    art = [[other\cangbaotu.blp]],
    
    --说明
    tip = [[到指定地点，挖开即可得 |cffdf19d0 各种物品哦 |r

    PS：获得的金币、经验，受英雄的|cffdf19d0金币获取率、经验获取率|r影响！]],
    
    --物品类型
    item_type = '消耗品',
    
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    
    --物品技能
    is_skill = true,
    --挖图范围
    area = 500,

    --售价
    gold = 250,
    --cd
    cool = 2.5,
    --物品详细介绍的title
    content_tip = '使用说明：',
    --自动挖宝
    wabao_auto_use = false,
    
}
    
function mt:on_add()
    --全图随机刷 正式用
    self.random_point =  ac.map.rects['刷怪']:get_point()
    --测试用
    -- self.random_point = self.owner:get_point()
end

function mt:on_cast_start()
    local hero = self.owner
    local player = hero:get_owner()
    local item = self 
    local list = {}
    --需要先增加一个，否则消耗品点击则无条件先消耗
    self:add_item_count(1) 

    if hero.wabao_auto then 
        self.wabao_auto_use = true
    else
        self.wabao_auto_use = false
    end    

    local tx,ty = self.random_point:get()
    local rect = ac.rect.create( tx - self.area/2, ty-self.area/2, tx + self.area/2, ty + self.area/2)
    local region = ac.region.create(rect)
    local point = hero:get_point()

    --自动寻宝
    if self.wabao_auto_use then 
        --区域修改
        rect = ac.rect.create( tx - 32, ty-32, tx + 32, ty + 32)
        region = ac.region.create(rect)
        if not self.trg then 
            self.trg = region:event '区域-进入' (function(trg, unit)
                if  unit == hero then
                    if hero.unit_type == '宠物' or hero.unit_type == '召唤物' then 
                        player:sendMsg('|cff00ffff宠物不能挖图|r',10)
                        player:sendMsg('|cff00ffff宠物不能挖图|r',10)
                        return true
                    end 
                    -- print('单位进入')
                    self:on_add() 
                    --添加东西给英雄
                    self:add_content()  
                    self:add_item_count(-1) 
                    self.trg:remove()
                    self.trg = nil
                    
                    if self:get_item_count()>= 1 then 
                        --模拟消耗品使用
                        self:on_cast_start()
                        self:add_item_count(-1) 
                    end  
                end
            end)
        end    
        ac.wait(500,function()
            hero:issue_order('move',self.random_point)
        end)
        player:pingMinimap(self.random_point, 3)
    else      
        --点在区域内
        if region < point  then
            if hero.unit_type == '宠物' or hero.unit_type == '召唤物' then 
                player:sendMsg('|cff00ffff宠物不能挖图|r',10)
                player:sendMsg('|cff00ffff宠物不能挖图|r',10)
                return true
            end    

            self:add_item_count(-1) 
            self:on_add() 
            --添加东西给英雄
            self:add_content()
        else
            player:pingMinimap(self.random_point, 3)
        end 
    end       
end    

function mt:add_content()
    
    local hero = self.owner
    local player = self.owner:get_owner()
    hero = player.hero 
    -- print('使用了命运花')
    local rand_list = ac.unit_reward['藏宝图']
    local rand_name = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name)
    if not rand_name then 
        return true
    end  
    local index 
    local data
    local gold
    local exp
    if ac.creep['刷怪-无尽'].index >= 1 then 
        gold = 0
        exp = 0
    else
        index = ac.creep['刷怪'].index > 0 and ac.creep['刷怪'].index or 1
        index = (index - 1) > 0 and (index - 1) or 1

        data = ac.table.UnitData['进攻怪-'..index]
        gold = math.ceil( (data.gold or 0) * 10 * (1 + hero:get('金币加成')/100))
        exp = math.ceil((data.exp or 0)  * 10 * (1 + hero:get('经验加成')/100))
    end
    
    if rand_name == '无' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 挖了|cff00ffff藏宝图|r, |cffff0000什么事都没发生|r',10)

        -- 概率小于等于5 且 没有挖宝达人，设置为挖宝达人
        local rate = 5 
        if math.random(1,100)<=rate and not ac.flag_wabao  then 
            -- ac.flag_wabao = player
            -- player.flag_wabao = true
            player.is_show_nickname = '(挖宝达人)'
            local hero = player.hero
            hero:addGold(88888)
            hero:addXp(88888)
            --给全部玩家发送消息
            ac.player.self:sendMsg("【系统提示】玩家 |cffff0000"..player:get_name()..'|r 经常|cff00ffff挖图失败|r,获得称号|cffff0000"挖宝达人" |r，一次性奖励 |cffff0000金币88888，经验88888|r',10)
            ac.player.self:sendMsg("【系统提示】玩家 |cffff0000"..player:get_name()..'|r 经常|cff00ffff挖图失败|r,获得称号|cffff0000"挖宝达人" |r，一次性奖励 |cffff0000金币88888，经验88888|r',10)
        end

    elseif rand_name == '金币10' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 挖了|cff00ffff藏宝图|r, |cffff0000奖励金币：'..gold..'|r',10)
        hero:addGold(gold)
    elseif  rand_name == '经验10' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 挖了|cff00ffff藏宝图|r, |cffff0000奖励经验：'..exp..'|r',10)
        hero:addXp(exp)
    elseif  rand_name == '随机物品' then
        --给英雄随机添加物品
        local name = ac.all_item[math.random( 1,#ac.all_item)]
        --满时，掉在地上
        hero:add_item(name,true)
        local lni_color ='白'
        if  ac.table.ItemData[name] and ac.table.ItemData[name].color then 
            lni_color = ac.table.ItemData[name].color
        end    
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 挖了|cff00ffff藏宝图|r, 奖励：|cff'..ac.color_code[lni_color]..name..'|r',10)
    elseif  rand_name == '随机技能' then
       --给英雄随机添加物品
        local rand_list = ac.unit_reward['商店随机技能']
        local rand_name = ac.get_reward_name(rand_list)
        if not rand_name then 
            return
        end    
        -- skill_list2 英雄技能库
        local list = ac.skill_list2
        --添加给英雄
        local name = list[math.random(#list)]
        ac.item.add_skill_item(name,hero)
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 挖了|cff00ffff藏宝图|r, |cffff0000奖励 技能书：'..name..'|r',10)
    elseif  rand_name == '召唤练功怪' then
        hero:add_item('召唤练功怪',true)
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 挖了|cff00ffff藏宝图|r, |cffff0000奖励：召唤练功怪|r',10)
    elseif  rand_name == '召唤boss' then
        hero:add_item('召唤boss',true)
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 挖了|cff00ffff藏宝图|r, |cffff0000奖励：召唤boss|r',10)
    elseif  rand_name == '吞噬丹' then
        hero:add_item('吞噬丹',true)
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 挖了|cff00ffff藏宝图|r, |cffff0000奖励：吞噬丹|r',10)
    elseif  rand_name == '杀怪全属性5' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 挖了|cff00ffff藏宝图|r, |cffff0000杀怪 全属性+5 |r',10)
        hero:add('杀怪全属性',5)
    elseif  rand_name == '全属性加1000' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 挖了|cff00ffff藏宝图|r, |cffff0000全属性加1000 |r',10)
        hero:add('力量',1000)
        hero:add('敏捷',1000)
        hero:add('智力',1000)
    elseif  rand_name == '全属性加10000' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 挖了|cff00ffff藏宝图|r, |cffff0000全属性加10000 |r',10)
        hero:add('力量',10000)
        hero:add('敏捷',10000)
        hero:add('智力',10000)    
    elseif  rand_name == '护甲加50' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 挖了|cff00ffff藏宝图|r, |cffff0000护甲加25 |r',10)
        hero:add('护甲',25)    
    elseif  rand_name == '杀怪力量5' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 挖了|cff00ffff藏宝图|r, |cffff0000杀怪 力量+5 |r',10)
        hero:add('杀怪力量',5)
    elseif  rand_name == '杀怪敏捷5' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 挖了|cff00ffff藏宝图|r, |cffff0000杀怪 敏捷+5 |r',10)
        hero:add('杀怪敏捷',5)
    elseif  rand_name == '杀怪智力5' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 挖了|cff00ffff藏宝图|r, |cffff0000杀怪 智力+5 |r',10)
        hero:add('杀怪智力',5)
    elseif  rand_name == '通关积分100' then
        local value =   100 * ((hero:get '积分加成' or 0) + 1)
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 挖了|cff00ffff藏宝图|r, |cffff0000 通关积分+'..value..' |r',10)
        if ac.jiami then 
            ac.jiami(player,'jifen',(value or 0))
        end  
    elseif rand_name == '十连挖' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 挖了|cff00ffff藏宝图|r, |cffff0000 十连挖 |r',10)
        if not player.flag_shilianwan then 
            player.flag_shilianwan = true
            --添加东西给英雄
            for i=1,10 do 
                self:add_content()
            end   
            player.flag_shilianwan = false 
        end    
    end
   

end

function mt:on_remove()
    local hero = self.owner
    if self.trg then 
        self.trg:remove()
        self.trg = nil
    end    
end