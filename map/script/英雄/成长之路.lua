
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
mt.skills = {'魔鬼的交易','神兵利器','护天神甲','套装洗练','境界突破','彩蛋','扭蛋'}

local mt = ac.skill['彩蛋']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[czzl.blp]],
    title = '彩蛋',
    tip = [[

点击查看 |cff00ff00彩蛋|r
    ]],
}
mt.skills = {}

local mt = ac.skill['扭蛋']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[czzl.blp]],
    title = '扭蛋',
    tip = [[

点击查看 |cff00ff00扭蛋|r
    ]],
}
mt.skills = {}

ac.game:event '玩家-注册英雄' (function(_, player, hero)
	--移动英雄天赋位置	
	hero:add_skill('成长之路','英雄',11)
	-- hero:add_skill('魔法书demo','英雄')
	--开始处理神兵神甲额外文本提示
	for k,val in pairs(ac.magic_item) do
		for _,name in ipairs(val) do
			-- print(name)
			local skl = hero:find_skill(name,nil,true)
            skl:set('extr_tip','\n|cffFFE799【状态】：|r|cffff0000未激活|r')
		end	
	end	
	
	for k,val in ipairs(ac.devil_deal) do
		for _,data in ipairs(val) do
			local name = data[1]
			local skl = hero:find_skill(name,nil,true)
            skl:set('extr_tip','\n|cffFFE799【状态】：|r|cffff0000未激活|r')
			skl:set('tip','%extr_tip% \n'..data[3]..'+'..data[4]..'%')
			-- print(skl.tip,skl.data.tip)
			skl:fresh_tip()
		end	
	end	
end)