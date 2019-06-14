--商城武器
local mt = ac.skill['霸王莲龙锤']
mt{
--等级
level = 0,
--图标
art = [[wuqi10.blp]],
is_order = 1,
--说明
tip = [[挖宝积分兑换/神龙碎片兑换
激活地图等级：%need_map_level%
已拥有碎片：%skin_cnt%
]],
need_map_level = 3,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[self.name..'碎片'] or 0
end,
--所需激活碎片
need_sp_cnt = 50,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 150,
['吸血'] = 10,
['减甲'] = 10,
--特效
effect = [[wuqi10.mdx]]
}

local mt = ac.skill['惊虹奔雷剑']
mt{
--等级
level = 0,
--图标
art = [[wuqi13.blp]],
is_order = 1,
--说明
tip = [[地图等级30
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 300,
['攻击间隔'] = -0.05,
['减甲'] = 10,
--特效
effect = [[wuqi13.mdx]]
}

local mt = ac.skill['幻海雪饮剑']
mt{
--等级
level = 0,
--图标
art = [[wuqi9.blp]],
is_order = 1,
--说明
tip = [[最强王者40星
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 450,
['吸血'] = 10,
['攻击间隔'] = -0.05,
--特效
effect = [[wuqi9.mdx]]
}


local mt = ac.skill['皇帝剑']
mt{
--等级
level = 0,
--图标
art = [[wuqi8.blp]],
is_order = 1,
--说明
tip = [[商城88
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 600,
['暴击几率'] = 5,
['技暴几率'] = 5,
['全伤加深'] = 5,
--特效
effect = [[wuqi8.mdx]]
}

local mt = ac.skill['皇帝刀']
mt{
--等级
level = 0,
--图标
art = [[wuqi11.blp]],
is_order = 1,
--说明
tip = [[商城128
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 750,
['暴击几率'] = 5,
['技暴几率'] = 5,
['全伤加深'] = 5,
--特效
effect = [[wuqi11.mdx]]
}


for i,name in ipairs({'霸王莲龙锤','惊虹奔雷剑','幻海雪饮剑','皇帝剑','皇帝刀'}) do
    local mt = ac.skill[name]
    function mt:on_add()
        local hero = self.owner
        local player = self.owner:get_owner()
        hero = player.hero 
        --改变外观，添加武器
        if hero.effect_wuqi then 
            hero.effect_wuqi:remove()
        end     
        local orf = ac.hero_weapon[hero.name] or 'hand'
        hero.effect_wuqi = hero:add_effect(orf,self.effect)
    end    
    mt.on_cast_start=mt.on_add
end    