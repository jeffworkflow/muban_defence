local mt = ac.skill['自动合成']

mt{
	--必填
	is_skill = true,
	
	--初始等级
	level = 1,
	title = function(self)
		return '自动合成：'..self.auto_hecheng..')'
	end,	
	max_level = 5,
	auto_fresh_tip = false,
	
	tip = [[
自动合成： %auto_hecheng%	
|cffFFE799【使用说明】：|r
可使一键拾取时，自动合成物品。
（有红装不会自动合）
]],
	--技能图标
	art = [[icon\jineng037.blp]],
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
