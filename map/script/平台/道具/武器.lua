--商城武器
local mt = ac.skill['霸王莲龙锤']
mt{
--等级
level = 0,
--图标
art = [[wuqi10.blp]],
is_order = 1,
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝积分超过 2W  自动获得，已拥有积分：|r%wabao_cnt% 或者
|cff00ffff神龙碎片超过 150 自动获得，已拥有碎片：|r%skin_cnt%

|cffFFE799【神兵属性】：|r
|cff00ff00+300 杀怪加攻击|r
|cff00ff00+20% 吸血|r
|cff00ff00+35   攻击减甲|r
|cff00ff00+25%  物理伤害加深|r

|cffff0000【点击可更换神兵外观，所有神兵属性可叠加】|r]],
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
need_sp_cnt = 150,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 300,
['吸血'] = 20,
['攻击减甲'] = 35,
['物理伤害加深'] = 25,
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
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff地图等级=%need_map_level%

|cffFFE799【神兵属性】：|r
|cff00ff00+400  杀怪加攻击|r
|cff00ff00-0.05 攻击间隔|r
|cff00ff00+50   攻击减甲|r
|cff00ff00+10%   对BOSS额外伤害|r

|cffff0000【点击可更换神兵外观，所有神兵属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 400,
['攻击间隔'] = -0.05,
['攻击减甲'] = 50,
['对BOSS额外伤害'] = 10,
need_map_level = 20,
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
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff星耀10星

|cffFFE799【神兵属性】：|r
|cff00ff00+500  杀怪加攻击|r
|cff00ff00-0.05 攻击间隔|r
|cff00ff00+50%  吸血|r
|cff00ff00+5%  对BOSS额外伤害|r

|cffff0000【点击可更换神兵外观，所有神兵属性可叠加】|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 500,
['吸血'] = 50,
['攻击间隔'] = -0.05,
['对BOSS额外伤害'] = 5,

need_map_level = 10,

--特效
effect = [[wuqi9.mdx]]
}

local mt = ac.skill['紫色哀伤']
mt{
--等级
level = 0,
--图标
art = [[zsas.blp]],
is_order = 1,
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff荣耀王者15星 

|cffFFE799【神兵属性】：|r
|cff00ff00+600  杀怪加攻击|r
|cff00ff00+50 攻击减甲|r
|cff00ff00+75%  分裂伤害|r
|cff00ff00+50%  物理伤害加深|r
|cff00ff00+10%  对BOSS额外伤害|r

|cffff0000【点击可更换神兵外观，所有神兵属性可叠加】|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 600,
['攻击减甲'] = 50,
['分裂伤害'] = 75,
['物理伤害加深'] = 50,
['对BOSS额外伤害'] = 10,

need_map_level = 13,

--特效
effect = [[wuqi-hy1.mdx]]
}

local mt = ac.skill['霜之哀伤']
mt{
--等级
level = 0,
--图标
art = [[xlmswq.blp]],
is_order = 1,
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff修罗模式25星 

|cffFFE799【神兵属性】：|r
|cff00ff00+700  杀怪加攻击|r
|cff00ff00+100  攻击减甲|r
|cff00ff00+100% 分裂伤害|r
|cff00ff00+75%  物理伤害加深|r
|cff00ff00+15%  对BOSS额外伤害|r

|cffff0000【点击可更换神兵外观，所有神兵属性可叠加】|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 700,
['攻击减甲'] = 100,
['分裂伤害'] = 100,
['物理伤害加深'] = 75,
['对BOSS额外伤害'] = 15,

need_map_level = 16,

--特效
effect = [[BingPoHanGuangJian.mdx]]
}

local mt = ac.skill['飞星雷火剑']
mt{
--等级
level = 0,
--图标
art = [[fxlhj.blp]],
is_order = 1,
--说明
tip = [[
|cffffe799【获得方式】：|r
|cff00ffff地图等级=26级 

|cffFFE799【神兵属性】：|r
|cff00ff00+800  杀怪加攻击|r
|cff00ff00+50%  物理伤害加深|r
|cff00ff00+50%  暴击加深|r
|cff00ff00+15%  对BOSS额外伤害|r
|cff00ff00+15%  全伤加深|r

|cffff0000【点击可更换神兵外观，所有神兵属性可叠加】|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 800,
['物理伤害加深'] = 50,
['暴击加深'] = 50,
['全伤加深'] = 15,
['对BOSS额外伤害'] = 15,

need_map_level = 18,

--特效
effect = [[wuqi123.mdx]]
}

local mt = ac.skill['方天画戟']
mt{
--等级
level = 0,
--图标
art = [[fthj.blp]],
is_order = 1,
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff斗破苍穹|cffff0000累计|cff00ffff无尽波数=500波

|cffFFE799【武器属性】：|r
|cff00ff00+900  杀怪加攻击|r
|cff00ff00+150   攻击减甲|r
|cff00ff00+150% 分裂伤害|r
|cff00ff00+100% 物理伤害加深|r|r

|cffff0000【点击可更换神兵外观，所有神兵属性可叠加】|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 900,
['物理伤害加深'] = 100,
['分裂伤害'] = 150,
['攻击减甲'] = 150,

need_map_level = 26,

--特效
effect = [[Wuqi_fangtainhuaji.mdx]]
}

local mt = ac.skill['圣神无双剑']
mt{
--等级
level = 0,
--图标
art = [[ssws.blp]],
is_order = 1,
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff无上之境|cffff0000累计|cff00ffff无尽波数=150波

|cffFFE799【武器属性】：|r
|cff00ff00+1000  杀怪加攻击|r
|cff00ff00+250   攻击减甲|r
|cff00ff00+50% 技暴加深|r
|cff00ff00+50% 技能伤害加深|r
|cff00ff00+50% 会心伤害|r

|cffff0000【点击可更换神兵外观，所有神兵属性可叠加】|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 1000,
['攻击减甲'] = 250,
['技暴加深'] = 50,
['技能伤害加深'] = 50,
['会心伤害'] = 50,

need_map_level = 31,

--特效
effect = [[Wuqi_tianlongshengjian.mdx]]
}

local mt = ac.skill['灭神紫霄剑']
mt{
--等级
level = 0,
--图标
art = [[mszxj.blp]],
is_order = 1,
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff无限乱斗25星 

|cffFFE799【武器属性】：|r
|cff00ff00+1250  杀怪加攻击|r
|cff00ff00+275   攻击减甲|r
|cff00ff00+50% 分裂伤害|r
|cff00ff00+50% 暴击加深|r
|cff00ff00+50% 物理伤害加深|r
|cff00ff00+50% 会心伤害|r

|cffff0000【点击可更换神兵外观，所有神兵属性可叠加】|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 1250,
['攻击减甲'] = 275,
['分裂伤害'] = 50,
['暴击加深'] = 50,
['物理伤害加深'] = 50,
['会心伤害'] = 50,

need_map_level = 15,

--特效
effect = [[Wuqi_leiguanglanjian.mdx]]
}



local mt = ac.skill['皇帝剑']
mt{
--等级
level = 0,
--图标
art = [[wuqi8.blp]],
is_order = 1,
--说明
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff商城购买后自动激活

|cffFFE799【神兵属性】：|r
|cff00ff00+600  杀怪加攻击|r
|cff00ff00+5%   暴击几率|r
|cff00ff00+100%   暴击加深|r
|cff00ff00+5%   技暴几率|r
|cff00ff00+100%   技暴加深|r
|cff00ff00+25%   全伤加深|r
|cff00ff00攻击10%几率造成范围技能伤害|cff00ffff（伤害公式：全属性*65）

|cffffff00皇帝剑+皇帝刀激活特殊属性：攻击减甲+250，减少周围护甲+1500，分裂伤害+150%

|cffff0000【点击可更换神兵外观，所有神兵属性可叠加】|r]],
--触发几率
chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
--伤害
damage = function(self)
    return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*65)
end,
--特效2
damage_effect = [[jn_tf2.mdx]],
--伤害范围
damage_area = 800,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 600,
['暴击几率'] = 5,
['暴击加深'] = 100,
['技暴几率'] = 5,
['技暴加深'] = 100,
['全伤加深'] = 25,
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
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff商城购买后自动激活

|cffFFE799【神兵属性】：|r
|cff00ff00+750  杀怪加攻击|r
|cff00ff00+5%   暴击几率|r
|cff00ff00+100%   暴击加深|r
|cff00ff00+5%   技暴几率|r
|cff00ff00+100%   技暴加深|r
|cff00ff00+30%   全伤加深|r
|cff00ff00攻击10%几率造成范围技能伤害|cff00ffff（伤害公式：全属性*100）

|cffffff00皇帝剑+皇帝刀激活特殊属性：攻击减甲+250，减少周围护甲+1500，分裂伤害+150%

|cffff0000【点击可更换神兵外观，所有神兵属性可叠加】|r
]],
--触发几率
chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
--伤害
damage = function(self)
    return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*100)
end,
--特效2
damage_effect = [[jn_tf2.mdx]],
--伤害范围
damage_area = 800,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 750,
['暴击几率'] = 5,
['暴击加深'] = 100,
['技暴几率'] = 5,
['技暴加深'] = 100,
['全伤加深'] = 30,
['攻击减甲'] = function(self) 
    local val = 0 
    local p = self.owner:get_owner()
    if (p.mall and p.mall['皇帝剑'] or 0) >=1 then 
        val = 250
    end    
    return val
end,

['减少周围护甲'] = function(self) 
    local val = 0 
    local p = self.owner:get_owner()
    if (p.mall and p.mall['皇帝剑'] or 0) >=1 then 
        val = 1500
    end    
    return val
end,
['分裂伤害'] = function(self) 
    local val = 0 
    local p = self.owner:get_owner()
    if (p.mall and p.mall['皇帝剑'] or 0) >=1 then 
        val = 150
    end    
    return val
end,
--特效
effect = [[wuqi11.mdx]]
}


for i,name in ipairs({'霸王莲龙锤','惊虹奔雷剑','幻海雪饮剑','紫色哀伤','霜之哀伤','飞星雷火剑','方天画戟','皇帝剑','皇帝刀','圣神无双剑','灭神紫霄剑'}) do
    local mt = ac.skill[name]
    function mt:on_cast_start()
        local skill = self
        local hero = self.owner
        local player = self.owner:get_owner()
        hero = player.hero 
        --改变外观，添加武器
        if hero.effect_wuqi then 
            hero.effect_wuqi:remove()
        end     
        local orf = ac.hero_weapon[hero.name] or 'hand'
        hero.effect_wuqi = hero:add_effect(orf,self.effect)

        --添加被动技能
        if finds(name,'皇帝刀','皇帝剑') then
            self.trg = hero:event '造成伤害效果' (function(_,damage)
                if not damage:is_common_attack()  then 
                    return 
                end 
                --触发时修改攻击方式
                if math.random(100) <= self.chance then
                    --创建特效
                    local angle = damage.source:get_point() / damage.target:get_point()
                    ac.effect(damage.source:get_point(),skill.damage_effect,angle,1,'origin'):remove()
                    --计算伤害
                    for _,unit in ac.selector()
                    : in_sector(hero:get_point(),self.damage_area,angle,95 )
                    : is_enemy(hero)
                    : ipairs()
                    do 
                        unit:damage
                        {
                            source = hero,
                            damage = skill.damage,
                            skill = skill,
                            damage_type = '法术'
                        }
                    end 
                end
            end)
        end
    end    
    -- mt.on_cast_start=mt.on_add --自动显示特效
    function mt:on_remove()
        local hero = self.owner
        if self.trg then
            self.trg:remove()
            self.trg = nil
        end
    end    
end    