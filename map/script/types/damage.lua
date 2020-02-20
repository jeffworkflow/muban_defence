
local jass = require 'jass.common'
local slk = require 'jass.slk'
local setmetatable = setmetatable
local tostring = tostring
local math = math
local ac_event_dispatch = ac.event_dispatch
local ac_event_notify = ac.event_notify
local table_insert = table.insert
local table_remove = table.remove

local damage = {}
setmetatable(damage, damage)
local mt = {}
damage.__index = mt

--类型
mt.type = 'damage'

--来源
mt.source = nil

--目标
mt.target = nil

--初始伤害
mt.damage = 0

--当前伤害
mt.current_damage = 0

--是否成功
mt.success = true

--关联技能
mt.skill = nil

--关联弹道
mt.missile = nil

--是否是普通攻击
mt.common_attack = false

--伤害类型 只有物理和法术
mt.damage_type = '物理'

--是否触发攻击特效
mt.attack = false

--是否是Aoe伤害
mt.aoe = false

--是否是致命一击
mt.physicals_crit_flag = nil
--是否是法术暴击
mt.spells_crit_flag = nil
--是否是会心一击
mt.heart_crit_flag = nil
--是否触发攻击回血
mt.damage_hp = false

--累计的伤害倍率变化
mt.change_rate = 1

--武器音效
mt.weapon = false

--是否是致命一击
function mt:is_physicals_crit()
	return self.physicals_crit_flag
end

--是否是法术暴击
function mt:is_spells_crit()
	return self.spells_crit_flag
end

--是否是会心一击
function mt:is_heart_crit()
	return self.heart_crit_flag
end

--伤害是否是技能造成的
function mt:is_skill()
	return self.skill
end

--伤害是否触发攻击效果
function mt:is_attack()
	return self.attack
end

--是否是普通攻击
function mt:is_common_attack()
	return self.common_attack
end

--是否是AOE
function mt:is_aoe()
	return self.aoe
end

--是否是物品
function mt:is_item()
	return self.skill and self.skill:get_type() == '物品'
end

--获取原始伤害
function mt:get_damage()
	return self.damage
end

--获取当前伤害
function mt:get_current_damage()
	return self.current_damage
end

--修改当前伤害
function mt:set_current_damage(value)
	self.current_damage = value
end

--修改原始伤害
function mt:set_damage(value)
	self.damage = value
end

--是否触发攻击回血
function mt:is_damage_hp()
	return self.damage_hp
end

function mt:mul(n, callback)
	if callback then
		if not self.cost_mul then
			self.cost_mul = {}
		end
		table_insert(self.cost_mul, {n, callback})
		return
	end
	self.change_rate = self.change_rate * (1 + n)
end

function mt:div(n, callback)
	if callback then
		if not self.cost_div then
			self.cost_div = {}
		end
		table_insert(self.cost_div, {n, callback})
		return
	end
	self.change_rate = self.change_rate * (1 - n)
end

-- 初始化属性
function mt:on_attribute_attack()
	if self.has_attribute_attack then
		return
	end
	self.has_attribute_attack = true
	local source = self.source
	if not self['破甲'] then
		self['破甲'] = source:get '破甲'
	end
	if not self['破魔'] then
		self['破魔'] = source:get '破魔'
	end
	if not self['穿透'] then
		self['穿透'] = source:get '穿透'
	end
	if not self['穿魔'] then
		self['穿魔'] = source:get '穿魔'
	end
	if not self['暴击'] then
		self['暴击'] = source:get '暴击'
	end
	if not self['暴击伤害'] then
		self['暴击伤害'] = source:get '暴击伤害'
	end
	if not self['吸血'] then
		self['吸血'] = source:get '吸血'
	end
	if not self['分裂伤害'] then
		self['分裂伤害'] = source:get '分裂伤害'
	end
	--self.attack and 
	if self.damage_type == '物理' then	
		--致命一击
		if self.physicals_crit_flag == nil then
			self.physicals_crit_flag = (source:get '暴击几率' >= math.random(100)) or (source:get '暴击几率' >100)
		end
	else	
		--法术暴击
		if self.spells_crit_flag == nil then
			self.spells_crit_flag =  (source:get '技暴几率' >= math.random(100)) or  (source:get  '技暴几率'>100)
		end
	end	
	--会心一击
	if self.heart_crit_flag == nil then
		self.heart_crit_flag =  (source:get '会心几率' >= math.random(100)) or (source:get '会心几率' >100)
	end
end

function mt:on_attribute_defence()
	if self.has_attribute_defence then
		return
	end
	self.has_attribute_defence = true
	local target = self.target
	if not self['护甲'] then
		self['护甲'] = target:get '护甲'
	end
	if not self['魔抗'] then
		self['魔抗'] = target:get '魔抗'
	end
	if not self['格挡'] then
		self['格挡'] = target:get '格挡'
	end
	if not self['格挡伤害'] then
		self['格挡伤害'] = target:get '格挡伤害'
	end
end

local function on_damage_a(self)
	self.current_damage = self.current_damage
		* (self.source and self.source:getDamageRate() / 100 or 1)
		* (self.target:getDamagedRate() / 100)
end

local function show_block(u,str)
	local str = str or '格挡!'
	local x, y,z = u:get_point():get()
	-- local z = u:get_point():getZ()
	ac.texttag
	{
		string = str,
		size = 8,
		position = ac.point(x - 60, y, z + 30),
		speed = 86,
		angle = 135,
		red = 100*100,
		green = 20*100,
		blue = 20*100,
	}
end

-- 计算暴击伤害
local function on_crit(self)
	if self:is_physicals_crit() then
		self:mul(self['暴击伤害'] / 100 - 1)
	end
end

local function on_block(self)
	local hero = self.target
	if self['格挡'] > math.random(0, 99) then
		if self['格挡伤害'] >= 100 then
			self.current_damage = 0
		else
			self:div(self['格挡伤害'] / 100)
		end
		show_block(hero)
		self.source:event_notify('造成伤害格挡', self)
		self.target:event_notify('受到伤害格挡', self)
	end
end

--护甲减免伤害
mt.DEF_SUB = tonumber(slk.misc.Misc.DefenseArmor)
mt.DEF_ADD = tonumber(slk.misc.Misc.DefenseArmor)

local function on_defence(self)
	local target = self.target
	local pene, pene_rate = self['破甲'], self['穿透']
	local def = self['护甲']
	if def > 0 then
		if pene_rate < 100 then
			def = def * (1 - pene_rate / 100)
		else
			def = 0
		end
	end
	if pene then
		def = def - pene
	end
	if def < 0 then
		--每点负护甲相当于受到的伤害加深
		local def = - def
		self.current_damage = self.current_damage * (1 + self.DEF_ADD * def)
	elseif def > 0 then
		--每点护甲相当于生命值增加 X%
		self.current_damage = self.current_damage / (1 + self.DEF_SUB * def)
	end
end

local function on_life_steal(self)
	--是攻击就吸血 普攻吸血
	if not self:is_attack() then
		return
	end
	local life_steal = self['吸血']
	if life_steal == 0 then
		return
	end
	self.source:heal
	{
		source = self.source,
		heal = self.current_damage * life_steal / 100,
		skill = self.skill,
		damage = self,
		life_steal = true,
	}
	--在身上创建特效
	self.source:add_effect('origin', [[Abilities\Spells\Undead\VampiricAura\VampiricAuraTarget.mdl]]):remove()
end

local function on_splash(self)
	--普攻、都有效 or (not self.source:isMelee()) 
	if not self:is_attack() or self:is_aoe() then
		return
	end
	local source, target = self.source, self.target
	local splash = self['分裂伤害']
	if splash == 0 then
		return
	end
	local dmg = self.current_damage * splash / 100
	for _, u in ac.selector()
		: in_range(target, 275)
		: is_enemy(source)
		: is_not(target)
		: ipairs()
	do	
		if u:get_name() =='毁灭者' then 
			dmg = 0
		end	
		u:damage
		{
			source = source,
			damage = dmg,
			aoe = true,
			skill = self.skill,
			real_damage = true,
		}
	end
	--在地上创建特效
	target:get_point():add_effect([[ModelDEKAN\Weapon\Dekan_Weapon_Sputtering.mdl]]):remove()
end

--攻击分裂伤害(直接加深AOE伤害)
local function on_splash_aoe(self)
	if not self:is_attack() or not self:is_aoe() then
		return
	end
	local source, target = self.source, self.target
	local splash = self['分裂伤害']
	if splash == 0 then
		return
	end
	self:mul(splash / 1000)
	target:get_point():add_effect([[ModelDEKAN\Weapon\Dekan_Weapon_Sputtering.mdl]]):remove()
end



--伤害音效
local function on_sound(self)
	local weapon = self.weapon
	if not weapon then
		return
	end
	if weapon == true then
		weapon = nil
	end
	local name = self.source:get_weapon_sound(self.target, weapon, nil)
	self.target:play_sound(name)
end

local function on_damage_mul_div(self)
	--禁止获取伤害
	self.get_damage = false
	self.get_current_damage = false
	
	if self.source:event_dispatch('造成伤害', self) then 
		return 
	end	
	if self.target:event_dispatch('受到伤害', self) then 
		return 
	end	

	self.get_damage = nil
	self.get_current_damage = nil

	self.current_damage = self.current_damage * self.change_rate

	if self.cost_mul then
		for _, data in ipairs(self.cost_mul) do
			local n, callback = data[1], data[2]
			callback(self)
			self.current_damage = self.current_damage * (1 + n)
		end
	end

	if self.cost_div then
		for _, data in ipairs(self.cost_div) do
			local n, callback = data[1], data[2]
			callback(self)
			self.current_damage = self.current_damage * (1 - n)
		end
	end
	return true
end

local function cost_shield(self)
	local target = self.target
	local effect_damage = self.current_damage
	local shields = target.shields
	if not shields then
		return effect_damage
	end
	while #shields > 0 do
		local shield = shields[1]
		if effect_damage < shield.life then
			shield.life = shield.life - effect_damage
			target:add('护盾', - effect_damage)
			return 0
		end
		effect_damage = effect_damage - shield.life
		target:add('护盾', - shield.life)
		shield.life = 0
		table_remove(shields, 1)
		shield:remove()
	end
	target:set('护盾', 0)
	return effect_damage
end

local function texttag(self,str,size,angle,r,g,b)
   
end	
local function on_texttag(self)
	if self.source:get_owner() ~= ac.player.self and self.target ~= ac.player.self.hero   then
		return
	end
	if self.source:get_owner().flag_damage_texttag then 
		return 
	end	
	--非暴击就return
	-- if not self:is_physicals_crit() or not self:is_spells_crit() or not self:is_heart_crit() then
	-- 	return
	-- end
    --普攻，技能伤害加深 颜色 白色
	local color ={}
	color['r'] = 255
	color['g'] = 255
	color['b'] = 255
	local angle = 85
	local size = 8
	local str = ' '
	
	--致命一击 颜色 橙色
	if self:is_physicals_crit() then
	--	angle = 45 --暴击类的，文字漂浮右边
		color['r'] = 255
		color['g'] = 152
		color['b'] = 0
		size = 10
		str = '暴击'
	end		
	--法术暴击 颜色 蓝色
	if self:is_spells_crit() then
		color['r'] = 31
		color['g'] = 165
		color['b'] = 238
		size = 10
		str = '技暴'
	end		
	--会心一击 颜色 红色
	if self:is_heart_crit() then
		color['r'] = 238
		color['g'] = 31
		color['b'] = 39
		size = 10
		str = '会心'
	end		
	if self.current_damage > 100000000 then
		str = str..(' %.1f'):format(self.current_damage/100000000)..'亿'
	elseif	self.current_damage > 10000 then
		str = str..(' %.1f'):format(self.current_damage/10000)..'万'
	else	
		str = str..(' %.0f'):format(self.current_damage)
	end

	local x, y,z = self.target:get_point():get()
	-- local z = self.target:get_point():getZ()
	-- print(self.target:get_name(),z)
	local tag = ac.texttag
	{
		string = str,
		size = size,
		position = ac.point(x + 15, y, z),
		speed = 250,
		angle = angle,
		red = color['r'],
		green = color['g'],
		blue = color['b'],
		crit_size = 0,
		life = 1,
		fade = 0.5,
		time = ac.clock(),
	}
	
	if tag then 
		local i = 0
		ac.timer(10, 25, function()
			i = i + 1
			if i < 10 then
				tag.crit_size = tag.crit_size + 1
			elseif i < 20 then
				tag.crit_size = tag.crit_size	
			else 
				tag.crit_size = tag.crit_size - 1
			end	
			tag:setText(nil, tag.size + tag.crit_size)
		end)
	end	
			-- self.target.damage_texttag_crit = tag
		-- end
	
	-- local tag = self.target.damage_texttag
	-- -- if tag and ac.clock() - tag.time < 2000 then
	-- -- 	tag.damage = tag.damage + self.current_damage
	-- -- 	tag:setText(('%.f'):format(tag.damage), 8 + (tag.damage ^ 0.5) / 5)
	-- -- else
	-- 	--每次伤害都显示出来
	-- 	local x, y = self.target:get_point():get()
	-- 	local z = self.target:get_point():getZ()
	-- 	local tag = ac.texttag
	-- 	{
	-- 		string = ('%.f'):format(self.current_damage),
	-- 		size = 8 + (self.current_damage ^ 0.5) / 5,
	-- 		position = ac.point(x - 60, y, z + 30),
	-- 		speed = 86,
	-- 		angle = 135,
	-- 		red = 100,
	-- 		green = 20,
	-- 		blue = 20,
	-- 		damage = self.current_damage,
	-- 		time = ac.clock(),
	-- 	}
	-- 	self.target.damage_texttag = tag
	-- end
	
end

function mt:on_attack_drop()
	if self.source:get_owner() ~= ac.player.self and self.target ~= ac.player.self.hero then
		return
	end
	local tag = self.target.damage_texttag
	if tag and ac.clock() - tag.time < 1000 then

	else 
		local x, y = self.source:get_point():get()
		local tag = ac.texttag
		{
			player = self.source:get_owner(),
			string = '丢失!',
			size = 12,
			position = ac.point( x, y, 70),
			speed = 86,
			angle = 45,
			red = 100*2.55,
			green = 20*2.55,
			blue = 20*2.55,
			time = ac.clock(),
		}
	
		self.target.damage_texttag_miss = tag

	end
	
end 

function mt:on_miss()
	if self.source:get_owner() ~= ac.player.self and self.target ~= ac.player.self.hero then
		return
	end
	local tag = self.target.damage_texttag
	if tag and ac.clock() - tag.time < 1000 then

	else 
		local x, y = self.target:get_point():get()
		local tag = ac.texttag
		{
			player = self.target:get_owner(),
			string = 'miss',
			size = 12,
			position = ac.point( x, y, 70),
			speed = 86,
			angle = 45,
			red = 100*2.55,
			green = 20*2.55,
			blue = 20*2.55,
			time = ac.clock(),
		}
	
		self.target.damage_texttag_miss = tag

	end
	
end 

--死亡
function mt:kill()
	local target = self.target
	if target:has_restriction '免死' then
		-- print('理应免死')
		-- target:set('生命', 0) --谨慎使用，生命上限100亿时，设置生命0会导致魔兽端死亡,英萌端认为还是活着。
		return false
	end
	if target:event_dispatch('单位-即将死亡', self.target,self.source) then
		return false
	end
	return target:kill(self.source)
end


--// add by jeff 
--// start

--[[
    当前伤害：10
    致命伤害：200. / 0   100
          
    装备  +40    ， +40%
	
	实现：  
	u:add('致命伤害',40)	实际+40  
	u:add('致命伤害%',40)	实际+50  

	最终致命伤害 250  / 0
    最终伤害 10+2.5*10 = 35  / 0
	 
	致命伤害 = 10
	致命伤害% = 20%
	
	致命伤害 实际理解为 暴击全伤加深。 

]]

--计算物理暴击
function mt:on_physicals_crit_damage()
	local source = self.source
	local dmg = source:get '暴击加深'   
	--暴击加深 <=0 ,返回0
	if dmg <= -100 then
		self.current_damage = 0
	end 
	self.current_damage = self.current_damage * ( 1 + dmg/100 + 1 ) 
end

--计算会心一击
function mt:on_heart_crit_damage()
	local source = self.source
	local dmg = source:get '会心伤害'
	--会心一击 <=0 ,返回0
	if dmg <= -100 then
		self.current_damage = 0
	end 
	self.current_damage = self.current_damage * (1 + dmg/100 + 1)
end

--计算法术暴击
function mt:on_spells_crit_damage()
	local source = self.source
	local dmg = source:get '技暴加深'
	--技暴加深 <=0 ,返回0
	if dmg <=  -100 then
		self.current_damage = 0
	end 
	self.current_damage = self.current_damage * (1 + dmg/100 + 1)
end


--计算boss全伤加深
function mt:on_boss_damage()
	local source = self.source
	local target = self.target
	--只对boss or 英雄 造成全伤加深
	if target:is_hero() then 
		local dmg = source:get '对BOSS额外伤害'
		--boss全伤加深 <=0 ,返回0
		if dmg <= -100 then
			self.current_damage = 0
		end 
		self.current_damage = self.current_damage * (1 + dmg/100)
	end 	
end

--计算护甲和破甲
function mt:count_defence()
	local source = self.source
	local target = self.target
	local pene, pene_rate = self['破甲'], self['穿透']
	local def = target:get '护甲'
	local a = 1

	if def > 0 then
		if pene_rate < 100 then
			def = def * (1 - pene_rate / 100)
		else
			def = 0
		end
	end
	if pene then
		def = def - pene
	end

	--如果为负数护甲，每点增加0.1%伤害，最大200%
	if def < 0 then
		a = 1 + (-def * 0.1) / 100
		def = 0
		if a > 2 then
			a = 2
		end
	end
	-- print(def,a)
    -- print(self.current_damage,a,def)
	self.current_damage = (self.current_damage * (1 - def * 0.06 / (1 + def * 0.06))) * a
    -- print(self.current_damage,a)
end

--计算魔抗和破魔
function mt:count_mokang_defence()
	local source = self.source
	local target = self.target
	local pene, pene_rate = self['破魔'], self['穿魔']
	local def = target:get '魔抗'
	local a = 1

	if def > 0 then
		if pene_rate < 100 then
			def = def * (1 - pene_rate / 100)
		else
			def = 0
		end
	end
	if pene then
		def = def - pene
	end

	--如果为负数护甲，每点增加0.1%伤害，最大200%
	if def < 0 then
		a = 1 + (-def * 0.1) / 100
		def = 0
		if a > 2 then
			a = 2
		end
	end
	-- print(def,a)
    -- print(self.current_damage,a,def)
	self.current_damage = (self.current_damage * (1 - def * 0.06 / (1 + def * 0.06))) * a
    -- print(self.current_damage,a)
end

--计算减伤
function mt:Injury()
	local target = self.target
	local dmg = target:get '免伤'

	if dmg <=0 then 
		dmg = 0
	end

	local hero = self.target
	if target:get('免伤几率') > math.random(0, 99) then
		show_block(hero,'免伤!')	
		self.current_damage = 0
	else
		if self.current_damage <= target:get '伤害减少'  then 
			self.current_damage = 0
		else 
			self.current_damage = (self.current_damage - target:get '伤害减少') * (1 - dmg/100)
		end	
	end

end

--计算法术伤害减免
function mt:MagicInjury()
	local target = self.target
	local dmg = target:get '法术伤害减免'

	if dmg <=0 then 
		dmg = 0
	end

	if self.current_damage <= target:get '法术伤害减伤'  then 
		self.current_damage = 0
	else 
	    self.current_damage = (self.current_damage - target:get '法术伤害减伤') * (1 - dmg/100)
	end	

end

--计算技能伤害加成
function mt:on_skill_damage()
	local source = self.source
	local dmg = source:get '技能伤害'
	-- local dmg_base = source:get '技能基础伤害'

	if dmg <=0 then 
		dmg = 0
	end 	
	-- if dmg_base <= 0  then 
	-- 	dmg_base = 0
	-- end	

	-- self.current_damage = (self.current_damage + dmg_base) * (1 + dmg/100)
	self.current_damage = (self.current_damage ) * (1 + dmg/100)
	
end

--计算技能伤害加深 伤害加成
function mt:on_more_magic_damage()
	local source = self.source
	local dmg = source:get '技能伤害加深'
	-- local dmg_base = source:get '技能基础伤害'

	if dmg <=0 then 
		dmg = 0
	end 	
	-- if dmg_base <= 0  then 
	-- 	dmg_base = 0
	-- end	

	-- self.current_damage = (self.current_damage + dmg_base) * (1 + dmg/100)
	self.current_damage = (self.current_damage ) * (1 + dmg/100)
	
end
--计算物理伤害加深
function mt:on_more_physical_damage()
	local source = self.source
	local dmg = source:get '物理伤害加深'
	if dmg <=0 then 
		dmg = 0
	end 	
	self.current_damage = (self.current_damage ) * (1 + dmg/100)
end

--攻击回血
function mt:count_damage_hp()
	local source = self.source
	local a = source:get '攻击回血'
	if a > 0 then
		self.source:heal
		{
			source = self.source,
			heal = a,
			skill = self.skill,
			damage = self,
		}
		--在身上创建特效
		self.source:add_effect('origin', [[Abilities\Spells\Undead\VampiricAura\VampiricAuraTarget.mdl]]):remove()
	end

end

--杀怪回血
function mt:count_kill_hp()
	local source = self.source
	local a = source:get '杀怪回血'

	if a > 0 then
		self.source:heal
		{
			source = self.source,
			heal = a,
			skill = self.skill,
			damage = self,
		}
		--在身上创建特效
		self.source:add_effect('origin', [[Abilities\Spells\Undead\VampiricAura\VampiricAuraTarget.mdl]]):remove()
	end
end
--// add by jeff 
--// end

--攻击减甲 双抗
function mt:on_reduce_defence()
	if self:is_common_attack() or self.skill == '多重射' then
		local source = self.source
		local target = self.target
		local val = source:get '攻击减甲'
		
		if val > 0 then
			target:add('护甲',-val)
			-- target:add('魔抗',-val)
			--记录数据，给pk模式用
			if source:is_hero() and target:is_hero() then 
				target.had_reduce_defence = (target.had_reduce_defence or 0) + val
			end	
		end
	end	
end



--创建伤害
function damage:__call()
	local source, target = self.source, self.target
	self.success = false
	if not target or self.damage == 0 then
		self.current_damage = 0
		return
	end
	if self.damage_type == "物理" then
		if target:has_restriction '物免' then
			self.current_damage = 0
			return
		end
		
	else
		if target:has_restriction '魔免' then
			self.current_damage = 0
			return
		end
	end
	--不是技能造成的，进行攻击丢失处理
	if not self:is_skill() then 
		local rand = math.random(100)
		if rand <= self.source:get('攻击丢失') then 
			self:on_attack_drop()
			return 
		end 
	end	

	--不是技能造成的，进行闪避处理
	if not self:is_skill() then 
		local rand = math.random(100)
		if rand <= self.target:get('闪避') then 
			self:on_miss()
			return 
		end 
	end	
	
	ac.game:event_notify('伤害初始化', self)

	if not source then
		self.source = self.target
		source = target
		log.error('伤害没有伤害来源')
	end

	if self.skill == nil then
		log.error('伤害没有传入技能或物品')
	end

	self:on_attribute_attack()
	self:on_attribute_defence()

	self.current_damage = self.damage
	
	if source then
		source:setActive(target)
		target:setActive(source)
	end

	--检验伤害有效性
	if source:event_dispatch('造成伤害开始', self) then
		self.current_damage = 0
		return
	end
	
	if target:event_dispatch('受到伤害开始', self) then
		self.current_damage = 0
		return
	end

	if not self.real_damage then
		source:event_notify('造成伤害前效果', self)
		target:event_notify('受到伤害前效果', self)

		--攻击命中在伤害有效性后结算
		if self:is_attack() then
			if self.common_attack then
				ac_event_notify(self, '法球命中', self)
			else
				ac_event_notify(source, '法球命中', self)
			end
		end

		--[[  add by jeff
			start
		]]
		--判断攻击类型  技能需要额外加成属性栏里面的技能伤害值
		if self.common_attack then
			source:event_notify('单位-造成普攻伤害', self)
			target:event_notify('单位-受到普攻伤害', self)
			--计算物理伤害加深
			self:on_more_physical_damage()
		else
			source:event_notify('单位-造成技能伤害', self)
			target:event_notify('单位-受到技能伤害', self)
			--计算技能基础伤害
			self.current_damage = self.current_damage + source:get('技能基础伤害')
			--计算技能伤害加成
			self:on_skill_damage()
			--计算计算技能伤害加深加成
			self:on_more_magic_damage()
		end
		--判断伤害类型
		if self.damage_type == '物理' then	
			--计算物理暴击
			
			if  self:is_physicals_crit()  then
				self:on_physicals_crit_damage()
			end
		else
			--计算法术暴击
			if  self:is_spells_crit()  then
				self:on_spells_crit_damage()
			end
			source:event_notify('单位-造成法术伤害', self)
		end
		-- 计算会心一击
		if  self:is_heart_crit() then
			self:on_heart_crit_damage()
		end

		--计算 对 boss 全伤加深
		self:on_boss_damage()

		--判断伤害类型
		if self.damage_type == '物理'  then
			--计算护甲和破甲 (技能、普攻物理含)
			self:count_defence()
			
		else
			--计算魔抗和破魔 (技能法术)
			self:count_mokang_defence()
			--计算法术伤害减免
			self:MagicInjury()
		end	
		--计算免伤相关
		self:Injury()

		--计算格挡
		on_block(self)

		local ewsh = source:get '全伤加深'
		--计算全伤加深
		self.current_damage = (self.current_damage ) * (1 + ewsh/100)

		--加成
		if not on_damage_mul_div(self) then 
			return 
		end	
	end

	self.success = true
	--造成伤害
	if self.current_damage < 0 then
		self.current_damage = 0
	end
	--return true 终止伤害
	if target:event_dispatch('伤害计算完毕', self) then
		self.current_damage = 0
		return
	end

	if self:is_common_attack()  then
		--攻击回血
		self:count_damage_hp()
	end

	--消耗护盾
	local effect_damage = cost_shield(self)
	local life = target:get '生命'
	if life <= effect_damage then
		--杀怪回血
		self:count_kill_hp()
		self:kill()
	else
		target:set('生命', life - effect_damage)
	end
	--音效
	on_sound(self)
	--漂浮文字
	on_texttag(self)
	
	if not self.real_damage then

		if not target:is_type('建筑') then
			--吸血
			on_life_steal(self)
			--分裂伤害
			on_splash(self)
			--攻击减甲
			self:on_reduce_defence()
		end
		
		--伤害效果
		source:event_notify('造成伤害效果', self)
		target:event_notify('受到伤害效果', self)
	end

	source:event_notify('造成伤害结束', self)
	--print(source,'造成伤害结束')
	target:event_notify('受到伤害结束', self)
	--print(target,'造成伤害结束')

	return self
end

function mt:on_attack_start()
	self.source:event_notify('单位-攻击开始', self)
	self.target:event_notify('单位-被攻击开始', self)
end

function mt:on_attack_cast()
	self.source:event_notify('单位-攻击出手', self)
	self.target:event_notify('单位-被攻击出手', self)
end

local event = { 
	['单位-攻击开始'] = mt.on_attack_start,
	['单位-攻击出手'] = mt.on_attack_cast,
	['单位-造成伤害'] = mt.dispatch,
	['单位-受到伤害'] = mt.dispatch,
}

function mt:event_dispatch(name)
	return event[name](self)
end

function mt:event_notify(name)
	-- print('伤害事件：',name,event[name])
	return event[name](self)
end

function mt:event(name)
	local events = self.events
	if not events then
		events = {}
		self.events = events
	end
	local event = events[name]
	if not event then
		event = {}
		events[name] = event
	end
	return function (f)
		return ac.trigger(event, f)
	end
end

function damage.init()
	
end

return damage
