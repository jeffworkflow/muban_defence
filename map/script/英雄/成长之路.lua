
--魔法书
local mt = ac.skill['成长之路']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[czzl.blp]],
    title = '成长之路',
    tip = [[

点击查看 |cff00ff00成长之路|r
    ]],
}
mt.skills = {'魔鬼的交易','神兵利器','护天神甲','套装洗练','境界突破'}

ac.game:event '玩家-注册英雄' (function(_, player, hero)
	--移动英雄天赋位置	
	hero:add_skill('成长之路','英雄',11)
	-- hero:add_skill('魔法书demo','英雄')

	--开始处理神兵神甲额外文本提示
	for k,val in pairs(ac.magic_item) do
		for _,name in ipairs(val) do
			-- print(name)
			local skl = hero:find_skill(name,nil,true)
			skl:set('extr_tip','|cff未激活')
		end	
	end	

end)