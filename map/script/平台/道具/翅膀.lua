--翅膀
local mt = ac.skill['梦蝶仙翼']
mt{
--等级
level = 0,
--图标
art = [[chibang2.blp]],
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
['杀怪加全属性'] = 50,
['生命上限'] = 1000,
['护甲'] = 1000,
['每秒回血'] = 2.5,
--特效
effect = [[chibang2.mdx]]
}

local mt = ac.skill['玄羽绣云翼']
mt{
--等级
level = 0,
--图标
art = [[chibang4.blp]],
--说明
tip = [[地图等级40
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 100,
['生命上限'] = 2000,
['护甲'] = 1000,
--特效
effect = [[chibang4.mdx]]
}

local mt = ac.skill['天罡苍羽翼']
mt{
--等级
level = 0,
--图标
art = [[chibang3.blp]],
--说明
tip = [[最强王者50星
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 450,
['吸血'] = 10,
['攻击间隔'] = -0.05,
--特效
effect = [[chibang3.mdx]]
}


local mt = ac.skill['绝世阳炎翼']
mt{
--等级
level = 0,
--图标
art = [[chibang8.blp]],
--说明
tip = [[商城188
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 600,
['暴击几率'] = 5,
['技暴几率'] = 5,
['全伤加深'] = 5,
--特效
effect = [[chibang8.mdx]]
}

local mt = ac.skill['轮迴幻魔翼']
mt{
--等级
level = 0,
--图标
art = [[chibang7.blp]],
--说明
tip = [[商城218
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 750,
['暴击几率'] = 5,
['技暴几率'] = 5,
['全伤加深'] = 5,
--特效
effect = [[chibang7.mdx]]
}

for i,name in ipairs({'梦蝶仙翼','玄羽绣云翼','天罡苍羽翼','绝世阳炎翼','轮迴幻魔翼'}) do
    local mt = ac.skill[name]
    function mt:on_cast_start()
        local hero = self.owner
        local player = self.owner:get_owner()
        hero = player.hero 
        --改变外观，添加武器
        if hero.effect_chibang then 
            hero.effect_chibang:remove()
        end     
        hero.effect_chibang = hero:add_effect('chest',self.effect)
    end   
    mt.on_add = mt.on_cast_start 
end    