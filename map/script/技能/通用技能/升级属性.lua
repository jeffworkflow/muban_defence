
ac.game:event '技能-升级' (function (_,hero,self)
    -- print(hero,self.name) 创建物品时，会添加到马甲单位初始化技能，此时由old_status,并赋值给你item，item再初始化时就又有了数据。
    -- --item_type 有值表示为物品，以下代码不生效 or not hero:is_type('英雄') 
    --如果技能在宠物身上，加强效果在人身上
    if self.strong_hero then 
        hero = hero:get_owner().hero
    end    
    -- print(hero.name,self.item_type,self.item_type)
	if not hero or self.item_type =='消耗品' then 
		return
	end	
	--保存物品 ix_now =0 1级+10， ix=10,ix_now=10,ix=20
    local name = self.name
    if self.level == 1 then 
        self.old_status =  self.old_status or {} 
        --self.old_status or
    end
    -- print_r(self.old_status)
    -- print('老值:',self.old_status)
    -- self.old_status = self.old_status or {}
	--单位的属性表
	local data = ac.unit.attribute
    for key in sortpairs(data) do 
        --处理基础值
        local value = self[key]
        local old_value = self.old_status[key]
        if old_value then 
            hero:add_tran(key,-old_value)
		end 
		if value then 
            hero:add_tran(key,value)
        end 
        self.old_status[key] = value
        --处理%值
		key = key..'%'
		value = self[key]
        old_value = self.old_status[key]
		if old_value then 
            hero:add_tran(key,-old_value)
		end 
		if value then 
            hero:add_tran(key,value)
        end 
        self.old_status[key] = value

        -- self:set('old_status',self.old_status)
	end
end)

--神符类的技能获取时会自动失去，所以要排除在外，属性才能加上
ac.game:event '技能-失去' (function (_,hero,self)
    -- print(hero,self.name) or not hero:is_type('英雄')
    --如果技能在宠物身上，加强效果在人身上
    if self.strong_hero then 
        hero = hero:get_owner().hero
    end    
    if self.old_status then self.old_status = nil end
	if not hero  or self.item_type =='消耗品' or self.item_type =='神符'    then 
		return
    end	
	--单位的属性表
	local data = ac.unit.attribute
    for key in sortpairs(data) do 
        --处理基础值
        local value = self[key]
		if value then 
            hero:add_tran(key,-value)
        end 

        --处理%值
		key = key..'%'
		value = self[key]
		if value then 
            hero:add_tran(key,-value)
        end 
	end
end)    

-- local mt = ac.skill['bj']
-- mt{
-- 	--必填
-- 	is_skill = true,
-- 	--技能类型
-- 	skill_type = "被动",
-- 	--是否被动
-- 	passive = true,
-- 	--初始等级
-- 	level = 1,
-- 	max_level = 5,
-- 	tip = [[
-- 		|cff00ccff被动|r:
-- 		暴击几率+%暴击几率% % ，暴击加深+%physical_damage% % 
-- 		会心几率+%physical_rate% % ，会心伤害+%physical_damage% %
-- 		技暴几率+%physical_rate% % ，技暴加深+%physical_damage% %]],
-- 	--技能图标
-- 	art = [[ReplaceableTextures\PassiveButtons\PASBTNCriticalStrike.blp]],
-- 	['暴击几率'] = {2,4,6,8,10},
-- }


