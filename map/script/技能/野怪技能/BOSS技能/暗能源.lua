local mt = ac.skill['暗能源']
mt{
--初始等级
level = 1,
--施法信息
cast_start_time = 0,
cast_channel_time = 1,
cast_shot_time = 0,
cast_finish_time = 1,
--技能图标
art = [[icon\card\2\card2_6.blp]],
--技能说明
title = '暗能源',
tip = [[
    持续对'area'范围内的敌人造成伤害与晕眩
]],
--范围
area = 500,
--消耗
cost_data = {	type = '魔法',	num_type = '三维',	rate = 0.2,},
--伤害
damage_type = '暗',
damage_data = {
	{		base = 0,		attr = '攻击',		rate = 3,		},
},
--持续时间
time = 3,
--减速比例%
spd_div = 50,
--次数
num = 5,
--冷却
cool = 10
}
mt.effect = [[Abilities\Weapons\AvengerMissile\AvengerMissile.mdl]]

function mt:boss_skill_shot()
    local hero = self.owner
    local skill = self
    -- local damage_data = skill:damage_data_cal()
    
    local time = 3
    local num = 20
    local list = {}
    local group = {}
    local speed = skill.area/time
    for i = 1,num do
        list[i] = hero:follow
        {
            start = hero:get_point(),
            source = hero,
            skill = skill,
            model = skill.effect,
            angle = 360/10*i,
            angle_speed = 120,
            distance_speed = speed,
            size = 2,
            high = 50,
        }
    end

    local timer
	local tm = 0
    timer = ac.loop(0.1*1000,function()
    	tm = tm + 1
    	local point = hero:get_point()
    	for _,u in ac.selector()
	    	: in_range( point, speed * tm * 0.1 )
	    	: is_enemy(hero)
            : is_not(ac.key_unit)
	    	: ipairs()
    	do
	    	if not group[u] then
		    	if point * u:get_point() > speed * tm * 0.1 -120 then
			    	group[u] = true
			        u:damage
                    {
                        source = hero,
                        skill = self,
                        damage = hero:get('攻击')*10
                    }

		    		u:add_effect('chest',skill.effect):remove()
	    		end
    		end
    	end
    end)

    hero:wait(time*1000,function()
    	timer:remove()
		tm = 0
		group = {}
	    timer = ac.loop(0.1*1000,function()
	    	tm = tm + 1
    		local point = hero:get_point()
	    	for _,u in ac.selector()
		    	: in_range( point, skill.area - speed * tm * 0.1 + 50 )
		    	: is_enemy(hero)
		    	: ipairs()
	    	do
		    	if not group[u] then
			    	if point * u:get_point() > skill.area - speed * tm * 0.1 -100 then
				    	group[u] = true
                        u:damage
                        {
                            source = hero,
                            skill = self,
                            damage = hero:get('攻击')*10
                        }
		    			u:add_effect('chest',skill.effect):remove()
			    	end
		    	end
	    	end
	    end)
        for i = 1,num do
            list[i]:remove()
            list[i] = hero:follow
            {
                start = hero:get_point() - {360/10*i,skill.area},
                distance = skill.area,
                source = hero,
                skill = skill,
                model = skill.effect,
                angle = 360/10*i,
                angle_speed = 120,
                distance_speed = -skill.area/time,
                size = 2,
                high = 50,
            }
        end
        hero:wait(time*1000,function()
    		timer:remove()
            for i = 1,num do
                list[i]:remove()
            end
        end)
    end)
end

function mt:on_cast_start()
    self.eft = ac.warning_effect_ring
    {
        point = self.owner:get_point(),
        area = self.area,
        time = self.cast_channel_time,
    }
end

function mt:on_cast_shot()
    self:boss_skill_shot()
end

function mt:on_cast_stop()
    if self.eft then
        self.eft:remove()
    end
end

local mt = ac.buff['暗能源-发射']
mt.pulse = 0.03
function mt:on_add()
end