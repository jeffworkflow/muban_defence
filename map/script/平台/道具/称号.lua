--称号
local mt = ac.skill['炉火纯青']
mt{
--等级
level = 0,
--图标
art = [[lhcq.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff青铜1星 

|cffFFE799【称号属性】：|r
|cff00ff00+15  杀怪加全属性|r
|cff00ff00+5%  杀敌数加成|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 15,
['杀敌数加成'] = 5,
need_map_level = 2,
--特效
effect = [[lhcq.mdx]]
}

local mt = ac.skill['势不可挡']
mt{
--等级
level = 0,
--图标
art = [[sbkd.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝积分超过 2K 自动获得，已拥有积分：|r%wabao_cnt% 或者
|cff00ffff消耗勇士徽章 15 兑换获得

|cffFFE799【称号属性】：|r
|cff00ff00+50   杀怪加攻击|r
|cff00ff00+500  护甲|r
|cff00ff00+10% 物品获取率|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

wabao_cnt = function(self)
    local p = ac.player.self
    return p.cus_server['挖宝积分'] or 0
end,

['杀怪加攻击'] = 50,
['护甲'] = 500,
['物品获取率'] = 10,
need_map_level = 3,
--特效
effect = [[sbkd.mdx]]
}

local mt = ac.skill['毁天灭地']
mt{
--等级
level = 0,
--图标
art = [[htmd.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff黄金3星 

|cffFFE799【称号属性】：|r
|cff00ff00+30    杀怪加全属性|r
|cff00ff00+20%   物理伤害加深|r
|cff00ff00+2.5%  全伤加深|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 30,
['物理伤害加深'] = 20,
['全伤加深'] = 2.5,
need_map_level = 4,
--特效
effect = [[htmd.mdx]]
}

local mt = ac.skill['风驰电掣']
mt{
--等级
level = 0,
--图标
art = [[dfty.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff钻石5星 

|cffFFE799【称号属性】：|r
|cff00ff00+68   杀怪加全属性|r
|cff00ff00+30   攻击减甲|r
|cff00ff00+15%  物品获取率|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 68,
['攻击减甲'] = 30,
['物品获取率'] = 15,
need_map_level = 6,
--特效
effect = [[fengjiws6 - 副本.mdx]]
}


local mt = ac.skill['君临天下']
mt{
--等级
level = 0,
--图标
art = [[jltx.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff消耗勇士徽章  75  兑换获得

|cffFFE799【称号属性】：|r
|cff00ff00+250  杀怪加攻击|r
|cff00ff00+15%   全伤加深|r
|cff00ff00+35%   分裂伤害|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 250,
['全伤加深'] = 15,
['分裂伤害'] = 35,
need_map_level = 7,

--特效
effect = [[jltx.mdx]]
}

local mt = ac.skill['无双魅影']
mt{
--等级
level = 0,
--图标
art = [[jstz.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff王者5星

|cffFFE799【称号属性】：|r
|cff00ff00+100 杀怪加全属性|r
|cff00ff00+5%  免伤|r
|cff00ff00+25%  全伤加深|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 100,
['免伤'] = 5,
['全伤加深'] = 25,
need_map_level = 8,

--特效
effect = [[myws.mdx]]
}


local mt = ac.skill['神帝']
mt{
--等级
level = 0,
--图标
art = [[shendi.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff消耗勇士徽章  200  兑换获得

|cffFFE799【称号属性】：|r
|cff00ff00+500  杀怪加攻击|r
|cff00ff00+800  减少周围护甲|r
|cff00ff00-0.05 攻击间隔|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 500,
['减少周围护甲'] = 800,
['攻击间隔'] = -0.05,
need_map_level = 9,
--特效
effect = [[shendi.mdx]]
}

local mt = ac.skill['傲世天下']
mt{
--等级
level = 0,
--图标
art = [[wzgl.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff消耗勇士徽章  350  兑换获得

|cffFFE799【称号属性】：|r
|cff00ff00+268  杀怪加全属性|r
|cff00ff00+10%   免伤几率|r
|cff00ff00+10%   对BOSS额外伤害|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 750,
['对BOSS额外伤害'] = 10,
['免伤几率'] = 10,
need_map_level = 10,
--特效
effect = [[vip.mdx]]
}


local mt = ac.skill['九洲帝王']
mt{
--等级
level = 0, 
--图标
art = [[jzdw.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【成就说明】：|r
|cff00ffff通过 国庆活动 获得

|cffFFE799【成就属性】：|r
|cff00ff00+26.8   杀怪加全属性|r
|cff00ff00+26.8   攻击减甲|r
|cff00ff00+26.8%  杀敌数加成|r
|cff00ff00+26.8%  全伤加深|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 26.8,
['攻击减甲'] = 26.8,
['杀敌数加成'] = 26.8,
['全伤加深'] = 26.8,

need_map_level = 5,
--特效
effect = [[fm_jzdwch.mdx]]
}

local mt = ac.skill['真龙天子']
mt{
--等级
level = 0,
--图标
art = [[zltz.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff商城购买自动激活

|cffFFE799【称号属性】：|r
|cff00ff00+488   杀怪加全属性|r
|cff00ff00+488   攻击减甲|r
|cff00ff00+488%  全伤加深|r
|cff00ffff+50%   每秒回血|r
|cff00ffff+10%  闪避|r
|cffff0000+15%   会心几率|r
|cffff0000+150%  会心伤害|r

|cffdf19d0攻击10%几率造成范围技能伤害|cff00ffff（伤害公式：全属性*150）

|cffffff00齐天大圣+真龙天子激活：攻击减甲+288，全伤加深+288%

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 488,
['每秒回血'] = 50,
['会心几率'] = 15,
['会心伤害'] = 150,
['闪避'] = 10,
--特效
effect = [[zhenlongtianzi.mdx]],

['攻击减甲'] = function(self) 
    local val = 488 
    local p = self.owner:get_owner()
    if (p.mall and p.mall['齐天大圣A'] or 0) >=1 or (p.mall and p.mall['齐天大圣B'] or 0) >=1  then 
        val = val + 288
    end    
    return val
end,  
['全伤加深'] = function(self) 
    local val = 488 
    local p = self.owner:get_owner()
    if (p.mall and p.mall['齐天大圣A'] or 0) >=1 or (p.mall and p.mall['齐天大圣B'] or 0) >=1  then 
        val = val + 288
    end    
    return val
end,  
effect1 = [[Hero_EmberSpirit_N4S_F_Blast.mdx]],
--触发几率
chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
cool = 1,
ignore_cool_save = true,
area = 600,
--伤害
damage = function(self)
    return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*150)
end,
}
function mt:on_add()
    local hero =self.owner
    local skill =self
    self.trg = hero:event '造成伤害效果' (function(_,damage)
        if not damage:is_common_attack()  then 
            return 
        end 
		--技能是否正在CD
        if skill:is_cooling() then
			return 
		end
        --触发时修改攻击方式
        if math.random(100) <= self.chance then
            --创建特效
            local angle = damage.source:get_point() / damage.target:get_point()
            ac.effect(damage.target:get_point(),skill.effect1,angle,1,'origin'):remove()
            --计算伤害
            for _,unit in ac.selector()
            : in_range(damage.target:get_point(),self.area)
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
            --激活cd
            skill:active_cd()
        end
    end)
end    
function mt:on_remove()
    if self.trg then 
        self.trg:remove()
        self.trg = nil
    end   
end    

local mt = ac.skill['独孤求败']
mt{
--等级
level = 0,
--图标
art = [[dgqb.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff进入|cffffff00修罗模式/斗破苍穹/无上之境/乱斗/挖宝/比武-今日排行榜前十名（按F6查看）|cff00ffff即可获得|r
|cffcccccc（非永久存档称号，掉出排行榜将失去称号）|r

|cffFFE799【称号属性】：|r
|cff00ff00+368   杀怪加全属性|r
|cff00ff00+200   攻击减甲|r
|cff00ff00+5%    会心几率|r
|cff00ff00+100%  会心伤害|r
|cff00ff00+168%  全伤加深|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 368,
['攻击减甲'] = 200,
['会心几率'] = 5,
['会心伤害'] = 100,
['全伤加深'] = 168,
need_map_level = 8,
--特效
effect = [[CH_duguqiubai.mdx]]
}
function mt:on_add()
    local hero = self.owner
    local player = self.owner:get_owner()
    hero = player.hero 
    --改变外观，添加武器
    if hero.effect_chenghao then 
        hero.effect_chenghao:remove()
    end     
    hero.effect_chenghao = hero:add_effect('overhead',self.effect)
end    


local mt = ac.skill['逆天改命']
mt{
--等级
level = 0, 
--图标
art = [[ntgm.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff深渊乱斗25星

|cffFFE799【称号属性】：|r
|cff00ff00+1250 杀怪加攻击|r
|cff00ff00+50% 技暴加深|r
|cff00ff00+50% 技能伤害加深|r
|cff00ff00+50% 会心伤害|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 1250,
['技暴加深'] = 50,
['技能伤害加深'] = 50,
['会心伤害'] = 50,

need_map_level = 17,
--特效
effect = [[CH_nitiangaiming.mdx]]
}



for i,name in ipairs({'炉火纯青','势不可挡','毁天灭地','风驰电掣','君临天下','无双魅影','神帝','傲世天下','真龙天子','九洲帝王','独孤求败','逆天改命'}) do
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
    -- mt.on_add = mt.on_cast_start --自动显示特效
end    