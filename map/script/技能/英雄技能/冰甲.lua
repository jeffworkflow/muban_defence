local mt = ac.skill['冰甲']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "主动",
	--耗蓝
	cost = {10,50,100,200,400},
	--冷却时间 7
	cool = 7,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_UNIT,
	--施法距离
	range = 800,
	--介绍
	tip = [[|cff11ccff%skill_type%:|r 增加 %defence% % 护甲持续15秒，受击时减少敌人移速和攻速持续4秒
	]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNFrostArmor.blp]],
	--特效
	effect = [[Abilities\Spells\Undead\FrostArmor\FrostArmorTarget.mdl]],
	--护甲
	defence = {20,30,40,65,100},
	--持续时间
	time = 15,
	--移动速度
	move_speed = {40,45,50,55,60},
	--移动速度
	attack_speed = {20,25,30,35,40},
	--减少时间
	reduce_time = 4,
	--目标允许	
	target_data = '联盟 玩家单位 自己',
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end
function mt:on_cast_shot()
	local skill = self
	local hero = self.target

	if  hero and hero:is_alive() then 

		hero:add_buff '冰甲'
		{
			skill = skill,
			model = skill.effect,
			value = skill.defence,
			time = skill.time,
			move_speed = skill.move_speed,
			attack_speed = skill.attack_speed,
			reduce_time = skill.reduce_time
		}
	end	

end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end



local mt = ac.buff['冰甲']
mt.ref = 'chest' 
mt.cover_type = 1
mt.cover_max = 1
mt.keep = true

function mt:on_add()
	local hero =self.target;
	self.eff = hero:add_effect(self.ref,self.model)

	hero:add('护甲%',self.value * (1+hero:get('主动释放的增益效果')/100))

	self.trg = hero:event '受到伤害效果' (function (_,damage)

		--怪物受到伤害时，伤害来源为英雄。给伤害来源添加晕眩buff，来源为怪物本身
		local source = damage.source
		damage.source:add_buff '冰甲-被动'
		{
			source = hero,
			skill = self.skill,
			time = self.reduce_time,
			move_speed = self.move_speed,
			attack_speed = self.attack_speed,
			value = self.move_speed,
		}
			
	end)
end
function mt:on_remove()
	if self.eff then self.eff:remove() self.eff =nil end 
	if self.trg then self.trg:remove() self.trg =nil end 

	local hero =self.target;
	hero:add('护甲%',- self.value * (1+hero:get('主动释放的增益效果')/100))
	
end
function mt:on_cover(new)
	return new.value > self.value
end


local mt = ac.buff['冰甲-被动']
mt.ref = 'origin' 
mt.cover_type = 1
mt.cover_max = 1
mt.debuff = true

function mt:on_add()
	local hero =self.target;
	self.eff = hero:add_effect(self.ref,[[Abilities\Spells\Other\FrostDamage\FrostDamage.mdl]])

	hero:add('攻击速度',-self.attack_speed)
	hero:add('移动速度%',-self.move_speed)
    -- print(hero,hero:get('移动速度'))
	
end
function mt:on_remove()
	local hero =self.target;
	hero:add('攻击速度',self.attack_speed)
	hero:add('移动速度%',self.move_speed)

	if self.eff then self.eff:remove() self.eff =nil end 
	if self.trg then self.trg:remove() self.trg =nil end 
	
end
function mt:on_cover(new)
	return new.value > self.value
end




