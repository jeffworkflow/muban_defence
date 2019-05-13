--物品名称
local mt = ac.skill['召唤boss']
mt{
--等久
level = 1,

--图标
art = [[icon\zhaohuan.blp]],

--说明
tip = [[左键点击使用，召唤出一只boss.
BOSS掉落：100%掉落一件装备， 30%掉落吞噬丹
无尽后无效]],

--品质
color = '紫',

--物品类型
item_type = '消耗品',

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

--冷却
cool = 1,

--购买价格
gold = 0,

--物品数量
_count = 1,
--物品详细介绍的title
content_tip = '使用说明：'
}


function mt:on_cast_start()
    local hero = self.owner
    local target = self.target
    local items = self
    local player = hero:get_owner()

    if ac.creep['刷怪-无尽'].index >= 1 then 
        player:sendMsg('【系统消息】召唤boss，召唤练功怪，进入无尽后无效')
        return
    end
    
    --处理模型
    local unit_name = ac.special_boss[math.random(1,#ac.special_boss)]
    local player = ac.creep['刷怪'].creep_player
    local point = hero:get_point()-{hero:get_facing(),400}--在英雄附近 100 到 400 码 随机点

    local data = ac.table.UnitData[unit_name]
    local unit = player:create_unit(unit_name,point,270)

    if data.model_size then 
        unit:set_size(data.model_size)
    end    

    --处理属性 
    local index = ac.creep['刷怪'].index > 0 and ac.creep['刷怪'].index or 1
    index = (index - 1) > 0 and (index - 1) or 1

    local name = '进攻怪-'..index
    -- print(name)
    local data = ac.table.UnitData[name]
    data.attr_mul = 5
    data.food = 20

    if not unit.data  then 
        unit.data = {}
    end    
    --继承进攻怪lni 值
    for k,v in sortpairs(data) do 
        unit.data[k] = v
    end    
    --怪物类型为boss
    unit.data.type = 'boss'
    if unit and data  then 
        unit.gold = data.gold
        unit.exp = data.exp
        -- print(unit.category,data.category)
        unit.category = data.category
        for k,v in sortpairs(data.attribute) do 
            unit:set(k,v)
        end
    
        --属性 （难度系数）
        unit:set('攻击',data.attribute['攻击'] * data.attr_mul * ac.g_game_degree_attr)
        unit:set('护甲',data.attribute['护甲'] * data.attr_mul * ac.g_game_degree_attr)
        unit:set('生命上限',data.attribute['生命上限'] * data.attr_mul * ac.g_game_degree_attr)
        unit:set('魔法上限',data.attribute['魔法上限'] * data.attr_mul * ac.g_game_degree_attr)
        unit:set('生命恢复',data.attribute['生命恢复'] * data.attr_mul * ac.g_game_degree_attr)
        unit:set('魔法恢复',data.attribute['魔法恢复'] * data.attr_mul * ac.g_game_degree_attr)
        --设置魔抗 
        unit:set('魔抗',data.attribute['护甲']* data.attr_mul * ac.g_game_degree_attr)
        --掉落概率
        unit.fall_rate = 100
        --掉落金币和经验
        unit.gold = 0
        unit.exp = 0
    end 

    --处理额外几率掉落 吞噬丹 统一在掉落的调整怪处理
    


end