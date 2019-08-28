
local mt = ac.skill['抓青蛙']
mt{
--等久
level = 1,
--图标
art = [[jdzw.blp]],
--说明
tip = [[ 
|cffffe799【活动时间】|r|cff00ff008月29日-9月2日
|cffffe799【活动说明】|r|cff00ff00雨过不知龙去处，一池草色万蛙鸣。|cff00ffff这几天基地里经常出现一些青蛙，天天在那里哇哇叫。|cff00ff00还请帮忙|cffff0000把青蛙抓起来|r|cff00ff00，放到|cffffff00右边花园的井里|r
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
art = [[bsdqw.blp]],
--说明
tip = [[


|cff00ffff青蛙：|cff00ff00我感觉我还可以救一下，请将我丢进|cffff0000基地右边花园的井里|cffffff00（也可见死不救，点击左键可食用，增加10%生命上限|r）

|cffcccccc抓青蛙活动物品|r]],
--品质
color = '紫',
--物品类型
item_type = '消耗品',
cool = 1,
['生命上限%'] = 10,
rate = 10,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}
function mt:on_cast_start()
    local hero = self.owner 
    local p = hero:get_owner()
    local player = hero:get_owner()
    hero = p.hero
    local save_name = '食物链顶端的人'
    -- print(self.rate)
    if math.random(100) <= self.rate then 
        local key = ac.server.name2key(save_name)
        -- if p:Map_GetServerValue(key) < 1 then 
        --激活成就（存档） 
        p:Map_AddServerValue(key,1) --网易服务器
        --动态插入魔法书
        local skl = hero:find_skill(save_name,nil,true) 
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'精彩活动','食物链顶端的人')
            ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 食用了青蛙，惊喜获得|cffff0000【可存档成就】'..save_name..'|r |cff00ff00+18.8杀怪加全属性|r |cff00ff00+18.8攻击减甲|r |cff00ff00+18.8%物品获取率|r |cff00ff00+18.8%暴击加深|r',6) 
        else
            skl:upgrade(1)
            p:sendMsg('|cffff0000【可存档成就】'..save_name..'+1',6)  
        end 
        -- end    
    end    


end    

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
        p:sendMsg('|cffffe799【系统消息】|r 青蛙快乐地游走了',3) 
    elseif  finds(rand_name,'格里芬','黑暗项链','最强生物心脏','白胡子的大刀') then
        --满时，掉在地上
        hero:add_item(rand_name,true)
        ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 救蛙一命，胜造七级浮屠，奖励 |cffff0000'..rand_name..'|r',4) 
    elseif  finds('红 金',rand_name) then   
        local list = ac.quality_item[rand_name]
        local name = list[math.random(#list)]
        --满时，掉在地上
        local item = hero:add_item(name,true)
        p:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 救蛙一命，胜造七级浮屠，奖励 '..item.color_name..'',4) 
    elseif finds(rand_name,'点金石','恶魔果实','吞噬丹')  then
        --满时，掉在地上
        hero:add_item(rand_name,true)
        ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 救蛙一命，胜造七级浮屠，奖励 |cffff0000'..rand_name..'|r',4) 
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
        ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 救蛙一命，胜造七级浮屠，奖励 |cffff0000'..rand_name..'|r',4) 
    elseif  rand_name == '井底之蛙' then 
        local key = ac.server.name2key(rand_name)
        -- if p:Map_GetServerValue(key) < 1  then 
        --激活成就（存档） 
        p:Map_AddServerValue(key,1) --网易服务器
        --动态插入魔法书
        local skl = hero:find_skill(rand_name,nil,true) 
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'精彩活动','井底之蛙')
            ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r  将青蛙丢进井里，惊喜获得|cffff0000【可存档成就】'..rand_name..'|r |cff00ff00+16.8杀怪加全属性|r |cff00ff00+16.8攻击减甲|r |cff00ff00+16.8%杀敌数加成|r |cff00ff00+16.8%物理伤害加深|r',6) 
        else
            skl:upgrade(1)
            p:sendMsg('|cffff0000【可存档成就】'..rand_name..'+1',6) 
        end 
        -- else   
        --     --重新来一次
        --     give_award(hero)
        -- end    
    end    


end

ac.game:event '游戏-开始'(function()
    -- 注册材料获得事件
    local time = 60 * 5 
    -- local time = 30
    ac.loop(time*1000,function()
        local point = ac.map.rects['藏宝区']:get_random_point()
        local unit = ac.player(16):create_unit('青蛙',point)

        unit:add_buff '随机逃跑' {}
        ac.nick_name('呱呱呱',unit,150)

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
        -- print('区域进入')

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
