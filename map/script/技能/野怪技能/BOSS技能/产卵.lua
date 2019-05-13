
local mt = ac.skill['产卵']
mt{
--初始等级
level = 1,
--施法信息
cast_start_time = 0,
cast_channel_time = 3,
cast_shot_time = 0,
cast_finish_time = 1,
--技能图标
art = [[ReplaceableTextures\CommandButtons\BTNNerubian.blp]],
--技能说明
title = '产卵',
tip = [[
    召唤蜘蛛
]],
--范围
area = 1000,
--数量
num = 20,
--持续时间
time = 60,
--冷却
cool = 10,
}
mt.effect = [[Doodads\Dungeon\Terrain\EggSack\EggSack0.mdl]]
mt.effect2 = [[Abilities\Weapons\GreenDragonMissile\GreenDragonMissile.mdl]]

function mt:boss_skill_shot()
    local hero = self.owner
    local skill = self
    -- local damage_data = skill:damage_data_cal()
    
    local function raining(point)

        local effect = ac.effect_ex
        {
            model = skill.effect,
            point = point,
            size = 1,
        }
        ac.effect_ex
        {
            model = skill.effect2,
            point = point,
            size = 1,
            rotate = {math.random(0,360),math.random(-10,10),math.random(-10,10)}
        }:remove()

        hero:wait(3*1000,function()
            local summon = hero:create_unit('黑蜘蛛',point,math.random(1,360))
            local index = ac.creep['刷怪'].index
            if not index or index == 0 then 
            	index = 1
            end	
            if index > 60 then 
                index = 60
            end    
            -- print('技能使用时 当前波数',index)
            local data = ac.table.UnitData['进攻怪-'..index] 
            
            if summon then
                summon:add_buff '召唤物' {
                    time = self.time,
                    attribute = data.attribute,
                    attr_mul = 4,
                    skill = self,
                }
                --设置搜敌路径
                summon:set_search_range(99999)
            end
            effect:remove()
        end)
    end

    for i = 1,skill.num do
        raining(hero:get_point()-{math.random(0,360) , math.random(0,skill.area) })
    end
end

function mt:on_add()
	--[[ local hero = self.owner
	local skill = self
	self.trg = hero:event '造成伤害效果' (function(_,damage)
		if ac.attack_skill_rate_cal({hero = hero,skill = skill,damage = damage}) == false then return end
			skill:boss_skill_shot(damage)
	end) ]]
end

function mt:on_cast_start()
    -- print('1212121212121212')
    self.eft = ac.warning_effect_ring
    {
        point = self.owner:get_point(),
        area = self.area,
        time = self.cast_channel_time,
    }
end

function mt:on_cast_shot()
    self:boss_skill_shot()
end

function mt:on_cast_stop()
    if self.eft then
        self.eft:remove()
    end
end