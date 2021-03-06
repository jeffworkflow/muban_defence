local mt = ac.skill['强化后的红莲爆']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 5,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--技能类型
	skill_type = "被动,暴击",
	--被动
	passive = true,
    title = "|cffdf19d0强化后的红莲爆|r",
	--冷却时间
	cool = 1,
	ignore_cool_save = true,
	--介绍
    tip = [[
        
|cff00bdec【被动效果】攻击10%几率触发，接下来的7次普攻必定暴击|r
    
]],
	--技能图标
	art = [[qhhlb.blp]],
    value = 7,
	--特效
	effect = [[1]],
}
function mt:on_add()
    local skill = self
    local hero = self.owner

    self.trg = hero:event '造成伤害效果' (function(_,damage)
		if not damage:is_common_attack()  then 
			return 
		end 
		--技能是否正在CD
        if skill:is_cooling() then
			return 
		end
        --触发时修改攻击方式
        if math.random(100) <= self.chance then
            self.buff = hero:add_buff('红莲爆')
            {
                value = self.value,
                source = hero,
                skill = self,
                effect = self.effect,
            }
            --激活cd
            skill:active_cd()
        end

    end)
end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
    if self.buff then
        self.buff:remove()
        self.buff = nil
    end
end

local mt = ac.buff['红莲爆']
mt.cover_type = 0
mt.cover_max = 1
-- mt.keep = true

function mt:on_add()
    local target = self.target
    local hero = self.target
    self.eff = target:add_effect('origin',self.effect)
    -- print('注册受伤害事件')
    self.trg = hero:event '造成伤害前效果' (function(trg, damage)
        -- print(self.value)
        if self.value>0 then 
            if not hero.hlb_flg then 
                hero:add('暴击几率',100)
                hero.hlb_flg = true 
            end    
            self.value = self.value -1
        else
            self:remove()
        end    
    end)    

end

function mt:on_remove()
    local target = self.target
    -- print('移除红莲爆',target:get('暴击几率'))
    target:add('暴击几率',-100)   
    target.hlb_flg = false 
    if self.eff then self.eff:remove() self.eff = nil   end
    if self.trg then self.trg:remove() self.trg = nil end
end
function mt:on_cover(new)
	if new.value > self.value then
		self.value = new.value
	end
	return false
end

