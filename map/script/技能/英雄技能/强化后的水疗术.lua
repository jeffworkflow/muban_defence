local mt = ac.skill['强化后的水疗术']
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
	skill_type = "被动,肉",
	--被动
	passive = true,
    title = "|cffdf19d0强化后的水疗术|r",
	--冷却时间
    cool = 1,
	ignore_cool_save = true,
    ['每秒回血'] = 35,
	--介绍
    tip = [[

|cffffff00【每秒回血】+35%|r
        
|cff00bdec【被动效果1】攻击10%几率触发， 回复20%的生命值|r

|cff00bdec【被动效果2】唯一技能-内伤：10几率对周围敌人造成|r|cffffff00生命恢复效果减少50%|r，|cff00bdec持续0.5秒|r
    
]],
	--技能图标
	art = [[qhsls.blp]],
	--特效
    effect = [[Abilities\Spells\Human\HolyBolt\HolyBoltSpecialArt.mdl]],
    effect1 = [[Effect_az_heiseguangzhu.mdx]],
    --内伤
    area = 500,
    value = -50,
    time = 0.5,

    --补血量
    heal = 20
}
function mt:on_add()
    local skill = self
    local hero = self.owner

    self.trg = hero:event '造成伤害效果' (function(_,damage)--注册触发
		if not damage:is_common_attack()  then 
			return 
		end 
		--技能是否正在CD
        if skill:is_cooling() then
			return 
		end
        --触发时修改攻击方式
		if math.random(100) <= self.chance then
            --补血
            hero:heal
            {
                source = hero,
                skill = skill,
                -- string = '水疗术',
                size = 10,
                heal = hero:get('生命上限') * skill.heal/100,
            }	

            ac.effect(damage.target:get_point(),self.effect1,0,1,'origin'):remove()
            for _,unit in ac.selector()
			: in_range(damage.target,skill.area)
			: is_enemy(hero)
			: ipairs()
			do 
                unit:add_buff('生命恢复效果')
                {
                    value = self.value,
                    source = hero,
                    time = self.time,
                    skill = self,
                }
			end 
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
