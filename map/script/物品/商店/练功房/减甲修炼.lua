
local rect = require 'types.rect'

--物品名称
local mt = ac.skill['减甲修炼']
mt{
--等久
level = 1,

--图标
art = [[shaguaijianjia.blp]],

--说明
tip = [[减甲修炼，杀一只怪+0.02攻击减甲|r]],

--物品类型
item_type = '神符',

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

--冷却
cool = 0,

content_tip = '',
--物品技能
is_skill = true,
--增加值
value = 0.02

}

function mt:on_cast_start()
    local hero = self.owner
    local p = hero:get_owner()
    local ret = 'lgfsg'..p.id
    local name = '苦工'..p.id

    -- local region = ac.map.rects['刷怪']

    -- 根据点击玩家 决定 小金币怪的刷新区域
    -- 只需要传入string 就行
    local cep = ac.creep[name]
    -- cep.region = region
    cep:set_region(ret)
    cep.owner = p
    cep:start()
    
end

ac.wait(10,function()
    for i = 1,10 do 
        local player = ac.player(i)
        if player:is_player() then 
            local name = '苦工'..i
            local mt = ac.creep[name]{    
                creeps_datas = '苦工*20',
                cool = 2,
                is_leave_region_replace = true,
                is_region_replace = true,

            }
            function mt:on_change_creep(unit,lni_data)
                -- print('打印：',name,self.index)
                local index = ac.creep['刷怪'].index
                if index >=60 then 
                    index = 60
                end    
                local name = '进攻怪-'..index
                local data = ac.table.UnitData[name]
                data.attr_mul = lni_data.attr_mul
                data.food = lni_data.food
                --继承进攻怪lni 值
                for k,v in sortpairs(data) do 
                    unit.data[k] = v
                end    
            
                if unit and data  then 
                    -- print(unit.category,data.category)
                    unit.category = data.category
                    for k,v in sortpairs(data.attribute) do 
                        unit:set(k,v)
                    end
                    --设置魔抗
                    unit:set('魔抗',data.attribute['护甲'])
                    --设置 boss 等 属性倍数
                    if lni_data.attr_mul  then
                        --属性
                        unit:set('攻击',data.attribute['攻击'] * lni_data.attr_mul * (1+(ac.g_game_degree_attr-1)*0.5))
                        unit:set('护甲',data.attribute['护甲'] * lni_data.attr_mul * (1+(ac.g_game_degree_attr-1)*0.5))
                        unit:set('生命上限',data.attribute['生命上限'] * lni_data.attr_mul * (1+(ac.g_game_degree_attr-1)*0.5))
                        unit:set('魔法上限',data.attribute['魔法上限'] * lni_data.attr_mul * ac.g_game_degree_attr)
                        unit:set('生命恢复',data.attribute['生命恢复'] * lni_data.attr_mul * ac.g_game_degree_attr)
                        unit:set('魔法恢复',data.attribute['魔法恢复'] * lni_data.attr_mul * ac.g_game_degree_attr)
                        --设置魔抗 
                        unit:set('魔抗',data.attribute['护甲']* lni_data.attr_mul * (1+(ac.g_game_degree_attr-1)*0.5))
                    end
                    --掉落概率
                    unit.fall_rate = 0
                    --掉落金币和经验
                    unit.gold = 0
                    unit.exp = 0

                end 
                --设置搜敌范围
                unit:set_search_range(2000)

                unit:event '单位-死亡' (function(_,unit,killer) 
                    --召唤物杀死的也是算英雄的
                    local p = killer:get_owner()
                    local hero = p.hero
                    hero:add('减甲',ac.skill['减甲修炼'].value)
                end)    
            end
        end    
    end    

end)
