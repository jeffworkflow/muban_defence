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
title = '绝世魔剑1',
--图标
art = [[ydss.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff消耗 |cffff0000三十根喜鹊翎毛|r |cff00ffff兑换获得

|cffFFE799【成就属性】：|r
|cff00ff00+13.8   杀怪加全属性|r
|cff00ff00+13.8   攻击减甲|r
|cff00ff00+13.8%  木头加成|r
|cff00ff00+13.8%  会心伤害|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
attack = 100,
attack_gap = 0.5,
skill_attack = 10,
}
local mt = ac.skill['绝世魔剑2']
mt{
--等级
level = 0, --要动态插入
title = '绝世魔剑2',
--图标
art = [[ydss.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r
杀怪加全属性+38*Lv
获得一个随从-绝世魔剑，攻击间隔=0.95
魔剑攻击力=150%任务攻击力
魔剑攻击5%概率造成范围物理伤害（伤害公式：英雄攻击力*4）
继承英雄暴击几率/暴击加深/物理伤害加深/全伤加深

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
attack = 200,
attack_gap = 0.5,
skill_attack = 20,
}

local mt = ac.skill['绝世魔剑3']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[ydss.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff消耗 |cffff0000三十根喜鹊翎毛|r |cff00ffff兑换获得

|cffFFE799【成就属性】：|r
|cff00ff00+13.8   杀怪加全属性|r
|cff00ff00+13.8   攻击减甲|r
|cff00ff00+13.8%  木头加成|r
|cff00ff00+13.8%  会心伤害|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
attack = 300,
attack_gap = 0.5,
skill_attack = 30,
}

local mt = ac.skill['绝世魔剑4']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[ydss.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r
【魔剑属性】
杀怪加全属性+38*Lv
获得一个随从-绝世魔剑，攻击间隔=0.5
魔剑攻击力=600%任务攻击力
魔剑攻击5%概率造成范围物理伤害（伤害公式：英雄攻击力*20）
继承英雄暴击几率/暴击加深/物理伤害加深/全伤加深

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
attack = 600,
attack_gap = 0.5,
skill_attack = 40,
}

for i=1,11 do 
    local mt = ac.skill['绝世魔剑'..i]
    function mt:on_add()
        local skill =self
        local hero = self.owner
        local p = hero:get_owner()
        if p.id >10 then return end 
        
        local attribute ={
            ['攻击'] = function() return hero:get('攻击')*skill.attack end,
            ['攻击间隔'] = function() return hero:get('攻击间隔')*skill.attack_gap end,
            ['攻击速度'] = function() return hero:get('攻击速度') end,
            ['生命上限'] = function() return hero:get('生命上限') end,
            ['魔法上限'] = function() return hero:get('魔法上限') end,
            ['生命恢复'] = function() return hero:get('生命恢复') end,
            ['魔法恢复'] = function() return hero:get('魔法恢复') end,
            ['移动速度'] = function() return hero:get('移动速度') end,

            ['分裂伤害'] = function() return hero:get('分裂伤害') end,
            ['攻击减甲'] = function() return hero:get('攻击减甲') end,
            ['暴击几率'] = function() return hero:get('暴击几率') end,
            ['暴击伤害'] = function() return hero:get('暴击伤害') end,
            ['会心几率'] = function() return hero:get('会心几率') end,
            ['会心伤害'] = function() return hero:get('会心伤害') end,

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
            print(skl.skill_attack,self.skill_attack)
            skl.skill_attack = self.skill_attack
        end   
        --  
    end
end

local mt = ac.skill['绝世魔剑']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[jchd.blp]],
    title = '绝世魔剑',
    tip = [[

查看精彩活动
    ]],
    
}

mt.skills = {
    '绝世魔剑1','绝世魔剑2','绝世魔剑3','绝世魔剑4',
    -- '绝世魔剑5','绝世魔剑6','绝世魔剑7','绝世魔剑8',
    -- '绝世魔剑9','绝世魔剑10','绝世魔剑11',
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