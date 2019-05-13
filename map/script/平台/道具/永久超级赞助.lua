local mt = ac.skill['永久超级赞助']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 0,
    --魔法书
    is_order = 1,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--介绍
	tip = [[%active%
|cffffff00特权1：|r全属性+1000，杀怪全属性+18
|cffffff00特权2：|r物爆几率+5%； 会心几率+5%； 法爆几率+5%
|cffffff00特权3：|r吸血+0.5%； 减免+10%； 每秒回血1%；
|cffffff00特权4：|r金币获取率+25%； 经验获取率+25%； 物品获取率+25%]],
	--技能图标
	art = [[cjhy.blp]],
	--特效
	effect = [[]],
    --是否激活状态
    active = function(self)
        local res = [[|cff00bdec需要：
 - 通过【官方商城】获得|r]]
        if self.level >=1 then 
            res = ''
        end    
        return res
    end,   
    --全属性
    all_attr = 1000,
    --杀怪全属性
    killer_attr = 18,
    --物爆几率 会心几率 法爆几率
    crite_rate = 5,
    --吸血
    steal_life = 0.5,
    --减免
    reduce_rate = 10,
    --金币加成 经验加成 物品获取率
    value = 25,
    --团队生命次数
    team_revive = 1,
    
	
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    if not hero:is_hero() then return end
    local p = hero:get_owner()
    local peon = p.peon

    hero:add('力量',self.all_attr)
    hero:add('敏捷',self.all_attr)
    hero:add('智力',self.all_attr)
    hero:add('杀怪全属性',self.killer_attr)

    hero:add('物爆几率',self.crite_rate)
    hero:add('法爆几率',self.crite_rate)
    hero:add('会心几率',self.crite_rate)

    hero:add('吸血',self.steal_life)
    hero:add('减免',self.reduce_rate)

    hero:add('金币加成',self.value)
    hero:add('经验加成',self.value)
    hero:add('物品获取率',self.value)
    --团队挑战次数
    ac.game.challenge_cnt = ac.game.challenge_cnt + self.team_revive 
    
end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
    
    hero:add('力量',-self.all_attr)
    hero:add('敏捷',-self.all_attr)
    hero:add('智力',-self.all_attr)
    hero:add('杀怪全属性',-self.killer_attr)

    hero:add('物爆几率',-self.crite_rate)
    hero:add('法爆几率',-self.crite_rate)
    hero:add('会心几率',-self.crite_rate)

    hero:add('吸血',-self.steal_life)
    hero:add('减免',-self.reduce_rate)

    hero:add('金币加成',-self.value)
    hero:add('经验加成',-self.value)
    hero:add('物品获取率',-self.value)

end
