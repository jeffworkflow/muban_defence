local mt = ac.skill['强化后的践踏']
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
   area = 500,
	--技能类型
	skill_type = "被动,力量,晕眩",
	--被动
	passive = true,
    title = "|cffdf19d0强化后的践踏|r",
	--冷却时间
	cool = 1,
	ignore_cool_save = true,
	--伤害
	damage = function(self)
  return (self.owner:get('力量')*40+10000)*self.level
end,
	--介绍
	tip = [[
        
|cff00bdec【被动效果】攻击10%几率造成范围技能伤害，并晕眩0.2S
【伤害公式】(力量*40+1w)*Lv|r

]],
    --技能图标
    art = [[qhjt.blp]],
    --特效
    effect = [[Abilities\Spells\Human\ThunderClap\ThunderclapCaster.mdx]],
    --特效1
    effect1 = [[Abilities\Spells\Human\ThunderClap\ThunderclapTarget.mdx]],

    --持续时间
    time = 0.2 ,
    damage_type ='法术'
}
function mt:on_add()
    local skill = self
    local hero = self.owner
	local target = self.target

    local function start_damage()
        local point = hero:get_point()
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
                damage_type = skill.damage_type
            }
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
            start_damage()
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
