
--魔法书
local mt = ac.skill['成长之路']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[sc.blp]],
    title = '成长之路',
    tip = [[
查看成长之路
    ]],
}
mt.skills = {'魔鬼的交易','神兵利器','护天护甲','境界突破','套装洗练'}

ac.game:event '玩家-注册英雄' (function(_, player, hero)
	--移动英雄天赋位置	
	hero:add_skill('成长之路','英雄',11)
	-- hero:add_skill('魔法书demo','英雄')
	
end)