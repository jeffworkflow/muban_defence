local mt = ac.skill['痛苦尖叫']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   area = 800,
	--技能类型
	skill_type = "主动,智力",
	--耗蓝
	cost = 100,
	--冷却时间
	cool = 15,
	--伤害
	damage = function(self)
  return (self.owner:get('智力')*15+10000)* self.level*5
end,
	--属性加成
 ['每秒加智力'] = {50,100,150,200,250},
 ['攻击加智力'] = {50,100,150,200,250},
 ['杀怪加智力'] = {50,100,150,200,250},
	--介绍
	tip = [[
		
|cffffff00【每秒加智力】+50*Lv
【攻击加智力】+50*Lv
【杀怪加智力】+50*Lv|r

|cff00bdec【主动施放】对周围敌人造成范围技能伤害
【伤害公式】(智力*15+1w)*Lv*5|r

]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNPossession.blp]],
	--特效
	effect = [[Abilities\Spells\Undead\Possession\PossessionMissile.mdl]],
	
	damage_type = '法术',
	strong_skill_tip ='（可食用|cffffff00恶魔果实|r进行强化）',
	casting_cnt = 1
}
function mt:strong_skill_func()
	local hero = self.owner 
	local player = hero:get_owner()
	-- 增强 卜算子 技能 1个变为多个 --商城 或是 技能进阶可得。
	if (hero.strong_skill and hero.strong_skill[self.name]) then 
		self:set('casting_cnt',5)
		self:set('strong_skill_tip','|cffffff00已强化：|r|cff00ff00额外触发4次痛苦尖叫，造成等值伤害|r')
		-- print(2222222222222222222)
	end	
end	
function mt:on_add()
    local skill = self
    local hero = self.owner
	self:strong_skill_func()
end

function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
	local target = self.target
	local function start_damage()
		for i, u in ac.selector()
			: in_range(hero,self.area)
			: is_enemy(hero)
			: of_not_building()
			: ipairs()
		do
			local mvr = ac.mover.target
			{
				source = hero,
				target = u,
				model = skill.effect,
				speed = 600,
				height = 110,
				skill = skill,
			}
			if not mvr then
				return
			end
			function mvr:on_finish()
				u:damage
				{
					source = hero,
					damage = skill.damage ,
					skill = skill,
					damage_type =skill.damage_type
				}	
			end
		end
	end
	
	--先释放一次，再释放4次
	start_damage()
	if self.casting_cnt >1 then 
		hero:timer(0.3*1000,self.casting_cnt-1,function(t)
			start_damage()
		end)
	end	
	
	
end	


function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
