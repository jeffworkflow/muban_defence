local mt = ac.skill['团团圆圆庆元宵']
mt{
--等久
level = 1,
--图标
art = [[fuqi.blp]],
--说明
tip = [[ 
|cffffe799【活动时间】|r|cff00ff001月17日-1月31日
|cffffe799【活动说明】|r|cff00ff00集五福瓜分|cffffff00100亿的可存档全属性|cff00ff00，活动结束后，按每个人的集齐次数进行瓜分发放！

|cffcccccc你的 五福集齐次数：%wufu%|cffffff00（最大集齐次数受限于地图等级）
|cffcccccc世界 五福集齐次数：%sj_wufu%]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 1,
is_small_num = true,
--物品技能
is_skill = true,
store_affix = '',
store_name = '|cffdf19d0团团圆圆庆元宵|r',
--物品详细介绍的title
content_tip = ''
}


local mt = ac.skill['【白糖元宵】']
mt{
--等久
level = 1,
--图标
art = [[hexie.blp]],
--说明
tip = [[


|cffdf19d0【白糖元宵】|cff00ffff+【芝麻元宵】+【豆沙元宵】+【玫瑰元宵】=【七彩元宵】|cff00ff00（使用可增加五福集齐次数，活动结束后可瓜分百亿属性！）

|cffcccccc春节活动物品|r]],
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


local mt = ac.skill['【芝麻元宵】']
mt{
--等久
level = 1,
no_use =true,
wood = 1000,
--图标
art = [[aiguo.blp]],
--说明
tip = [[


|cff00ffff【白糖元宵】+|cffdf19d0【芝麻元宵】|cff00ffff+【豆沙元宵】+【玫瑰元宵】=【七彩元宵】|cff00ff00（使用可增加五福集齐次数，活动结束后可瓜分百亿属性！）

|cffcccccc春节活动物品|r]],
--品质
color = '紫',
--物品类型
item_type = '消耗品',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}

local mt = ac.skill['【豆沙元宵】']
mt{
--等久
level = 1,
no_use =true,
wood = 1000,
--图标
art = [[jingye.blp]],
--说明
tip = [[


|cff00ffff【白糖元宵】+【芝麻元宵】+|cffdf19d0【豆沙元宵】|cff00ffff+【玫瑰元宵】=【七彩元宵】|cff00ff00（使用可增加五福集齐次数，活动结束后可瓜分百亿属性！）

|cffcccccc春节活动物品|r]],
--品质
color = '紫',
--物品类型
item_type = '消耗品',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}

local mt = ac.skill['【玫瑰元宵】']
mt{
--等久
level = 1,
no_use =true,
wood = 1000,
--图标
art = [[youshan.blp]],
--说明
tip = [[


|cff00ffff【白糖元宵】+【芝麻元宵】+【豆沙元宵】+|cffdf19d0【玫瑰元宵】|cff00ffff=【七彩元宵】|cff00ff00（使用可增加五福集齐次数，活动结束后可瓜分百亿属性！）

|cffcccccc春节活动物品|r]],
--品质
color = '紫',
--物品类型
item_type = '消耗品',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}


--奖品
local award_list = { 
    ['【七彩元宵】'] =  {
        { rand = 49.25,      name = '无'},
        { rand = 35,     name = '细嚼慢咽'},
        { rand = 8,      name = '津津有味'},
        { rand = 4,      name = '吃元宵不吐元宵皮'},
        { rand = 2,      name = '饥不择食'},
        { rand = 1,      name = '狼吞虎咽'},
        { rand = 0.3,      name = '王昭君'},
    },
}
local name2id = {
    ['细嚼慢咽'] = 1,
    ['津津有味'] = 2,
    ['吃元宵不吐元宵皮'] = 3,
    ['饥不择食'] = 4,
    ['狼吞虎咽'] = 5,
}
ac.bobing_name2id = name2id
  

local function give_award(hero) 
    local p = hero:get_owner()
    local player = hero:get_owner()
    local rand_list = award_list['【七彩元宵】']
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
        local key = 'yuanxiao'
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

local mt = ac.skill['【七彩元宵】']
mt{
--等久
level = 1,
--图标
art = [[bobingquan.blp]],
--说明
tip = [[


|cff00ff00点击获得一个五福集齐次数|cffffff00(集齐次数可在NPC“活动使者”处查看)|cff00ff00，活动结束后可瓜分百亿属性！

|cffcccccc春节活动物品|r]],
--品质
color = '紫',
--物品类型
item_type = '消耗品',
--物品技能
is_skill = true,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}
function mt:on_cast_start()
    local hero = self.owner
    give_award(hero)
end
--插入到合成表
ac.wait(100,function()
    table.insert(ac.streng_item_list,{'【七彩元宵】','【白糖元宵】*1 【芝麻元宵】*1 【豆沙元宵】*1 【玫瑰元宵】*1'})
end)


--获得事件
local unit_reward = { 
    ['练功房怪'] =  {
        { rand = 10.05,     name = '【白糖元宵】'},
        { rand = 10.05,     name = '【芝麻元宵】'},
        { rand = 10.05,     name = '【豆沙元宵】'},
        { rand = 10.05,     name = '【玫瑰元宵】'},
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
