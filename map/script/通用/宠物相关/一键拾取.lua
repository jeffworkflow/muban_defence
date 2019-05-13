local mt = ac.skill['一键拾取']

mt{
	--必填
	is_skill = true,
	
	--初始等级
	level = 1,

	max_level = 5,
	
	tip = [[
一键拾取周边物品，范围 %area%
	]],
	
	--技能图标
	art = [[icon\jineng037.blp]],

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
	-- hero:add_effect('origin',self.effect)
	-- local target = self.target
	-- local point = target:get_point()

    -- self.eff = ac.effect(point, self.effect, 270, 1,'origin')

    --开始选择物品
    for _,v in sortpairs(ac.item.item_map) do 
        -- 没有所有者 ，视为在地图上
        -- 在地图上 被隐藏的，一般为默认切换背包时的装备 或者 为添加物品给英雄，没有添加成功
        if not v.owner  then 
            -- print(v.name,v._eff)
            local item_unit = v._eff.unit
            if item_unit then 
                if item_unit:is_in_range(hero,self.area) then 
                    if v.name =='学习技能' then 
                        ac.item.add_skill_item(v,hero)
                    else 
                        hero:add_item(v,true)
                    end
                end    
            end    
        end	
    end
	


end

function mt:on_remove()

end
