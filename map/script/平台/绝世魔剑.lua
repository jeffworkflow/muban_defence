local mt = ac.skill['魔剑攻击']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --触发几率
   chance = function(self) return 5*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--被动
	passive = true,
	--伤害
	damage = function(self)
  return self.owner:get('攻击')*self.skill_attack
end,
	--介绍
	tip = [[]],
	--技能图标
	art = [[yinudan.blp]],
	--特效
    effect = [[MXXXT28 -  F.mdx]],
    skill_attack = 2,
	cool = 1
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    
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
            print('魔剑攻击',self.skill_attack)
			--创建特效
			local angle = damage.source:get_point() / damage.target:get_point()
			ac.effect(damage.source:get_point(),skill.effect,angle,1,'origin'):remove()
			--计算伤害
			for _,unit in ac.selector()
			: in_range(damage.target:get_point(),self.damage_area)
			: is_enemy(hero)
			: ipairs()
			do 
				unit:damage
				{
					source = hero,
					damage = skill.damage,
					skill = skill,
				}
			end 
            --激活cd
            skill:active_cd()
        end
    end)
end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end



local mt = ac.skill['绝世魔剑1']
mt{
--等级
level = 0, --要动态插入
title = '魔剑获得（N1）',
--图标
art = [[jueshimojian.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00无限BOSS模式下，通关|cffffff00难1|cff00ff00获得

|cffFFE799【魔剑属性】：|r
|cff00ff00获得一个随从-绝世魔剑
|cff00ffff魔剑攻击力=100%英雄攻击力
|cffffff00魔剑攻击5%概率造成范围物理伤害（伤害公式：英雄攻击力*2）
|cffff0000继承英雄暴击几率/加深，会心几率/加深，物伤/全伤加深]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 3,
attack = 100,
attack_gap = 1,
skill_attack = 2,
}

local mt = ac.skill['绝世魔剑2']
mt{
--等级
level = 0, --要动态插入
title = '魔剑升级（N2）',
--图标
art = [[jueshimojian.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00无限BOSS模式下，通关|cffffff00难2|cff00ff00获得|cffff0000（如果之前的魔剑未激活，将先激活之前的魔剑存档）

|cffFFE799【魔剑属性】：|r
|cff00ff00获得一个随从-绝世魔剑
|cff00ffff魔剑攻击力=150%英雄攻击力
|cffffff00魔剑攻击5%概率造成范围物理伤害（伤害公式：英雄攻击力*4）
|cffff0000继承英雄暴击几率/加深，会心几率/加深，物伤/全伤加深]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
attack = 150,
attack_gap = 0.95,
skill_attack = 4,
}

local mt = ac.skill['绝世魔剑3']
mt{
--等级
level = 0, --要动态插入
--图标
title = '魔剑升级（N3）',
--图标
art = [[jueshimojian.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00无限BOSS模式下，通关|cffffff00难3|cff00ff00获得|cffff0000（如果之前的魔剑未激活，将先激活之前的魔剑存档）

|cffFFE799【魔剑属性】：|r
|cff00ff00获得一个随从-绝世魔剑
|cff00ffff魔剑攻击力=200%英雄攻击力
|cffffff00魔剑攻击5%概率造成范围物理伤害（伤害公式：英雄攻击力*6）
|cffff0000继承英雄暴击几率/加深，会心几率/加深，物伤/全伤加深]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 7,
attack = 200,
attack_gap = 0.9,
skill_attack = 6,
}

local mt = ac.skill['绝世魔剑4']
mt{
--等级
level = 0, --要动态插入
--图标
title = '魔剑升级（N4）',
--图标
art = [[jueshimojian.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00无限BOSS模式下，通关|cffffff00难4|cff00ff00获得|cffff0000（如果之前的魔剑未激活，将先激活之前的魔剑存档）

|cffFFE799【魔剑属性】：|r
|cff00ff00获得一个随从-绝世魔剑
|cff00ffff魔剑攻击力=250%英雄攻击力
|cffffff00魔剑攻击5%概率造成范围物理伤害（伤害公式：英雄攻击力*8）
|cffff0000继承英雄暴击几率/加深，会心几率/加深，物伤/全伤加深]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 9,
attack = 250,
attack_gap = 0.85,
skill_attack = 8,
}

local mt = ac.skill['绝世魔剑5']
mt{
--等级
level = 0, --要动态插入
--图标
title = '魔剑升级（N5）',
--图标
art = [[jueshimojian.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00无限BOSS模式下，通关|cffffff00难5|cff00ff00获得|cffff0000（如果之前的魔剑未激活，将先激活之前的魔剑存档）

|cffFFE799【魔剑属性】：|r
|cff00ff00获得一个随从-绝世魔剑
|cff00ffff魔剑攻击力=300%英雄攻击力
|cffffff00魔剑攻击5%概率造成范围物理伤害（伤害公式：英雄攻击力*10）
|cffff0000继承英雄暴击几率/加深，会心几率/加深，物伤/全伤加深]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 11,
attack = 300,
attack_gap = 0.8,
skill_attack = 10,
}
local mt = ac.skill['绝世魔剑6']
mt{
--等级
level = 0, --要动态插入
--图标
title = '魔剑升级（N6）',
--图标
art = [[jueshimojian.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00无限BOSS模式下，通关|cffffff00难6|cff00ff00获得|cffff0000（如果之前的魔剑未激活，将先激活之前的魔剑存档）

|cffFFE799【魔剑属性】：|r
|cff00ff00获得一个随从-绝世魔剑
|cff00ffff魔剑攻击力=350%英雄攻击力
|cffffff00魔剑攻击5%概率造成范围物理伤害（伤害公式：英雄攻击力*12）
|cffff0000继承英雄暴击几率/加深，会心几率/加深，物伤/全伤加深]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 13,
attack = 350,
attack_gap = 0.75,
skill_attack = 12,
}
local mt = ac.skill['绝世魔剑7']
mt{
--等级
level = 0, --要动态插入
--图标
title = '魔剑升级（N7）',
--图标
art = [[jueshimojian.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00无限BOSS模式下，通关|cffffff00难7|cff00ff00获得|cffff0000（如果之前的魔剑未激活，将先激活之前的魔剑存档）

|cffFFE799【魔剑属性】：|r
|cff00ff00获得一个随从-绝世魔剑
|cff00ffff魔剑攻击力=400%英雄攻击力
|cffffff00魔剑攻击5%概率造成范围物理伤害（伤害公式：英雄攻击力*14）
|cffff0000继承英雄暴击几率/加深，会心几率/加深，物伤/全伤加深]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 15,
attack = 400,
attack_gap = 0.7,
skill_attack = 14,
}
local mt = ac.skill['绝世魔剑8']
mt{
--等级
level = 0, --要动态插入
--图标
title = '魔剑升级（N8）',
--图标
art = [[jueshimojian.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00无限BOSS模式下，通关|cffffff00难8|cff00ff00获得|cffff0000（如果之前的魔剑未激活，将先激活之前的魔剑存档）

|cffFFE799【魔剑属性】：|r
|cff00ff00获得一个随从-绝世魔剑
|cff00ffff魔剑攻击力=450%英雄攻击力
|cffffff00魔剑攻击5%概率造成范围物理伤害（伤害公式：英雄攻击力*16）
|cffff0000继承英雄暴击几率/加深，会心几率/加深，物伤/全伤加深]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 17,
attack = 450,
attack_gap = 0.65,
skill_attack = 16,
}
local mt = ac.skill['绝世魔剑9']
mt{
--等级
level = 0, --要动态插入
--图标
title = '魔剑升级（N9）',
--图标
art = [[jueshimojian.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00无限BOSS模式下，通关|cffffff00难9|cff00ff00获得|cffff0000（如果之前的魔剑未激活，将先激活之前的魔剑存档）

|cffFFE799【魔剑属性】：|r
|cff00ff00获得一个随从-绝世魔剑
|cff00ffff魔剑攻击力=500%英雄攻击力
|cffffff00魔剑攻击5%概率造成范围物理伤害（伤害公式：英雄攻击力*18）
|cffff0000继承英雄暴击几率/加深，会心几率/加深，物伤/全伤加深]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 19,
attack = 500,
attack_gap = 0.6,
skill_attack = 18,
}
local mt = ac.skill['绝世魔剑10']
mt{
--等级
level = 0, --要动态插入
--图标
title = '魔剑升级（N10）',
--图标
art = [[jueshimojian.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00无限BOSS模式下，通关|cffffff00难10|cff00ff00获得|cffff0000（如果之前的魔剑未激活，将先激活之前的魔剑存档）

|cffFFE799【魔剑属性】：|r
|cff00ff00获得一个随从-绝世魔剑
|cff00ffff魔剑攻击力=550%英雄攻击力
|cffffff00魔剑攻击5%概率造成范围物理伤害（伤害公式：英雄攻击力*20）
|cffff0000继承英雄暴击几率/加深，会心几率/加深，物伤/全伤加深]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 21,
attack = 550,
attack_gap = 0.55,
skill_attack = 20,
}

for i=1,11 do 
    local mt = ac.skill['绝世魔剑'..i]
    function mt:on_add()
        local skill =self
        local hero = self.owner
        local p = hero:get_owner()
        if p.id >10 then return end 
        
        local attribute ={
            ['攻击'] = function() return hero:get('攻击')*skill.attack*0.01 end,
            ['攻击间隔'] = function() return skill.attack_gap end,
            ['攻击速度'] = function() return hero:get('攻击速度') end,
            ['生命上限'] = function() return hero:get('生命上限') end,
            ['魔法上限'] = function() return hero:get('魔法上限') end,
            ['生命恢复'] = function() return hero:get('生命恢复') end,
            ['魔法恢复'] = function() return hero:get('魔法恢复') end,
            ['移动速度'] = 522,

            
            
            ['暴击几率'] = function() return hero:get('暴击几率') end,
            ['暴击伤害'] = function() return hero:get('暴击伤害') end,
            ['会心几率'] = function() return hero:get('会心几率') end,
            ['会心伤害'] = function() return hero:get('会心伤害') end,
            ['物理伤害加深'] = function() return hero:get('物理伤害加深') end,
            ['全伤加深'] = function() return hero:get('全伤加深') end,

            ['物品获取率'] = function() return hero:get('物品获取率') end,
            ['木头加成'] = function() return hero:get('木头加成') end,
            ['金币加成'] = function() return hero:get('金币加成') end,
            ['杀敌数加成'] = function() return hero:get('杀敌数加成') end,
            ['火灵加成'] = function() return hero:get('火灵加成') end,
        }
        p.attribute = attribute

        if not p.unit_mojian then 
            p.unit_mojian = p:create_unit('绝世魔剑',hero:get_point()-{math.random(360),100})
            p.unit_mojian:remove_ability 'AInv'
            p.unit_mojian:add_ability 'Aloc'
            p.unit_mojian:add_restriction '无敌'
            p.unit_mojian:add_buff "召唤物"{
                attribute = attribute,
                skill = self,
                follow = true,
                search_area = 500, --搜敌路径    
            }
            --每秒刷新召唤物的属性
            p.unit_mojian:loop(1000,function()
                for k, v in sortpairs(p.attribute) do
                    local val = v
                    if type(v) == 'function' then 
                        val = v()
                        p.unit_mojian:set(k, val)
                    end	
                end
                -- print('攻击',p.attribute['攻击']())
            end)
        end   
        
        --技能相关
        local skl = p.unit_mojian:find_skill('魔剑攻击',nil)
        if not skl then 
            skl = p.unit_mojian:add_skill('魔剑攻击','隐藏')
            skl.skill_attack = self.skill_attack
        else 
            -- print(skl.skill_attack,self.skill_attack)
            skl.skill_attack = self.skill_attack
        end   
        --  
    end
end

local mt = ac.skill['绝世魔剑']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[jueshimojian.blp]],
    title = '绝世魔剑',
    tip = [[

查看绝世魔剑
    ]],
    
}

mt.skills = {
    '绝世魔剑1','绝世魔剑2','绝世魔剑3','绝世魔剑4',
    '绝世魔剑5','绝世魔剑6','绝世魔剑7','绝世魔剑8',
    '绝世魔剑9','绝世魔剑10',
}

function mt:on_add()
    local hero = self.owner 
    local player = hero:get_owner() 
    for index,skill in ipairs(self.skill_book) do 
        local has_mall = (player.cus_server['绝世魔剑']or 0 ) - index >= 0
        if has_mall and player:Map_GetMapLevel()>=skill.need_map_level then 
            skill:set_level(1)
        end
    end
end