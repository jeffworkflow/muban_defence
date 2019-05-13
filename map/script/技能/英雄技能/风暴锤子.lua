local mt = ac.skill['风暴锤子']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "主动 控制",
	--耗蓝
	cost = {30,150,270,390,500},
	--冷却时间
	cool = 10,

	--技能目标
	target_type = ac.skill.TARGET_TYPE_UNIT,
	--施法距离
	range = 900,

	int = {25,30,35,40,50},

	shanghai ={30000,300000,3000000,8000000,12500000},

	--介绍
	tip = [[|cff11ccff%skill_type%:|r 对单一敌人造成晕眩3S，并造成物理伤害
伤害计算：|cffd10c44攻击力 * %int% |r+ |cffd10c44 %shanghai% |r
伤害类型：|cff04be12物理伤害|r
	]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNStormBolt.blp]],
	--特效
	effect = [[StormBoltMissile.mdx]],
	--特效
	effect1 = [[StormBoltTarget.mdx]],
	--持续时间
	time = 3,
	--伤害
	damage = function(self,hero)
		if self and self.owner and self.owner:is_hero() then 
		return self.owner:get('攻击')*self.int+self.shanghai
		end
	end	,
	--投射物移动速度
	speed = 1000,
	--必填
	is_skill = true,
	
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end

function mt:on_cast_shot()
    local skill = self
    local hero = self.owner

	local target = self.target
	-- print('弹射目标：',u,u:get_point())
	local mvr = ac.mover.target
	{
		source = hero,
		target = target,
		speed = skill.speed,
		skill = skill,
		high = 110,
		model = skill.effect, 
		size = 1
	}
	if not mvr then 
		return
	end

	function mvr:on_finish()
		target:add_buff '晕眩'
		{
			source = hero,
			skill = skill,
			time = skill.time
			
		}
		target:damage
		{
			skill = skill,
			source = hero,
			damage = skill.damage,
			damage_type = '物理'
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
