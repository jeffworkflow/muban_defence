local mt = ac.skill['漫天花雨']

mt{
	--必填
	is_skill = true,
	
	--初始等级
	level = 1,
	max_level = 5,
	
	tip = [[
		主动：多重射 +%cnt% ，攻击力提升 %attack_mul% 倍，持续时间 %time% 秒
		被动：攻击间隔 - %attack_gap%
	]],
	
	--技能图标
	art = [[jineng\jineng009.blp]],

	--技能目标类型 无目标
	target_type = ac.skill.TARGET_TYPE_NONE,

	--多重射数量
	cnt = {2,3,4,5,6},

	--持续时间
	time = {5,6,7,8,10},

	--攻击力倍数
	attack_mul = {0.5,0.75,1,1.25,1.5},

	--攻击间隔
	attack_gap = {-0.05,-0.075,-0.1,-0.125,-0.15},

	--cd 15
	cool = 10,

	--耗蓝35
	cost = {35,140,313,512,861},

	--特效模型
	effect = [[Abilities\Spells\Orc\Bloodlust\BloodlustTarget.mdl]],
	-- effect = [[Hero_Juggernaut_N4S_F_Source.mdx]],
	
}

mt.attack_gap_now = 0

function mt:on_upgrade()
	local hero = self.owner
	-- print(self.physical_crite_rate_now)
	hero:add('攻击间隔', -self.attack_gap_now)
	self.attack_gap_now = self.attack_gap
	hero:add('攻击间隔', self.attack_gap)
end

function mt:on_add()
	local hero = self.owner 

end	
function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
	-- hero:add('多重射',-self.cnt)
	hero:add_buff '漫天花雨' 
	{
		source = hero,
		time =self.time,
		cnt =self.cnt,
		attack_mul =self.attack_mul,
		effect = self.effect
	}

end

function mt:on_remove()

    local hero = self.owner 
    -- 提升三维(生命上限，护甲，攻击)
	hero:add('攻击间隔',self.attack_gap)
	
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end    

end
local mt = ac.buff['漫天花雨']

mt.cover_type = 1

function mt:on_add()
	self.target:add('多重射',self.cnt)
	self.target:add('攻击%',self.attack_mul*100)
	self.eff = self.target:add_effect('chest', self.effect)
end

function mt:on_remove()
	if self.eff then
		self.eff:remove()
	end
	self.target:add('多重射',-self.cnt)
	self.target:add('攻击%',-self.attack_mul*100)
end

function mt:on_cover(new)
	if new.time > self:get_remaining() then
		self:set_remaining(new.time)
	end
	return false
end
