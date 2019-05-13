local mt = ac.skill['召唤强化']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    max_level = 5,
	--技能类型
	skill_type = "被动",
	--被动
	passive = true,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--介绍
    tip = [[|cff11ccff%skill_type%:|r 召唤物属性+ %summon_attr% %
    ]],
	--技能图标
    art = [[jineng\jineng014.blp]],
    
    summon_attr = {35,50,75,125,200},
}

mt.summon_attr_now = 0

function mt:on_upgrade()
	local hero = self.owner
	-- print(self.life_rate_now)
	hero:add('召唤物属性', -self.summon_attr_now)
	self.summon_attr_now = self.summon_attr
	hero:add('召唤物属性', self.summon_attr)
end


function mt:on_add()
    local skill = self
    local hero = self.owner
   
end
function mt:on_remove()
    local hero = self.owner
    hero:add('召唤物属性',-self.summon_attr)
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
