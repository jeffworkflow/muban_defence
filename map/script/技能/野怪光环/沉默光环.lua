--物品名称
local mt = ac.skill['沉默光环']

mt.title = "沉默光环"
mt.tip = [[
	被动1：使得敌人无法使用主动魔法
	被动2：降低自己的三维45%
]]

-- mt.switch = true
--影响三维值 (怪物为：生命上限，护甲，攻击力)
mt.value = 45

--影响范围
mt.area = 99999
--是否光环
mt.is_aura = true

function mt:on_add()
	local hero = self.owner
	if hero:is_illusion() then
		return
	end
	local area = self.area
	local key_unit = ac.key_unit



	self.buff = hero:add_buff '沉默光环'
	{
		source = hero,
		skill = self,
		selector = ac.selector()
			: in_range(hero, self.area)
			: is_not(key_unit) 
			,
        -- buff的数据，会在所有自己的子buff里共享这个数据表
        data = {
			value = self.value,
        },
	}
end

function mt:on_remove()
	if self.buff then
		self.buff:remove()
	end
end



local mt = ac.aura_buff['沉默光环']
-- 魔兽中两个不同的专注光环会相互覆盖，但光环模版默认是不同来源的光环不会相互覆盖，所以要将这个buff改为全局buff。
mt.cover_global = 1

mt.cover_type = 1
mt.cover_max = 1

mt.effect = [[]]
mt.target_effect = [[Abilities\Spells\Other\Silence\SilenceTarget.mdl]]

mt.keep = true

function mt:on_add()
	
	-- print('打印受光环英雄的单位',self.target:get_name())

	--光环持有者的敌对单位处理
	if self.source:is_enemy(self.target) then 
		--加特效
        -- self.target_eff = self.target:add_effect('overhead', self.target_effect)
		-- 沉默
		self.target:add_buff '沉默'{
			source = self.source
		}
		-- print('打印敌对单位',self.target:get_name(),self.target:get('移动速度'))
	else
		--光环持有者的同盟单位处理
		-- 降低三维(生命上限，护甲，攻击)
		self.target:add('生命上限%', -self.data.value)
		self.target:add('护甲%', -self.data.value)
		self.target:add('攻击%', -self.data.value)
		-- print('打印友军单位',self.target:get_name(),self.target:get('生命上限'))
	end	
	
end

function mt:on_remove()
	if self.source_eff then self.source_eff:remove() end
	if self.target_eff then self.target_eff:remove() end
    
	--光环持有者的敌对单位处理
	if self.source:is_enemy(self.target) then 
		-- 沉默
		self.target:remove_buff '沉默'
	else
		--光环持有者的同盟单位处理
		-- 降低三维(生命上限，护甲，攻击)
		self.target:add('生命上限%', self.data.value)
		self.target:add('护甲%', self.data.value)
		self.target:add('攻击%', self.data.value)
	end	
    
end
