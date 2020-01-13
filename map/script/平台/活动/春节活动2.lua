local mt = ac.skill['五福四海过福年']
mt{
--等久
level = 1,
--图标
art = [[yanhua.blp]],
--说明
tip = [[ 
    活动时间：1月17日-1月31日
    集五福瓜分100亿的可存档全属性，活动结束后，按每个人的集齐次数进行瓜分发放！
    你的 五福集齐次数：%wufu%（集齐次数上限说明=15*地图等级）
    世界 五福集齐次数：%sj_wufu%
 ]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 1,
wufu = function()
    return math.min(ac.player.self.cus_server['五福'],15*ac.player.self:Map_GetMapLevel())
end,
sj_wufu = function()
    return ac.player.self.cus_server2 and ac.player.self.cus_server2['世界五福']
end,
--物品技能
is_skill = true,
store_affix = '',
store_name = '|cffdf19d0五福四海过福年|r',
--物品详细介绍的title
content_tip = ''
}


local mt = ac.skill['【和谐福】']
mt{
--等久
level = 1,
--图标
art = [[zhong.blp]],
--说明
tip = [[


|cffdf19d0【和谐福】|cff00ffff+【爱国】+【敬业】+【友善】=【五福】|cff00ff00（可在“活动使者”处，进行一次博饼）

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


local mt = ac.skill['【爱国】']
mt{
--等久
level = 1,
no_use =true,
wood = 1000,
--图标
art = [[qiu.blp]],
--说明
tip = [[


|cff00ffff【和谐福】+|cffdf19d0【爱国】|cff00ffff+【敬业】+【友善】=【五福】|cff00ff00（可在“活动使者”处，进行一次博饼）

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

local mt = ac.skill['【敬业】']
mt{
--等久
level = 1,
no_use =true,
wood = 1000,
--图标
art = [[kuai.blp]],
--说明
tip = [[


|cff00ffff【和谐福】+【爱国】+|cffdf19d0【敬业】|cff00ffff+【友善】=【五福】|cff00ff00（可在“活动使者”处，进行一次博饼）

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

local mt = ac.skill['【友善】']
mt{
--等久
level = 1,
no_use =true,
wood = 1000,
--图标
art = [[le.blp]],
--说明
tip = [[


|cff00ffff【和谐福】+【爱国】+【敬业】+|cffdf19d0【友善】|cff00ffff=【五福】|cff00ff00（可在“活动使者”处，进行一次博饼）

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

local mt = ac.skill['【富强】']
mt{
--等久
level = 1,
no_use =true,
wood = 1000,
--图标
art = [[le.blp]],
--说明
tip = [[


|cff00ffff【和谐福】+【爱国】+【敬业】+【友善】+|cffdf19d0【富强】|cff00ffff=【五福】|cff00ff00（可在“活动使者”处，进行一次博饼）

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

local mt = ac.skill['【五福】']
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
--物品技能
is_skill = true,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}
function mt:on_cast_start()
    local hero = self.owner
    local p = hero.owner 
    --发送信息
    p:sendMsg('恭喜收集五福',2)
    local key =ac.server.name2key('五福')
    --网易服务器存档
    p:Map_AddServerValue(key,1) --网易服务器

    --自己服务器存档
    local key = ac.server.name2key('世界五福')
    ac.player(11):AddServerValue(key,1)
    ac.player.self.cus_server2['世界五福'] = ac.player(11).cus_server2['世界五福']
end
--插入到合成表
ac.wait(100,function()
    table.insert(ac.streng_item_list,{'【五福】','【和谐福】*1 【爱国】*1 【敬业】*1 【友善】*1'})
end)


--获得事件
local unit_reward = { 
    ['练功房怪'] =  {
        { rand = 0.05,     name = '【和谐】'},
        { rand = 0.05,     name = '【爱国】'},
        { rand = 0.05,     name = '【敬业】'},
        { rand = 0.05,     name = '【友善】'},
        { rand = 0.05,     name = '【富强】'},
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

--等待1秒读取
ac.wait(1000,function()
    ac.player(11):sp_get_map_test()
end)