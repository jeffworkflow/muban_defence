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
|cff00ffff挖宝积分超过 4W  自动获得，已拥有积分：|r%wabao_cnt% 或者
|cff00ffff神龙碎片超过 300 自动获得，已拥有碎片：|r%skin_cnt%

|cffFFE799【神兵属性】：|r
|cff00ff00+150 杀怪加攻击|r
|cff00ff00+10% 吸血|r
|cff00ff00+10   攻击减甲|r

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
need_sp_cnt = 300,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 150,
['吸血'] = 10,
['攻击减甲'] = 10,
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
|cff00ff00+300  杀怪加攻击|r
|cff00ff00-0.05 攻击间隔|r
|cff00ff00+10   攻击减甲|r

|cffff0000【点击可更换神兵外观，所有神兵属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 300,
['攻击间隔'] = -0.05,
['攻击减甲'] = 10,
need_map_level = 30,
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
|cff00ffff最强王者40星

|cffFFE799【神兵属性】：|r
|cff00ff00+450  杀怪加攻击|r
|cff00ff00-0.05 攻击间隔|r
|cff00ff00+10%  吸血|r

|cffff0000【点击可更换神兵外观，所有神兵属性可叠加】|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 450,
['吸血'] = 10,
['攻击间隔'] = -0.05,
need_map_level = 10,

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
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff商城购买后自动激活

|cffFFE799【神兵属性】：|r
|cff00ff00+600  杀怪加攻击|r
|cff00ff00+5%   暴击几率|r
|cff00ff00+5%   技暴几率|r
|cff00ff00+5%   全伤加深|r
攻击10%几率造成范围技能伤害（伤害公式：全属性*40）
|cffff0000【点击可更换神兵外观，所有神兵属性可叠加】|r]],
--触发几率
chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
--伤害
damage = function(self)
    return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*40)
end,
--特效2
damage_effect = [[jn_tf2.mdx]],
--伤害范围
damage_area = 800,
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
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff商城购买后自动激活

|cffFFE799【神兵属性】：|r
|cff00ff00+750  杀怪加攻击|r
|cff00ff00+5%   暴击几率|r
|cff00ff00+5%   技暴几率|r
|cff00ff00+5%   全伤加深|r
攻击10%几率造成范围技能伤害（伤害公式：全属性*60）
|cffff0000【点击可更换神兵外观，所有神兵属性可叠加】|r
]],
--触发几率
chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
--伤害
damage = function(self)
    return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*60)
end,
--特效2
damage_effect = [[jn_tf2.mdx]],
--伤害范围
damage_area = 800,
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
    mt.on_cast_start=mt.on_add
    function mt:on_remove()
        local hero = self.owner
        if self.trg then
            self.trg:remove()
            self.trg = nil
        end
    end    
end    