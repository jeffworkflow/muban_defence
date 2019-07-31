local mt = ac.skill['自动合成']

mt{
	--必填
	is_skill = true,
	
	--初始等级
	level = 1,
	title = function(self)
		return '自动合成开关'
	end,	
	max_level = 5,
	auto_fresh_tip = false,
	
	tip = [[
|cffcccccc（当前状态： %auto_hecheng%）

|cffFFE799【使用说明】：|r
|cff00ff00打开后，使用一键拾取，拾取周围物品时，能自动合成高品质物品|cffffff00（红装不会被合成）

]],
	--技能图标
	art = [[kaiguan.blp]],
	
    ignore_cool_save = true, --忽略技能冷却
	--cd
	cool = 1,
	--自动合成
	auto_hecheng= function(self)
		local hero = self.owner
		local p = hero:get_owner()
		local str = p.flag_auto_hecheng and '|cff00ff00开|r' or '|cffff0000关|r'
		return str
	end,	
}


function mt:on_add()
	local hero = self.owner 
end	

function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
	local p = hero:get_owner()
	-- print('标识1：',p.flag_auto_hecheng)
	p.flag_auto_hecheng = not p.flag_auto_hecheng  and true or false
	-- print('标识2：',p.flag_auto_hecheng)
	self:fresh_title()
	self:fresh_tip()

	local skl = hero:find_skill('一键拾取',nil,true)
	skl:fresh_title()
	skl:fresh_tip()

end

function mt:on_remove()

end
