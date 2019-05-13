local mt = ac.skill['贪婪者的心愿']
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
	tip = [[|cff11ccff%skill_type%:|r 物品获取率+%item_rate% %
	]],
	--技能图标
	art = [[jineng\jineng017.blp]],
	item_rate = {40,60,80,100,120},
}

mt.item_rate_now = 0

function mt:on_upgrade()
	local hero = self.owner
	-- print(self.life_rate_now)
	hero:add('物品获取率', -self.item_rate_now)
	self.item_rate_now = self.item_rate
	hero:add('物品获取率', self.item_rate)
end	

function mt:on_add()
    local skill = self
    local hero = self.owner
end
function mt:on_remove()
    local hero = self.owner
    hero:add('物品获取率',-self.item_rate)
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
