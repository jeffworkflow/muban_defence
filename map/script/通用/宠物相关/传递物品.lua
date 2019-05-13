local mt = ac.skill['传递物品']

mt{
    --必填
    is_skill = true,
    
    --等级
    level = 1,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_UNIT,

    --目标允许
    target_data = '物品',

	tip = [[
传递物品给英雄
	]],
	
	--技能图标
	art = [[icon\jineng038.blp]],

	--cd
	cool = 1,
	
	--施法距离
	range = 99999,
}


function mt:on_add()
	local hero = self.owner 
end	

function mt:on_cast_start()
    local unit = self.owner
	local it = self.target
	local player = unit:get_owner()
	local hero = player.hero
	-- print(it)
    -- hero:event_notify('单位-拾取物品',hero,it)
	-- 点太快 重复触发两次拾取。
	if it.owner then 
		unit:remove_item(it)
	end	
	-- print()
	-- print(it.owner)
	-- local item = ac.item.create_item('新手剑',ac.point(0,0))
	if hero:is_alive() then 
		hero:add_item(it,true)
	else
		it:setPoint(hero:get_point())
	end	
   
end

function mt:on_remove()

end
