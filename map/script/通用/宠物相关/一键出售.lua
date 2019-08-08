local mt = ac.skill['一键出售']

mt{
	--必填
	is_skill = true,
	
	--初始等级
	level = 1,

	max_level = 5,
	auto_fresh_tip = false,
	tip = [[

|cffFFE799【使用说明】：|r
可以将宠物身上的物品|cff00ff00全部出售|r

]],
	
	--技能图标
	art = [[yijianchushou.blp]],
	
    ignore_cool_save = true, --忽略技能冷却

	--技能目标类型 无目标
	target_type = ac.skill.TARGET_TYPE_NONE,

	--施法范围
	area = 500,

	--cd
	cool = 1,

	--特效模型
	effect = [[AZ_Doomdragon_T.mdx]],
	-- effect = [[Hero_Juggernaut_N4S_F_Source.mdx]],
	
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
		local items = hero:get_slot_item(i)
		if items then 
			-- print(items.name,items.handle)
			if items.name ~= '勇士徽章' then 
				gold = gold + items:sell_price()
				items:item_remove()
			end	
		end
	end
	if gold > 0 then 
		hero:addGold(gold)
	end	


end

function mt:on_remove()

end
