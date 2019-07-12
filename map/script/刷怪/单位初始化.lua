
local function get_difficult(degree)
    local base =1
    local base_rate =1.45
    local degree = degree or 1 
    if degree == 1 then 
        return base 
    else
        return get_difficult(degree -1) *base_rate  
    end 
end    


--单位创建 属性增强
ac.game:event '单位-创建' (function(_,unit)
    -- 英雄返回
    if unit:is_hero() then  return end 
    -- 根据难度增强属性。
    local name = unit:get_name()
    local data = ac.table.UnitData[name]
    if not data then return end 
    -- 再次初始化业务端字段，以免漏掉处理
    unit.name = data.name
    unit.category = data.category
    unit.unit_type= data.unit_type
    unit.missile_art= data.missile_art
    unit.index= data.index
    unit.gold= data.gold
    unit.wood= data.wood
    unit.fire_seed= data.fire_seed
    unit.exp= data.exp
    unit.fall_rate= data.fall_rate

    --设置搜敌范围
    unit:set_search_range(500)
    local attr_mul = get_difficult(ac.g_game_degree_attr)
    --根据难度增强属性 
    if data.attribute then  
        unit:set('攻击',data.attribute['攻击'] )
        unit:set('生命上限',data.attribute['生命上限'])
        unit:set('魔法上限',data.attribute['魔法上限'])
        unit:set('生命恢复',data.attribute['生命恢复'])
        unit:set('魔法恢复',data.attribute['魔法恢复'])
        -- print(ac.g_game_degree_attr)
        unit:set('护甲',data.attribute['护甲'] *  (attr_mul or 1))
        unit:set('魔抗',data.attribute['护甲'] * (attr_mul or 1))

        unit:set('暴击加深',data.attribute['暴击加深'] * (attr_mul or 1))
    end    

    --单独增强最终boss
    if unit:get_name() == '最终boss' then
        unit:set('攻击减甲',data.attribute['攻击减甲'] * (ac.g_game_degree_attr or 1) )
    end    


    --根据玩家数量，怪物属性倍数 5  20 . 5 40， 20*1.1 = 22
    -- local attr_mul = ( get_player_count() -1 ) * 5
    -- --属性
    -- -- print('打印是否根据玩家数增加属性1',unit:get('攻击'))
    -- unit:add('攻击%',attr_mul*7)
    -- unit:add('护甲%',attr_mul*7)
    -- unit:add('生命上限%',attr_mul*7)
    -- unit:add('魔法上限%',attr_mul)
    -- unit:add('生命恢复%',attr_mul)
    -- unit:add('魔法恢复%',attr_mul)
    -- --设置魔抗 
    -- unit:add('魔抗%',attr_mul*7)

    
end)