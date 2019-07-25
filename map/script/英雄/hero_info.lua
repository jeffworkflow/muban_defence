--[[ 
应用场景： 英萌里面每个英雄 技能右上角显示 此英雄的属性值。（攻击力、穿透率、生命等 ）

特别注意：tip 里面的 %life% 调取局部life 函数，获得返回值。

]]

local damage = require 'types.damage'

local mt = ac.skill['英雄属性面板']
{
	level = 1,

	max_level = 1,

	never_copy = true,

	passive = true,
	
	-- ability_id = 'B889',

	tip = [[
攻击:    %attack% （已加成 %attack_per% %）
攻击间隔:    %attack_gip% 
攻速:    %attack_speed% (每秒攻击%attack_rate%次)
分裂伤害:  %splash% %  
攻击减甲:    %pene%    
吸血:    %life_steal% %
免伤几率:  %wtf_rate% %  免伤:  %defence_rate% %  

闪避:    %miss% %  攻击丢失:    %attack_drop% %

暴击几率: %physical_rate% %  暴击加深:  %physical_damage% %
技暴几率: %magic_rate% %  技暴加深:  %magic_damage% %
会心几率: %heart_rate% %  会心伤害:  %heart_damage% %

金币加成：   %moregold% %  木头加成： %morewood% %
经验加成：   %moreexp% %  火灵加成： %morefireseed% %
物品获取率： %item_rate% %  杀敌数加成： %morekillcount% %

杀怪加力量： %kill_str%     每秒加金币:   %per_gold%  
杀怪加敏捷： %kill_agi%     每秒加全属性: %per_allattr% 
杀怪加智力： %kill_int%
杀怪加全属性： %kill_all_attr%
杀怪加护甲： %kill_defence%
杀怪加攻击： %kill_attack%
]],
}

function mt:miss()
	return ('|cffF9C801%.f|r'):format(self.owner:get '闪避')
end
function mt:attack_drop()
	return ('|cffF9C801%.f|r'):format(self.owner:get '攻击丢失')
end
function mt:wtf_rate()
	return ('|cffF9C801%.f|r'):format(self.owner:get '免伤几率')
end
function mt:morewood()
	return ('|cffF9C801%.f|r'):format(self.owner:get '木头加成')
end
function mt:morefireseed()
	return ('|cffF9C801%.f|r'):format(self.owner:get '火灵加成')
end
function mt:morekillcount()
	return ('|cffF9C801%.f|r'):format(self.owner:get '杀敌数加成')
end

function mt:kill_attack()
	return ('|cffF9C801%.2f|r'):format(self.owner:get '杀怪加攻击')
end

function mt:duochongshe()
	return ('|cffF9C801%.2f|r'):format(self.owner:get '多重射')
end

function mt:per_allattr()
	return ('|cffF9C801%.f|r'):format(self.owner:get '每秒加全属性')
end
function mt:per_gold()
	return ('|cffF9C801%.f|r'):format(self.owner:get '每秒加金币')
end
function mt:kill_defence()
	return ('|cffF9C801%.f|r'):format(self.owner:get '杀怪加护甲')
end
function mt:kill_str()
	return ('|cffF9C801%.f|r'):format(self.owner:get '杀怪加力量')
end
function mt:kill_agi()
	return ('|cffF9C801%.f|r'):format(self.owner:get '杀怪加敏捷')
end
function mt:kill_int()
	return ('|cffF9C801%.f|r'):format(self.owner:get '杀怪加智力')
end
function mt:kill_all_attr()
	return ('|cffF9C801%.f|r'):format(self.owner:get '杀怪加全属性')
end
function mt:attack()
	return ('|cffF9C801%.f|r'):format(self.owner:get '攻击')
end

function mt:attack_per()
	return ('|cffF9C801%.2f|r'):format(self.owner:get '攻击%')
end


function mt:physical_rate()
	return ('|cffF9C801%.2f|r'):format(self.owner:get '暴击几率')
end

function mt:physical_damage()
	return ('|cffF9C801%.f|r'):format(self.owner:get '暴击加深'+100)
end

function mt:magic_rate()
	return ('|cffF9C801%.2f|r'):format(self.owner:get '技暴几率')
end
function mt:magic_damage()
	return ('|cffF9C801%.f|r'):format(self.owner:get '技暴加深'+100)
end

function mt:heart_rate()
	return ('|cffF9C801%.2f|r'):format(self.owner:get '会心几率')
end
function mt:heart_damage()
	return ('|cffF9C801%.f|r'):format(self.owner:get '会心伤害'+100)
end

function mt:dummy()
	return ('|cffF9C801%.1f|r'):format(self.owner:get '召唤物')
end
function mt:dummy_attr()
	return ('|cffF9C801%.f|r'):format(self.owner:get '召唤物属性')
end
function mt:magic_attack()
	return ('|cffF9C801%.f|r'):format(self.owner:get '技能伤害加深')
end


function mt:moregood()
	return ('|cffF9C801%.f|r'):format(self.owner:get '主动释放的增益效果')
end


function mt:moregold()
	return ('|cffF9C801%.f|r'):format(self.owner:get '金币加成')
end
function mt:moreexp()
	return ('|cffF9C801%.f|r'):format(self.owner:get '经验加成')
end
function mt:item_rate()
	return ('|cffF9C801%.f|r'):format(self.owner:get '物品获取率')
end

local life_color = 'ff00dd11'

local function get_resource_color(hero)
	return ac.resource[hero.resource_type].color
end

function mt:on_add()
	local hero = ac.player.self.hero
	if hero then
		self.art = hero:get_slk 'Art'
		self:fresh_art()
		if self.owner:get_owner():is_self() then
			local name = self.owner:get_owner():getColorWord() .. hero:get_name() .. '|r'
			self.title = name
		end
	end
end

function mt:attack_gip()
	return ('|cffF9C801%.2f|r'):format(self.owner:get '攻击间隔')
end


function mt:life()
	return ('|c%s%.2f|r'):format(life_color, self.owner:get '生命')
end

function mt:max_life()
	return ('|c%s%.2f|r'):format(life_color, self.owner:get '生命上限')
end

function mt:life_recover()
	local recover = self.owner:get '生命恢复'
	local str = ('%.2f'):format(recover)
	if recover >= 0 then
		str = '+' .. str
	end
	if not self.owner.active then
		str = '|cff7f7f7f(' .. str .. ')|r'
	else
		str = '|cffffffff(|r|c' .. life_color .. str .. '|r|cffffffff)|r'
	end
	return str
end

function mt:life_recover_idle()
	local recover, recover_idle = self.owner:get '生命恢复', self.owner:get '生命脱战恢复'
	local str = ('%.2f'):format(recover + recover_idle)
	if recover >= 0 then
		str = '+' .. str
	end
	if self.owner.active then
		str = '|cff7f7f7f(' .. str .. ')|r'
	else
		str = '|cffffffff(|r|c' .. life_color .. str .. '|r|cffffffff)|r'
	end
	return str
end

function mt:mana()
	return ('|cff%s%.2f|r'):format(get_resource_color(self.owner), self.owner:get '魔法')
end

function mt:max_mana()
	return ('|cff%s%.2f|r'):format(get_resource_color(self.owner), self.owner:get '魔法上限')
end

function mt:mana_recover()
	local recover = self.owner:get '魔法恢复'
	local str = ('%.2f'):format(recover)
	if recover >= 0 then
		str = '+' .. str
	end
	if not self.owner.active then
		str = '|cff7f7f7f(' .. str .. ')|r'
	else
		str = '|cffffffff(|r|cff' .. get_resource_color(self.owner) .. str .. '|r|cffffffff)|r'
	end
	return str
end

function mt:mana_recover_idle()
	local recover, recover_idle = self.owner:get '魔法恢复', self.owner:get '魔法脱战恢复'
	local str = ('%.2f'):format(recover + recover_idle)
	if recover + recover_idle >= 0 then
		str = '+' .. str
	end
	if self.owner.active then
		str = '|cff7f7f7f(' .. str .. ')|r'
	else
		str = '|cffffffff(|r|cff' .. get_resource_color(self.owner) .. str .. '|r|cffffffff)|r'
	end
	return str
end

function mt:attack_speed()
	return ('|cffF9C801%.2f|r'):format(self.owner:get '攻击速度')
end

function mt:attack_rate()
	local attack_cool = self.owner:get '攻击间隔'
	local attack_speed = self.owner:get '攻击速度'
	if attack_speed >= 0 then
		attack_cool = attack_cool / (1 + attack_speed / 100)
	else
		attack_cool = attack_cool * (1 - attack_speed / 100)
	end
	return ('|cffF9C801%.2f|r'):format(1 / attack_cool)
end

function mt:crit_chance()
	return self.owner:get '暴击'
end

function mt:crit_damage()
	return self.owner:get '暴击伤害'
end

function mt:splash()
	return self.owner:get '分裂伤害'
end

function mt:pene()
	return ('|cffF9C801%.2f|r'):format(self.owner:get '攻击减甲')
end

function mt:pene_rate()
	local rate = self.owner:get '穿透'
	return rate
end

function mt:life_steal()
	return self.owner:get '吸血'
end

function mt:cool_speed()
	return ('|cffF9C801%.2f|r'):format(self.owner:getSkillCool(100))
end

function mt:cost_save()
	return ('|cffF9C801%.2f|r'):format(self.owner:get '减耗')
end

function mt:defence()
	return self.owner:get '护甲'
end

function mt:defence_rate()
	return ('|cffF9C801%.2f|r'):format(self.owner:get '免伤')
end

function mt:block_chance()
	return self.owner:get '格挡'
end

function mt:block_rate()
	local block_rate = self.owner:get '格挡伤害'
	return block_rate
end

function mt:resource_type()
	return '|r' .. self.owner.resource_type .. '|cffffffff'
end

function mt:damage_rate()
	return self.owner:getDamageRate()
end

function mt:damaged_rate()
	return self.owner:getDamagedRate()
end

function mt:shield()
    local v = self.owner:get '护盾'
    if v > 0 then
        return '|r护盾:    |cff77bbff' .. v .. '|r|n'
    end
    return ''
end
