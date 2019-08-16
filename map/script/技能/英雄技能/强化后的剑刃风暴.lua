local mt = ac.skill['强化后的剑刃风暴']

mt{
    --必填
    is_skill = true,
    --初始等级
    level = 5,
    --最大等级
   max_level = 5,
   ['每秒加力量'] = {100,200,300,400,500},
   ['攻击加力量'] = {100,200,300,400,500},
   ['杀怪加力量'] = {100,200,300,400,500},
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
   damage = function(self)
	return (self.owner:get('力量')*15+10000)* self.level
  end,
	tip = [[
		
|cffffff00【每秒加力量】+100*Lv
【攻击加力量】+100*Lv
【杀怪加力量】+100*Lv|r

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】(力量*40+1w)*Lv|r

]],
	--技能图标 3（40°扇形分三条，角度20%）+3+3+1+1，一共5波，
    art = [[jrfb.blp]],
	--技能类型
	skill_type = "被动,力量",
	--被动
	passive = true,
	--技能目标类型 无目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--冷却时间
	cool = 4.5,
	ignore_cool_save = true,
	--施法范围
	area = 500,
	area2 = 1000,
	--持续时间
	time = 3,
	--每几秒
	pulse = 0.2,
	--特效模型
	effect = [[Hero_Juggernaut_N4S_F_Source.mdx]],
	--冲击波
	effect1 = [[Abilities\Spells\Orc\Shockwave\ShockwaveMissile.mdl]],
	--冲击波移动距离
	distance = 500,
	--冲击波速度
	speed = 1600,
	--冲击波碰撞范围
	hit_area = 200,

	--伤害类型
	damage_type = '法术',
}

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
			
			local area = self.area
			if self.is_stronged then 
				area = self.area2
			end	
			self.trg = hero:add_buff '剑刃风暴' 
			{
				source = hero,
				skill = self,
				area = area,
				damage = self.damage,
				effect = self.effect,
				pulse = 0.02, --剑刃风暴 立即受伤害
				real_pulse = self.pulse,  --实际每秒受伤害
				time = self.time,
				is_stronged = self.is_stronged,   --强化标识
				effect1 = self.effect1,
				speed = self.speed,
				damage_type = self.damage_type
			}
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
end
