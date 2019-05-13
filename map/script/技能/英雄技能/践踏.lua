local mt = ac.skill['践踏']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "主动 力量 控制",
	--耗蓝
	cost = {40,80,160,320,450},
	--冷却时间
	cool = 15,

	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--施法范围
	area = 500,
	--介绍
	tip = [[|cff11ccff%skill_type%:|r 对范围500码敌人晕眩2S，并造成物理伤害 （%damage%）
	伤害计算：|cffd10c44力量 * %int% |r+ |cffd10c44 %shanghai% |r
	伤害类型：|cff04be12物理伤害|r
	]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNWarStomp.blp]],
	--特效
	effect = [[Abilities\Spells\Human\ThunderClap\ThunderclapCaster.mdx]],
	--特效1
	effect1 = [[Abilities\Spells\Human\ThunderClap\ThunderclapTarget.mdx]],

	int = {25,30,35,40,50},

	shanghai ={25000,250000,2500000,6250000,10000000},

	--伤害
	damage = function(self,hero)
		if self and self.owner and self.owner:is_hero() then 
		return self.owner:get('力量') * self.int+self.shanghai
		end
	end,
	--持续时间
	time = 2 ,
}

function mt:on_add()
    local skill = self
    local hero = self.owner
end


function mt:on_cast_shot()
    local skill = self
    local hero = self.owner

    local point = hero:get_point()
	-- hero:add_effect('origin',self.effect):remove()
	local effect = ac.effect(point,self.effect,0,2,'origin'):remove()

	for i, u in ac.selector()
		: in_range(hero,self.area)
		: is_enemy(hero)
		: of_not_building()
		: ipairs()
	do
		u:add_buff '晕眩'
		{
			time = self.time,
			skill = self,
			source = hero,
			model = self.effect1,
		}
		u:damage
		{
			skill = self,
			source = hero,
			damage = self.damage,
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
