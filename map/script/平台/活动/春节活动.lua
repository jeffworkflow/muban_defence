local mt = ac.skill['爆竹闹春战邪兽']
mt{
--等久
level = 1,
--图标
art = [[ruishou.blp]],
--说明
tip = [[ 
|cffffe799【活动时间】|r|cff00ff001月17日-2月12日
|cffffe799【活动说明】|r|cff00ff00爆竹声中一岁除，春风送暖入屠苏。春风送暖，旭日初升，家家户户点燃爆竹，热火朝天地迎接着春节的到来，|cffffff00各位少侠快去凑个热闹吧！
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
store_name = '|cffdf19d0爆竹闹春战邪兽|r',
--物品详细介绍的title
content_tip = ''
}
--[[4%	随机金装
4%	随机红装
4%	随机技能书
4%	点金石
4%	恶魔果实
4%	吞噬丹
4%	格里芬
4%	黑暗项链
4%	最强生物心脏
4%	白胡子的大刀
4%	获得可存档成就-放炮小达人，激活巅峰神域-精彩活动里面，最大等级=5级，重复获得可以升级
56%	什么都没有
]]

--奖品
local award_list = { 
    ['新春爆竹'] =  {
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
        { rand = 4, name = '放炮小达人'},
        { rand = 56, name = '无'},
    },
}
--掉落在地上
local function give_award(hero,unit) 
    local p = hero:get_owner()
    local player = hero:get_owner()
    local peon = p.peon
    local rand_list = award_list['新春爆竹']
    local rand_name,rand_rate = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name)  
    if not rand_name then 
        return true
    end

    if rand_name == '无' then
        p:sendMsg('|cffffe799【系统消息】|r |cff00ff00鞭炮点燃后，只见天空中出现了八个大字：|cffffff00盛世嘉年，新春快乐|cff00ff00!',3) 

    elseif  finds(rand_name,'格里芬','黑暗项链','最强生物心脏','白胡子的大刀') then
        --满时，掉在地上
        if unit then 
            ac.item.create_item(rand_name,unit:get_point())
        else 
            hero:add_item(rand_name,true)
        end        
        ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ff00鞭炮点燃后，一道绚丽的光芒闪过，好像掉落了什么，仔细一看是|cffff0000'..rand_name..'|r',4) 
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
        p:sendMsg('|cffffe799【系统消息】|r |cff00ff00鞭炮点燃后，一道绚丽的光芒闪过，好像掉落了什么，仔细一看是|cffff0000'..it.color_name..'|r',4)
    elseif finds(rand_name,'点金石','恶魔果实','吞噬丹')  then
        --满时，掉在地上
        local it 
        if unit then  
            it = ac.item.create_item(rand_name,unit:get_point())
        else 
            it = hero:add_item(rand_name,true)
        end  
        p:sendMsg('|cffffe799【系统消息】|r |cff00ff00鞭炮点燃后，一道绚丽的光芒闪过，好像掉落了什么，仔细一看是|cffff0000'..rand_name..'|r',4)
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
        p:sendMsg('|cffffe799【系统消息】|r |cff00ff00鞭炮点燃后，一道绚丽的光芒闪过，好像掉落了什么，仔细一看是|cffff0000'..name..'|r',4)
    elseif  rand_name == '放炮小达人' then 
        local key = ac.server.name2key(rand_name)
        --动态插入魔法书
        local skl = hero:find_skill(rand_name,nil,true) 
        if not skl  then 
            --激活成就（存档） 
            p:Map_AddServerValue(key,1) --网易服务器
            ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',rand_name)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..p:get_name()..'|r |cff00ff00放炮一时爽，一直放炮一直爽，惊喜获得|cffffff00【可存档成就】'..rand_name..'|r',6) 
        elseif skl.level<skl.max_level then
            --激活成就（存档） 
            p:Map_AddServerValue(key,1) --网易服务器
            skl:upgrade(1)
            p:sendMsg('|cffff0000【可存档成就】'..rand_name..'+1',6)  
        else    
            give_award(hero)
        end  
    end    

end


local mt = ac.skill['新春爆竹']
mt{
--等久
level = 1,
--图标
art = [[bianpao.blp]],
--说明
tip = [[


|cff00ff00轰然一响，万山齐应，如闻霹雳声|cffffff00(可驱除捣乱的年兽)

|cffcccccc春节活动物品|r]],
--品质
color = '紫',
--物品类型
item_type = '消耗品',
cool = 0.5,
life_rate = 20,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
effect = [[Fireworksred.mdx]],
effect2 = [[Abilities\Weapons\FireBallMissile\FireBallMissile.mdl]],
}
function mt:on_cast_start()
    local skill = self
    local hero = self.owner 
    local p = hero:get_owner()
    hero = p.hero
    local player = hero:get_owner()
    local eff = ac.effect(hero:get_point(),self.effect,0,1.5,'overhead',350):remove()
    give_award(hero)


    --范围内如果有年兽，造成百分比伤害
    for _,unit in ac.selector()
    : in_range(hero:get_point(),800)
    : is_enemy(hero)
    : add_filter(function (u)
        return u:get_name() == '捣乱的年兽'
    end)
    : ipairs()
    do 
        local mvr = ac.mover.target
        {
            source = hero,
            target = unit,
            model = self.effect2,
            speed = 1000,
            skill = skill,
            on_finish = function()
                unit:damage
                {
                    source = hero,
                    damage = unit:get('生命上限') * skill.life_rate /100,
                    skill = skill,
                    real_damage = true
                }
            end
        }
    end  
end   

--注册新春爆竹 掉落
ac.game:event '单位-死亡' (function (_,unit,killer)
    if  unit.unit_type ~= 'boss' then 
        return
    end    
    local p = killer:get_owner()
    if not p.max_item_fall then 
        p.max_item_fall = {}
    end
    local rate = 10 
    local rand = math.random(10000)/100 
    local max_cnt =20
    if rand < rate and (p.max_item_fall['新春爆竹'] or 0) <=20 then 
        p.max_item_fall['新春爆竹'] = (p.max_item_fall['新春爆竹'] or 0) + 1
        ac.item.create_item('新春爆竹',unit:get_point())
    end
end)



local mt = ac.skill['木材堆']
mt{
--等久
level = 1,
wood = 1000,
--图标
art = [[qiu.blp]],
--说明
tip = [[
木头+1000
]],
--品质
color = '紫',
--物品类型
item_type = '神符',
specail_model = [[Objects\InventoryItems\BundleofLumber\BundleofLumber.mdx]],

--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}
function mt:on_cast_start()
    local hero =self.owner 
    hero:add_wood(self.wood)
end

local mt = ac.skill['兽魂之佑1']
mt{
--等久
level = 1,
title ='兽魂之佑',
-- wood = 1000,
--图标
art = [[ruishou.blp]],
title = [[兽魂之佑]],
--说明
tip = [[

|cffffff00点击激活可存档成就【兽魂之佑】，激活后可在成长之路-精彩活动中查看

|cffFFE799【成就属性】：|r
|cff00ff00+|cffffff008.8   |cff00ff00杀怪加全属性|r
|cff00ff00+|cffffff008.8   |cff00ff00攻击减甲|r
|cff00ff00+|cffffff008.8 |cff00ff00%  |cff00ff00杀敌数加成|r
|cff00ff00+|cffffff008.8 |cff00ff00%  |cff00ff00暴击加深|r

]],
--品质
color = '紫',
--物品类型
item_type = '消耗品',
specail_model = [[faguangzi.mdx]],
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}
function mt:on_cast_start()
    local hero =self.owner 
    local player = hero.owner 
    local p = hero.owner 
    hero = player.hero
    local real_name = '兽魂之佑'
    local key = ac.server.name2key(real_name)
    --动态插入魔法书
    local skl = hero:find_skill(real_name,nil,true) 
    if not skl  then 
        --激活成就（存档） 
        p:Map_AddServerValue(key,1) --网易服务器
        ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',real_name)
        ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..p:get_name()..'|r |cff00ff00击败了捣乱的年兽，惊喜获得|cffffff00【可存档成就】'..real_name..'|r',6) 
    elseif skl.level<skl.max_level then
        --激活成就（存档） 
        p:Map_AddServerValue(key,1) --网易服务器
        skl:upgrade(1)
        p:sendMsg('|cffff0000【可存档成就】'..real_name..'+1',6)  
    else    
        self:add_item_count(1)
        p:sendMsg('|cffff0000已达最高等级'..real_name..'',6)  
        return
    end 
end

--注册捣乱的年兽 生成事件
ac.game:event '游戏-开始'(function()
    -- 注册材料获得事件
    local time = 60 * 10 
    -- local time = 10
    ac.timer(time*1000,10,function()
        local online_cnt = get_player_count()
        local cnt = math.floor(online_cnt/2) + 1 

        for i= 1, cnt do 
            local point = ac.map.rects['藏宝区']:get_random_point()
            local unit = ac.player(16):create_unit('捣乱的年兽',point)

            unit:add_buff '随机逃跑' {}
            -- ac.nick_name('捣捣捣捣捣',unit,250)
            unit:event '受到伤害开始' (function(_,damage)
                if damage.skill and type(damage.skill) =='table' and damage.skill.name =='新春爆竹' then 
                    return 
                else 
                    return true 
                end
            end)
        end    
    end)

end)


--[[20% 1个木材堆，神符类，右键点击后消失，+1000木头，模型Objects\InventoryItems\BundleofLumber\BundleofLumber.mdl
20% 3个木材堆，三个木材堆
20% 1个吞噬丹，
20% 1个恶魔果实，
20% 1个兽魂之佑]]

--获得事件
local unit_reward = { 
    ['捣乱的年兽'] =  {
        { rand = 20,     name = '木材堆*1'},
        { rand = 20,     name = '木材堆*3'},
        { rand = 20,     name = '吞噬丹*1'},
        { rand = 20,     name = '恶魔果实*1'},
        { rand = 20,     name = '兽魂之佑1*1'},
    },
}

ac.game:event '单位-死亡' (function (_,unit,killer)
    if not finds(unit:get_name(),'捣乱的年兽') then 
        return
    end    
    local p = killer:get_owner()
    local rand_name = ac.get_reward_name(unit_reward['捣乱的年兽'])  
    if not rand_name then 
        return 
    end   

    --处理掉落物品相关
    for k,v in rand_name:gmatch '(%S+)%*(%d+%s-)' do
        --进行多个处理
        for i=1,tonumber(v) do 
            ac.item.create_item(k,unit:get_point())
        end  
    end   

end)
