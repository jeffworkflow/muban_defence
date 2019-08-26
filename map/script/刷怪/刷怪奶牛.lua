

-- {'nainiu11', 

for i=1,3 do 
    local mt = ac.creep['奶牛'..i]{    
        creeps_datas = '奶牛*15',
        region = 'nainiu1'..i,
        cool = 1,
        create_unit_cool = 0,
    }
    function mt:on_change_creep(unit,lni_data)
        --设置搜敌范围
        unit:set_search_range(1000)
        unit:event '单位-死亡'(function(_,unit,killer)
            local player = killer.owner
            local hero = player.hero
            --概率 超级彩蛋
            local rate = 0.02
            -- local rate = 10 --测试
            local rand = math.random(100000)/1000
            if rand <= rate then 
                --掉落
                local skl = hero:find_skill('无敌破坏神',nil,true)
                if not skl then 
                    ac.game:event_notify('技能-插入魔法书',hero,'超级彩蛋','无敌破坏神')
                    ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r 杀牛一时爽，一直杀牛一直爽，|r 获得成就|cffff0000 "无敌破坏神" |r，奖励 |cffff00005000万全属性，物理伤害加深+200%，技能伤害加深+100%|r',6)
                end    
            end 
        end)
    end  
end    

local mt = ac.creep['物品吞噬极限']{    
    creeps_datas = '吞噬极限守卫*15',
    region = 'tssx11',
    cool = 1,
    create_unit_cool = 0,
    -- cool_count = 3,
}
function mt:on_change_creep(unit,lni_data)
    --设置搜敌范围
    unit:set_search_range(1000)
end  


local mt = ac.creep['技能强化极限']{    
    creeps_datas = '强化极限守卫*15',
    region = 'tssx22',
    cool = 1,
    create_unit_cool = 0,
    -- cool_count = 3,
}
function mt:on_change_creep(unit,lni_data)
    --设置搜敌范围
    unit:set_search_range(1000)
end  


local mt = ac.creep['暴击几率极限']{    
    creeps_datas = '暴击极限守卫*15',
    region = 'tssx33',
    cool = 1,
    create_unit_cool = 0,
    -- cool_count = 3,
}
function mt:on_change_creep(unit,lni_data)
    --设置搜敌范围
    unit:set_search_range(1000)
end  


local mt = ac.creep['免伤几率极限']{    
    creeps_datas = '免伤几率极限守卫*15',
    region = 'tssx44',
    cool = 1,
    create_unit_cool = 0,
    -- cool_count = 3,
}
function mt:on_change_creep(unit,lni_data)
    --设置搜敌范围
    unit:set_search_range(1000)
end  


local mt = ac.creep['技暴几率极限']{    
    creeps_datas = '技暴极限守卫*15',
    region = 'tsjx55',
    cool = 1,
    create_unit_cool = 0,
    -- cool_count = 3,
}
function mt:on_change_creep(unit,lni_data)
    --设置搜敌范围
    unit:set_search_range(1000)
end  

local mt = ac.creep['闪避极限']{    
    creeps_datas = '闪避极限守卫*15',
    region = 'tsjx66',
    cool = 1,
    create_unit_cool = 0,
    -- cool_count = 3,
}
function mt:on_change_creep(unit,lni_data)
    --设置搜敌范围
    unit:set_search_range(1000)
end  

local mt = ac.creep['会心几率极限']{    
    creeps_datas = '会心极限守卫*15',
    region = 'tsjx77',
    cool = 1,
    create_unit_cool = 0,
    -- cool_count = 3,
}
function mt:on_change_creep(unit,lni_data)
    --设置搜敌范围
    unit:set_search_range(1000)
end  

local mt = ac.creep['免伤极限']{    
    creeps_datas = '免伤极限守卫*15',
    region = 'tsjx88',
    cool = 1,
    create_unit_cool = 0,
    -- cool_count = 3,
}
function mt:on_change_creep(unit,lni_data)
    --设置搜敌范围
    unit:set_search_range(1000)
end  
