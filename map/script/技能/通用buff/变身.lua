--暂时不可用
local mt = ac.buff['变身']

mt.keep = true

function mt:on_add()
    if not self.unit_id then
        return
    end 
    --支持 即将变身的单位名
    local name = tostring(self.unit_id)
    local data = ac.table.UnitData[name]
    if data and data.id then 
        self.unit_id = data.id
    end    

	local hero = self.target
	--特效
	hero:get_point():add_effect([[modeldekan\ability\dekan_goku_r_effect_add.mdl]]):remove()
	self.origin_id = hero:get_type_id() 
    self.origin_size = hero:get_size()  
	self.origin_weapon = hero.weapon
	self.origin_missile_art = hero.missile_art
	--变身
	hero:transform(self.unit_id)

    if not hero.weapon then 
        hero.weapon = {}
    end   

	--恢复远程攻击
	local data = ac.table.UnitData[target_id]
	if data and  data.weapon then 
		hero.weapon = data.weapon
    end	
    
    if data and data.missile_art then 
        hero.missile_art = data.missile_art
    end
    
	--设置大小
	if self.size then
		hero:set_size(self.size)
    end

	--调整属性
	if self.attribute then
		for k, v in sortpairs(self.attribute) do
			hero:add(k, v)
		end
    end


end

function mt:on_remove()
    
	local hero = self.target
	--特效x
	hero:get_point():add_effect([[modeldekan\ability\dekan_goku_r_effect_remove.mdl]]):remove()
	--变回去
    hero:transform(self.origin_id)
	hero:set_size(self.origin_size)
    hero.weapon = self.origin_weapon
    hero.missile_art = self.origin_missile_art
	
	--调整属性
	if self.attribute then
		for k, v in sortpairs(self.attribute) do
			hero:add(k, -v)
		end
    end
    
end