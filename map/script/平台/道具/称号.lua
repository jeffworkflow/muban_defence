--称号
local mt = ac.skill['炉火纯青']
mt{
--等级
level = 0,
--图标
art = [[lhcq.blp]],
--说明
tip = [[挖宝积分兑换/神龙碎片兑换
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 50,
['生命上限'] = 1000,
['护甲'] = 1000,
['每秒回血'] = 2.5,
--特效
effect = [[lhcq.mdx]]
}

local mt = ac.skill['势不可挡']
mt{
--等级
level = 0,
--图标
art = [[chibang2.blp]],
--说明
tip = [[挖宝积分兑换/神龙碎片兑换
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 50,
['生命上限'] = 1000,
['护甲'] = 1000,
['每秒回血'] = 2.5,
--特效
effect = [[wuqi10.mdx]]
}

local mt = ac.skill['毁天灭地']
mt{
--等级
level = 0,
--图标
art = [[chibang2.blp]],
--说明
tip = [[挖宝积分兑换/神龙碎片兑换
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 50,
['生命上限'] = 1000,
['护甲'] = 1000,
['每秒回血'] = 2.5,
--特效
effect = [[wuqi10.mdx]]
}

local mt = ac.skill['巅峰领域']
mt{
--等级
level = 0,
--图标
art = [[chibang2.blp]],
--说明
tip = [[挖宝积分兑换/神龙碎片兑换
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 50,
['生命上限'] = 1000,
['护甲'] = 1000,
['每秒回血'] = 2.5,
--特效
effect = [[wuqi10.mdx]]
}


local mt = ac.skill['君临天下']
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
effect = [[wuqi10.mdx]]
}

local mt = ac.skill['九世天尊']
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
effect = [[wuqi10.mdx]]
}


local mt = ac.skill['神帝']
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
effect = [[wuqi10.mdx]]
}

local mt = ac.skill['王者归来']
mt{
--等级
level = 0,
--图标
art = [[chibang7.blp]],
--说明
tip = [[替天行道
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 750,
['暴击几率'] = 5,
['技暴几率'] = 5,
['全伤加深'] = 5,
--特效
effect = [[wuqi10.mdx]]
}


for i,name in ipairs({'炉火纯青','势不可挡','毁天灭地','巅峰领域','君临天下','九世天尊','神帝','王者归来'}) do
    local mt = ac.skill[name]
    function mt:on_cast_start()
        local hero = self.owner
        local player = self.owner:get_owner()
        hero = player.hero 
        --改变外观，添加武器
        if hero.effect_chenghao then 
            hero.effect_chenghao:remove()
        end     
        hero.effect_chenghao = hero:add_effect('overhead',self.effect)
    end    
    mt.on_add = mt.on_cast_start
end    