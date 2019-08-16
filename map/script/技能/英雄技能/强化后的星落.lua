local mt = ac.skill['强化后的星落']

mt{
    --必填
    is_skill = true,
    --初始等级
    level = 5,
    --最大等级
   max_level = 5,
   ['每秒加智力'] = {100,200,300,400,500},
   ['攻击加智力'] = {100,200,300,400,500},
   ['杀怪加智力'] = {100,200,300,400,500},
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
   damage = function(self)
	return (self.owner:get('智力')*80+10000)* self.level
  end,
	tip = [[
		
|cffffff00【每秒加智力】+100*Lv
【攻击加智力】+100*Lv
【杀怪加智力】+100*Lv|r

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】(智力*80+1w)*Lv|r

]],
	--技能图标 3（40°扇形分三条，角度20%）+3+3+1+1，一共5波，
    art = [[xingluo.blp]],
	--技能类型
	skill_type = "被动,智力",
	--被动
	passive = true,
	--技能目标类型 无目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--冷却时间
	cool = 3,
	ignore_cool_save = true,
	--延迟1秒轰炸
	delay_time = 2.5,
	--碰撞范围
	area = 500,
	--碰撞范围
	range = 1200,
	--耗蓝
	cost = 100,
	effect = [[AZ_Kaer_D1.mdx]],
	effect2 = [[Hero_EmberSpirit_N4S_C_Cicle.mdx]],
	
	damage_type = '法术'
}

local function damage_shot(skill,target)
    local self = skill
	local hero = self.owner
	--在目标区域创建特效
	--预警圈
    self.eft = ac.warning_effect_ring
    {
        point = target,
        area = self.area,
        time = self.delay_time,
	}

	--圈圈
	-- ac.effect(self.target,self.effect2,0,1.2,'origin'):remove()
	-- ac.timer(0.3*1000,2,function()
	-- 	ac.effect(self.target,self.effect2,0,1.2,'origin'):remove()
	-- end)
	--陨石
	ac.wait(1000,function() 
		local eff1 = ac.effect(target,self.effect,0,1,'origin')

		ac.wait((self.delay_time-1)*1000,function()
			eff1:remove()
			for i, u in ac.selector()
				: in_range(target,self.area)
				: is_enemy(hero)
				: of_not_building()
				: ipairs()
			do
				u:damage
				{
					source = hero,
					damage = skill.damage ,
					skill = skill,
					damage_type =skill.damage_type
				}	
			end 
		end)
	end)	
end


function mt:on_upgrade()
	local hero = self.owner
end

function mt:on_add()
	local hero = self.owner 
    local skill = self

    --注册触发
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
			damage_shot(skill,damage.target:get_point())
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
	
    if self.trg1 then
        self.trg1:remove()
        self.trg1 = nil
	end  
	
    if self.eft then
        self.eft:remove()
        self.eft = nil
    end      
end
