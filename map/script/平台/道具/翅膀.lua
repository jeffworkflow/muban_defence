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
|cff00ffff神龙碎片超过 200 自动获得，已拥有碎片：|r%skin_cnt%

|cffFFE799【翅膀属性】：|r
|cff00ff00+100     杀怪加全属性|r
|cff00ff00+2000W 生命|r
|cff00ff00+2000   护甲
|cff00ff00+10%   免伤几率|r

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
need_sp_cnt = 200,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 100,
['生命上限'] = 20000000,
['护甲'] = 2000,
['免伤几率'] = 10,
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
|cff00ff00+350     杀怪加全属性|r
|cff00ff00+3000W 初始生命|r
|cff00ff00+3000  初始护甲
|cff00ff00+10%     闪避|r
|cff00ff00+25     每秒加木头|r

|cffff0000【点击可更换翅膀外观，所有翅膀属性可叠加】|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 350,
['生命上限'] = 20000000,
['护甲'] = 2000,
['闪避'] = 10,
['每秒加木头'] = 25,
need_map_level = 30,
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
|cff00ffff王者10星

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

local mt = ac.skill['白龙凝酥翼']
mt{
--等级
level = 0,
--图标
art = [[chibang9.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff巅峰王者15星

|cffFFE799【翅膀属性】：|r
|cff00ff00+200  杀怪加全属性|r
|cff00ff00+5    每秒加护甲|r
|cff00ff00+20%  触发概率加成
|cff00ff00+5%   技暴几率|r
|cff00ff00+50%  技暴加深|r

|cffff0000【点击可更换翅膀外观，所有翅膀属性可叠加】|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 150,
['每秒加护甲'] = 5,
['触发概率加成'] = 20,
['技暴几率'] = 5,
['技暴加深'] = 50,
need_map_level = 15,
--特效
effect = [[chibang9.mdx]]
}

local mt = ac.skill['天使之光']
mt{
--等级
level = 0,
--图标
art = [[tszg.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff修罗模式|cffff0000累计|cff00ffff无尽波数=150波

|cffFFE799【翅膀属性】：|r
|cff00ff00+250  杀怪加全属性|r
|cff00ff00+750  减少周围护甲|r
|cff00ff00+5    每秒加护甲
|cff00ff00+1500 初始护甲|r
|cff00ff00+10%  技能冷却|r

|cffff0000【点击可更换翅膀外观，所有翅膀属性可叠加】|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 250,
['减少周围护甲'] = 750,
['每秒加护甲'] = 5,
['护甲'] = 1500,
['技能冷却'] = 10,
need_map_level = 18,
--特效
effect = [[Hero_Slayer_N5S_F_Chest.mdx]]
}

local mt = ac.skill['白羽金虹翼']
mt{
--等级
level = 0,
--图标
art = [[byjhy.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff|cff00ffff地图等级=%need_map_level%

|cffFFE799【翅膀属性】：|r
|cff00ff00+300  杀怪加全属性|r
|cff00ff00+2500W  初始生命|r
|cff00ff00+2500   初始护甲|r
|cff00ff00+20%  对BOSS额外伤害|r
|cff00ff00+25   每秒加火灵|r

|cffff0000【点击可更换翅膀外观，所有翅膀属性可叠加】|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 300,
['初始生命'] = 25000000,
['护甲'] = 2500,
['对BOSS额外伤害'] = 20,
['每秒加火灵'] = 25,
need_map_level = 28,
--特效
effect = [[chibang03.mdx]]
}

local mt = ac.skill['龙吟双形翼']
mt{
--等级
level = 0,
--图标
art = [[lysxy.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff无上之境25星

|cffFFE799【翅膀属性】：|r
|cff00ff00+350  杀怪加全属性|r
|cff00ff00+350  攻击减甲|r
|cff00ff00+3500W  初始生命|r
|cff00ff00+3500   初始护甲|r
|cff00ff00+5    每秒加杀敌数|r

|cffff0000【点击可更换翅膀外观，所有翅膀属性可叠加】|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 350,
['初始生命'] = 35000000,
['护甲'] = 3500,
['攻击减甲'] = 350,
['每秒加杀敌数'] = 5,
need_map_level = 29,
--特效
effect = [[Cb_tianlongshengyiBlue.mdx]]
}

local mt = ac.skill['金鳞双型翼']
mt{
--等级
level = 0,
--图标
art = [[wujinleiji500.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff无上之境|cffff0000累计|cff00ffff无尽波数=500波

|cffFFE799【翅膀属性】：|r
|cff00ff00+350  杀怪加全属性|r
|cff00ff00+350  攻击减甲|r
|cff00ff00+25%  技能伤害加深|r
|cff00ff00+25%  对BOSS额外伤害|r
|cff00ff00+25%  会心伤害|r

|cffff0000【点击可更换翅膀外观，所有翅膀属性可叠加】|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 350,
['攻击减甲'] = 350,
['技能伤害加深'] = 25,
['对BOSS额外伤害'] = 25,
['会心伤害'] = 25,
need_map_level = 33,
--特效
effect = [[Cb_tianlongshengyi.MDX]]
}

local mt = ac.skill['赤魔双形翼']
mt{
--等级
level = 0,
--图标
art = [[cmsxy.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff无限乱斗|cffff0000累计|cff00ffff无尽波数=300波

|cffFFE799【翅膀属性】：|r
|cff00ff00+400  杀怪加全属性|r
|cff00ff00+400  攻击减甲|r
|cff00ff00+5    每秒加杀敌数|r
|cff00ff00+15   每秒加木头|r
|cff00ff00+25   每秒加火灵|r
|cff00ff00+40%  全伤加深|r

|cffff0000【点击可更换翅膀外观，所有翅膀属性可叠加】|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 400,
['攻击减甲'] = 400,
['每秒加杀敌数'] = 5,
['每秒加木头'] = 15,
['每秒加火灵'] = 25,
['全伤加深'] = 40,
need_map_level = 36,
--特效
effect = [[Cb_tianlongshengyiBlack.MDX]]
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
|cff00ff00+388    攻击加全属性|r
|cff00ff00+688    每秒加全属性|r
|cff00ff00+10    每秒加护甲|r
|cff00ff00+10%   闪避|r
|cff00ff00+10%   免伤几率|r
|cff00ff00+10%   对BOSS额外伤害|r

|cffffff00轮迴幻魔翼+绝世阳炎翼可激活属性：全伤加深+100%， 会心伤害+100%

|cffff0000【点击可更换翅膀外观，所有翅膀属性可叠加】|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 200,
['每秒加全属性'] = 688,
['攻击加全属性'] = 388,
['每秒加护甲'] = 10,
['免伤几率'] = 10,
['对BOSS额外伤害'] = 10,
['闪避'] = 10,
['全伤加深'] = function(self) 
    local val = 0 
    local p = self.owner:get_owner()
    if (p.mall and p.mall['轮迴幻魔翼'] or 1) >=1 then 
        val = 100
    end    
    return val
end,

['会心伤害'] = function(self) 
    local val = 0 
    local p = self.owner:get_owner()
    if (p.mall and p.mall['轮迴幻魔翼'] or 1) >=1 then 
        val = 100
    end    
    return val
end,

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
|cff00ff00+488    攻击加全属性|r
|cff00ff00+788    每秒加全属性|r
|cff00ff00+10    每秒加护甲|r
|cff00ff00+10%   免伤|r
|cff00ff00+10%   免伤几率|r
|cff00ff00+10%   对BOSS额外伤害|r

|cffffff00轮迴幻魔翼+绝世阳炎翼可激活属性：全伤加深+100%， 会心伤害+100%

|cffff0000【点击可更换翅膀外观，所有翅膀属性可叠加】|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 250,
['每秒加全属性'] = 788,
['攻击加全属性'] = 488,
['每秒加护甲'] = 10,
['免伤几率'] = 10,
['对BOSS额外伤害'] = 10,
['免伤'] = 10,
--特效
effect = [[chibang7.mdx]]
}

for i,name in ipairs({'梦蝶仙翼','玄羽绣云翼','天罡苍羽翼','白龙凝酥翼','天使之光','白羽金虹翼','龙吟双形翼','金鳞双型翼','赤魔双形翼','绝世阳炎翼','轮迴幻魔翼'}) do
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