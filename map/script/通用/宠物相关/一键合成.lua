local mt = ac.skill['一键合成']

mt{
	--目标类型 = 单位
	target_type = ac.skill.TARGET_TYPE_POINT,
	level = 1,
	title = function(self)
		return '一键合成'
	end,	
	max_level = 5,
	tip = [[

|cffFFE799【使用说明】：|r
|cff00ff00对指定范围的内物品，进行|cff00ffff自动合成

]],

	ignore_cool_save = true, --忽略技能冷却
	--技能图标
	art = [[yijianhecheng.blp]],
	--施法范围
	area = 400,
	--cd
	cool = 1,
	--施法距离
	range = 1000,
}


function mt:on_add()
	local hero = self.owner 
end	

function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
	local p = hero:get_owner()
	
	local selected_item = {}
    for _,v in sortpairs(ac.item.item_map) do 
        -- 没有所有者 ，视为在地图上
        -- 在地图上 被隐藏的，一般为默认切换背包时的装备 或者 为添加物品给英雄，没有添加成功
        if not v.owner  then 
			-- print(v.name,v._eff)
			if v._eff then 
				local item_point = v:get_point()
				if item_point then 
					if item_point:is_in_range(self.target ,self.area) then 
						if finds(v.item_type,'装备','消耗品') and v.color and finds(v.color,'白','蓝','金')  then 
							table.insert(selected_item,v)
						end	
					end
				end
			end
		end
	end		
	local hecheng = {
		['白'] ={},
		['蓝'] ={},
		['金'] ={},
		['红'] ={},
	}	
	local hecheng1 = {'白','蓝','金','红'}
	local function get_next_color(color)
		local res
		for i,name in ipairs(hecheng1) do 
			if name == color then 
				res = hecheng1[i+1]
				break
			end
		end
		return res	
	end	
	--进行合成，
	-- selected_item 白，蓝，金，红
	for i=1,#selected_item+#selected_item do 
		local item = selected_item[i]
		if item and item.color then 
			table.insert(hecheng[item.color],i)
			-- hecheng[item.color] = (hecheng[item.color] or 0 +1)
			if #hecheng[item.color] == 4 then 
				--删物品
				for i,index in ipairs(hecheng[item.color]) do 
					--优先处理消耗品
					if selected_item[index]._count > 1 then 
						local new_item = ac.item.create_item(selected_item[index].name,self.target) --创建物品
						new_item:set_item_count(selected_item[index]._count-1)
						table.insert(selected_item,new_item)
					end	
					selected_item[index]:item_remove()
					selected_item[index] = nil
				end	
				--清空表
				hecheng[item.color] = {}

				--增加新物品
				local next_color = get_next_color(item.color)
				local list = ac.quality_item[next_color] 
				if not list then 
					return 
				end 
				local name = list[math.random(#list)]
				local new_item = ac.item.create_item(name,self.target) --创建物品
				table.insert(selected_item,new_item)


			end	
		end	
	end	

		



end

function mt:on_remove()

end
