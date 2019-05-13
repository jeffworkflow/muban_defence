local mt = ac.skill['重击']

mt{
	--必填
	is_skill = true,

	--是否被动
	passive = true,
	--技能类型
	skill_type = "被动 控制",
	
	--初始等级
	level = 1,
	max_level = 5,
	
	tip = [[
|cff11ccff%skill_type%:|r 攻击时 %chance% % 触发， 对敌人造成物理伤害 (%damage%) ，并击晕敌人 %time% 秒，近战有效
伤害计算：|cffd10c44力量 * %int% |r+ |cffd10c44 %shanghai% |r
伤害类型：|cff04be12物理伤害|r
		]],
	
	--技能图标
	art = [[ReplaceableTextures\PassiveButtons\PASBTNBash.blp]],

	--概率
	chance = 15,

	--晕眩时间
	time = 1,

	int = {5,6,7,8,10},

	shanghai ={5000,50000,500000,125000,2000000},

	--伤害
	damage = function(self,hero)
		if self and self.owner and self.owner:is_hero() then 
		return self.owner:get('攻击')*self.int+self.shanghai
		end
	end,	

}


function mt:on_add()
	local skill = self
	local hero = self.owner 
	self.trg = hero:event '造成伤害效果' (function(trg, damage)
		--普攻触发 and 近战
		if damage:is_common_attack() and damage.source:isMelee()  then
            --几率触发
			if math.random(1,100) > self.chance then
				return
			end
	 	   damage.target:add_buff('晕眩')
			{
				source = hero,
				skill = skill,
				time =  skill.time,
				damage = skill.damage
			}
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
