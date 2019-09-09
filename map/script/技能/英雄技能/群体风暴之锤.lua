local mt = ac.skill['群体风暴之锤']

mt{
	--必填
	is_skill = true,
	--初始等级
	level = 1,
	max_level = 5,
	damage = function(self)
		return (self.owner:get('智力')*15+10000)* self.level*5
	end,
	['每秒加智力'] = {50,100,150,200,250},
	['攻击加智力'] = {50,100,150,200,250},
	['杀怪加智力'] = {50,100,150,200,250},
	tip = [[

|cffffff00【每秒加智力】+50*Lv
【攻击加智力】+50*Lv
【杀怪加智力】+50*Lv|r

|cff00bdec【主动施放】对周围敌人造成范围技能伤害
【伤害公式】(智力*15+1w)*Lv*5|r

	]],
	--技能图标 3（40°扇形分三条，角度20%）+3+3+1+1，一共5波，
    art = [[jineng\jineng032.blp]],
	--技能类型
	skill_type = "主动,智力",
	--冷却时间
    cool = 15,
	--技能目标类型 点目标
	target_type = ac.skill.TARGET_TYPE_POINT,
	--施法距离
	range = 1000,
	--施法范围
	area = 500,
	--耗蓝
	cost = 100,
	effect = [[Abilities\Weapons\WaterElementalMissile\WaterElementalMissile.mdl]],
	
}



function mt:on_add()
	local hero = self.owner 
	
end	
function mt:on_cast_shot()
	local skill = self
	local hero = skill.owner
	-- print('射线距离',skill.distance,skill.speed,angle)
	local target = skill.target
	--X射线
	for i, u in ac.selector()
		: in_range(target,self.area)
		: is_enemy(hero)
		: of_not_building()
		: ipairs()
	do
		local mvr = ac.mover.target
		{
			source = hero,
			target = u,
			model = self.effect,
			speed = 1500,
			skill = skill,
		}
		if not mvr then 
			return
		end
		function mvr:on_finish()
			u:damage
			{
				source = skill.owner,
				damage = skill.damage,
				skill = skill,
				damage_type = '法术'
			}
			u:add_buff '晕眩'{
				source = hero,
				skll = skill,
				time = 3
			}
		end	
	end	

end

function mt:on_remove()

    local hero = self.owner 
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end    

end
