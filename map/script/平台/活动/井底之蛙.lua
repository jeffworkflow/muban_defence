
local mt = ac.skill['抓青蛙']
mt{
--等久
level = 1,
--图标
art = [[xique.blp]],
--说明
tip = [[ 
|cffffe799【活动时间】|r|cff00ff008月6日-8月8日
|cffffe799【活动说明】|r|cff00ff00金风玉露一相逢，便胜却人间无数。年年岁岁架鹊桥，牛郎织女偷相会。少侠既然也是有心之人，还请帮忙收集|cffffff00喜鹊翎毛|r|cffcccccc（挖宝掉落）
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
-- store_name = '|cffdf19d0挑战 |r',
--物品详细介绍的title
content_tip = ''
}





local mt = ac.skill['奄奄一息的青蛙']
mt{
--等久
level = 1,
--图标
art = [[lushui.blp]],
--说明
tip = [[

|cff00ff00传说七夕节时的露水是牛郎织女相会时的眼泪,如抹在眼上和手上,可使人眼明手快。|cffffff00使用后增加10%攻速|r

|cffcccccc七夕活动物品|r]],
--品质
color = '紫',
--物品类型
item_type = '消耗品',
cool = 1,
['生命上限%'] = 10,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}

local function give_award(hero) 
    local p = hero:get_owner()
    local player = hero:get_owner()
    local rand_list = ac.unit_reward['井底之蛙']
    local rand_name,rand_rate = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name)  
    if not rand_name then 
        return true
    end
    if rand_name == '无' then
        p:sendMsg('|cffffe799【系统消息】|r 溜走了',2) 
    elseif  finds(rand_name,'格里芬','黑暗项链','最强生物心脏','白胡子的大刀') then
        --满时，掉在地上
        hero:add_item(rand_name,true)
        ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 兑换到了 |cffff0000'..rand_name..'|r',2) 
    elseif  finds('红 金',rand_name) then   
        local list = ac.quality_item[rand_name]
        local name = list[math.random(#list)]
        --满时，掉在地上
        local item = hero:add_item(name,true)
        p:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 兑换到了 '..item.color_name..'',2) 
    elseif finds(rand_name,'点金石','恶魔果实','吞噬丹')  then
        --满时，掉在地上
        hero:add_item(rand_name,true)
        ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 兑换到了 |cffff0000'..rand_name..'|r',2) 
    elseif finds(rand_name,'随机技能书')  then    
        local rand_list = ac.unit_reward['商店随机技能']
        local rand_name = ac.get_reward_name(rand_list)
        if not rand_name then 
            return
        end    
        local list = ac.skill_list2
        --添加给购买者
        local name = list[math.random(#list)]
        ac.item.add_skill_item(name,hero)
    elseif  rand_name == '井底之蛙' then 
        local key = ac.server.name2key(rand_name)
        if p:Map_GetServerValue(key) < 1 and p:Map_GetMapLevel()>=5 then 
            --激活成就（存档） 
            p:Map_SaveServerValue(key,1) --网易服务器
            --动态插入魔法书
            local skl = hero:find_skill(rand_name,nil,true) 
            if not skl  then 
                ac.game:event_notify('技能-插入魔法书',hero,'精彩活动','井底之蛙')
                ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 兑换到了 |cffff0000'..rand_name..'|r',2) 
            end 
        else   
            --重新来一次
            give_award(hero)
        end    
    end    


end

ac.game:event '游戏-开始'(function()
    -- 注册材料获得事件
    local time = 60 * 5 
    local time = 30
    ac.loop(time*1000,function()
        local point = ac.map.rects['藏宝区']:get_random_point()
        local unit = ac.player(16):create_unit('青蛙',point)

        unit:add_buff '随机逃跑' {}
        ac.nick_name('呱呱呱!',unit,200)

        unit:event '单位-死亡'(function()
            ac.item.create_item('奄奄一息的青蛙',unit:get_point())
        end)
    end)


    --注册 材料兑换事件
    local reg = ac.region.create(ac.rect.j_rect('jing'))
    reg:event '区域-进入'(function(trg,unit,reg)
        if not unit:is_hero() then 
            return
        end
        print('区域进入')

        local item = unit:has_item('奄奄一息的青蛙') 
        if not item then 
            return 
        end
        local max_cnt = item:get_item_count()    
        for i=1,max_cnt do 
            give_award(unit)
        end    
        item:item_remove()

    end)
end)
