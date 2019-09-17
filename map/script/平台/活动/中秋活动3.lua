
local mt = ac.skill['一起捉玉兔']
mt{
--等久
level = 1,
--图标
art = [[zyt.blp]],
--说明
tip = [[ 
|cffffe799【活动时间】|r|cff00ff009月17日-9月25日
|cffffe799【活动说明】|r|cff00ff00玉兔，是古代神话传说中的神兽，常年居住在月球上，民间传说它经常在中秋时节下凡采药。|cff00ffff基地右边的花园里，最近经常出现一些神秘的兔子。
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
store_name = '|cffdf19d0一起捉玉兔|r',
--物品详细介绍的title
content_tip = ''
}

--奖品
local award_list = { 
    ['玉兔'] =  {
        { rand = 6, name = '金'},
        { rand = 6, name = '红'},
        { rand = 6, name = '随机技能书'},
        { rand = 6, name = '点金石'},
        { rand = 6, name = '恶魔果实'},
        { rand = 6, name = '吞噬丹'},
        { rand = 6, name = '格里芬'},
        { rand = 6, name = '黑暗项链'},
        { rand = 6, name = '最强生物心脏'},
        { rand = 6, name = '白胡子的大刀'},
        { rand = 6, name = '玉兔'},
        { rand = 34, name = '无'},
    },
}

local function give_award(unit,hero) 
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
        p:sendMsg('|cffffe799【系统消息】|r |cff00ff00兔子欢快地跳走了',3) 
    elseif  finds(rand_name,'格里芬','黑暗项链','最强生物心脏','白胡子的大刀') then
        --满时，掉在地上
        ac.item.create_item(rand_name,unit:get_point())
        ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ff00兔子慌慌张张地跳走了，好像掉落了什么，仔细一看是|cffff0000'..rand_name..'|r',4) 
    elseif  finds('红 金',rand_name) then   
        local list = ac.quality_item[rand_name]
        local name = list[math.random(#list)]
        --满时，掉在地上
        local it = ac.item.create_item(name,unit:get_point())
        p:sendMsg('|cffffe799【系统消息】|r |cff00ff00兔子慌慌张张地跳走了，好像掉落了什么，仔细一看是|cffff0000'..it.color_name..'|r',4)
    elseif finds(rand_name,'点金石','恶魔果实','吞噬丹')  then
        --满时，掉在地上
        ac.item.create_item(rand_name,unit:get_point())
        p:sendMsg('|cffffe799【系统消息】|r |cff00ff00兔子慌慌张张地跳走了，好像掉落了什么，仔细一看是|cffff0000'..rand_name..'|r',4)
    elseif finds(rand_name,'随机技能书')  then    
        local rand_list = ac.unit_reward['商店随机技能']
        local rand_name = ac.get_reward_name(rand_list)
        if not rand_name then 
            return
        end    
        local list = ac.skill_list2
        --添加给购买者
        local name = list[math.random(#list)]
        ac.item.create_skill_item(name,unit:get_point())
        p:sendMsg('|cffffe799【系统消息】|r |cff00ff00兔子慌慌张张地跳走了，好像掉落了什么，仔细一看是|cffff0000'..name..'|r',4)
    elseif  rand_name == '玉兔' then 
        local key = ac.server.name2key(rand_name)
        if p:Map_GetServerValue(key) < 1  then 
            --激活成就（存档） 
            p:Map_SaveServerValue(key,1) --网易服务器
            --动态插入魔法书
            local skl = peon:find_skill(rand_name,nil,true) 
            if skl  then 
                skl:set_level(1) 
                ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r |cff00ff00一把逮住了兔子，这只绝对不是普通的兔子，惊喜获得|cffff0000【可存档宠物】'..rand_name..'|r |cff00ff00属性可在宠物技能栏-宠物皮肤中查看',6) 
            end 
        else   
            --重新来一次
            give_award(unit,hero)
        end    
    end    


end

ac.game:event '游戏-开始'(function()
    -- 注册材料获得事件
    local time = 60 * 5 
    -- local time = 10
    ac.loop(time*1000,function()
        local point = ac.rect.j_rect('sjjh2'):get_random_point()
        local unit = ac.player(16):create_unit('玉兔',point)

        unit:add_buff '随机逃跑' {}
        -- ac.nick_name('呱呱呱',unit,150)

        unit:event '单位-死亡'(function(_,u,killer)
            -- ac.item.create_item('奄奄一息的青蛙',unit:get_point())
            give_award(u,killer)
        end)
    end)


end)
