
local mt = ac.skill['江湖小虾']
mt{
--等级
level = 0,
--图标
art = [[jhxx.blp]],
--说明
tip = [[|cffffff00【要求地图等级>=3|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff比武积分|cffff0000（武林大会模式获得）|cff00ffff超过 250  自动获得，已拥有积分：|r%wabao_cnt%

|cffFFE799【成就属性】：|r
|cff00ff00+28 杀怪加全属性|r
|cff00ff00+10% 物理伤害加深|r
|cff00ff00+5% 技能伤害加深|r
|cff00ff00+10% 暴击加深|r
|cff00ff00+10% 技暴加深|r
 ]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
['杀怪加全属性'] = 28,
['物理伤害加深'] = 10,
['技能伤害加深'] = 5,
['暴击加深'] = 10,
['技暴加深'] = 10,

wabao_cnt = function(self)
    local p = ac.player.self
    return p.cus_server['比武积分'] or 0
end,

}

local mt = ac.skill['明日之星']
mt{
--等级
level = 0,
--图标
art = [[mrzx.blp]],
--说明
tip = [[|cffffff00【要求地图等级>=6|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff比武积分|cffff0000（武林大会模式获得）|cff00ffff超过 500  自动获得，已拥有积分：|r%wabao_cnt%

|cffFFE799【成就属性】：|r
|cff00ff00+58 杀怪加全属性|r
|cff00ff00+20% 物理伤害加深|r
|cff00ff00+10% 技能伤害加深|r
|cff00ff00+20% 暴击加深|r
|cff00ff00+20% 技暴加深|r
 ]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 58,
['物理伤害加深'] = 20,
['技能伤害加深'] = 10,
['暴击加深'] = 20,
['技暴加深'] = 20,

wabao_cnt = function(self)
    local p = ac.player.self
    return p.cus_server['比武积分'] or 0
end,

}

local mt = ac.skill['武林高手']
mt{
--等级
level = 0,
--图标
art = [[wlgs.blp]],
--说明
tip = [[|cffffff00【要求地图等级>=8|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff比武积分|cffff0000（武林大会模式获得）|cff00ffff超过 1000  自动获得，已拥有积分：|r%wabao_cnt%

|cffFFE799【成就属性】：|r
|cff00ff00+88 杀怪加全属性|r
|cff00ff00+30% 物理伤害加深|r
|cff00ff00+15% 技能伤害加深|r
|cff00ff00+30% 暴击加深|r
|cff00ff00+30% 技暴加深|r
 ]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 88,
['物理伤害加深'] = 30,
['技能伤害加深'] = 15,
['暴击加深'] = 30,
['技暴加深'] = 30,

wabao_cnt = function(self)
    local p = ac.player.self
    return p.cus_server['比武积分'] or 0
end,

}

local mt = ac.skill['绝世奇才']
mt{
--等级
level = 0,
--图标
art = [[jsqc.blp]],
--说明
tip = [[|cffffff00【要求地图等级>=10|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff比武积分|cffff0000（武林大会模式获得）|cff00ffff超过 1500  自动获得，已拥有积分：|r%wabao_cnt%

|cffFFE799【成就属性】：|r
|cff00ff00+128 杀怪加全属性|r
|cff00ff00+35% 物理伤害加深|r
|cff00ff00+20% 技能伤害加深|r
|cff00ff00+35% 暴击伤害加深|r
|cff00ff00+35% 技暴伤害加深|r
 ]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 128,
['物理伤害加深'] = 35,
['技能伤害加深'] = 20,
['暴击加深'] = 35,
['技暴加深'] = 35,

wabao_cnt = function(self)
    local p = ac.player.self
    return p.cus_server['比武积分'] or 0
end,

}
local mt = ac.skill['威震三界']
mt{
--等级
level = 0,
--图标
art = [[wzsj.blp]],
--说明
tip = [[|cffffff00【要求地图等级>=12|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff比武积分|cffff0000（武林大会模式获得）|cff00ffff超过 2000  自动获得，已拥有积分：|r%wabao_cnt%

|cffFFE799【成就属性】：|r
|cff00ff00+158 杀怪加全属性|r
|cff00ff00+45% 物理伤害加深|r
|cff00ff00+25% 技能伤害加深|r
|cff00ff00+45% 暴击伤害加深|r
|cff00ff00+45% 技暴伤害加深|r
 ]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 158,
['物理伤害加深'] = 45,
['技能伤害加深'] = 25,
['暴击加深'] = 45,
['技暴加深'] = 45,

wabao_cnt = function(self)
    local p = ac.player.self
    return p.cus_server['比武积分'] or 0
end,

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
    '江湖小虾','明日之星','武林高手','绝世奇才','威震三界'
}






