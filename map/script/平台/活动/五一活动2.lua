local mt = ac.skill['快乐萌宠']
mt{
--等久
level = 1,
--图标
art = [[mengchong.blp]],
--说明
tip = [[ 
|cffffe799【活动时间】|r|cff00ff004月23日-5月13日
|cffffe799【活动说明】|r|cff00ff00劳动节期间，农牧天官给每一位少侠带来了一只可爱的小猪仔，希望小猪仔能被|cff00fffff充满爱心的你|cff00ff00好好照料！
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
store_name = '|cffdf19d0快乐萌宠|r',
--物品详细介绍的title
content_tip = ''
}

local mt = ac.skill['花心萝卜']
mt{
--等久
level = 1,
--图标
art = [[huaxinluobo.blp]],
--说明
tip = [[


|cff00ff00在皑皑白雪的土地上
光鲜嫩绿
眉飞色舞
无人知道它内心的虚与空|cffffff00(可用来喂猪)

|cffcccccc劳动节活动物品|r]],
--品质
-- color = '紫',
--物品类型
item_type = '消耗品',
cool = 0.5,
life_rate = 20,
--目标类型
target_type = ac.skill.TARGET_TYPE_UNIT,
target_data = '联盟 玩家单位',
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
effect = [[Fireworksred.mdx]],
effect2 = [[Abilities\Weapons\FireBallMissile\FireBallMissile.mdl]],
range = 10000,
}

function mt:on_cast_start()
    local skill = self
    local hero = self.owner 
    local p = hero:get_owner()
    hero = p.hero
    local player = hero:get_owner()

    local target = self.target
    if target:get_name() ~='小猪仔' then 
        p:sendMsg('只能对小猪仔使用！',5)
        self:add_item_count(1)
        return true
    end
    if (hero.xzz_cnt or 0) >=10 then 
        p:sendMsg('小猪仔已满级',5)
        self:add_item_count(1)
        return true
    end
    --几率数字
    hero.xzz_cnt = (hero.xzz_cnt or 0) + 1

    --加属性
    hero:add('会心几率',1)
    hero:add('会心伤害',10)

    --小猪仔变大
    local size = target:get_size()
    target:set_size(size + 0.15)
   
    p:sendMsg('|cffffe799【系统消息】|cff00ff00喂猪成功，恭喜获得|cffffff00会心几率+1%，会心伤害+10%',5)

    --小猪飞了
    if hero.xzz_cnt == 10 then 
        target:remove()
        -- print('小猪飞了')
        local save_name = '放了那只猪'
        local key = ac.server.name2key(save_name)
        --动态插入魔法书
        local skl = hero:find_skill(save_name,nil,true) 
        if not skl  then 
            --激活成就（存档） 
            p:Map_AddServerValue(key,1) --网易服务器
            ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',save_name)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..p:get_name()..'|r |cff00ff00的小猪已经成年，回归了大自然，惊喜获得|cffffff00【可存档成就】'..save_name..'|r |cff00ff00属性可在巅峰神域-精彩活动中查看',6) 
        elseif skl.level<skl.max_level then
            --激活成就（存档） 
            p:Map_AddServerValue(key,1) --网易服务器
            skl:upgrade(1)
            p:sendMsg('|cffff0000【可存档成就】'..save_name..'+1',6)  
        else    
            p:sendMsg(save_name..' 已满级',5)
        end
    end
end   

ac.game:event '游戏-开始'(function()
    for i = 1,10  do 
        local p = ac.player(i)
        if p:is_player() then 
            local point = ac.rect.j_rect('lgfbh'..i)
            local u = p:create_unit('小猪仔',point)
            -- u:add_buff '无敌'{}
            u:add_buff '隐身'{ 
                alpha = 50
            }
            u:add_buff '随机逃跑'{
                pulse = 5
            }
        end
    end
end)

--获得事件
ac.game:event '单位-死亡' (function (_,unit,killer)
    if not finds(unit:get_name(),'经验怪','金币','木头','火灵') then 
        return
    end    
    local p = killer:get_owner()
    local hero = p.hero
    local rate = 0.03 --概率
    -- local rate = 50.03 --测试
    local rand_name ='花心萝卜'
    if math.random(100000)/1000 <= rate then   
        if not p.max_item_fall then 
            p.max_item_fall = {}
        end
        p.max_item_fall[rand_name] = (p.max_item_fall[rand_name] or 0) + 1
        --获得最多次数
        local max_cnt = 10   
        if p.max_item_fall[rand_name] <= max_cnt then 
            ac.item.create_item(rand_name,unit:get_point())
        end    
    end 

end)

