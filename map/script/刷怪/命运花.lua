local mt = ac.skill['命运花']

mt{
    --必填
    is_skill = true,
    
    --等级
    level = 1,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,

	tip = [[
命运花出现啦，赶紧去寻找。
	]],
	--cd
	cool = 0,
	--模型
    _model = [[Objects\InventoryItems\Shimmerweed\Shimmerweed.mdl]],
    --物品
    item_type = '神符'
	
}

--创建
function mt:on_create()
    local hero = self.owner
    local region = ac.map.rects['刷怪']
    local point = region:get_point()
    -- print(self.item)
    if self.item then 
        self.item:item_remove() 
    end    
    self.item = ac.item.create_item(self.name,point)
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
    local rand_list = ac.unit_reward['命运花']
    local rand_name = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name)
    if not rand_name then 
        return true
    end   

    if rand_name == '无' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 拾取了命运花, |cff00ffff什么事都没发生|r',10)
        local rate = 15 
        if math.random(1,100)<=rate and not ac.flag_mingyunhua  then 
            ac.flag_mingyunhua = player
            player.flag_mingyunhua = true
            player.is_show_nickname = '(采花大盗)'
            local hero = player.hero
            hero:add('闪避',30)
            hero:add('攻击间隔',-0.15)
            --给全部玩家发送消息
            ac.player.self:sendMsg("【系统提示】玩家 |cffff0000"..player:get_name()..'|r 经常|cff00ffff拾取命运花|r,获得唯一称号|cffff0000"采花大盗" |r，奖励: |cffff0000闪避+30，攻击间隔-0.15|r',10)
            ac.player.self:sendMsg("【系统提示】玩家 |cffff0000"..player:get_name()..'|r 经常|cff00ffff拾取命运花|r,获得唯一称号|cffff0000"采花大盗" |r，奖励: |cffff0000闪避+30，攻击间隔-0.15|r',10)
        end
    elseif  rand_name == '中毒' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 拾取了命运花, |cff00ffff中毒，当前生命-50% |r',10)
        hero:damage{
            source = hero,
            damage = hero:get('生命')*0.5,
            skill = self,
            real_damage = true
        }
    elseif  rand_name == '沉默' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 拾取了命运花, |cff00ffff沉默，无法使用法术，持续10s |r',10)
        hero:add_buff '沉默'{
            time = 10,
            skill = self,
            source = hero
        }
    elseif  rand_name == '减速' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 拾取了命运花, |cff00ffff减速，移动速度减少60%，持续10s |r',10)
        hero:add_buff '减速'{
            time = 10,
            skill = self,
            source = hero,
            move_speed_rate = 60,
        }
    elseif  rand_name == '暴击率翻倍' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 拾取了命运花, |cff00ffff暴击率100%，持续10S |r',10)
        hero:add_buff '暴击'{
            time = 10,
            skill = self,
            source = hero,
            value = 100,
        }
    elseif  rand_name == '生命全满' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 拾取了命运花, |cff00ffff生命全满，补满当前生命值 |r',10)
        hero:heal
		{
			source = hero,
			skill = self,
			size = 10,
			heal = hero:get('生命上限'),
		}
    elseif  rand_name == '攻击力翻倍' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 拾取了命运花, |cff00ffff攻击力翻倍，持续10S |r',10)
        hero:add_buff '攻击加倍'{
            time = 10,
            skill = self,
            source = hero,
            value = 100,
        }
    elseif  rand_name == '护甲加50' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 拾取了命运花, |cff00ffff护甲加50 |r',10)
        hero:add('护甲',50)
    elseif  rand_name == '全属性加100' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 拾取了命运花, |cff00ffff全属性加100 |r',10)
        hero:add('力量',100)
        hero:add('敏捷',100)
        hero:add('智力',100)
    elseif  rand_name == '全属性加1000' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 拾取了命运花, |cff00ffff全属性加1000 |r',10)
        hero:add('力量',1000)
        hero:add('敏捷',1000)
        hero:add('智力',1000)
    elseif  rand_name == '全属性加10000' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r 拾取了命运花, |cff00ffff全属性加10000 |r',10)
        hero:add('力量',10000)
        hero:add('敏捷',10000)
        hero:add('智力',10000)
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
    --回合开始时，创建命运花
    mt:on_create()
end)
