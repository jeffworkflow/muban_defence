local blessing ={
    -- '蔚蓝石像的祝福',
    -- '疾风的祝福','幽灵的祝福',
    -- '战神的祝福','墨翟的祝福','虚灵的祝福',
    -- '我爱罗的祝福','铁匠的祝福',
    '葛布的祝福'
}
for i,name in ipairs(blessing) do 
    local mt = ac.buff[name]
    mt.cover_type = 1
    mt.cover_max = 1
    function mt:on_add()
        self.target:add_skill(name,'隐藏')
    end    
    function mt:on_remove()
        self.target:remove_skill(name)
    end
end    

local mt = ac.skill['蔚蓝石像的祝福']
mt{
    ['智力%'] = 100,
    ['触发概率加成'] = 50,
    ['技暴几率'] = 50,
    ['技暴加深'] = 800,
    ['会心伤害'] = 400,
    ['技能伤害加深'] = 200,
    ['全伤加深'] = 100,
}
local mt = ac.skill['疾风的祝福']
mt{
    ['攻击速度'] = 500,
    ['攻击间隔'] = -0.1,
    ['攻击距离'] = 1000,
    ['多重射'] = 3,
    ['攻击减甲'] = 800,
    ['移动速度'] = 200,
}
local mt = ac.skill['幽灵的祝福']
mt{
    ['敏捷%'] = 100,
    ['暴击几率'] = 50,
    ['暴击加深'] = 1000,
    ['会心伤害'] = 500,
    ['物理伤害加深'] = 250,
    ['全伤加深'] = 125,
}

local mt = ac.skill['战神的祝福']
mt{
    ['攻击速度'] = 500,
    ['攻击间隔'] = -0.1,
    ['攻击距离'] = 1000,
    ['多重射'] = 3,
    ['攻击减甲'] = 800,
    ['移动速度'] = 200,
}
local mt = ac.skill['墨翟的祝福']
mt{
    ['攻击速度'] = 500,
    ['攻击间隔'] = -0.1,
    ['攻击距离'] = 1000,
    ['多重射'] = 3,
    ['攻击减甲'] = 800,
    ['移动速度'] = 200,
}
local mt = ac.skill['虚灵的祝福']
mt{
    ['攻击速度'] = 500,
    ['攻击间隔'] = -0.1,
    ['攻击距离'] = 1000,
    ['多重射'] = 3,
    ['攻击减甲'] = 800,
    ['移动速度'] = 200,
}
local mt = ac.skill['我爱罗的祝福']
mt{
    ['攻击速度'] = 500,
    ['攻击间隔'] = -0.1,
    ['攻击距离'] = 1000,
    ['多重射'] = 3,
    ['攻击减甲'] = 800,
    ['移动速度'] = 200,
}
local mt = ac.skill['铁匠的祝福']
mt{
}
function mt:on_add()
    local p = self.owner:get_owner()
    local id =p.id
    local point = ac.map.rects['练功房刷怪'..id]:get_point()
    for i=1,2 do 
        ac.item.create_item('随机技能书',point)
        local name = ac.quality_item['红'][math.random(#ac.quality_item['红'])]
        ac.item.create_item(name,point)
    end    
    
    ac.item.create_item('吞噬丹',point):set_item_count(2)
    ac.item.create_item('恶魔果实',point):set_item_count(2)
    ac.item.create_item('点金石',point):set_item_count(20)
end    


local mt = ac.skill['葛布的祝福']
mt{
}
function mt:on_add()
    local p = self.owner:get_owner()
    p.old_up_fall_wabao = p.up_fall_wabao
    p.up_fall_wabao = p.up_fall_wabao + 100 --挖宝几率提高一倍
    p.peon_wabao = true --宠物可挖宝
    p.cnt_award_wabao = 2 --挖宝收益翻倍
end   
function mt:on_remove()
    local p = self.owner:get_owner()
    p.up_fall_wabao = p.old_up_fall_wabao
    p.peon_wabao = false 
    p.cnt_award_wabao = 1
end    





ac.game:event '选择难度' (function(_,g_game_degree_name)
    if g_game_degree_name ~= '乱斗模式' then 
        return
    end    
    --改变怪物出怪间隔
    for i=1,3 do 
        local mt = ac.creep['刷怪'..i]
        mt.force_cool = 120
        --改变怪物
        function mt:on_change_creep(unit,lni_data)
            --设置搜敌范围
            unit:set_search_range(1000)
            local point = ac.map.rects['主城']:get_point()
            unit:issue_order('attack',point)
            
            --改变怪物极限属性
            unit:set('移动速度',522)
            unit:set('攻击间隔',0.9)
            unit:set('攻击速度',500)
            unit:set('闪避',50)
            unit:set('暴击几率',50)
            unit:set('会心几率',50)
        end
    end

    --改变boss极限属性
    ac.game:event '单位-创建' (function(_,unit)
        local str = table.concat(ac.attack_boss)
        if finds(str,unit:get_name()) then
            unit:set('移动速度',522)
            unit:set('攻击间隔',0.9)
            unit:set('攻击速度',500)
            unit:set('闪避',50)
            unit:set('暴击几率',50)
            unit:set('会心几率',50) 
        end    
    end)

    --改变练功房的怪物重生时间  在练功师处完成

    --每5分钟随机一种祝福
    local time =10
    ac.loop(time * 1000,function()
        local name = blessing[math.random(#blessing)]
        for i=1,10 do 
            local p = ac.player(i)
            if p:is_player() then 
                p.hero:add_buff(name){
                    time = time
                }
            end
        end    
        ac.player.self:sendMsg('当前祝福:'..name)    
    end)
end)





















