local mt = ac.skill['强化后的穿刺']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 5,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--技能类型
	skill_type = "被动,敏捷,晕眩",
	--被动
	passive = true,

	title = "|cffdf19d0强化后的穿刺|r",

	--耗蓝
	-- cost = 100,
	--冷却时间
	cool = 1,
	ignore_cool_save = true,
	--伤害
	damage = function(self)
  return (self.owner:get('敏捷')*40+10000)* self.level
end,
	--介绍
	tip = [[
		
|cff00bdec【被动效果】攻击10%几率造成范围技能伤害，并晕眩0.2S
【伤害公式】(敏捷*40+1w)*Lv|r

]],

    --技能图标
    art = [[qhcc.blp]],
    --特效
    effect = [[Abilities\Spells\Undead\Impale\ImpaleHitTarget.mdx]],
    --特效1
    effect1 = [[Abilities\Spells\Undead\Impale\ImpaleMissTarget.mdx]],

    --持续时间
    time = 0.2 ,
    --碰撞范围
    hit_area = 200,
    --特效移动速度
    speed = 5000,

    strong_skill_tip ='（可食用|cffffff00恶魔果实|r进行强化）',
    casting_cnt = 1
}
function mt:on_add()
    local skill = self
    local hero = self.owner

	local function start_damage(damage)
		local source = hero:get_point()
		local target = damage.target:get_point()
		local angle = source / target
		local mvr = ac.mover.line
		{
			source = hero,
			start = hero,
			angle = angle,
			speed = skill.speed,
			distance = skill.range,
			skill = skill,
			high = 110,
			model = '', 
			hit_area = skill.hit_area,
			size = 1
		}
		if not mvr then 
			return
		end

		function mvr:on_move()
			-- print('移动中创建特效',skill.effect1)
			ac.effect(self.mover:get_point(),skill.effect1,0,1,'origin'):remove()  
		end	
		function mvr:on_hit(dest)
			-- for i, u in ac.selector()
			-- 	: in_range(dest,skill.hit_area)
			-- 	: is_enemy(hero)
			-- 	: of_not_building()
			-- 	: ipairs()
			-- do
				local u = dest
				u:add_effect('origin',skill.effect):remove()
				u:add_buff '晕眩'
				{
					time = skill.time,
					skill = skill,
					source = hero,
				}
				
				u:add_buff '高度'
				{
					time = 0.3,
					speed = 1200,
					skill = skill,
					reduction_when_remove = true
				}
				u:damage
				{
					skill = skill,
					source = hero,
					damage = skill.damage,
					damage_type = '法术'
				}
			-- end	
		end	
    end	
    
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
            start_damage(damage)
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
