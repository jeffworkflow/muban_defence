local mt = ac.skill['强化后的缠绕']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 5,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 15*(1+self.owner:get('触发概率加成')/100) end,
	--技能类型
	skill_type = "被动,全属性,晕眩",
	--被动
	passive = true,
    title = "|cffdf19d0强化后的缠绕|r",
	--冷却时间
	cool = 20,
	--伤害
	damage = function(self)
  return (self.owner:get('全属性')*10+10000)*5
end,
	--介绍
	tip = [[
        
|cff00bdec【被动效果】攻击15%几率造成范围技能伤害，并晕眩1S
【伤害公式】(全属性*5+1w)*5|r

]],
    --施法范围
    area = 500,
    --技能图标
    art = [[qhcr.blp]],
    --特效
    effect = [[Abilities\Spells\NightElf\EntanglingRoots\EntanglingRootsTarget.mdl]],
    --持续时间
    time = 1 ,
    damage_type = '法术'
}
function mt:on_add()
    local skill = self
    local hero = self.owner
	local target = self.target

    local function start_damage()
        for i, u in ac.selector()
            : in_range(target,self.area)
            : is_enemy(hero)
            : of_not_building()
            : ipairs()
        do
            u:add_buff '晕眩'
            {
                time = self.time,
                skill = self,
                source = hero,
                model = self.effect,
            }
            u:damage
            {
                skill = self,
                source = hero,
                damage = self.damage,
                damage_type = '法术'
            }
        end	
    end    
    
    self.trg = hero:event '造成伤害效果' (function(_,damage)
		if not damage:is_common_attack()  then 
			return 
		end 
        --触发时修改攻击方式
        if math.random(100) <= self.chance then
            start_damage()
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
