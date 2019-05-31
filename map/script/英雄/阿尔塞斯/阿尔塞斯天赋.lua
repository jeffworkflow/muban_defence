local mt = ac.skill['阿尔塞斯天赋']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率')/100) end,
    --伤害范围
   damage_area = 800,
	--技能类型
	skill_type = "天赋",
	--被动
	passive = true,
	--伤害
	damage = function(self)
		return (self.owner:get('力量')*10+10000)* self.level
	end,
	--属性加成
 ['杀怪加全属性'] = {10,20,30,40,50},
 ['分裂伤害'] = 25,
	--介绍
	tip = [[|cffffff00【杀怪加全属性】+10*Lv
【分裂伤害】+25%|r

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】(力量*10+1w)*Lv|r

|cff00ff00【凌波微步】按D向鼠标方向飘逸500码距离|r]],
	--技能图标
	art = [[aess.blp]],
	--特效
	effect = [[jn_tf1.mdx]],
}
function mt:on_add()
    local skill = self
	local hero = self.owner

	self.trg = hero:event '造成伤害效果' (function(_,damage)
		if not damage:is_common_attack()  then 
			return 
		end 
        --触发时修改攻击方式
		if math.random(100) <= self.chance then
			--创建特效
			local angle = damage.source:get_point() / damage.target:get_point()
			ac.effect(damage.source:get_point(),skill.effect,angle,1,'origin'):remove()
			--计算伤害
			for _,unit in ac.selector()
			: in_sector(hero:get_point(),self.damage_area,angle,95)
			: is_enemy(hero)
			: ipairs()
			do 
				unit:damage
				{
					source = hero,
					damage = skill.damage,
					skill = skill,
					damage_type = '法术'
				}
			end 
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
