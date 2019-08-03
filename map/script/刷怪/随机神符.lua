local mt = ac.skill['随机神符']

mt{
--必填
is_skill = true,
--等级
level = 1,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
tip = [[
随机神符出现啦，赶紧去寻找。
]],
--cd
cool = 0,
--模型
_model = [[Objects\InventoryItems\runicobject\runicobject.mdl]],
--物品
item_type = '神符'
}

--创建
function mt:on_create()
    local hero = self.owner
    local region = ac.map.rects['武林大会']
    local point = ac.map.rects['武林大会']:get_random_point(true)
    -- print(self.item)
    -- if self.item then 
    --     self.item:item_remove() 
    -- end    
    -- self.item = 
    ac.item.create_item(self.name,point)
end	
--右击使用
function mt:on_cast_start()
    local hero = self.owner
    local player = self.owner:get_owner()
    if hero.unit_type == '宠物' or hero.unit_type == '召唤物' then 
        player:sendMsg('|cff00ffff宠物不能拾取|r',10)
        player:sendMsg('|cff00ffff宠物不能拾取|r',10)
        return true
    end    
    -- print('使用了命运花')
    local rand_list = ac.unit_reward['随机神符']
    local rand_name = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name)
    if not rand_name then 
        return true
    end   

    if rand_name == '无' then
    elseif  rand_name == '无敌' then
        ac.player.self:sendMsg('|cffffe799【系统消息】|r玩家 |cff00ffff'..player:get_name()..'|r 捡到'..rand_name..'神符, |cffdf19d0拥有无敌状态|r |cff00ff00持续3秒|r',6)
        hero:add_buff '无敌' {
            time = 3
        }
    elseif  rand_name == '治疗' then
        ac.player.self:sendMsg('|cffffe799【系统消息】|r玩家 |cff00ffff'..player:get_name()..'|r 捡到'..rand_name..'神符, |cffdf19d0瞬间满血|r',6)
        hero:heal
		{
			source = hero,
			skill = self,
			size = 10,
			heal = hero:get('生命上限'),
		}
    elseif  rand_name == '暴击' then
        ac.player.self:sendMsg('|cffffe799【系统消息】|r玩家 |cff00ffff'..player:get_name()..'|r 捡到'..rand_name..'神符, |cffdf19d0暴击/技暴几率翻倍|r |cff00ff00持续8秒|r',6)
        hero:add_buff '暴击'{
            time = 8,
            skill = self,
            source = hero,
            mul = 1,
        }
    elseif  rand_name == '攻击' then
        ac.player.self:sendMsg('|cffffe799【系统消息】|r玩家 |cff00ffff'..player:get_name()..'|r 捡到'..rand_name..'神符, |cffdf19d0攻击+1亿|r |cff00ff00持续8秒|r',6)
        hero:add_buff '攻击'{
            time = 8,
            skill = self,
            source = hero,
            value = 100000000, 
        }
    elseif  rand_name == '法术' then
        ac.player.self:sendMsg('|cffffe799【系统消息】|r玩家 |cff00ffff'..player:get_name()..'|r 捡到'..rand_name..'神符, |cffdf19d0技能伤害加深+100%|r |cff00ff00持续8秒|r',6)
        hero:add_buff '技能伤害加深'{
            time = 8,
            skill = self,
            source = hero,
            model =[[Abilities\Spells\Human\Brilliance\Brilliance.mdl]],
            ref = 'origin',
            value = 100, 
        }
    elseif  rand_name == '减甲' then
        ac.player.self:sendMsg('|cffffe799【系统消息】|r玩家 |cff00ffff'..player:get_name()..'|r 捡到'..rand_name..'神符, |cffdf19d0减少周围护甲+5000|r |cff00ff00持续8秒|r',6)
        hero:add_buff '减甲神符'{
            time = 8,
            skill = self,
            source = hero,
            value = 5000, 
        }
    elseif  rand_name == '中毒' then
        ac.player.self:sendMsg('|cffffe799【系统消息】|r玩家 |cff00ffff'..player:get_name()..'|r 捡到'..rand_name..'神符, |cffdf19d0生命-50%|r',6)
        hero:damage{
            source = hero,
            damage = hero:get('生命')*0.5,
            skill = self,
            real_damage = true
        }
    elseif  rand_name == '沉默' then
        ac.player.self:sendMsg('|cffffe799【系统消息】|r玩家 |cff00ffff'..player:get_name()..'|r 捡到'..rand_name..'神符, |cffdf19d0拥有沉默状态|r |cff00ff00持续5秒|r',6)
        hero:add_buff '沉默'{
            time = 5,
            skill = self,
            source = hero
        }
    elseif  rand_name == '定身' then
        ac.player.self:sendMsg('|cffffe799【系统消息】|r玩家 |cff00ffff'..player:get_name()..'|r 捡到'..rand_name..'神符, |cffdf19d0拥有定身状态|r |cff00ff00持续3秒|r',6)
        hero:add_buff '定身'{
            time = 3,
            skill = self,
            model =[[Abilities\Spells\NightElf\EntanglingRoots\EntanglingRootsTarget.mdl]],
            ref = 'origin',
            source = hero
        }
    end

end

function mt:on_remove()
    -- print('进行移除')
    if self.item then 
        -- self.item:item_remove()
        self.item = nil
    end     
end



ac.game:event '游戏-回合开始'(function(trg,index, creep) 
    if creep.name ~= '刷怪' then
        return
    end    
    print('回合开始2')
end)

local looper 
local time = 15
ac.game:event '武林大会-开始' (function()

    --回合开始时，创建命运花
    if not looper then 
        looper = ac.loop(time*1000,function() 
            mt:on_create()
        end) 
    end    



end)    
ac.game:event '武林大会-结束' (function()
    if looper then 
        looper:remove()
        looper = nil
    end    
end)    