
local mt = ac.skill['繁光缀天落九州']
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
store_name = '|cffdf19d0繁光缀天落九州|r',
--物品详细介绍的title
content_tip = ''
}

--奖品
local award_list = { 
    ['九洲帝王'] =  {
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
        { rand = 4, name = '九洲帝王'},
        { rand = 4, name = '蟠桃种子'},
        { rand = 52, name = '无'},
    },
}
--掉落在地上
local function give_award(hero,unit) 
    local p = hero:get_owner()
    local player = hero:get_owner()
    local peon = p.peon
    local rand_list = award_list['九洲帝王']
    local rand_name,rand_rate = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name)  
    if not rand_name then 
        return true
    end


    if rand_name == '无' then
        p:sendMsg('|cffffe799【系统消息】|r |cff00ff00烟花点燃后，只见天空中出现了八个大字：|cffffff00盛世嘉年，普天同庆|cff00ff00!',3) 

    elseif  finds(rand_name,'格里芬','黑暗项链','最强生物心脏','白胡子的大刀') then
        --满时，掉在地上
        if unit then 
            ac.item.create_item(rand_name,unit:get_point())
        else 
            hero:add_item(rand_name,true)
        end        
        ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ff00烟花点燃后，一道绚丽的光芒闪过，好像掉落了什么，仔细一看是|cffff0000'..rand_name..'|r',4) 
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
        p:sendMsg('|cffffe799【系统消息】|r |cff00ff00烟花点燃后，一道绚丽的光芒闪过，好像掉落了什么，仔细一看是|cffff0000'..it.color_name..'|r',4)
    elseif finds(rand_name,'点金石','恶魔果实','吞噬丹','蟠桃种子')  then
        --满时，掉在地上
        local it 
        if unit then  
            it = ac.item.create_item(rand_name,unit:get_point())
        else 
            it = hero:add_item(rand_name,true)
        end  
        p:sendMsg('|cffffe799【系统消息】|r |cff00ff00烟花点燃后，一道绚丽的光芒闪过，好像掉落了什么，仔细一看是|cffff0000'..rand_name..'|r',4)
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
        p:sendMsg('|cffffe799【系统消息】|r |cff00ff00烟花点燃后，一道绚丽的光芒闪过，好像掉落了什么，仔细一看是|cffff0000'..name..'|r',4)
    elseif  rand_name == '九洲帝王' then 
        local key = ac.server.name2key(rand_name)
        if p:Map_GetServerValue(key) < 1  then 
            --激活成就（存档） 
            p:Map_SaveServerValue(key,1) --网易服务器
            --动态插入魔法书
            local skl = hero:find_skill(rand_name,nil,true) 
            if skl  then 
                skl:set_level(1) 
                ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r |cff00ff00放烟花一时爽，一直放一直爽，惊喜获得|cffff0000【可存档称号】'..rand_name..'|r |cff00ff00属性可在巅峰神域-荣耀称号中查看',6) 
            end 
        else   
            --重新来一次
            give_award(hero,nil)
        end    
    end    


end


local mt = ac.skill['七彩烟花']
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
    local eff = ac.effect(hero:get_point(),self.effect,0,1.5,'overhead',350):remove()
    give_award(hero)

end   



--获得事件
local unit_reward = { 
    ['练功房怪'] =  {
        { rand = 0.05,     name = '七彩烟花'},
    },
}
ac.game:event '单位-死亡' (function (_,unit,killer)
    if not finds(unit:get_name(),'经验怪','金币','木头','火灵') then 
        return
    end    
    local p = killer:get_owner()
    local rand_name = ac.get_reward_name(unit_reward['练功房怪'])  
    if not rand_name then 
        return 
    end   

    if not p.max_item_fall then 
        p.max_item_fall = {}
    end
    p.max_item_fall[rand_name] = (p.max_item_fall[rand_name] or 0) + 1
    --获得最多次数
    local max_cnt = 20   
    if p.max_item_fall[rand_name] <= max_cnt then 
        ac.item.create_item(rand_name,unit:get_point())
    end    

end)