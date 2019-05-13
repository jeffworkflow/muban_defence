local mt = ac.skill['属性转换']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    max_level = 5,
	--技能类型
	skill_type = "主动",
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--介绍
    tip = [[
|cff11ccff%skill_type%:|r 力量和敏捷互相转换，转化3%/秒的属性点。点击可切换

被动:增加生命上限 %value1% %

|cff00bdec%tip2%|r
]],
	--技能图标
	art =  [[sxzh1.blp]],
	--技能图标
	art1 = [[sxzh3]],
	--技能图标
	art2 = [[sxzh2]],
	--每秒
    pulse = 1,
    --值
    value = 3,

    value1={10,20,30,40,50},

    --当前状态 1停止（刚开始图标）   2力量转敏捷(图标为力量转敏捷) 3敏捷转力量(图标为敏捷转力量)
    current_status = 1,
    tip2 = function(self,hero)
        if self and self.owner and self.owner:is_hero() then 
            return self.owner.tran_tip 
        end    
    end,
}


mt.value1_now = 0

function mt:on_upgrade()
	local hero = self.owner
	-- print(self.life_rate_now)
	hero:add('生命上限%', -self.value1_now)
	self.value1_now = self.value1
	hero:add('生命上限%', self.value1)
end

function mt:on_add()
    local skill = self
    local hero = self.owner
    self.origin_tip = self.tip
    self.mark = {}
end

function mt:on_cast_shot()
	local skill = self
    local hero = self.owner
    local buf = hero:find_buff '属性转换'
    if buf then 
        if buf.conver_target == '力量' then
            -- print('设置转化目标为敏捷')
            self.mark['敏捷'] = skill:add_blend(self.art1, 'frame', 3)
            -- print(self:get_art())
            -- print(skill:get_art())
            -- self:set_art(self.art2)
            hero.tran_tip = '当前：力量转敏捷 '
            hero:add_buff '属性转换'
            {
                skill = skill,
                model = skill.effect,
                value = skill.value,
                main_attr_value = math.ceil(hero:get('力量') * skill.value /100),
                pulse = skill.pulse,
                conver_target = '敏捷'
            }

        else 
            --清空混合图标
            for key,value in sortpairs(self.mark) do 
                value:remove()
            end
            -- self:set_art(self.art)
            -- print()
            hero.tran_tip = '无'
            if buf.conver_target == '敏捷' then
                buf:remove()
            end
        end    
    else
        self.mark['力量'] = skill:add_blend(self.art2, 'frame', 2)
        -- print(skill:get_art())

        hero.tran_tip = '当前：敏捷转力量'
        hero:add_buff '属性转换'
        {
            skill = skill,
            model = skill.effect,
            value = skill.value,
            main_attr_value = math.ceil(hero:get('敏捷') * skill.value /100),
            pulse = skill.pulse,
            conver_target = '力量'
        }
    end    


end

function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
    local buf = hero:find_buff '属性转换'
    if buf then 
        buf:remove()
    end    
    hero:add('生命上限%', -self.value1)
end


local mt = ac.buff['属性转换']
mt.ref = 'origin' 
mt.cover_type = 0
mt.cover_max = 1
mt.keep = true
-- mt.cover_global = 1

function mt:on_add()
	local hero =self.target;
	-- self.eff = hero:add_effect(self.ref,self.model)

end

function mt:on_pulse()
    local hero = self.target
    -- print(self.conver_target,self.main_attr_value)

    if self.conver_target =='力量' then
        if hero:get('敏捷') > self.main_attr_value  then 
            hero:add('力量',self.main_attr_value ) 
            hero:add('敏捷',-self.main_attr_value ) 
        
        end    
    end    

    if self.conver_target =='敏捷' then
        if hero:get('力量') > self.main_attr_value  then 
            hero:add('敏捷',self.main_attr_value ) 
            hero:add('力量',-self.main_attr_value ) 
        end    
    end    


end
function mt:on_remove()
	if self.eff then self.eff:remove() self.eff =nil end 
	if self.trg then self.trg:remove() self.trg =nil end 

	local hero =self.target;
	-- hero:add('物品获取率',- self.value * (1+hero:get('主动释放的增益效果')/100))
	
end
function mt:on_cover(new)
	return true
end