
local mt = ac.skill['鱼人驾到']
mt{
--等久
level = 1,
--图标
art = [[yanhua.blp]],
--说明
tip = [[ 
|cffffe799【活动时间】|r|cff00ff009月24日-10月9日
|cffffe799【活动说明】|r|cff00ff00盛世嘉年，普天同庆，三界上下将举行烟花盛典庆贺祖国华诞。
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
store_name = '|cffdf19d0鱼人驾到|r',
--物品详细介绍的title
content_tip = ''
}

--奖品
local award_list = { 
    ['大智若鱼'] =  {
        { rand = 10, name = '木材礼包'},
        { rand = 10, name = '金币礼包'},
        { rand = 5, name = '神仙水'},
        { rand = 5, name = '首充大礼包'},
        { rand = 5, name = '寻宝小飞侠'},
        { rand = 5, name = '永久赞助'},
        { rand = 3, name = '神装大礼包'},
        { rand = 3, name = '神技大礼包'},
        { rand = 2, name = '永久超级赞助'},
        { rand = 2, name = '百变英雄礼包'},
        { rand = 0.1, name = '满赞'},
        { rand = 0.1, name = '肝帝'},
        { rand = 10, name = '大智若鱼'},
        { rand = 39.2, name = '无'},
    },
}
local temp = {
    ['木材礼包'] = '礼包',
    ['金币礼包'] = '礼包',
    ['神仙水'] = '礼包',
    ['首充大礼包'] = '首充',
    ['寻宝小飞侠'] = '礼包',
    ['永久赞助'] = '赞助',
    ['神装大礼包'] = '礼包',
    ['神技大礼包'] = '礼包',
    ['永久超级赞助'] = '赞助',
    ['百变英雄礼包'] = '礼包',
    ['满赞'] = '赞助',
    ['肝帝'] = '赞助',
}


--掉落在地上
local function give_award(hero,unit) 
    local p = hero:get_owner()
    local player = hero:get_owner()
    local peon = p.peon
    local rand_list = award_list['大智若鱼']
    local rand_name,rand_rate = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name)  
    if not rand_name then 
        return true
    end

    if rand_name == '无' then
        p:sendMsg('|cffffe799【系统消息】|r |cff00ff00烟花点燃后，只见天空中出现了八个大字：|cffffff00盛世嘉年，普天同庆|cff00ff00!',3) 
    elseif  rand_name == '大智若鱼' then 
        local key = ac.server.name2key(rand_name)
        if p:Map_GetServerValue(key) < ac.skill[rand_name].max_level  then 
            --激活成就（存档） 
            p:Map_AddServerValue(key,1) --网易服务器
            --动态插入魔法书
            local skl = hero:find_skill(rand_name,nil,true) 
            if not skl  then 
                ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',rand_name)
                ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 超度了一个灵魂，获得|cffff0000【可存档成就】'..rand_name..'|r，成就属性可在“巅峰神域-精彩活动”中查看',6) 
            else
                --有魔法书的情况下，升级
                skl:upgrade(1)
                p:sendMsg('|cffff0000【可存档成就】'..rand_name..'+1',6) 
            end   
        else   
            --重新来一次
            give_award(hero,nil)
        end    
    else
        p.mall[rand_name] = (p.mall[rand_name]  or 0) >0 and 0 or 1
        local book_name = temp[rand_name]
        ac.game:event_notify('技能-删除魔法书',hero,book_name,rand_name)
        ac.game:event_notify('技能-插入魔法书',hero,book_name,rand_name)
        local skl = hero:find_skill(rand_name,nil,true)
        if p.mall[rand_name] > 0 then 
            skl:set_level(1)
        end
        p:sendMsg(rand_name..' 激活: '..p.mall[rand_name])

    end    


end

local mt = ac.skill['鱼人宝盒']
mt{
    --等久
    level = 1,
    --图标
    art = [[yanhua1.blp]],
    --说明
    tip = [[
    
    
    |cff00ff00燃放绚丽烟花，庆祖国华诞！
    
    |cffcccccc国庆活动物品|r]],
    --品质
    color = '紫',
    --物品类型
    item_type = '消耗品',
    cool = 0.5,
    rate = 10,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --物品详细介绍的title
    content_tip = '|cffffe799使用说明：|r',
    effect = [[Fireworksred.mdx]]
}
function mt:on_cast_start()
    local hero = self.owner 
    local p = hero:get_owner()
    local player = hero:get_owner()
    give_award(hero)

end   


--获得事件

ac.game:event '单位-死亡' (function (_,unit,killer)
    if not finds(unit:get_name(),'经验怪','金币','木头','火灵') then 
        return
    end    
    local p = killer:get_owner()
    local hero = p.hero
    local rate = 0.01 --概率
    rate = 20
    if math.random(10000)/100 < rate then   
        local point = hero:get_point()-{hero:get_facing(),100}--在英雄附近 100 到 400 码 随机点
        local u = ac.player(12):create_unit('鱼人',point)
        u:add_buff '定身'{
            time = 2
        }
        u:add_buff '无敌'{
            time = 2
        }
        u:event '单位-死亡' (function(_,unit,killer) 
            ac.item.create_item('鱼人宝盒',unit:get_point())
            p:sendMsg('|cffFFE799【系统消息】|r|cff00ff00恭喜挑战成功|r，奖励 |cffff0000吞噬丹+1 物品吞噬极限+1|r',6)
        end)    
        p:sendMsg('|cffFFE799【系统消息】|r|cffff0000极限BOSS|r已出现，请尽快击杀',2)
    end 

end)