
local mt = ac.skill['江湖小虾']
mt{
--等级
level = 0,
--图标
art = [[rlsh.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff在平台上，本地图的全部评论数超过 5.5W 自动激活

|cffFFE799【奖励属性】：|r
|cff00ff00+20%  杀敌数加成|r
|cff00ff00+10   攻击减甲|r
|cff00ff00+2%   对BOSS额外伤害|r
|cff00ff00+1%   会心几率|r
|cff00ff00+10%  会心伤害|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
['杀敌数加成'] = 20,
['攻击减甲'] = 10,
['对BOSS额外伤害'] = 2,
['会心几率'] = 1,
['会心伤害'] = 10,

}

local mt = ac.skill['明日之星']
mt{
--等级
level = 0,
--图标
art = [[ypxg.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff在平台上，本地图的全部评论数超过 7.5W 自动激活

|cffFFE799【奖励属性】：|r
|cff00ff00+30   攻击减甲|r
|cff00ff00+20%  物理伤害加深|r
|cff00ff00+10%  技能伤害加深|r
|cff00ff00+10%  全伤加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['攻击减甲'] = 30,
['物理伤害加深'] = 20,
['技能伤害加深'] = 10,
['全伤加深'] = 10,
need_map_level = 8,

}

local mt = ac.skill['武林高手']
mt{
--等级
level = 0,
--图标
art = [[ypxg.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff在平台上，本地图的全部评论数超过 7.5W 自动激活

|cffFFE799【奖励属性】：|r
|cff00ff00+30   攻击减甲|r
|cff00ff00+20%  物理伤害加深|r
|cff00ff00+10%  技能伤害加深|r
|cff00ff00+10%  全伤加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['攻击减甲'] = 30,
['物理伤害加深'] = 20,
['技能伤害加深'] = 10,
['全伤加深'] = 10,
need_map_level = 8,

}


local mt = ac.skill['武林大会']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[jhxx.blp]],
    title = '武林大会',
    tip = [[

查看武林大会
    ]],
    
}
mt.skills = {
    '江湖小虾','明日之星','武林高手'
}






