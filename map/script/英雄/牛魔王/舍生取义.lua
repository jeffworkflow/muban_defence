local mt = ac.skill['舍生取义']

mt{
	--必填
	is_skill = true,
	
	--初始等级
	level = 1,
	max_level = 5,
	
	tip = [[
		主动：每秒恢复 %life_rate% %的血量，持续时间 %time% 秒, 冷却 %cool%秒
		被动1：每损失1点的最大生命值， 额外获得 %attack% 点的攻击力提升
		被动2：增加 %reduce_rate% % 的生命上限
	]],
	
	--技能图标
	art = [[jineng\jineng001.blp]],

	--技能目标类型 无目标
	target_type = ac.skill.TARGET_TYPE_NONE,

	--施法范围
	area = 500,

	--持续时间
	time = 8,

	--每几秒
	pulse = 0.2,

	--生命上限
	life_rate = 6,

	--攻击提升
	attack = {2,4,6,8,10},
	--cd
	cool = {20,17.5,15,12.5,10},
    --减免
	reduce_rate = {20,40,60,80,100},

	--耗蓝
	cost = {35,175,325,475,650},

	--特效模型
	effect = [[Hero_Juggernaut_N4S_F_Source.mdx]],
	--施法距离
	-- range = 99999,
}
mt.reduce_rate_now = 0

function mt:on_upgrade()
	local hero = self.owner
	-- print(self.life_rate_now)
	hero:add('生命上限%', -self.reduce_rate_now)
	self.reduce_rate_now = self.reduce_rate
	hero:add('生命上限%', self.reduce_rate)

	self.trg = hero:add_buff '舍生取义-被动' 
	{
		source = hero,
		skill = self,
		attack = self.attack,
		pulse = 0.02, --立即生效
		real_pulse = 0.1  --实际每几秒检测一次
	}
end

function mt:on_add()
    local skill = self
	local hero = self.owner 

end	
function mt:on_add()
    local skill = self
	local hero = self.owner 
	hero:add('减免',self.reduce_rate)
end	

function mt:on_cast_shot()
	local hero = self.owner
	-- hero:add_effect('origin',self.effect)
	self.trg = hero:add_buff '舍生取义' 
	{
		source = hero,
		skill = self,
		life_rate = self.life_rate,
		time = self.time,
		pulse = 0.02, --立即生效
		real_pulse = 1  --实际每几秒检测一次
	}
end

function mt:on_remove()
	local hero = self.owner 
    -- 提升三维(生命上限，护甲，攻击)
    hero:add('生命上限%',-self.reduce_rate)
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end    

end


local mt = ac.buff['舍生取义']

function mt:on_add()
	local hero = self.target
	--特效

end

function mt:on_pulse()
	local hero = self.target
	self.pulse = self.real_pulse
	hero:heal 
	{
		source = hero,
		skill = self.skill,
		size = 10,
		-- string = '治疗',
		heal = hero:get('生命上限')*self.life_rate/100 ,
	}

end	
function mt:on_remove()
	local hero = self.target 
end

local mt = ac.buff['舍生取义-被动']

mt.cover_type = 1
mt.cover_max = 1
mt.keep = true --死亡时依旧保持

function mt:on_add()
	local hero = self.target
	--特效

end

function mt:on_pulse()
	local hero = self.target
	self.pulse = self.real_pulse
	--每 0.2 秒检测周围单位一次，先移除上次增加的攻击，再重新计算添加。
	if self.skill.cnt then 
		hero:add('攻击',-self.skill.cnt*self.attack)
	end	

	self.skill.cnt = hero:get('生命上限') - hero:get('生命')
	
	hero:add('攻击',self.skill.cnt*self.attack)
	-- print('周围单位个数：'..self.skill.cnt,hero:get('攻击%'))
end

function mt:on_remove()
	local hero = self.target
	if self.skill.cnt then 
		hero:add('攻击',-self.skill.cnt*self.attack)
	end	
	self.skill.cnt = 0

end	
function mt:on_cover(new)
	return new.attack > self.attack
end