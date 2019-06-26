
local player = require 'ac.player'
local fogmodifier = require 'types.fogmodifier'
local sync = require 'types.sync'
local jass = require 'jass.common'
local hero = require 'types.hero'
local item = require 'types.item'
local affix = require 'types.affix'
local japi = require 'jass.japi'
local japi = require 'jass.japi'
local rect = require 'types.rect'
local dbg = require 'jass.debug'

--创建全图视野
local function icu()
	fogmodifier.create(ac.player(1), ac.map_area)
end
icu()

ac.test_unit ={}
--输入 over 游戏结束
ac.game:event '玩家-聊天' (function(self, player, str)
    local hero = player.hero
	local p = player
	local peon = player.peon
	-- if not peon or not hero then return end 
	
    if str == 'qlwp' then
		--开始清理物品
		local tbl = {}
		for _,v in pairs(ac.item.item_map) do

			if not v.owner  then 
				table.insert(tbl,v)
			end	
		end

		table.sort(tbl,function (a,b)
			local p = ac.point(0,0)
			return a:get_point() * p <  b:get_point() * p
		end)

		for index,item in ipairs(tbl) do 
			item:item_remove()
		end 
	end  

	if str == 'qx' then
		if not peon or not hero then return end 
		--取消特效
		if hero.effect_chibang then 
			hero.effect_chibang:remove()
		end	
		if hero.effect_wuqi then 
			hero.effect_wuqi:remove()
		end
		if hero.effect_chenghao then 
			hero.effect_chenghao:remove()
		end
		local old_model = peon:get_slk 'file'
		if not getextension(old_model) then 
			old_model = old_model..'.mdl'
		end	
		japi.SetUnitModel(peon.handle,old_model)
	end  
	if str == 'jixu' then
		player.flag_get_map_test = true 
	end  
	-- if str =='1' then 
	-- 	for i=1,500 do
	-- 		local u = ac.player(16):create_unit('金币怪',ac.point(100,200))
	-- 		u:set('生命上限',20000000)
	-- 		u:set('移动速度',300)
	-- 		ac.test_unit[u] = true
	-- 	end
	-- end	

    -- if str == '2' then
	-- 	for u in pairs(ac.test_unit) do
	-- 		print(u.handle,u,math.random(100000))
	-- 		-- u:remove()
	-- 		-- ac.test_unit[u] = false
	-- 	end	
	-- end	

    -- if str == '3' then
	-- 	for i=1,500 do
	-- 		local k = {id = i }
	-- 		dbg.gchash(k,i)
	-- 		ac.test_unit[k] = i 
	-- 	end	
	-- end
    -- if str == '4' then
	-- 	for k,v in pairs(ac.test_unit) do
	-- 		print(k.id)
	-- 	end	
	-- end		
end)	
