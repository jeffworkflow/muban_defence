local mt = ac.skill['超新星']
mt{
passive = 1,
--初始等级
level = 1,
--技能图标
art = [[icon\card\2\card2_2.blp]],
--技能说明
title = '超新星',
tip = [[
扑街然后站起来
攻击带分裂
]],
--伤害
damage_type = '火',
--范围
area = 1000,
--每秒生命伤害比例
rate = 20,
--变蛋时间,
time = 5,
--冷却
cool = 300,
--分裂伤害攻击范围
range1 = 75,
range2 = 125,
range3 = 150,
}
mt.effect1 = [[model\orbfirex.mdx]]
mt.effect2 = [[model\birdshit_1.mdx]]
mt.effect3 = [[model\warmth.mdx]]

function mt:on_add()
	local hero = self.owner
	local skill = self
	self.trg = {}
	self.trg[1] = hero:event '单位-即将死亡' (function()
		if self:get_cd() == 0 then
			hero:add_buff '超新星-BUFF'
			{
				skill = skill,
				time = skill.time,
			}
			self:active_cd(skill.cool)
			return true
		end
	end)
    self.trg[2] = hero:event '造成伤害开始' (function (_,damage)
    	local rate

        if damage:is_common_attack() == false then 
            return 
        end 
        
        if damage.is_cleave_attack then 
            return 
        end 
        for _,u in ac.selector()
            : in_range(hero,skill.range3)
            : is_enemy(hero)
			: is_not(ac.key_unit)
            : ipairs()
        do 
            if u ~= damage.target then 
	            if u:get_point() * hero:get_point() < skill.range1 then
		            rate = 100
	            elseif u:get_point() * hero:get_point() < skill.range1 then
		            rate = 75
	            else
		            rate = 50
                end
                u:damage
                {
                    source = hero,
                    skill = skill,
                    damage = damage.current_damage * rate / 100,
                    damage_type = '物理',
                    common_attack = true,
                }
            end
        end
    end)
end

function mt:on_remove()
	self.trg[1]:remove()
	self.trg[2]:remove()
end


local mt = ac.buff['超新星-BUFF']
mt.pulse = 0.2

function mt:on_pulse()
	local hero = self.target
	local skill = self.skill
	for _,u in ac.selector()
		: in_range(hero,skill.area)
		: is_enemy(hero)
		: is_not(ac.key_unit)
		: ipairs()
	do
		u:damage
		{
			source = hero,
			target = u,
			damage = u:get('生命上限')*skill.rate/100*self.pulse,
			skill = self.skill
		}
	end
end
function mt:on_add()
	local hero = self.target
	local skill = self.skill
	hero:add_restriction '无敌'
	hero:add_restriction '禁魔'
	hero:add_restriction '缴械'
	hero:add_restriction '硬直'

	hero:set('生命',hero:get('生命上限'))

	self.eft = {
		[1] = ac.effect_ex
		{
			point = hero:get_point(),
			model = skill.effect1,
			size = 5,
		},
		[2] = ac.effect_ex
		{
			point = hero:get_point(),
			model = skill.effect2,
			size = 3,
		},
		[3] = ac.effect_ex
		{
			point = hero:get_point(),
			model = skill.effect3,
			size = 1,
		},
	}
	
end
function mt:on_remove()
	local hero = self.target
	hero:remove_restriction '无敌'
	hero:remove_restriction '禁魔'
	hero:remove_restriction '缴械'
	hero:remove_restriction '硬直'

	for k,v in ipairs(self.eft) do
		-- print(k,v)
		v:remove()
	end
end