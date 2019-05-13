local mt = ac.skill['财富']
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
	tip = [[|cff11ccff%skill_type%:|r 金钱获取率+%more_gold% %
	]],
	--技能图标
	art = [[jineng\jineng019.blp]],
	more_gold = {40,60,80,100,120},
}
mt.more_gold_now = 0

function mt:on_upgrade()
	local hero = self.owner
	-- print(self.life_rate_now)
	hero:add('金币加成', -self.more_gold_now)
	self.more_gold_now = self.more_gold
	hero:add('金币加成', self.more_gold)
end	

function mt:on_add()
    local skill = self
    local hero = self.owner
end

function mt:on_remove()
    local hero = self.owner
    hero:add('金币加成',-self.more_gold)
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
