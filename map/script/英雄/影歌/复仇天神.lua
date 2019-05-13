local mt = ac.skill['复仇天神']

mt{
	--必填
	is_skill = true,
	
	--初始等级
	level = 1,
	max_level = 5,
	
	tip = [[
		主动：创造一个强大的复仇天神（远程攻击，属性与智力相关），
			 这个天神攻击有 %fuchou_chance% % 概率 召唤无敌的复仇之魂（无碰撞体积，属性与智力相关）
			 
		被动：攻击有 %chance% % 概率召唤 复仇之魂
	]],
	
	--技能图标 3（60°扇形分三条，角度30%）+3+3+1+1，一共5波，
	art = [[ReplaceableTextures\CommandButtons\BTNSpiritOfVengeance.blp]],

	--技能目标类型 无目标
	target_type = ac.skill.TARGET_TYPE_NONE,

	--几率
	chance = 10,

	--复仇天神几率
	fuchou_chance = 20,

	--cd 45
	cool = {30,27.5,25,22.5,20},

	--耗蓝
	cost = {45,140,235,330,425},

	--持续时间
	time = 25,
	--数量
	cnt = 1,
	--属性倍数
	attr_mul = 1,

	--特效模型
	effect = [[]],
	
	
}
function mt:on_add()
	local hero = self.owner 
	local skill = hero:add_skill('复仇之魂','隐藏')
	skill.chance = self.chance
end	

function mt:on_upgrade()
	local hero = self.owner 
	local skill = hero:find_skill('复仇之魂','隐藏')
	if skill then 
		skill.chance = self.chance
	end	
end

function mt:on_cast_shot()
    local skill = self
	local hero = self.owner

	local cnt = (self.cnt + hero:get('召唤物')) or 1
	--多个召唤物
	for i=1,cnt do 
		local point = hero:get_point()-{hero:get_facing(),100}--在英雄附近 100 到 400 码 随机点
		local unit = hero:get_owner():create_unit('复仇天神',point)	
		
		local index = ac.creep['刷怪'].index 
		if not index or index == 0 then 
			index = 1
		end	
		index = index + ac.creep['刷怪-无尽'].index 

		local life_mul, defence_mul, attack_mul = ac.get_summon_mul(index)
		local data = {}
		data.attribute={
			['生命上限'] = hero:get('智力') * life_mul*1.5,
			['护甲'] = hero:get('智力') * defence_mul*1.5,
			['攻击'] = hero:get('智力') * attack_mul*1.5,
			['魔法上限'] = 60,
			['移动速度'] = 325,
			['攻击间隔'] = 1,
			['生命恢复'] = 1.2,
			['魔法恢复'] = 0.6,
			['攻击距离'] = 100,
		}
		-- print('技能使用时 当前波数',index)

		self.buff = unit:add_buff '召唤物' {
			time = self.time,
			attribute = data.attribute,
			attr_mul = self.attr_mul - 1,
			skill = self,
			follow = true
		}
		unit:add('攻击距离', 800)

		local skl = unit:add_skill('复仇之魂','英雄')
		skl.chance = self.fuchou_chance
		-- print(unit:get('移动速度'))
	end	
	

end

function mt:on_remove()

    local hero = self.owner 
	
    if self.trg then
        self.trg:remove()
        self.trg = nil
	end  
	if hero:find_skill('复仇之魂') then 
		hero:remove_skill('复仇之魂')
	end	
	
    -- if self.buff then
    --     self.buff:remove()
    --     self.buff = nil
    -- end     

end
