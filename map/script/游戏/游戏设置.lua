--游戏全局设置
--ac.rect.map 全图 rect.create(-4000,-4000,4000,4000) or
local rect = require("types.rect")
local region = require("types.region")
local slk = require 'jass.slk'
local effect = require 'types.effect'
local jass = require 'jass.common'
local player = require 'ac.player'
local Unit = require 'types.unit'
local fogmodifier = require 'types.fogmodifier'

--游戏时长 
ac.g_game_time = 0 

local ti = ac.loop(1000,function(t)
    --modify by jeff 
    ac.g_game_time = ac.g_game_time + 1
    local str = os.date("!%H:%M:%S",  ac.g_game_time)
    -- ranking.ui.date:set_text('游戏时长:'..str)
    ac.game.multiboard:set_time(str) --多面板显示
	-- ac.game.multiboard:set_title()
	local end_time = 60*60*7.5
	-- local end_time = 30-- 测试
    if ac.g_game_time == end_time  then
        ac.game:event_notify('游戏-结束')
        t:remove()
    end

end)


ac.game:event '玩家-金币变化' (function(_,data) 
	local gold = data.gold
	local player = data.player
	--大于100W 转为 100 木头
	local target_gold = 1000000
	if player.gold >=target_gold then
		player:addGold(-target_gold) 
		player:add_wood(100)
	end	
end)

--火灵相关
player.__index.fire_seed = 0
function player.__index:get_fire_seed()
	return (self.fire_seed or 0) 
end	
--获得火灵
--	火灵数量
--	[漂浮文字显示位置]
--	[不抛出加木头事件]
function player.__index:add_fire_seed(fire_seed, where, flag)
	if not fire_seed or tonumber(fire_seed) == 0  then 
		return 
	end	
	local fire_seed = tonumber(string.format( "%.2f",fire_seed))
	local data = {player = self, fire_seed = fire_seed}
	if fire_seed > 0 and not flag then
		self:event_notify('玩家-即将获得火灵', data)
		fire_seed = data.fire_seed
	end
	local fire_seed = tonumber(string.format( "%.2f",fire_seed))
	self.fire_seed = (self.fire_seed or 0) + fire_seed
	-- self.fire_seed = jass.I2R(self.fire_seed)
	if self.fire_seed < 0 then 
		self.fire_seed = 0
	end	
	self:event_notify('玩家-火灵变化', data)

	if not where  then
		return
	end
	if not where:is_visible(self) then
		where = self.hero
		if not where then
			return
		end
	end
	local x, y = where:get_point():get()
	local z = where:get_point():getZ()
	local position = ac.point(x - 30, y, z + 30)
	--modify by jeff 金币小于0 也显示文字出来
	local str = nil
	if fire_seed < 0 then 
		 str =  fire_seed
	else
		 str = '+' .. fire_seed
	end	
	ac.texttag
	{
		string = str,
		size = 12,
		position = position,
		speed = 86,
		red = 223,
		green = 25,
		blue = 208,
		player = self,
		show = ac.texttag.SHOW_SELF
	}
end
--单位获得火灵
function Unit.__index:add_fire_seed(num)
	self:get_owner():add_fire_seed(num, where or self, flag)
end
local function findunit_byname(name)
	local unit
	for key,val in pairs(ac.unit.all_units) do 
		if val:get_name() == name then 
			unit = val
			break
		end
	end	
	return unit
end	
ac.game.findunit_byname = findunit_byname


--禁止A队友
ac.game:event '单位-攻击开始' (function(self, data)
	if data.target:is_ally(data.source) then
		if data.target:get_name() ~= '游戏说明' then 
			data.source:issue_order 'stop'
			return true		--终结事件流程
		end	
	end
end)
--游戏说明 被玩家12攻击则无敌5秒
ac.game:event '游戏-开始' (function()
	local unit = ac.game.findunit_byname('游戏说明')
	unit:event '受到伤害效果'(function(_,damage)
		if damage.source:get_owner().id >=11 then 
			damage.target:add_buff '无敌'{
				time = 5
			}
		end	
	end)
end)

ac.map = {}
ac.map_area =  ac.rect.map --全图
ac.map.rects={
    ['刷怪1'] = rect.j_rect('cg1') ,
    ['刷怪2'] = rect.j_rect('cg2') ,
    ['刷怪3'] = rect.j_rect('cg3') ,
	['进攻点'] = rect.j_rect('jg1') ,
	['主城'] = rect.j_rect('jg2_jd') ,
	['游戏结束'] = rect.j_rect('jg2_jd') ,
	
    ['刷怪-boss'] = rect.j_rect('cgboss4') ,
	['选人区域'] =rect.j_rect('xuanren') ,
	['武林大会'] =rect.j_rect('wldh') ,

	['npc1'] =rect.j_rect('npc1') ,
	['npc2'] =rect.j_rect('npc2') ,
	['npc3'] =rect.j_rect('npc3') ,
	['npc4'] =rect.j_rect('npc4') ,
	['npc5'] =rect.j_rect('npc5') ,
	['npc6'] =rect.j_rect('npc6') ,
	['npc7'] =rect.j_rect('npc7') ,
	['npc8'] =rect.j_rect('npc8') ,
	['npc9'] =rect.j_rect('npc9') ,
    ['选人出生点'] =rect.j_rect('xrcs') ,
	['出生点'] =rect.j_rect('F2cs') ,

	--野怪
	['杀鸡儆猴1'] =rect.j_rect('sjjh1') ,
	['杀鸡儆猴2'] =rect.j_rect('sjjh2') ,
	['杀鸡儆猴3'] =rect.j_rect('sjjh3') ,
	

	--练功房 
	['练功房11'] =rect.j_rect('lgf11') ,
	['练功房12'] =rect.j_rect('lgf12') ,
	['练功房13'] =rect.j_rect('lgf13') ,
	['练功房14'] =rect.j_rect('lgf14') ,
	-- ['练功房刷怪1'] =rect.j_rect('lgfsg1') ,
	['练功房刷怪1'] =rect.j_rect('lgfbh1') ,

	['练功房21'] =rect.j_rect('lgf21') ,
	['练功房22'] =rect.j_rect('lgf22') ,
	['练功房23'] =rect.j_rect('lgf23') ,
	['练功房24'] =rect.j_rect('lgf24') ,
	['练功房刷怪2'] =rect.j_rect('lgfbh2') ,

	['练功房31'] =rect.j_rect('lgf31') ,
	['练功房32'] =rect.j_rect('lgf32') ,
	['练功房33'] =rect.j_rect('lgf33') ,
	['练功房34'] =rect.j_rect('lgf34') ,
	['练功房刷怪3'] =rect.j_rect('lgfbh3') ,

	['练功房41'] =rect.j_rect('lgf41') ,
	['练功房42'] =rect.j_rect('lgf42') ,
	['练功房43'] =rect.j_rect('lgf43') ,
	['练功房44'] =rect.j_rect('lgf44') ,
	['练功房刷怪4'] =rect.j_rect('lgfbh4') ,

	['练功房51'] =rect.j_rect('lgf51') ,
	['练功房52'] =rect.j_rect('lgf52') ,
	['练功房53'] =rect.j_rect('lgf53') ,
	['练功房54'] =rect.j_rect('lgf54') ,
	['练功房刷怪5'] =rect.j_rect('lgfbh5') ,

	['练功房61'] =rect.j_rect('lgf61') ,
	['练功房62'] =rect.j_rect('lgf62') ,
	['练功房63'] =rect.j_rect('lgf63') ,
	['练功房64'] =rect.j_rect('lgf64') ,
	['练功房刷怪6'] =rect.j_rect('lgfbh6') ,
	
	--武器
	['传送-武器1'] =rect.j_rect('wuqi1') ,
	['传送-武器2'] =rect.j_rect('wuqi2') ,
	['传送-武器3'] =rect.j_rect('wuqi3') ,
	['传送-武器4'] =rect.j_rect('wuqi4') ,
	['传送-武器5'] =rect.j_rect('wuqi5') ,
	['传送-武器6'] =rect.j_rect('wuqi6') ,
	['传送-武器7'] =rect.j_rect('wuqi7') ,
	['传送-武器8'] =rect.j_rect('wuqi8') ,
	['传送-武器9'] =rect.j_rect('wuqi9') ,
	['传送-武器10'] =rect.j_rect('wuqi10') ,
	['传送-武器11'] =rect.j_rect('wuqi111') ,
	
	['boss-武器1'] =rect.j_rect('wuqi11') ,
	['boss-武器2'] =rect.j_rect('wuqi22') ,
	['boss-武器3'] =rect.j_rect('wuqi33') ,
	['boss-武器4'] =rect.j_rect('wuqi44') ,
	['boss-武器5'] =rect.j_rect('wuqi55') ,
	['boss-武器6'] =rect.j_rect('wuqi66') ,
	['boss-武器7'] =rect.j_rect('wuqi77') ,
	['boss-武器8'] =rect.j_rect('wuqi88') ,
	['boss-武器9'] =rect.j_rect('wuqi99') ,
	['boss-武器10'] =rect.j_rect('wuqi1010') ,
	['boss-武器11'] =rect.j_rect('wuqi1111') ,
	
	--甲
	['传送-甲1'] =rect.j_rect('jia1') ,
	['传送-甲2'] =rect.j_rect('jia2') ,
	['传送-甲3'] =rect.j_rect('jia3') ,
	['传送-甲4'] =rect.j_rect('jia4') ,
	['传送-甲5'] =rect.j_rect('jia5') ,
	['传送-甲6'] =rect.j_rect('jia6') ,
	['传送-甲7'] =rect.j_rect('jia7') ,
	['传送-甲8'] =rect.j_rect('jia8') ,
	['传送-甲9'] =rect.j_rect('jia9') ,
	['传送-甲10'] =rect.j_rect('jia10') ,
	['传送-甲11'] =rect.j_rect('jia111') ,


	['boss-甲1'] =rect.j_rect('jia11') ,
	['boss-甲2'] =rect.j_rect('jia22') ,
	['boss-甲3'] =rect.j_rect('jia33') ,
	['boss-甲4'] =rect.j_rect('jia44') ,
	['boss-甲5'] =rect.j_rect('jia55') ,
	['boss-甲6'] =rect.j_rect('jia66') ,
	['boss-甲7'] =rect.j_rect('jia77') ,
	['boss-甲8'] =rect.j_rect('jia88') ,
	['boss-甲9'] =rect.j_rect('jia99') ,
	['boss-甲10'] =rect.j_rect('jia1010') ,
	['boss-甲11'] =rect.j_rect('jia1111') ,

	--技能
	['传送-技能1'] =rect.j_rect('jn1') ,
	['传送-技能2'] =rect.j_rect('jn2') ,
	['传送-技能3'] =rect.j_rect('jn3') ,
	['传送-技能4'] =rect.j_rect('jn4') ,
	
	['boss-技能1'] =rect.j_rect('jn11') ,
	['boss-技能2'] =rect.j_rect('jn22') ,
	['boss-技能3'] =rect.j_rect('jn33') ,
	['boss-技能4'] =rect.j_rect('jn44') ,

	--洗练石
	['传送-洗练石1'] =rect.j_rect('xls1') ,
	['传送-洗练石2'] =rect.j_rect('xls2') ,
	['传送-洗练石3'] =rect.j_rect('xls3') ,
	['传送-洗练石4'] =rect.j_rect('xls4') ,
	
	['boss-洗练石1'] =rect.j_rect('xls11') ,
	['boss-洗练石2'] =rect.j_rect('xls22') ,
	['boss-洗练石3'] =rect.j_rect('xls33') ,
	['boss-洗练石4'] =rect.j_rect('xls44') ,

	--境界
	['传送-境界1'] =rect.j_rect('jj1') ,
	['传送-境界2'] =rect.j_rect('jj2') ,
	['传送-境界3'] =rect.j_rect('jj3') ,
	['传送-境界4'] =rect.j_rect('jj4') ,
	['传送-境界5'] =rect.j_rect('jj5') ,
	['传送-境界6'] =rect.j_rect('jj6') ,
	['传送-境界7'] =rect.j_rect('jj7') ,
	['传送-境界8'] =rect.j_rect('jj8') ,
	['传送-境界9'] =rect.j_rect('jj9') ,
	['传送-境界10'] =rect.j_rect('jj10') ,
	['传送-境界11'] =rect.j_rect('sd1') ,

	['boss-境界1'] =rect.j_rect('jj11') ,
	['boss-境界2'] =rect.j_rect('jj22') ,
	['boss-境界3'] =rect.j_rect('jj33') ,
	['boss-境界4'] =rect.j_rect('jj44') ,
	['boss-境界5'] =rect.j_rect('jj55') ,
	['boss-境界6'] =rect.j_rect('jj66') ,
	['boss-境界7'] =rect.j_rect('jj77') ,
	['boss-境界8'] =rect.j_rect('jj88') ,
	['boss-境界9'] =rect.j_rect('jj99') ,
	['boss-境界10'] =rect.j_rect('jj1010') ,
	['boss-境界11'] =rect.j_rect('sd11') ,

	['传送-伏地魔'] =rect.j_rect('fdm1') ,
	['boss-伏地魔'] =rect.j_rect('fdm11') ,

	['传送-星星之火'] =rect.j_rect('xxzh1') ,
	['传送-陨落心炎'] =rect.j_rect('ylxy1') ,
	['传送-三千焱炎火'] =rect.j_rect('sqyyh1') ,
	['传送-虚无吞炎'] =rect.j_rect('xwty1') ,
	['传送-陀舍古帝'] =rect.j_rect('tsgd1') ,
	['传送-无尽火域'] =rect.j_rect('wjhy1') ,
	
	['boss-星星之火'] =rect.j_rect('xxzh111') ,
	['boss-陨落心炎'] =rect.j_rect('ylxy111') ,
	['boss-三千焱炎火'] =rect.j_rect('sqyyh111') ,
	['boss-虚无吞炎'] =rect.j_rect('xwty111') ,
	['boss-陀舍古帝'] =rect.j_rect('tsgd11') ,
	['boss-无尽火域'] =rect.j_rect('wjhy11') ,

	--藏宝图
	['藏宝图 '] =rect.j_rect('cbt1') ,
	['boss-藏宝图'] =rect.j_rect('cbt111'),
	['藏宝区'] =rect.j_rect('cbt2'),
	['奶牛区'] =rect.j_rect('nainiu1') ,

	--恶魔果实
	['传送-红发'] =rect.j_rect('emo1') ,
	['传送-黑胡子'] =rect.j_rect('emo2') ,
	['传送-百兽'] =rect.j_rect('emo3') ,
	['传送-白胡子'] =rect.j_rect('emo4') ,

	['boss-红发'] =rect.j_rect('emo11') ,
	['boss-黑胡子'] =rect.j_rect('emo22') ,
	['boss-百兽'] =rect.j_rect('emo33') ,
	['boss-白胡子'] =rect.j_rect('emo44') ,

	['传送-替天行道'] =rect.j_rect('ttxd1') ,
	['boss-食人魔'] =rect.j_rect('ttxd11') ,

	['传送-吞噬极限'] =rect.j_rect('tssx1') ,
	['刷怪-吞噬极限'] =rect.j_rect('tssx11') ,

	['传送-强化极限'] =rect.j_rect('tssx2') ,
	['刷怪-强化极限'] =rect.j_rect('tssx22') ,

	['传送-暴击几率'] =rect.j_rect('tssx3') ,
	['刷怪-暴击几率'] =rect.j_rect('tssx33') ,

	['传送-免伤几率'] =rect.j_rect('tssx4') ,
	['刷怪-免伤几率'] =rect.j_rect('tssx44') ,

	['传送-技暴几率'] =rect.j_rect('tsjx5') ,
	['刷怪-技暴几率'] =rect.j_rect('tsjx55') ,

	['传送-闪避'] =rect.j_rect('tsjx6') ,
	['刷怪-闪避'] =rect.j_rect('tsjx66') ,
	
	['传送-会心几率'] =rect.j_rect('tsjx7') ,
	['刷怪-会心几率'] =rect.j_rect('tsjx77') ,

	['传送-免伤'] =rect.j_rect('tsjx8') ,
	['刷怪-免伤'] =rect.j_rect('tsjx88') ,

	

}

-- local minx, miny, maxx, maxy = ac.map.rects['刷怪']:get()
-- local point = rect.j_rect('sg002'):get_point()
-- print(minx, miny, maxx, maxy)
local minx, miny, maxx, maxy = ac.map_area:get()
-- print(minx, miny, maxx, maxy)

local function pathRegionInit(minx, miny, maxx, maxy)
	jass.EnumDestructablesInRect(jass.Rect(minx, miny, maxx, maxy), nil, function()
		local dstrct = jass.GetEnumDestructable()
		local id = jass.GetDestructableTypeId(dstrct)
		if tonumber(slk.destructable[id].walkable) == 1 then
			return
		end
		local x0, y0 = jass.GetDestructableX(dstrct), jass.GetDestructableY(dstrct)
		
		--将附近的区域加入不可通行区域
		--local rng = 64
		--point.path_region = point.path_region + rect.create(x - rng, y - rng, x + rng, y + rng)
		local fly = false
		if id == base.string2id 'YTfb' or id == base.string2id 'YTfc'  then
			fly = true
		end
		--关闭附近的通行
		for x = x0 - 64, x0 + 64, 32 do
			for y = y0 - 64, y0 + 64, 32 do
				jass.SetTerrainPathable(x, y, 1, false)
				if fly then
					jass.SetTerrainPathable(x, y, 2, false)
				end
				jass.RemoveDestructable(dstrct)
			end
		end
	end)
end
pathRegionInit(minx, miny, maxx, maxy)


--出地图者死 
local rect = ac.rect.create(minx-200, miny-500, maxx+200, maxy+800)
local out_reg = ac.region.create(rect)

out_reg:event '区域-离开' (function(trg, hero)
	if  not hero.out_map_dying then
		--标记已经在死了
		hero.out_map_dying = true
		print(hero:get_name(),'出地图死')
		hero:kill()
		-- --附近找个地方
		-- local p = hero:get_point() - {hero:get_facing() + math.random(-60, 60), math.random(800, 1000)}
		-- --找可通行点 
		-- p:findMoveablePoint(1000)
		-- --创建一个黑洞
		-- local eff = ac.effect(p, [[cosmic field_65.mdl]])
		-- eff.unit:set_size(1)
		-- eff.unit:shareVisible(hero:get_owner())
		-- eff.unit:addSight(400)

		-- local mvr = ac.mover.target
		-- {
		-- 	source = eff.unit,
		-- 	mover = hero,
		-- 	start = hero,
		-- 	target = eff.unit,
		-- 	speed = 0,
		-- 	accel = 100,
		-- 	skill = false,
		-- 	super = true,
		-- }

		-- local function kill()
		-- 	hero:add_buff '晕眩'
		-- 	{
		-- 		source = hero,
		-- 		time = 1,
		-- 	}
		-- 	hero:set_animation('death')
		-- 	local count = 45
		-- 	ac.loop(20, function(t)
		-- 		if count <= 0 then
		-- 			hero:kill()
		-- 			eff:remove()
		-- 			hero.out_map_dying = false
		-- 			hero:set_size(1)
		-- 			hero:set_high(0)
		-- 			if not hero:is_alive() then
		-- 				hero:add_restriction '阿卡林'
		-- 				hero:event '单位-复活' (function(trg)
		-- 					trg:remove()
		-- 					hero:remove_restriction '阿卡林'
		-- 				end)
		-- 			end
		-- 			t:remove()
		-- 			return
		-- 		end
		-- 		count = count - 1
		-- 		hero:set_size(0.022*count)
		-- 		hero:set_high(135-3*count)
		-- 		hero:blink(p,true,true)
		-- 		if count == 15 then
		-- 			ac.effect(p, [[shadowexplosion.mdl]]):remove()
		-- 		end
		-- 		if count > 15 then
		-- 			eff.unit:set_size(1.9-0.02*count)
		-- 		else
		-- 			eff.unit:set_size(0.1*count)
		-- 		end
		-- 	end)
		-- end
		
		-- if not mvr then
		-- 	kill()
		-- 	return
		-- end

		-- function mvr:on_remove()
		-- 	kill()
		-- end
	end
end)



--召唤物倍数 波数
local function get_summon_mul(lv)
	local level_mul = {
		[10] ={ 
			['最小范围'] = 0,
			['生命'] = 20, 
			['护甲'] = 0.001, 
			['攻击'] = 0.5, 
		},
		[20] ={ 
			['最小范围'] = 10,
			['生命'] = 10, 
			['护甲'] = 0.001, 
			['攻击'] = 1, 
		},
		[30] ={ 
			['最小范围'] = 20,
			['生命'] = 9, 
			['护甲'] = 0.001, 
			['攻击'] = 3, 
		},
		[40] ={ 
			['最小范围'] = 30,
			['生命'] = 8, 
			['护甲'] = 0.001, 
			['攻击'] = 10, 
		},
		[50] ={ 
			['最小范围'] = 40,
			['生命'] = 7, 
			['护甲'] = 0.001, 
			['攻击'] = 40, 
		},
		[1000000] ={ 
			['最小范围'] = 50,
			['生命'] = 5, 
			['护甲'] = 0.001, 
			['攻击'] = 120, 
		},
	}

	local life_mul = 1
	local defence_mul = 1
	local attack_mul = 1
	for index,info in sortpairs(level_mul) do 
		if lv <= index and lv > info['最小范围']  then 
			life_mul = info['生命']
			defence_mul = info['护甲']
			attack_mul = info['攻击']
			break 
		end 
	end 
	return life_mul,defence_mul,attack_mul
end	

ac.get_summon_mul = get_summon_mul

