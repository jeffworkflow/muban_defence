
local mt = ac.skill['【中】']
mt{
--等久
level = 1,
--图标
art = [[zhong.blp]],
--说明
tip = [[


|cffdf19d0【中】|cff00ffff+【秋】+【快】+【乐】=【博饼券】|cff00ff00（可在“活动使者”处，进行一次博饼）

|cffcccccc中秋活动物品|r]],
--品质
color = '紫',
--物品类型
item_type = '消耗品',

no_use =true,
wood = 1000,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}


local mt = ac.skill['【秋】']
mt{
--等久
level = 1,
no_use =true,
wood = 1000,
--图标
art = [[qiu.blp]],
--说明
tip = [[


|cff00ffff【中】+|cffdf19d0【秋】|cff00ffff+【快】+【乐】=【博饼券】|cff00ff00（可在“活动使者”处，进行一次博饼）

|cffcccccc中秋活动物品|r]],
--品质
color = '紫',
--物品类型
item_type = '消耗品',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}

local mt = ac.skill['【快】']
mt{
--等久
level = 1,
no_use =true,
wood = 1000,
--图标
art = [[kuai.blp]],
--说明
tip = [[


|cff00ffff【中】+【秋】+|cffdf19d0【快】|cff00ffff+【乐】=【博饼券】|cff00ff00（可在“活动使者”处，进行一次博饼）

|cffcccccc中秋活动物品|r]],
--品质
color = '紫',
--物品类型
item_type = '消耗品',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}

local mt = ac.skill['【乐】']
mt{
--等久
level = 1,
no_use =true,
wood = 1000,
--图标
art = [[le.blp]],
--说明
tip = [[


|cff00ffff【中】+【秋】+【快】+|cffdf19d0【乐】|cff00ffff=【博饼券】|cff00ff00（可在“活动使者”处，进行一次博饼）

|cffcccccc中秋活动物品|r]],
--品质
color = '紫',
--物品类型
item_type = '消耗品',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}


local mt = ac.skill['博饼券']
mt{
--等久
level = 1,
--图标
art = [[bobingquan.blp]],
--说明
tip = [[


|cff00ff00可在“活动使者”处，进行一次博饼

|cffcccccc中秋活动物品|r]],
--品质
color = '紫',
--物品类型
item_type = '消耗品',
no_use =true,
--物品技能
is_skill = true,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}

--插入到合成表
ac.wait(100,function()
    table.insert(ac.streng_item_list,{'博饼券','【中】*1 【秋】*1 【快】*1 【乐】*1'})
end)
--奖品
local award_list = { 
    ['博饼券'] =  {
        { rand = 49.1,      name = '无'},
        { rand = 35,     name = '秀才'},
        { rand = 8,      name = '举人'},
        { rand = 4,      name = '进士'},
        { rand = 2,      name = '探花'},
        { rand = 1,      name = '榜眼'},
        { rand = 0.45,      name = '状元'},
        { rand = 0.15,      name = '王中王'},
        { rand = 0.3,      name = '王昭君'},
    },
}
local name2id = {
    ['秀才'] = 1,
    ['举人'] = 2,
    ['进士'] = 3,
    ['探花'] = 4,
    ['榜眼'] = 5,
    ['状元'] = 6,
    ['王中王'] = 7,
}
ac.bobing_name2id = name2id
  

local function give_award(hero) 
    local p = hero:get_owner()
    local player = hero:get_owner()
    local rand_list = award_list['博饼券']
    local rand_name,rand_rate = ac.get_reward_name(rand_list)
    local hero = p.hero
    -- print(rand_list,rand_name)  
    if not rand_name then 
        print('没有随机到任何东西')
        return true
    end
    if rand_name == '无' then
        p:sendMsg('|cffffe799【系统消息】|r|cff00ff00什么都没有博到',3) 
    elseif rand_name == '王昭君' then
        local has_award = p.cus_server and p.cus_server['王昭君'] or 0
        if has_award >0 then 
            p:sendMsg('|cffffe799【系统消息】|r|cff00ff00什么都没有博到',3) 
        else 
            local key = ac.server.name2key('王昭君')
            p:Map_SaveServerValue(key,1)
            p:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r |cff00ff00将骰子摇了下去，好多“四”，惊喜获得|cffff0000【可存档英雄】'..rand_name..'|r |cff00ff00激活条件可在“巅峰神域-英雄皮肤”中查看',6) 
        end    
    else    
        local key = 'bobing'
        -- local server_value = p.cus_server and p.cus_server[ac.server.key2name(key)] or 0 
        -- 需要直接从服务器取，否则武林大会这边会有问题
        local server_value = p:Map_GetServerValue(key)
        local value = name2id[rand_name]
        if value > server_value then 
            --激活成就（存档） 
            p:Map_SaveServerValue(key,value) --网易服务器
            --删掉旧的
            for key,val in sortpairs(name2id) do 
                local skl = hero:find_skill(key,nil,true)
                if skl then 
                    ac.game:event_notify('技能-删除魔法书',hero,'精彩活动',skl.name)
                end
            end  
            --插入新的 
            ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',rand_name)
            p:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r |cff00ff00将骰子摇了下去，好多“四”，惊喜获得|cffff0000【可存档称谓】'..rand_name..'|r |cff00ff00称谓属性可在“巅峰神域-精彩活动”中查看',6) 
        else
            p:sendMsg('|cffffe799【系统消息】|r|cff00ff00未博到更高级的称谓，博了个小'..rand_name,6)  
        end    
    end    
end

local mt = ac.skill['博饼使我快乐']
mt{
--等久
level = 1,
--图标
art = [[bbswkl.blp]],
--说明
tip = [[ 
|cffffe799【活动时间】|r|cff00ff009月30日-10月15日
|cffffe799【活动说明】|r|cff00ff00由郑成功发明的一种游戏，是闽南地区特有的一种中秋民俗活动。|cff00ffff相传这种游戏可以预测人未来一年内的运气。

|cffffff00消耗 |cffff0000一张博饼券 |cffffff00进行一次博饼

|cffcccccc博饼有概率获得不同的“可存档称谓”，但同时只能拥有一个最高等级的称谓]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 1,
--物品技能
is_skill = true,
store_affix = '',
store_name = '|cffdf19d0博饼使我快乐|r',
--兑换材料
raffle = '博饼券*1',
--物品详细介绍的title
content_tip = ''
} 
function mt:on_cast_start()
    local hero = self.owner
    give_award(hero)
end 



--获得事件
local unit_reward = { 
    ['练功房怪'] =  {
        { rand = 0.07,     name = '【中】'},
        { rand = 0.07,     name = '【秋】'},
        { rand = 0.07,     name = '【快】'},
        { rand = 0.07,     name = '【乐】'},
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
    local max_cnt = 3   
    if p.max_item_fall[rand_name] <= max_cnt then 
        ac.item.create_item(rand_name,unit:get_point())
    end    

end)
