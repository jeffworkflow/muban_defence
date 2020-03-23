
local mt = ac.skill['觅瓜乐开怀']
mt{
--等久
level = 1,
--图标
art = [[nanguazhongzi.blp]],
--说明
tip = [[ 
|cffffe799【活动时间】|r|cff00ff003月26日-4月5日
|cffffe799【活动说明】|r|cff00ff00沙瓜盛典普天同庆！从天而降的沙瓜种子散落在三界各地，玩家可以在活动期间，通过|cff00ffff各个途径|r|cff00ff00来获得|cff00ffff “沙瓜种子” |r|cff00ff00，完成任务获得丰厚奖励！
 ]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 1,
--物品技能
is_skill = true,
store_affix = '',
store_name = '|cffdf19d0觅瓜乐开怀|r',
--物品详细介绍的title
content_tip = ''
}

--奖品
local award_list = { 
    ['四月沙瓜'] =  {
        { rand = 4, name = '金'},
        { rand = 4, name = '红'},
        { rand = 4, name = '随机技能书'},
        { rand = 4, name = '点金石'},
        { rand = 4, name = '恶魔果实'},
        { rand = 4, name = '吞噬丹'},
        { rand = 4, name = '格里芬'},
        { rand = 4, name = '黑暗项链'},
        { rand = 4, name = '最强生物心脏'},
        { rand = 4, name = '白胡子的大刀'},
        { rand = 4, name = '四月沙瓜'},
        { rand = 56, name = '无'},
    },
}
--掉落在地上
local function give_award(hero,unit) 
    local p = hero:get_owner()
    local player = hero:get_owner()
    local peon = p.peon
    local rand_list = award_list['四月沙瓜']
    local rand_name,rand_rate = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name)  
    if not rand_name then 
        return true
    end


    if rand_name == '无' then
        p:sendMsg('|cffffe799【系统消息】|r |cff00ff00沙瓜被拾取后，只见天空中出现了八个大字：|cffffff00沙瓜盛典普天同庆|cff00ff00!',3) 

    elseif  finds(rand_name,'格里芬','黑暗项链','最强生物心脏','白胡子的大刀') then
        --满时，掉在地上
        if unit then 
            ac.item.create_item(rand_name,unit:get_point())
        else 
            hero:add_item(rand_name,true)
        end        
        ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ff00沙瓜被拾取后，一道绚丽的光芒闪过，好像掉落了什么，仔细一看是|cffff0000'..rand_name..'|r',4) 
    elseif  finds('红 金',rand_name) then   
        local list = ac.quality_item[rand_name]
        local name = list[math.random(#list)]
        --满时，掉在地上
        local it 
        if unit then  
            it = ac.item.create_item(name,unit:get_point())
        else 
            it = hero:add_item(name,true)
        end      
        p:sendMsg('|cffffe799【系统消息】|r |cff00ff00沙瓜被拾取后，一道绚丽的光芒闪过，好像掉落了什么，仔细一看是|cffff0000'..it.color_name..'|r',4)
    elseif finds(rand_name,'点金石','恶魔果实','吞噬丹')  then
        --满时，掉在地上
        local it 
        if unit then  
            it = ac.item.create_item(rand_name,unit:get_point())
        else 
            it = hero:add_item(rand_name,true)
        end  
        p:sendMsg('|cffffe799【系统消息】|r |cff00ff00沙瓜被拾取后，一道绚丽的光芒闪过，好像掉落了什么，仔细一看是|cffff0000'..rand_name..'|r',4)
    elseif finds(rand_name,'随机技能书')  then    
        local rand_list = ac.unit_reward['商店随机技能']
        local rand_name = ac.get_reward_name(rand_list)
        if not rand_name then 
            return
        end    
        local list = ac.skill_list2
        --添加给购买者
        local name = list[math.random(#list)]
        local it 
        if unit then  
            ac.item.create_skill_item(name,unit:get_point())
        else 
            ac.item.add_skill_item(name,hero)
        end  
        p:sendMsg('|cffffe799【系统消息】|r |cff00ff00沙瓜被拾取后，一道绚丽的光芒闪过，好像掉落了什么，仔细一看是|cffff0000'..name..'|r',4)
    elseif  rand_name == '四月沙瓜' then 
        local key = ac.server.name2key(rand_name)
        if p:Map_GetServerValue(key) < ac.skill[rand_name].max_level  then 
            --激活成就（存档） 
            p:Map_AddServerValue(key,1) --网易服务器
            --动态插入魔法书
            local skl = hero:find_skill(rand_name,nil,true) 
            if not skl  then 
                ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',rand_name)
                ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r摘了一个沙瓜，这个绝对不是普通的沙瓜，惊喜获得|cffff0000【可存档成就】'..rand_name..'|r，成就属性可在“巅峰神域-精彩活动”中查看',6) 
            else
                --有魔法书的情况下，升级
                skl:upgrade(1)
                p:sendMsg('|cffff0000【可存档成就】'..rand_name..'+1',6) 
            end   
        else   
            --重新来一次
            give_award(hero,nil)
        end    
    end    


end

local mt = ac.skill['沙瓜']
mt{
    --等久
    level = 1,
    --图标
    art = [[nanguazhongzi.blp]],
    --说明
    tip = [[


|cff00ffff在春天，埋下一颗沙瓜种子；在秋天，收获各种各样的沙瓜！

|cffcccccc愚人节活动物品|r]],
    --品质
    color = '紫',
    --物品类型
    item_type = '神符',
    specail_model = [[Pumpkin.mdx]],
    model_size = 2.5,
    
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --物品详细介绍的title
    content_tip = '|cffffe799使用说明：|r'
}
function mt:on_cast_start()
    local hero = self.owner 
    local p = hero:get_owner()
    local player = hero:get_owner()
    give_award(hero)

end   


local mt = ac.skill['沙瓜种子']
mt{
--等久
level = 1,
--图标
art = [[nanguazhongzi.blp]],
--说明
tip = [[


|cff00ffff在春天，埋下一颗沙瓜种子；在秋天，收获各种各样的沙瓜！

|cffcccccc愚人节活动物品|r]],
--品质
color = '紫',
--物品类型
item_type = '消耗品',
--目标类型
target_type = ac.skill.TARGET_TYPE_POINT,
--施法距离
range = 1000,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}
function mt:on_cast_start()
    local hero = self.owner 
    local p = hero:get_owner()
    local player = hero:get_owner()
    local u = p:create_unit('沙瓜',self.target)
    u:set('生命',1)
    u:add_restriction('无敌')
    --动画
    local time = 10
    u:add_buff '缩放' {
		time = time,
		origin_size = 0.1,
		target_size = 1.2,
    }
    ac.wait((time+1)*1000,function()
        --创建蟠桃
        ac.item.create_item('沙瓜',u:get_point())
        --移除桃树
        u:remove()
    
    end)
end   




--获得事件
--[[沙瓜种子的获得途经：
1.神奇的5分钟，游戏开始5分钟，给每个玩家发放一个沙瓜种子，系统提示：华诞盛典普天同庆！XXXXX
2.每隔8分钟，基地区域随机生成一个沙瓜种子(一局12个)
3.打伏地魔获得35%概率掉落，每局限5个
4.挖宝0.75%概率触发，掉落5-10个随机沙瓜种子，每局限一次（参考碎片幼儿园），系统提示：华诞盛典普天同庆！XXXXX
]]
local function give_seed()
    for i=1,6 do 
        local p= ac.player(i)
        if p:is_player() then 
            if p.hero then 
                p.hero:add_item('沙瓜种子',true)
            end
        end
    end
end    
ac.game:event '游戏-开始'(function()
    --1.每5分钟给一个
    local time = 5*60
    -- local time = 5*1
    ac.wait(time*1000,function()
        give_seed()
        ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00盛世耀华夏，神州共欢腾！百花仙子大发慈悲，给所有玩家发放了一枚|cffff0000沙瓜种子|r',5) 
    end)
    
    --2.每8分钟随机创建一个在地上
    local time = 8*60
    -- local time = 8*1
    ac.loop(time*1000,function()
        local point = ac.map.rects['藏宝区']:get_random_point()
        ac.item.create_item('沙瓜种子',point)
    end)
end)

--3.打伏地魔获得35%概率掉落，每局限5个
ac.game:event '单位-死亡'(function(_,unit,killer)
    if not finds([[陨落心炎boss 武器boss9]],unit:get_name())  then 
        return 
    end
    --概率  
    local rate = 35 
    local max_cnt = 5 --每人一局最大掉落次数
    local p= killer:get_owner()
    if unit:is_ally(killer) then
        return
    end
    p.kill_srm_guoshi = (p.kill_srm_guoshi or 0) 
    if p.kill_srm_guoshi < max_cnt and math.random(100) <= rate then 
        ac.item.create_item('沙瓜种子',unit:get_point())
        p.kill_srm_guoshi = (p.kill_srm_guoshi or 0) + 1  
    end    
end)

--4.挖宝0.75%概率触发，掉落5-10个随机沙瓜种子，每局限一次（参考碎片幼儿园），系统提示：华诞盛典普天同庆！XXXXX
local temp = {'沙瓜种子'}
ac.game:event '挖图成功'(function(trg,hero)
    local p = hero:get_owner()
    local rate = 0.75
    -- local rate = 10 --测试
    if math.random(10000)/100 <= rate then 
        if not ac.flag_ptzj then 
            ac.func_give_suipian(hero:get_point(),temp)
            ac.flag_ptzj = true 
            ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..p:get_name()..'|r 在挖宝时挖塌了|cffff0000种子幼儿园|r，一大堆种子散落|cffff0000老家周围|r，大家快去抢啊|r',5)    
        end    
    end    
end)

ac.game:event '玩家-聊天' (function(self, player, str)
    local hero = player.hero
	local p = player
    local peon = player.peon
    if str =='种子' and not p.flag_zz then 
        p.flag_zz = true
        hero:add_item('沙瓜种子')
        p:sendMsg('|cffffe799【系统消息】|r |cff00ff00上帝听到了你的呼唤，给你发放了一个|cffff0000沙瓜种子|r',4)
    end
end)
