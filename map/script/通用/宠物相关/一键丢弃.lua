local mt = ac.skill['一键丢弃']

mt{
	--必填
	is_skill = true,
	
	--初始等级
	level = 1,

	max_level = 5,
	auto_fresh_tip = false,
	tip = [[

|cffFFE799【使用说明】：|r
可以将宠物身上的物品|cff00ff00全部丢弃|r

]],
	
	--技能图标
	art = [[drop.blp]],
	
    ignore_cool_save = true, --忽略技能冷却

	--技能目标类型 无目标
	target_type = ac.skill.TARGET_TYPE_NONE,

	--施法范围
	area = 500,

	--cd
	cool = 1,

	
	--施法距离
	range = 99999,
}


function mt:on_add()
	local hero = self.owner 
end	

function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
	local gold = 0 
	for i=1,6 do
		local it = hero:get_slot_item(i)
		if it then 
			-- print(it.name,it.handle)
			if it.name ~= '勇士徽章' then 
				hero:remove_item(it)
			end	
		end
	end


end

function mt:on_remove()

end
