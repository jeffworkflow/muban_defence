--翅膀
local mt = ac.skill['梦蝶仙翼']
mt{
--等级
level = 0,
--图标
art = [[chibang2.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝积分超过 3W 自动获得，已拥有积分：|r%wabao_cnt% 或者
|cff00ffff神龙碎片超过 400 自动获得，已拥有碎片：|r%skin_cnt%

|cffFFE799【翅膀属性】：|r
|cff00ff00+100     杀怪加全属性|r
|cff00ff00+2000W 生命|r
|cff00ff00+2000   护甲
|cff00ff00+5%   免伤几率|r

|cffff0000【点击可更换翅膀外观，所有翅膀属性可叠加】|r
]],
need_map_level = 10,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[self.name..'碎片'] or 0
end,
wabao_cnt = function(self)
    local p = ac.player.self
    return p.cus_server['挖宝积分'] or 0
end,
--所需激活碎片
need_sp_cnt = 400,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 100,
['生命上限'] = 20000000,
['护甲'] = 2000,
['免伤几率'] = 5,
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
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff|cff00ffff地图等级=%need_map_level%

|cffFFE799【翅膀属性】：|r
|cff00ff00+150    杀怪加全属性|r
|cff00ff00+3000W 生命|r
|cff00ff00+3000   护甲
|cff00ff00+5%   闪避|r

|cffff0000【点击可更换翅膀外观，所有翅膀属性可叠加】|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 100,
['生命上限'] = 20000000,
['护甲'] = 2000,
['闪避'] = 5,
need_map_level = 40,
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
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff最强王者50星

|cffFFE799【翅膀属性】：|r
|cff00ff00+150    杀怪加全属性|r
|cff00ff00+3000W 生命|r
|cff00ff00+3000   护甲
|cff00ff00+5%   每秒回血|r
|cff00ff00+2.5%   免伤|r

|cffff0000【点击可更换翅膀外观，所有翅膀属性可叠加】|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 150,
['生命上限'] = 30000000,
['护甲'] = 3000,
['免伤'] = 2.5,
['每秒回血'] = 5,
need_map_level = 10,
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
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff商城购买后自动激活

|cffFFE799【翅膀属性】：|r
|cff00ff00+200    杀怪加全属性|r
|cff00ff00+10    每秒加护甲|r
|cff00ff00+10%   闪避|r
|cff00ff00+10%   免伤几率|r

|cffff0000【点击可更换翅膀外观，所有翅膀属性可叠加】|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 200,
['每秒加护甲'] = 10,
['免伤几率'] = 10,
['闪避'] = 10,
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
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff商城购买后自动激活

|cffFFE799【翅膀属性】：|r
|cff00ff00+250    杀怪加全属性|r
|cff00ff00+10    每秒加护甲|r
|cff00ff00+10%   免伤|r
|cff00ff00+10%   免伤几率|r

|cffff0000【点击可更换翅膀外观，所有翅膀属性可叠加】|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 250,
['每秒加护甲'] = 10,
['免伤几率'] = 10,
['免伤'] = 10,
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
    -- mt.on_add = mt.on_cast_start --自动显示特效
end    