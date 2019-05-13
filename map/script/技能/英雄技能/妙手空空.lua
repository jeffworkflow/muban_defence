local mt = ac.skill['妙手空空']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "主动",
	--耗蓝
	cost = {100,200,300,400,500},
	--冷却时间
	cool = {10,9,8,7,6},
	--技能目标
	target_type = ac.skill.TARGET_TYPE_UNIT,
	--施法距离
	range = 800,
	--介绍
	tip = [[|cff11ccff%skill_type%:|r 有几率从敌人身上获得物品，对boss无效
	]],
	--技能图标
	art = [[jineng\jineng025.blp]],

	--几率
	-- chance = 100,
}
	
function mt:on_add()
	local hero = self.owner 

end	
function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
	local target = self.target
	local player = hero:get_owner()
	
	if ac.creep['刷怪-无尽'].index >= 1 then 
		player:sendMsg(self.name..'无尽时无效',10)
		player:sendMsg(self.name..'无尽时无效',10)
		return 
	end
	

	if not target.data or target.data.type =='boss'  then
		hero:add('魔法',self.cost)
		self:set_cd(0)
		-- self:fresh()
		ac.on_texttag('【对boss无效】','橙',hero)
	else
		ac.game:event_dispatch('物品-偷窃',target,hero) 
	end	
end

function mt:on_remove()
    local hero = self.owner 
    if self.trg then
        self.trg:remove()
        self.trg = nil
	end  
end
