local mt = ac.skill['钥匙怪奖励']

mt{
    --必填
    is_skill = true,
    
    --等级
    level = 1,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,

	tip = [[]],
	--cd
	cool = 0,
	
}

--右击使用
function mt:on_cast_start()
    local hero = self.owner
    local player = self.owner:get_owner()
    hero = player.hero 
    -- print('使用了命运花')
    local rand_list = ac.unit_reward['钥匙怪']
    local rand_name = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name)
    if not rand_name then 
        return true
    end   

    local index = ac.creep['刷怪'].index > 0 and ac.creep['刷怪'].index or 1
    index = (index - 1) > 0 and (index - 1) or 1
    local data = ac.table.UnitData['进攻怪-'..index]
    local gold = math.ceil( (data.gold or 0) * 30  )
    local exp = math.ceil((data.exp or 0)  * 30 )

    if rand_name == '金币30' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 杀掉了钥匙怪, |cff00ffff奖励金币：'..gold..'|r',10)
        hero:addGold(gold)
    elseif  rand_name == '经验30' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 杀掉了钥匙怪, |cff00ffff奖励经验：'..exp..'|r',10)
        hero:addXp(exp)
    elseif  rand_name == '召唤boss' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 杀掉了钥匙怪, |cff00ffff奖励：召唤boss|r',10)
        hero:add_item('召唤boss',true)
    elseif  rand_name == '吞噬丹' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 杀掉了钥匙怪, |cff00ffff奖励：吞噬丹|r',10)
        hero:add_item('吞噬丹',true)
    elseif  rand_name == '杀怪全属性5' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 杀掉了钥匙怪, |cff00ffff杀怪 全属性+5 |r',10)
        hero:add('杀怪全属性',5)
    elseif  rand_name == '全属性加1000' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 杀掉了钥匙怪, |cff00ffff全属性加1000 |r',10)
        hero:add('力量',1000)
        hero:add('敏捷',1000)
        hero:add('智力',1000)
    elseif  rand_name == '全属性加10000' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 杀掉了钥匙怪, |cff00ffff全属性加10000 |r',10)
        hero:add('力量',10000)
        hero:add('敏捷',10000)
        hero:add('智力',10000)    
    elseif  rand_name == '护甲加50' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 杀掉了钥匙怪, |cff00ffff护甲加50 |r',10)
        hero:add('护甲',50)    
    elseif  rand_name == '杀怪力量10' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 杀掉了钥匙怪, |cff00ffff杀怪 力量+10 |r',10)
        hero:add('杀怪力量',10)
    elseif  rand_name == '杀怪敏捷10' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 杀掉了钥匙怪, |cff00ffff杀怪 敏捷+10 |r',10)
        hero:add('杀怪敏捷',10)
    elseif  rand_name == '杀怪智力10' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 杀掉了钥匙怪, |cff00ffff杀怪 智力+10 |r',10)
        hero:add('杀怪智力',10)
    end
   

end

function mt:on_remove()
   
end

-- 如果死亡的是钥匙怪的话
-- 按照玩家数 多产生掉落次数
ac.game:event '单位-死亡' (function (_,unit,killer)
    if unit:get_name() ~='钥匙怪' then
		return
    end
    local skill = killer:find_skill(mt.name) 
    if not skill then 
        skill = killer:add_skill(mt.name,'隐藏')
    end 
    skill:on_cast_start()

end)
