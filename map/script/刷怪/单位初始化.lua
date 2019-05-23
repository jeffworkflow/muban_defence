
--单位创建 属性增强
ac.game:event '单位-创建' (function(_,unit)
    if not unit then  return end 
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

    --根据难度增强属性 
    if data.attribute then  
        unit:set('攻击',data.attribute['攻击'] *  ac.g_game_degree_attr)
        unit:set('护甲',data.attribute['护甲'] *  ac.g_game_degree_attr)
        unit:set('生命上限',data.attribute['生命上限'] * ac.g_game_degree_attr)
        unit:set('魔法上限',data.attribute['魔法上限'] * ac.g_game_degree_attr)
        unit:set('生命恢复',data.attribute['生命恢复'] * ac.g_game_degree_attr)
        unit:set('魔法恢复',data.attribute['魔法恢复'] * ac.g_game_degree_attr)
        unit:set('魔抗',data.attribute['护甲'] * ac.g_game_degree_attr)
    end    

    --根据玩家数量，怪物属性倍数 5  20 . 5 40， 20*1.1 = 22
    local attr_mul = ( get_player_count() -1 ) * 5
    --属性
    -- print('打印是否根据玩家数增加属性1',unit:get('攻击'))
    unit:add('攻击%',attr_mul*7)
    unit:add('护甲%',attr_mul*7)
    unit:add('生命上限%',attr_mul*7)
    unit:add('魔法上限%',attr_mul)
    unit:add('生命恢复%',attr_mul)
    unit:add('魔法恢复%',attr_mul)
    --设置魔抗 
    unit:add('魔抗%',attr_mul*7)

    -- print('打印是否根据玩家数增加属性2',unit:get('攻击'))
    -- 最终boss、伏地魔玩家倍数增加
    if finds(unit:get_name(),'最终boss','伏地魔') then 
        --属性
        unit:add('攻击%',(ac.g_game_degree_attr -1)*100)
        unit:add('护甲%',(ac.g_game_degree_attr-1)*100)
        unit:add('生命上限%',(ac.g_game_degree_attr-1)*100)
        unit:add('魔法上限%',(ac.g_game_degree_attr-1)*100)
        unit:add('生命恢复%',(ac.g_game_degree_attr-1)*100)
        unit:add('魔法恢复%',(ac.g_game_degree_attr-1)*100)
        --设置魔抗 
        unit:add('魔抗%',(ac.g_game_degree_attr-1)*100)
    end    
end)