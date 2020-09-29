local mt = ac.skill['简易']
{
    reduce_level =5,
    tip=[[|cffffe799【特性-简易】|r佩戴的地图等级需求减少5级]],
}
local mt = ac.skill['超级简易']
{
    reduce_level =15,
    tip=[[|cffffe799【特性-超级简易】|r佩戴的地图等级需求减少15级]],
}
local mt = ac.skill['无级别']
{
    reduce_level =99, --表示无级别
    tip=[[|cffffe799【特性-无级别】|r无视佩戴的地图等级需求]],
}
local mt = ac.skill['精致']
{
    attr_mul =35, --表示无级别
    tip=[[|cffffe799【特性-精致】|r该装备的实际属性额外提升35%]],
}
local mt = ac.skill['珍宝']
{
    attr_mul =50, --表示无级别
    tip=[[|cffffe799【特性-珍宝】|r该装备的实际属性额外提升50%]],
}

local mt = ac.skill['破血狂攻']
{
    unique_name ='破血狂攻',
    event_name = '造成伤害效果',
    attack_cnt =10,
    tip =[[|cffffe799【唯一特性-破血狂攻】|r每攻击10下，可以额外攻击1次]]
}
function mt:on_add()
    local skill = self
    local hero = self.owner
	local p = hero:get_owner()
	if self.bff then 
		self.bff:remove()
	end
	self.bff = hero:add_buff('破血狂攻'){
		skill = skill,
		val = skill.attack_cnt
	}
end

function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.bff then
        self.bff:remove()
        self.bff = nil
    end
end

local mt = ac.buff['破血狂攻']
mt.cover_type = 0
function mt:on_add()
	local skill = self.skill
	self.trg = self.target:event '造成伤害效果'(function(_,damage)
		if not damage:is_common_attack()  then 
			return 
		end 
		if skill:is_cooling() then 
			return 
		end
		skill.lx = (skill.lx or 0) + 1
		skill:set('lx',skill.lx)
		-- print('造成伤害效果',skill.lx,math.floor(skill.v1) )
		if skill.lx >= math.floor(skill.attack_cnt) then
			skill:set('lx',0)
			--再发起一次攻击
			self.target:attack_start(damage.target)
			skill:active_cd()
		end

	end)
end

function mt:on_remove()
	if self.trg then 
		self.trg:remove()
		self.trg = nil 
	end
end
function mt:on_cover(new)
	return new.val < self.val
end


local mt = ac.skill['弱点击破']
mt{
    tip=[[|cffffe799【唯一特性-神佑】|r无视敌人5%的护甲]]
}
function mt:on_add()
    local hero = self.owner 
    self.buf = hero:add_buff '弱点击破'{
    }
end
function mt:on_remove()
    if self.buf then 
        self.buf:remove()
        self.buf = nil 
    end
end

local mt = ac.buff['弱点击破']
mt.cover_type = 0
function mt:on_add()
    self.target:add('穿透',5)
    self.target:add('穿魔',5)
end

function mt:on_remove()
    self.target:add('穿透',-5)
    self.target:add('穿魔',-5)
end

local mt = ac.skill['神佑']
mt{
    --触发几率
   chance = 10,
   unique_name ='神佑',
   effect = [[Abilities\Spells\Human\Resurrect\ResurrectCaster.mdl]],
   event_name = '单位-即将死亡',
   tip=[[|cffffe799【唯一特性-神佑】|r死亡时10%几率复活]]
}
function mt:damage_start(unit,killer)
    local hero =self.owner
    local p = hero.owner
    local skill =self
    --目标特效
    -- ac.effect(damage.target:get_point(),self.effect,0,4,'origin'):remove()
    hero:add_effect('chest',self.effect):remove()
    --目标减最大 
    hero:heal
    {
        source = hero,
        skill = skill,
        string = '长生',
        size = 10,
        heal = hero:get('生命上限'),
    }	
    hero:add_buff '无敌'{
        time =0.5
    }
    -- hero:add('护甲',1000000000)
    return true
end    

local mt = ac.skill['愤怒']
mt{
    --触发几率
   chance = 10,
   unique_name ='愤怒',
   event_name = '造成伤害效果',
   tip=[[|cffffe799【唯一特性-愤怒】|r攻击10% 几率提升5%全伤加深系数，持续10秒]]
}
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
	local target = damage.target

	if not damage:is_common_attack()  then 
		return 
	end 
	hero:add_buff '属性_全伤加深系数'{
        cover_max = 10,
        cover_type = 1,
        time = 10,
        value = 5,
        
    }
end

local mt = ac.skill['魔兽之印']
mt{
    --触发几率
   chance = 10,
   unique_name ='愤怒',
   event_name = '造成伤害效果',
   damage_area = 2000,
   tip=[[|cffffe799【唯一特性-魔兽之印】|r攻击10% 几率，提升周围友方单位2.5%全伤加深系数，持续10秒]]
}
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
	local target = damage.target

	if not damage:is_common_attack()  then 
		return 
    end 
    for i, u in ac.selector()
    : in_range(hero,self.damage_area)
    : is_ally(hero)
    : ipairs()
    do
        u:add_buff '属性_全伤加深系数'{
            cover_max = 10,
            cover_type = 1,
            time = 10,
            value = 2.5,
        }
    end
end

-- for key,name in pairs(ac.skill['弱点击破']) do 
--     print(key,name)
-- end

-- 简易：佩戴的地图等级需求减少5级
-- 超级简易：佩戴的地图等级需求减少15级
-- 无级别：无视佩戴的地图等级需求
-- 精致：基础值增加50%
-- 珍宝：特殊值增加50%
-- 唯一-破血狂攻：每攻击10下，可以额外攻击1次
-- 唯一-弱点击破：减少敌人5%的护甲
-- 唯一-神佑：20%的几率出现神佑复活效果
-- 唯一-愤怒：攻击10%几率提升5%全伤加深系数，持续10秒
-- 唯一-魔兽之印：攻击10%几率提升，周围友方单位2.5%全伤加深系数，持续10秒