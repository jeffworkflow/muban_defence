local mt = ac.skill['一键拾取']

mt{
	--必填
	is_skill = true,
	
	--初始等级
	level = 1,
	title = function(self)
		return '一键拾取'
	end,	
	max_level = 5,
	auto_fresh_tip = false,
	
	tip = [[
		
|cffFFE799【使用说明】：|r
一键|cff00ff00拾取|r周围 %area% 码的物品

]],
	
	--技能图标
	art = [[icon\jineng037.blp]],

    ignore_cool_save = true, --忽略技能冷却
	--技能目标类型 无目标
	target_type = ac.skill.TARGET_TYPE_NONE,

	--施法范围
	area = 350,

	--cd
	cool = 1,
	--自动合成
	auto_hecheng= function(self)
		local hero = self.owner
		local p = hero:get_owner()
		local str = p.flag_auto_hecheng and '|cff00ff00开|r' or '|cffff0000关|r'
		return str
	end,	
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
	local p = hero:get_owner()
	-- hero:add_effect('origin',self.effect)
	-- local target = self.target
	-- local point = target:get_point()
	
	local slot = hero:get_nil_slot()
	--满格
	if not slot then 
		p:sendMsg('物品栏已满',5)
		return 
	end	
	-- p.flag_auto_hecheng = true
    -- self.eff = ac.effect(point, self.effect, 270, 1,'origin')
	local i = 1
    --开始选择物品
    for _,v in sortpairs(ac.item.item_map) do 
        -- 没有所有者 ，视为在地图上
        -- 在地图上 被隐藏的，一般为默认切换背包时的装备 或者 为添加物品给英雄，没有添加成功
        if not v.owner  then 
			-- print(v.name,v._eff)
			if v._eff then 
				local slot = hero:get_nil_slot()
				--满格
				if not slot then 
					p:sendMsg('物品栏已满',5)
					return 
				end	
				local item_point = v:get_point()
				if item_point then 
					if item_point:is_in_range(hero,self.area) then 
						-- ac.wait(0,function()
						if v.name =='学习技能' then 
							ac.item.add_skill_item(v,hero)
						else 
							hero:add_item(v,true)
						end
						-- end)
						i=i+1
					end    
				end    
			end	
        end	
    end
	


end

function mt:on_remove()

end
