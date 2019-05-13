local mt = ac.skill['恶德医疗']

mt{
	--必填
	is_skill = true,
	
	--初始等级
	level = 1,
	max_level = 5,
	tip = [[
		主动：朝指定区域释放恶德医疗，对敌人造成 攻击力*2+智力*5 法术伤害 （%damage%） ；对友军英雄回复其 %life_rate% % 的最大生命值
		被动：主动释放的增益效果 + %value% %
	]],
	
	--技能图标
	art = [[jineng\jineng011.blp]],

	--技能目标类型 无目标
	target_type = ac.skill.TARGET_TYPE_POINT,

	--马甲移动距离
	distance = 600,
	--马甲移动速度
	speed = 800,

	--碰撞范围
	hit_area = 300,

	--主动释放的增益效果
	value = 30,

	--伤害
	damage = function(self,hero)
		return hero:get('攻击')*2 + hero:get('智力')*5
	end,	

	--生命上限
	life_rate = 10,

	--cd 5
	cool = 5,

	--耗蓝 20
	cost = {20,166.5,276,395.5,500},

	--特效模型
	effect = [[Abilities\Spells\Undead\CarrionSwarm\CarrionSwarmMissile.mdl]],
	-- effect = [[Hero_Juggernaut_N4S_F_Source.mdx]],
	
	--施法距离
	range = 600,
}

--恶得医疗
--角度
local function damage_shot(skill,angle)
	local skill = skill
	local hero = skill.owner
	-- print('射线距离',skill.distance,skill.speed,angle)
	--X射线
	local mvr = ac.mover.line
	{
		source = hero,
		distance = skill.distance,
		speed = skill.speed,
		skill = skill,
		angle = angle,
		high = 50,
		model = skill.effect, 
		hit_area = skill.hit_area,
		hit_type = '全部',
		size = 1
	}
	if not mvr then 
		return
	end
	function mvr:on_hit(dest)
		if dest:is_enemy(hero) then 
			dest:damage
			{
				source = skill.owner,
				damage = skill.damage,
				skill = skill,
				missile = skill.mover,
				damage_type = '法术'
			}
		else
			dest:heal 
			{
				source = hero,
				skill = skill,
				size = 10,
				string = '治疗',
				heal = hero:get('生命上限')*skill.life_rate/100 ,
			}
		end	
	end	
	hero:heal 
	{
		source = hero,
		skill = skill,
		size = 10,
		string = '治疗',
		heal = hero:get('生命上限')*skill.life_rate/100 ,
	}
end

function mt:on_add()
	local hero = self.owner 
	hero:add('主动释放的增益效果',self.value)

end	
function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
	local target = self.target
	local angle = hero:get_point() / target:get_point() 

	damage_shot(skill,angle)
	
	
end

function mt:on_remove()

    local hero = self.owner 
	hero:add('主动释放的增益效果',-self.value)
	
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end    

end
