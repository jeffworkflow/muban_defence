local mt = ac.skill['修罗之魂']

mt{
	--必填
	is_skill = true,
	
	--初始等级
	level = 1,

	max_level = 5,
	tip = [[
		主动：变身大帝，强化自身，持续 %time% S
			攻击力 +%attack% %
			多重射 +%duochongshe% 
			攻击间隔 %attack_gap%
			伤害减免 %reduce_damage% %
			攻击距离 +%attack_range%
		被动：凯撒周围%area%码的单位每增加1个，凯撒的攻击力增加 %attack_increase% %
	]],
	--播放动画
	-- show_animation = { 'Attack Alternate', 'spell channel' },
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNMetamorphosis.blp]],

	--技能目标类型 无目标
	target_type = ac.skill.TARGET_TYPE_NONE,

	--攻击
	attack = {40,45,50,55,60},

	--移动速度
	move_speed = 30,

	--攻击间隔
	attack_gap = -0.2,

	duochongshe = 2,

	--伤害减免
	reduce_damage = 30,

	--攻击距离
	attack_range = 800,

	--持续时间
	time = {20,22.5,25,27.5,30},

	--cd 45
	cool = 30,

	--耗蓝
	cost = {50,200,350,500,650},

	--特效模型
	effect = [[]],

	-- 变身模型id
	unit_type_id = 'Z003',

	-- 周围范围
	area = 600,
	-- 攻击加成
	attack_increase = {10,12.5,15,17.5,20},
	--施法距离
	-- range = 99999,
}

function mt:on_upgrade()
    local skill = self
	local hero = self.owner 
	self.trg = hero:add_buff '修罗之魂-被动' 
	{
		source = hero,
		skill = self,
		attack_increase = self.attack_increase,
		area = self.area,
		pulse = 0.02, --立即生效
		real_pulse = 0.1  --实际每几秒检测一次
	}
end	
function mt:on_add()
    local skill = self
	local hero = self.owner 


end	
function mt:on_cast_shot()
	local hero = self.owner
	-- hero:add_effect('origin',self.effect)
	--播放动画
	hero:set_animation('Attack Alternate')
	
	self.trg1 = hero:add_buff '修罗之魂' 
	{
		source = hero,
		skill = self,
		attack = self.attack,
		duochongshe = self.duochongshe,
		attack_gap = self.attack_gap,
		attack_range = self.attack_range,
		reduce_damage = self.reduce_damage,
		unit_type_id = self.unit_type_id,
		time = self.time
	}

	
end

function mt:on_remove()

    local hero = self.owner 
	
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end   
    if self.trg1 then
        self.trg1:remove()
        self.trg1 = nil
    end     

end


local mt = ac.buff['修罗之魂']

mt.keep = true
mt.origin_id = 0

function mt:on_add()

	local hero = self.target
	--特效
	hero:get_point():add_effect([[modeldekan\ability\dekan_goku_r_effect_add.mdl]]):remove()
	self.origin_id = hero:get_type_id()

	--变身
	hero:transform(self.unit_type_id)

	--变远程
	self.old_weapon = hero.weapon
	hero.weapon = ac.table.UnitData['凯撒(恶魔形态)'].weapon
	--设置为远程
	hero:setMelee(false)

	--增加攻击力与生命恢复速度
	hero:add('攻击%', self.attack)
	hero:add('多重射', self.duochongshe)
	hero:add('攻击距离', self.attack_range)
	hero:add('减免', self.reduce_damage)
	hero:add('攻击间隔', self.attack_gap)


end

function mt:on_remove()
    
	local hero = self.target
	--特效x
	hero:get_point():add_effect([[modeldekan\ability\dekan_goku_r_effect_remove.mdl]]):remove()
			
	--变回去
	hero:transform(self.origin_id)
	--设置为近战
	hero:setMelee(true)
	-- print(hero.weapon['弹道模型'])
	-- hero.weapon = self.old_weapon
	-- print(hero.weapon['弹道模型'],self.old_weapon)

	--增加攻击力与生命恢复速度
	hero:add('攻击%', -self.attack)
	hero:add('多重射', -self.duochongshe)
	hero:add('攻击距离', -self.attack_range)
	hero:add('减免', -self.reduce_damage)
	hero:add('攻击间隔', -self.attack_gap)
    
end



local mt = ac.buff['修罗之魂-被动']
mt.keep = true --死亡时依旧保持
mt.cover_type = 1
mt.cover_max = 1
-- mt.attack_sum = 0
function mt:on_add()
	local hero = self.target
	--特效

end

function mt:on_pulse()
	-- print('腐烂每秒伤害：',damage*self.pulse)
	local hero = self.target
	self.pulse = self.real_pulse
	--每 0.2 秒检测周围单位一次，先移除上次增加的攻击，再重新计算添加。
	if self.skill.cnt then 
		hero:add('攻击%',-self.skill.cnt*self.attack_increase)
	end	

	self.skill.cnt = 0
	local hero = self.target
	for i, u in ac.selector()
		: in_range(hero,self.area)
		: of_not_building()
		: is_not(hero)
		: ipairs()
	do
		self.skill.cnt = self.skill.cnt + 1
	end	
	hero:add('攻击%',self.skill.cnt*self.attack_increase)
	-- print('周围单位个数：'..self.skill.cnt,hero:get('攻击%'))
end
--人物死亡时，需要移除已添加的被动加成
function mt:on_remove()
	local hero = self.target
	if self.skill.cnt then 
		hero:add('攻击%',-self.skill.cnt*self.attack_increase)
	end	
	self.skill.cnt = 0
end

function mt:on_cover(new)
	return new.attack_increase > self.attack_increase
end
