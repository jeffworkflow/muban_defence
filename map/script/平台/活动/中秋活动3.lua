
local mt = ac.skill['一起捉玉兔']
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

--奖品
local award_list = { 
    ['玉兔'] =  {
        { rand = 5, name = '金'},
        { rand = 5, name = '红'},
        { rand = 5, name = '随机技能书'},
        { rand = 5, name = '点金石'},
        { rand = 5, name = '恶魔果实'},
        { rand = 5, name = '吞噬丹'},
        { rand = 5, name = '格里芬'},
        { rand = 5, name = '黑暗项链'},
        { rand = 5, name = '最强生物心脏'},
        { rand = 5, name = '白胡子的大刀'},
        { rand = 10, name = '玉兔'},
        { rand = 40, name = '无'},
    },
}

local function give_award(hero) 
    local p = hero:get_owner()
    local player = hero:get_owner()
    local peon = p.peon
    local rand_list = award_list['玉兔']
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
    elseif  rand_name == '玉兔' then 
        local key = ac.server.name2key(rand_name)
        if p:Map_GetServerValue(key) < 1  then 
            --激活成就（存档） 
            p:Map_SaveServerValue(key,1) --网易服务器
            --动态插入魔法书
            local skl = peon:find_skill(rand_name,nil,true) 
            if skl  then 
                skl:set_level(1)
                ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r  将青蛙丢进井里，惊喜获得|cffff0000【可存档成就】'..rand_name..'|r |cff00ff00+16.8杀怪加全属性|r |cff00ff00+16.8攻击减甲|r |cff00ff00+16.8%杀敌数加成|r |cff00ff00+16.8%物理伤害加深|r',6) 
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
        local point = ac.rect.j_rect('sjjh2'):get_random_point()
        local unit = ac.player(16):create_unit('玉兔',point)

        unit:add_buff '随机逃跑' {}
        ac.nick_name('呱呱呱',unit,150)

        unit:event '单位-死亡'(function()
            -- ac.item.create_item('奄奄一息的青蛙',unit:get_point())
            give_award(unit)
        end)
    end)


end)
