local mt = ac.skill['摔破罐子']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "主动",
	--耗蓝
	cost = 1,
	--冷却时间90
	cool = {35,30,25,20,15},
	--技能目标
	target_type = ac.skill.TARGET_TYPE_UNIT,
	--施法距离
	range = 500,
	--介绍
	tip = [[|cff11ccff%skill_type%:|r 直接杀死一名敌人（对BOSS无效），50% 获得一个物品，并永久降低自身 10% 的智力
	]],
	--技能图标
	art = [[jineng\jineng027.blp]],
	--扣智力
	addint = 10,
	--几率
	rate = 50,
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end
function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
	local target = self.target
	local player = hero:get_owner()
	-- print(target,target.data.type)
	if ac.creep['刷怪-无尽'].index >= 1 then 
		player:sendMsg(self.name..'无尽时无效',10)
		player:sendMsg(self.name..'无尽时无效',10)
		return 
	end
	
	local ln = ac.lightning('LN00',hero,target,50,50)
	ln:fade(-5)
	if not target.data or target.data.type =='boss' then
		hero:add('魔法',self.cost)
		self:set_cd(0)
		-- self:fresh()
		ac.on_texttag('【对boss无效】','橙',hero)
	else
		target:kill(hero)
		hero:add('智力',- math.ceil(hero:get('智力')*self.addint/100))
		local rand = math.random(1,100)
		if rand <= self.rate then 
			--@目标单位
			--@源单位,继承英雄获得物品获取率
			ac.game:event_dispatch('物品-随机装备',target,hero) 
		end	
	end	
	
end	
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end