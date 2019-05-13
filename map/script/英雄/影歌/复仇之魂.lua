local mt = ac.skill['复仇之魂']

mt{
	--必填
	is_skill = true,
	
	--初始等级
	level = 1,
	--是否被动
	passive = true,
	
	tip = [[
		被动：攻击有 %chance% % 概率召唤 复仇之魂 (无敌,无碰撞体积，属性与智力相关）
		|cff1FA5EE召唤物|r:
	]],
	
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNSpiritOfVengeance.blp]],

	--技能目标类型 无目标
	target_type = ac.skill.TARGET_TYPE_NONE,

	--几率
	chance = 5,

	--持续时间
	time = 25,

	attr_mul = 1,

	--特效模型
	effect = [[units\nightelf\Vengeance\Vengeance.mdl]],
	weapon_model = [[Abilities\Weapons\VengeanceMissile\VengeanceMissile.mdl]]
	
}
function mt:on_add()
    local skill = self
	local hero = self.owner
	
	self.trg = hero:event '单位-发动攻击'  (function(trg, damage)

		local rand = math.random(1,100)

		if rand <= self.chance then 

			local point = hero:get_point()-{hero:get_facing(),100}
			local unit = hero:get_owner():create_unit('幻象马甲-蝗虫',point)	
			local p_hero = hero:get_owner().hero
			
			local index = ac.creep['刷怪'].index 
			if not index or index == 0 then 
				index = 1
			end	
			index = index + ac.creep['刷怪-无尽'].index 

			local life_mul, defence_mul, attack_mul = ac.get_summon_mul(index)
			local data = {}
			data.attribute={
				['生命上限'] = p_hero:get('智力') * life_mul*1.5,
				['护甲'] = p_hero:get('智力') * defence_mul*1.5,
				['攻击'] = p_hero:get('智力') * attack_mul*1.5,
				['魔法上限'] = 60,
				['移动速度'] = 325,
				['攻击间隔'] = 1,
				['生命恢复'] = 1.2,
				['魔法恢复'] = 0.6,
				['攻击距离'] = 100,
			}

			
			self.buff = unit:add_buff '召唤物' {
				time = self.time,
				attribute = data.attribute,
				attr_mul = self.attr_mul - 1,
				skill = self,
				follow = true,
				model = self.effect,
			}
			unit:add_restriction '无敌'
			
			unit:add('攻击距离', 800)
			if not unit.weapon then 
				unit.weapon = {}
			end    
			unit.weapon['弹道模型'] = self.weapon_model
			unit.weapon['弹道速度'] = 1000

		end	

	end)	

end	

function mt:on_remove()

    local hero = self.owner 
	
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end  
    -- if self.buff then
    --     self.buff:remove()
    --     self.buff = nil
    -- end     

end
