local jass = require 'jass.common'
local heror = require 'types.hero'
local unit = require 'types.unit'

--1-12为12个技能模板，如玩家1是AA01-AA12，玩家2是AB01-AB12
--排序
--[[
	9 10 11 12
	5 6 7 8
	1 2 3 4
	
	A S X C
	Z D F G
	Q W E R
]]

--13是拾取技能,AA13 AB13...

local id_name = {'A','B','C','D','E','F','G','H','I','J','K','L'}
for i = 1, 12 do
	local p = ac.player[i]
	p.ability_list = {}
	p.ability_list['英雄'] = {}
	p.ability_list['隐藏'] = {}
	p.ability_list['拾取'] = {}
	p.ability_list['魔法书'] = {size = 12}

	local n = 0

	for t=1,12 do
		local id = 'A'..id_name[i]
		if t < 10 then
			id = id .. '0'..t
		else
			id = id ..t
		end
		p.ability_list['英雄'][t] = id
	end
	p.ability_list['拾取'][1] = 'A'..id_name[i]..'13'

	for x = 1, p.ability_list['魔法书'].size do
		p.ability_list['魔法书'][x] = ('AM%X%X'):format(i - 1, x - 1)
	end
end
--玩家16 技能预览图
local i =16
if i == 16 then
	local p = ac.player[i]
	p.ability_list = {}
	p.ability_list['预览'] = {size = 4}
	for x = 1, p.ability_list['预览'].size do
		p.ability_list['预览'][x] = ('Q20%d'):format(x)
	end
	
end

local function hero_register_main()
	--注册英雄
	ac.game:event '玩家-注册英雄' (function(_, player, hero)
		print('注册英雄3')
		-- SelectUnitForPlayerSingle(hero.handle,player.handle)
		-- 统一设置搜敌范围
		hero:set_search_range(1000)
		--添加技能
		print('注册英雄4')
		hero:add_all_hero_skills()

		print('注册英雄5')
		hero:add_skill('拾取','拾取',1)
		hero:add_skill('攻击','英雄',9)
		hero:add_skill('停止','英雄',10)
		-- hero:add_skill('保持原位','英雄',11)
		
		
		-- hero:add_skill('死亡飞镖','英雄')
		-- hero:add_skill('妙手空空','英雄')
		-- hero:add_skill('摔破罐子','英雄')
		
		
		-- hero:add('物品获取率',50)
    	-- ac.item.add_skill_item('巨浪',hero)
    
		--  hero:add_item('食尸王之剑')
		--hero:add_item('食尸王之剑')
		
		-- hero:add_item('新人寻宝石') 
		-- hero:add_item('生命药水') 
		print('注册英雄6')
		hero:add_item('新手礼包') 
		
		-- hero:add_item('勇气之证')

		-- hero:add_item('账簿')
		-- hero:add_item('故事书')
		-- hero:add_item('故事集')
		-- hero:add_item('故事集')
		-- hero:add_item('故事集')
		-- hero:add_item('故事集')

		-- hero:add_skill('魔法书', '英雄')
		-- hero:add_skill('魔法书', '英雄')
		--武器
		-- hero:add_effect('hand',[[Abilities\Weapons\PhoenixMissile\Phoenix_Missile.mdl]])
		-- hero:add_effect('hand',[[wuqi123.mdx]])
		
		print('注册英雄7')
		--添加英雄属性面板
		hero:add_skill('英雄属性面板', '英雄',12)
		-- 测试魔法书
		-- hero:add_skill('魔法书demo','英雄')
		
		print('注册英雄8')
		--创建一个宠物
		player:create_pets()
	end)

end

hero_register_main()



ac.game:event '玩家-选择单位后' (function(self, player, hero)
	-- print(hero,2)
	if hero:get_owner() ~= player then 
		return 
	end 
	player.selected = hero 
	for skill in hero:each_skill '英雄' do 
		skill:fresh()
	end 
end)