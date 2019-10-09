local player = require 'ac.player'
local fogmodifier = require 'types.fogmodifier'
local sync = require 'types.sync'
local jass = require 'jass.common'
local hero = require 'types.hero'
local Unit = require 'types.unit'
local item = require 'types.item'
local affix = require 'types.affix'
local japi = require 'jass.japi'
local dbg = require 'jass.debug' 
local runtime = require 'jass.runtime'
-- dbg.gchash = function () end 

local error_handle = require 'jass.runtime'.error_handle

local helper = {}

local function helper_reload(callback)
	local real_require = require
	function require(name, ...)
		if name:sub(1, 5) == 'jass.' then
			return real_require(name, ...)
		end
		if name:sub(1, 6) == 'types.' then
			return real_require(name, ...)
		end
		if not package.loaded[name] then
			return real_require(name, ...)
		end
		package.loaded[name] = nil
		return real_require(name, ...)
	end
	
	callback()

	require = real_require
end

local function reload_skill_buff()
	local ac_skill = ac.skill
	local ac_buff = ac.buff
	ac.skill = setmetatable({}, {__index = function(self, k)
		if type(ac_skill[k]) ~= 'table' then
			return ac_skill[k]
		end
		ac_skill[k] = nil
		self[k] = ac_skill[k]
		return ac_skill[k]
	end})
	ac.buff = setmetatable({}, {__index = function(self, k)
		if type(ac_buff[k]) ~= 'table' then
			return ac_buff[k]
		end
		ac_buff[k] = nil
		self[k] = ac_buff[k]
		return ac_buff[k]
	end})
	return function()
		ac.skill = ac_skill
		ac.buff = ac_buff
	end
end

--重载
function helper:reload()
	log.info('---- Reloading start ----')

	local reload_finish = reload_skill_buff()
	local map = require 'maps.map'

	helper_reload(function()
		require 'ac.buff.init'
		require 'ac.template_skill'
		require 'maps.hero.upgrade'
		require 'maps.smart_cast.init'
		map.load_heroes()
		item.clear_list()
		affix.clear_list()
		require 'maps.map_item._init'
		require 'maps.map_shop.page'
		require 'maps.map_shop.affix'
	end)

	reload_finish()
	
	--重载技能和Buff
	local levels = {}

	for i = 1, 10 do
		local hero = player[i].hero
		if hero then
			hero:cast_stop()
			if hero.buffs then
				local tbl = {}
				for bff in pairs(hero.buffs) do
					if not bff.name:match '宝箱奖励' then
						tbl[#tbl + 1] = bff
					end
				end
				for i = 1, #tbl do
					tbl[i]:remove()
				end
			end
			if hero.movers then
				local tbl = {}
				for mover in pairs(hero.movers) do
					tbl[#tbl + 1] = mover
				end
				for i = 1, #tbl do
					tbl[i]:remove()
				end
			end
		end
	end

	for i = 1, 10 do
		local hero = player[i].hero
		if hero then
			hero:set('生命', 1000000)
			hero:set('魔法', 1000000)
			local level_skills = {}
			--遍历身上的技能
			for skill in hero:each_skill(nil, true) do
				if not skill.never_reload then
					local name = skill.name
					skill:_call_event('on_reload', true)
					local level = skill:get_level()
					local slotid = skill.slotid
					local type = skill:get_type()
					local upgrade = skill._upgrade_skill
					skill:remove()
					local skill = select(2, xpcall(hero.add_skill, error_handle, hero, name, type, slotid, {level = ac.skill[name].level}))
					if skill then
						table.insert(level_skills, {skill, level, upgrade})
					end
				end
			end
			local skill_points = 0
			for _, data in ipairs(level_skills) do
				local skill = data[1]
				local level = data[2]
				skill:set_level(ac.skill[skill.name].level)
				skill_points = skill_points + level - skill:get_level()
			end
			hero:addSkillPoint(skill_points)
			for _, data in ipairs(level_skills) do
				local skill = data[1]
				local level = data[2]
				local upgrade = data[3]
				print('重载技能', skill.name, level, upgrade)
				if upgrade then
					for i = 1, level do
						if upgrade[i] then
							local skill = hero:find_skill(upgrade[i].name)
							if skill then
								skill:cast_force()
							end
						end
					end
				end
			end
			hero:addSkillPoint(0)
		end
	end

	--遍历身上的物品
	for i = 1, 6 do
		local it = self:find_skill(i, '物品')
		if it then
			local name = it.name
			local affixs = it.affixs
			local slotid = it.slotid
			it:remove()
			local skl = self:add_skill(name, '物品', slotid)
			if skl then
				skl:set_affixs(affixs)
				skl:fresh_tip()
			end
		end
	end
	log.info('---- Reloading end   ----')

	ac.game:event_notify('游戏-脚本重载')
end





--创建全图视野
function helper:icu()
	fogmodifier.create(self:get_owner(), require('maps.map').rects['全地图'])
end
--刷新技能
function helper:fresh(str)
	local skl = self:find_skill(str,nil,true)
	if skl then 
		skl:fresh()
	end	
end

--移动英雄
function helper:move()
	local data = self:get_owner():getCamera()
	self:get_owner():sync(data, function(data)
		self:blink(ac.point(data[1], data[2]), true)
	end)
end

--添加Buff
function helper:add_buff(name, time)
	if self then
		self:add_buff(name)
		{
			time = tonumber(time),
		}
	end
end

--移除Buff
function helper:remove_buff(name)
	if self then
		self:remove_buff(name)
	end
end

--创建瀑布
function helper:wave()
	require('maps.spring').start()
end

--创建宝箱
function helper:box()
	require('maps.spring').createBox()
end

--满级
function helper:lv(lv)
	self:set_level(tonumber(lv))
end

--评论数相关
function helper:pl(cnt)
	local p = self and self:get_owner() or ac.player(ac.player.self.id)
	p.comment = tonumber(cnt)
	print('个人评论次数：',p:Map_CommentCount())
end	
--总评论数相关
function helper:allpl(cnt)
	local p = self and self:get_owner() or ac.player(ac.player.self.id)
	p.total_comment = tonumber(cnt)
	print('地图总评论次数：',p:Map_CommentTotalCount())
end	
--地图等级相关
function helper:dtdj(lv)
	local p = self and self:get_owner() or ac.player(ac.player.self.id)
	p.map_level = tonumber(lv)
	--重载商城道具。
	for n=1,#ac.mall do
		local need_map_level = ac.mall[n][3] or 999999999999
		-- print(ac.mall[n][1],need_map_level)
		if     (p:Map_HasMallItem(ac.mall[n][1]) 
			or (p:Map_GetServerValue(ac.mall[n][1]) == '1') 
			or (p:Map_GetMapLevel() >= need_map_level) 
			or (p.cheating)) 
		then
			local key = ac.mall[n][2]  
			p.mall[key] = 1  
		end  
	end    
end

function helper:reload_mall(flag)
	local p = self and self:get_owner() or ac.player(ac.player.self.id) 
	local peon = p.peon
	
	--挖宝积分在读取存档数据后就赋值。
	p:event_notify '读取存档数据'

	if not flag then 
		ac.init_need_map_level()
	end	

	local skl = self:find_skill('巅峰神域')
	if skl then skl:remove() end
	self:add_skill('巅峰神域','英雄',12)	
	
	local skl = peon:find_skill('宠物皮肤')
	if skl then skl:remove() end
	peon:add_skill('宠物皮肤','英雄',12)

	local skl = peon:find_skill('宠物天赋')
	if skl then skl:remove() end
	peon:add_skill('宠物天赋','英雄',8)



end	

--积分 正常模式下，101波，boss打完就进入无尽，没有保存当前积分。 貌似要在回合结束统计分数。
function helper:jifen(jf)
	local p = self:get_owner()
	p.putong_jifen = jf
	
	local value = p.putong_jifen --* (p.hero:get '积分加成' + 1)
	print('积分',value)
	--保存积分
	p:add_jifen(value)

	print('服务器积分：',jifen)
end	
--ac.save_jifen
function helper:save_jifen()
	ac.save_jifen()
end	


--服务器存档 保存 
function helper:save(key,value)
	local p = self and self:get_owner() or ac.player(ac.player.self.id)
	-- p:SetServerValue(key,tonumber(value) or 1) 自定义服务器
	if key == 'all' then 
		for i,data in ipairs(ac.cus_server_key) do 
			local key = data[1]
			p:Map_SaveServerValue(key,tonumber(value) or 1) --网易服务器
		end		
	else	
		p:Map_SaveServerValue(key,tonumber(value) or 1) --网易服务器
	end	
end	
--服务器清空档案
function helper:clear_server(flag)
	if flag then 
		ac.clear_all_server()
	else	
		local p = self and self:get_owner() or ac.player(ac.player.self.id) 
		p:clear_server()
	end	
end

--服务器存档 读取 
function helper:get_server(key)
	local p = self and self:get_owner() or ac.player(ac.player.self.id)
	if key == 'all' then 
		for name,val in pairs(p.cus_server) do
			local key = ac.server.name2key(name)
			print('服务器存档:'..key,p:Map_GetServerValue(key))
			-- print('服务器存档:',key,val)
		end
	else		
		local name = ac.server.key2name(key)	
		print('服务器存档:'..key,p:Map_GetServerValue(key))
		-- print('服务器存档:'..key,p.cus_server[name])
	end	
end	

--动画
function helper:ani(name)
	self:set_animation(name)
end
--动画
function helper:print_item(unit,all)
	local hero = self
	local peon = hero:get_owner().peon
	local pt = ''
	if not all  then 
		for i = 1,6 do
			local item = peon:get_slot_item(i)
			if item then 
				pt = pt ..item.slot_id ..item.name .. ','
			end	
		end
	else
		for i = 1,100 do
			local item = peon.item_list[i]
			if item then 
				pt = pt ..item.slot_id ..item.name .. ','
			end	
		end
	end	
	print(pt)
end
--测试item.handle 
function helper:it1()
	ac.loop(1000,function()
		for i=1,30 do 
			local item = ac.item.create_item('冰剑',ac.point(0,0))
			-- local item = self:add_item('冰剑',true)
			-- print(item.handle)
			ac.wait(1*1000,function()
				item:item_remove()
			end)
		end	
	end)


end	
--测试杀怪内存
function helper:c1()
	local point = ac.map.rects['出生点']
	local u = ac.player(1):create_unit('甲虫',point)
	u:kill()
end	
function helper:c2()
	local point = ac.map.rects['选人出生点']
	for i=1,15 do 
		local u = ac.player(12):create_unit('甲虫',point)
		u:set('生命上限',32000000)
		-- ac.wait(5*1000,function()
		-- 	u:kill()
		-- end)

	end	
end	

--测试杀怪内存
function helper:test_k_u()
	local point = ac.map.rects['出生点']
	-- local u = ac.player(1):create_unit('甲虫',point)
	local temp = {}
	ac.test_unit = ac.loop(1000,function()
		for i=1,100 do
			-- local dummy = u:create_illusion(u:get_point())
			-- dummy:kill()	
			-- local x,y = point:get()
			-- local handle = jass.CreateUnit(ac.player(1).handle, base.string2id('u002'), x, y,0)
			-- self ={}
			-- self.handle = handle
			-- jass.SetWidgetLife(self.handle, 100000)--生命
			-- japi.SetUnitState(handle, jass.UNIT_STATE_MAX_LIFE, 100000) --生命上限
			-- japi.SetUnitState(handle, jass.UNIT_STATE_MAX_MANA, 100000) --魔法上限
			-- japi.SetUnitState(self.handle, jass.ConvertUnitState(0x20), 100000) --护甲
			-- japi.SetUnitState(self.handle, jass.ConvertUnitState(0x12), 123 - 1) --攻击 
			-- jass.RemoveUnit(handle)
			-- print(handle)
			local u = ac.player(12):create_unit('甲虫',point)
			u:kill()
			-- u:remove()
			-- table.insert(temp,u)
		end    
	end)
	ac.test_unit:on_timer()
	ac.loop(10000,function()
        --开始清理物品
		ac.game:clear_item()
	end)	
end	


--测试杀怪内存
function helper:test_stop()
	if ac.test_unit then 
		ac.test_unit:remove()
		ac.test_unit = nil
	end	
end	
--测试掉线
function helper:test_offline()
	ac.loop(3000,function()
		for i=1,10 do
			local p = ac.player(i)
			if p:is_player() then 
				local u = p:create_unit('民兵',ac.point(0,0))
				ac.wait(1000,function()
					u:kill()
				end)
			end    
		end    
	end)
end	

--难3测试
function helper:test_n3()
	local p = self and self:get_owner() or ac.player(ac.player.self.id)

    p:Map_SaveServerValue('JBLB',1) --网易服务器
    p:Map_SaveServerValue('MCLB',1) --网易服务器
    p:Map_SaveServerValue('WXHP',1) --网易服务器
    p:Map_SaveServerValue('zzl',1) --网易服务器
    p:Map_SaveServerValue('XHB',1) --网易服务器
    p:Map_SaveServerValue('lhcq',1) --网易服务器
    p:Map_SaveServerValue('sbkd',1) --网易服务器
    p:Map_SaveServerValue('nsl',1) --网易服务器
    p:Map_SaveServerValue('sjjh',50) --网易服务器
    p:Map_SaveServerValue('yshz',20) --网易服务器
    p:Map_SaveServerValue('wbjf',2000) --网易服务器
    p:Map_SaveServerValue('cwtf',60000) --网易服务器

end	

--伤害自己
function helper:damage(damage)
	self:damage
	{
		source = self,
		damage = damage,
		skill = false,
	}
end

function helper:setre()
	all_lb[11] = 20
end

function helper:hotfix()
	require('types.hot_fix').main(self:get_owner())
end

--显示伤害漂浮文字
function helper:show()
	local function text(damage)
		local size = 20
		local x, y = damage.target:get_point():get()
		local z = damage.target:get_point():getZ()
		local tag = ac.texttag
		{
			string = ('%d'):format(math.floor(damage:get_current_damage())),
			size = size,
			position = ac.point(x - 60, y, z - 30),
			speed = 86,
			angle = 90,
			red = 100,
			green = 20,
			blue = 20,
		}
	end
	ac.game:event '造成伤害效果' (function(trg, damage)
		if not damage.source or not damage.source:is_hero() then
			return
		end
		text(damage)
	end)
end

--计时器测试
function helper:timer()
    local count = 0
	local t = ac.loop(100, function(t)
        print(ac.clock())
        count = count + 1
        if count == 10 then
            t:pause()
        end
    end)
	ac.wait(3000, function()
		t:resume()
	end)
	ac.wait(5000, function()
		t:remove()
	end)
end

--测试
function helper:power()
	helper.move(self)
	helper.lv(self, 100)
	if not ac.wtf then
		helper.wtf(self)
	end
	local player = self:get_owner()
	self:add_restriction '免死'
	player:addGold(599999)
	player:add_wood(599999)
	player:add_kill_count(599999)
	player:add_fire_seed(599999)
end

--强制游戏结束
function helper:over(flag)
	ac.game:event_notify('游戏-结束',flag)
end
--强制游戏结束
function helper:add_restriction(str)
	self:add_restriction(str)
end
--插入魔法书
function helper:add_sub_skill(skill,book_skill)
	local hero = self --,'杀鸡狂魔'
	local temp_skill = {
		'倒霉蛋','游戏王','挖宝达人','五道杠少年','输出机器','技多不压身','实在是菜','浴火重生','ONE_PIECE','法老的遗产'
	}
	for i,name in ipairs(temp_skill) do
		print(name)
		ac.game:event_notify('技能-插入魔法书',hero,'彩蛋',name)
	end	
end

--强制下一波
function helper:add_red()
	for i =1,6 do 
		local name = ac.quality_item['红'][math.random(#ac.quality_item['红'])]
		self:add_item(name,true)
	end	
end	
function helper:add_black()
	for i =1,6 do 
		print(ac.quality_item['黑'][1])
		local name = ac.quality_item['黑'][math.random(#ac.quality_item['黑'])]
		self:add_item(name,true)
	end	
end	

--强制下一波
function helper:next()
	--强制下一波
	local self 
	for i=1,3 do
		if ac.creep['刷怪'..i].has_started then 
			ac.creep['刷怪'..i]:next()
		else
			ac.creep['刷怪'..i]:start()
		end		
	end	
end
--创建一个敌方英雄在地图中间，如果playerid有参数，则是为playerid玩家创建
function helper:create(str,cnt, playerid)
	if not playerid then
		playerid = 12
	end
	local p = ac.player[tonumber(playerid)]
	for i = 1 ,(cnt or 1) do
		local point = ac.map.rects['出生点']
		local unit = p:create_unit(str,point)
		local data = ac.table.UnitData[str]
		-- print(unit:get('护甲'),unit:get('护甲%'),data.attribute['护甲'])
		unit:set('移动速度',455)
		-- ac.wait(0.5*1000,function()
		-- 	print(unit:get('护甲'),unit:get('护甲%'),data.attribute['护甲'])
		-- end)
	end	
end
--创建一个敌方英雄在地图中间，如果playerid有参数，则是为playerid玩家创建
function helper:dummy(life, playerid)
	if not playerid then
		playerid = 13
	end
	local p = player[tonumber(playerid)]
	p.hero = p:createHero('诸葛亮', ac.point(0,0,0), 270)
	-- p:event_notify('玩家-注册英雄', p, p.hero)
	p.hero:add_enemy_tag()
	p.hero:add_restriction '缴械'
	p.hero:add('生命上限', tonumber(life) or 1000000)
end

function helper:black()
	jass.SetDayNightModels('', 'Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl')
end
--玩家设置队伍颜色 颜色id
function helper:psetcolor(str,pid)
	local p
	if not pid then 
		p = self:get_owner()
	else
		p = ac.player(tonumber(pid))	
	end	

	p:setColor(tonumber(str))
end

--给进攻怪增加技能 
function helper:ads(str)
	for i=1,3 do 
		local crep = ac.creep['刷怪-无尽'..i]
		for i,u in ipairs(crep.group) do 
			if u and u:is_alive() then 
				--先删旧技能，再加新技能
				for skl in u:each_skill() do 
					skl:remove()
				end
				u:add_skill(str,'隐藏')
			end
		end
	end				
end

--给进攻怪增加技能 
function helper:ads_u(unit,str)
	for key,val in pairs(ac.unit.all_units) do 
		if val:get_name() == unit then 
			val:add_skill(str,'英雄')
		end	
	end	
end
--增加 属性
function helper:add(str,cnt)
	print(self:add(str,tonumber(cnt)))
end
--读取 属性
function helper:get(key)
	print(self:get(key))
end	

--读取 单位属性
function helper:get_u(unit,str)
	for key,val in pairs(ac.unit.all_units) do 
		if val:get_name() == unit then 
			print(val:get(str))
			break
		end	
	end	
end	
--增加 单位属性
function helper:add_u(unit,str,cnt)
	for key,val in pairs(ac.unit.all_units) do 
		if val:get_name() == unit then 
			print(val:add(str,tonumber(cnt)))
		end	
	end	
end	

--增加技能物品
function helper:add_skill(str,cnt)
	local cnt = cnt or 1
	for i=1,cnt do
		ac.item.add_skill_item(str,self)
	end	
end
--移除技能
function helper:remove_skill(str)
	local skill = self:find_skill(str,'英雄',true)
	if skill then 
		skill:remove()
	end	
end
--升级技能
function helper:upgrade(str,lv)
	local peon = self:get_owner().peon
	-- print(peon,peon:find_skill(str))
	local skill = self:find_skill(str,nil,true) or self:has_item(str) or peon:find_skill(str,nil,true)
	if skill then 
		-- print(peon,peon:find_skill(str))
		skill:upgrade(tonumber(lv) or 1)
	end	
end
--增加物品
function helper:add_item(str,cnt)
	local cnt = cnt or 1
	for i=1,cnt do
		self:add_item(str,true)
	end	
end
--增加套装 可能掉线
function helper:add_suit(str)
	local cnt = 5 
	for name,data in pairs(ac.table.ItemData) do 
		if data.suit_type and data.suit_type == str then 
			if cnt > 0 then 
				print(name)
				self:add_item(name,true)
				cnt = cnt -1
			else
				break;	
			end	
		end
	end	
end	
--增加套装 可能掉线
function helper:remove_item(str)
	local item = self:has_item(str)
	-- self:remove_item(item)
	item:item_remove()
end	
--测试region  DzGetMouseTerrainX
function helper:aa(str)
	
	local x = japi.DzGetMouseTerrainX()
	local y = japi.DzGetMouseTerrainY()
	local player = ac.player(2)
	
	jass.SetUnitX(self.handle, x)
	jass.SetUnitY(self.handle, y)
	print('鼠标游戏内坐标',x,y,jass.IsPointInRegion(player.tt_region.handle,x,y))
end	
--测试region  DzGetMouseTerrainX
function helper:add_ability(str)

end	
--测试用的木桩
function helper:tt_unit(where)
	local cnt = 5 
	local point = ac.map.rects['出生点']:get_point()
	for i=1,cnt do 
		local unit = ac.player(12):create_unit('甲虫',point)
		unit:set('生命上限',10000000000)
		unit:set('生命恢复',10000000000)
		unit:set('护甲',10000)
		unit:set('攻击',10000)
		-- unit:set('移动速度',0)
	end	
end	
function helper:final()
	-- ac.creep['刷怪1'].index = 24
	-- ac.creep['刷怪2'].index = 24
	-- ac.creep['刷怪3'].index = 24
	
	ac.game:event_dispatch('游戏-最终boss')
end	
--进入地狱，7个光环
function helper:revive()
	self:revive()
	helper.move(self)
end
function helper:pk(flag) 
	if flag then
		ac.init_enemy()
	else
		ac.init_alliance()
	end	 
end	
--测试 暂停两次
function helper:pause(num)
	for i=1,3 do 
		local creep = ac.creep['刷怪-无尽'..i]
		creep:PauseTimer(tonumber(num) or 40)
	end
	--启用另一个计时器 显示停怪恢复倒计时	
	ac.main_stop_timer = ac.timer_ex
	{
		 time = tonumber(num) or 40,
		 title = '停怪还剩：',
		 func = function()
			 ac.player.self:sendMsg('|cffff0000停怪结束！！！ 请注意进攻怪来袭。|r')
			 ac.player.self:sendMsg('|cffff0000停怪结束！！！ 请注意进攻怪来袭。|r')
			 ac.player.self:sendMsg('|cffff0000停怪结束！！！ 请注意进攻怪来袭。|r')
		 end,
	 }
end	
--测试武林大会
function helper:wldh()
	ac.game.start_wldh()
end	

--进入地狱，7个光环
function helper:tt()
	ac.item.add_skill_item('战鼓光环',self)

	self:add('杀怪加全属性',3000)
	-- self:add('攻击距离',2000)
	self:add('暴击几率',90)
	self:add('会心几率',90)
	self:add('多重射',10)
	self:add('分裂伤害',100)
	self:add('全属性',10000000000)
	self:add('护甲',1000000000)
	self:add('会心伤害',10000000000)
	-- self.flag_dodge = true --突破极限
	self:add('闪避极限',5)
	self:add('闪避',100)
	self:add('免伤',90)
	self:add('免伤几率',90)
	self:add('全伤加深',10030000000)
	self:add('暴击加深',1003000)
	self:add('攻击速度',500)
	self:add('攻击间隔',-1)
	self:add_wood(10000000)
	self:add_fire_seed(10000000)
	-- if not ac.wtf then
	-- 	helper.wtf(self)
	-- end
	-- self:add_restriction '免死'
end

function helper:tt2()
	ac.item.add_skill_item('战鼓光环',self)

	self:add('杀怪加全属性',3000)
	-- self:add('攻击距离',2000)
	self:add('攻击间隔',-1)
	self:add('暴击几率',90)
	self:add('会心几率',90)
	self:add('多重射',10)
	self:add('分裂伤害',100)
	self:add('全属性',1000000000)
	self:add('护甲',1000000000)
	self:add('会心伤害',10000)

	for i,name in ipairs({'空间之力','炎爆术','回旋刃','交叉闪电','飞焰','阳光枪','风暴之力'}) do
		local skl = self:add_skill(name,'英雄')
		skl:upgrade(5)
	end	



	
end
--给商店添加商品
function helper:add_sell_item(shop,item,slotid)
	for key,unit in pairs(ac.shop.unit_list) do 
		if unit:get_name() == shop  then 
			unit:add_sell_item(item,(slotid or 1))
		end	
	end	

end	
--设置物品数量
function helper:set_item(str,cnt)
	local item = self:has_item(str)
	local cnt = tonumber(cnt) or 1
	if item then 
		item:set_item_count(cnt)
	end	
end
--设置商城道具
function helper:save_mall(str,flag)
	local p = ac.player(ac.player.self.id)
	local name = ac.server.key2name(str)
	p.mall[name] = tonumber(flag)
end

--宠物移除技能
function helper:peon_remove_skill(str)
	local hero = self:get_owner().peon
	local skill = hero:find_skill(str,'英雄',true)
	if skill then 
		skill:remove()
	end	
end
--技能CD清零
function helper:wtf()
	ac.wtf = not ac.wtf
	if ac.wtf then
		for i = 1, 10 do
			local hero = ac.player(i).hero
			if hero then
				for skill in hero:each_skill() do
					skill:set_cd(0)
				end
			end
		end
	end
end
--测试打印魔兽端与lua 生命上限问题

function Unit.__index:pt()
	ac.loop(1*1000,function()
		print('lua 生命上限:',self:get('生命上限'),'魔兽生命上限：',jass.GetUnitState(self.handle, jass.UNIT_STATE_MAX_LIFE))
		print('lua 生命:',self:get('生命'),'魔兽生命：',jass.GetWidgetLife(self.handle))
	end)

end

--打印hero键值对应的key值
function helper:print(str)
	local obj = self[str]
	self:pt()
	-- print(self,self:get_name())
	if obj then 
		if type(obj) == 'function' then 
			print(obj(self))
		elseif 	type(obj) == 'table' then 
			print(tostring(obj))
		else
			print(tostring(obj))
		end	
	end	
end

--打印hero键值对应的key值
function helper:print_p(str,index)
	local player = ac.player.self
	local obj = player[str]
	if obj then 
		if type(obj) == 'function' then 
			print(obj())
		elseif 	type(obj) == 'table' then 
			print(tostring(obj[index or 1]))
		else
			print(tostring(obj))
		end	
	else
		print(nil)	
	end	
end

function helper:addit(flag)
	for i=1,100 do 
        -- local name = ac.all_item[math.random( 1,#ac.all_item)]
        local list = ac.quality_item['白'] 
        local name = list[math.random(#list)]
		self.owner.peon:add_item(name,true)
	end	
end

function helper:gsp()
	ac.func_give_suipian(self:get_point())
end

--测试 
function helper:test_uu()
	print('当前怪物数量：',ac.unit_cnt)
	for i=1,3 do 
		local crep = ac.creep['刷怪-无尽'..i]
		print(i,#crep.group)
		for i,u in ipairs(crep.group) do 
			if u:is_in_range(ac.point(0,0),500) then 
				print(u:get_name(),'是否活着：',u:is_alive(),u:get_point())
			end	
		end	
	end	
end	
--测试 
function helper:test_uu2()
	print('当前怪物数量：',ac.unit_cnt)
	for i=1,3 do 
		local crep = ac.creep['刷怪-无尽'..i]
		print(i,#crep.group)
		for i,u in ipairs(crep.group) do 
			if u:is_in_range(ac.point(0,0),500) then 
				print(u:get_name(),'是否活着：',u:is_alive(),u:get_point())
				u:kill()
			end	
		end	
	end	
end	
--测试 魔法书功能
function helper:test_b1(str)
	local p = self and self:get_owner() or ac.player(ac.player.self.id)
	local hero = p.hero
	ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',str or '有趣的灵魂')

end	
function helper:test_b2(str)
	local p = self and self:get_owner() or ac.player(ac.player.self.id)
	local hero = p.hero
	ac.game:event_notify('技能-删除魔法书',hero,'精彩活动',str or '有趣的灵魂')
	
end	
--创建 魔兽自带兵
function helper:u1()
	local point = ac.map.rects['出生点']
	local x,y = point:get()
	local handle = jass.CreateUnit(ac.player(1).handle, base.string2id('u002'), x, y,0)
end	
--创建 英萌兵
function helper:u2()
	local point = ac.map.rects['出生点']
	ac.player(1):create_unit('甲虫',point)
end	

--测试 魔法书功能
function helper:t_dummy()
	local p = self and self:get_owner() or ac.player(ac.player.self.id)
	local hero = p.hero
	local u = p:create_dummy('e001',ac.point(0,0))
	print(u:get_class())

end	

--打印hero键值对应的key值
function helper:print_hero()
	for i = 1,10 do 
        local player = ac.player(i)
        local hero = player.hero
        if hero and hero:is_alive() then 
           print(player,hero,hero:is_alive())
        end 
    end 

end
--添加漂浮文字称号
function helper:add_ch(str,zoffset)
	if self.ch then 
		self.ch:remove()
	end	
	self.ch = ac.nick_name(str,self,zoffset)
end

--添加技能羁绊
function helper:add_skill_suit()
	ac.item.add_skill_item('财富',self)
	ac.item.add_skill_item('贪婪者的心愿',self)
	ac.item.add_skill_item('凰燃天成',self)
	ac.item.add_skill_item('龙凤佛杀',self)
end

function helper:never_dead(flag)
	if flag == nil then
		flag = true
	end
	if flag then
		self:add_restriction '免死'
	else
		self:remove_restriction '免死'
	end
end

ac.test_unit ={}
function helper:cr1()
	-- if str =='1' then 
		for i=1,500 do
			local u = ac.player(16):create_unit('金币怪',ac.point(100,200))
			u:set('生命上限',20000000)
			u:set('移动速度',300)
			ac.test_unit[u] = true
		end
	-- end	
	-- print(1111111111111111111111111111111111111)
end
function helper:cr2()
	for u in pairs(ac.test_unit) do
		print(u.handle,u,math.random(100000))
		-- u:remove()
		-- ac.test_unit[u] = false
	end	
end

function helper:cr3()
	-- if str =='1' then 
		for i=1,500 do
			local k = {id = i }
			dbg.gchash(k,i)
			k.gchash = i
			ac.test_unit[k] = i 
		end	
	-- end	
	-- print(1111111111111111111111111111111111111)
end
function helper:cr4()
	for k,v in pairs(ac.test_unit) do
		print(k.id)
	end	
end


--设置昼夜模型
function helper:light(type)
	local light = {
		'Ashenvale',
		'Dalaran',
		'Dungeon',
		'Felwood',
		'Lordaeron',
		'Underground',
	}
	if not tonumber(type) or tonumber(type) > #light or tonumber(type) < 1 then
		return
	end
	local name = light[tonumber(type)]
	jass.SetDayNightModels(([[Environment\DNC\DNC%s\DNC%sTerrain\DNC%sTerrain.mdx]]):format(name, name, name), ([[Environment\DNC\DNC%s\DNC%sUnit\DNC%sUnit.mdx]]):format(name, name, name))
end

function helper:sha1(name)
	local storm = require 'jass.storm'
	local rsa = require 'util.rsa'
	local file = storm.load(name)
	local sign = rsa:get_sign(file)
	print(sign)
	storm.save('我的英雄不可能那么萌\\sign.txt', sign)
end

local show_message = false
function helper:show_message()
    show_message = not show_message
end

local function message(obj, ...)
    local n = select('#', ...)
    local arg = {...}
    for i = 1, n do
        arg[i] = tostring(arg[i])
    end
    local str = table.concat(arg, '\t')
    print(obj, '-->', str)
    if show_message then
        for i = 1, 12 do
            ac.player(i):sendMsg(str)
        end
    end
end

local function call_method(obj, cmd)
    local f = obj[cmd[1]]
    if type(f) == 'function' then
        for i = 2, #cmd do
            local v = cmd[i]
            v = tonumber(v) or v
            if v == 'true' then
                v = true
            elseif v == 'false' then
                v = false
            end
            cmd[i] = v
        end
        local rs = {xpcall(f, error_handle, obj, table.unpack(cmd, 2))}
        message(obj, table.unpack(rs, 2))
    else
        message(obj, f)
    end
end

function helper:player(cmd)
    table.remove(cmd, 1)
    call_method(self:get_owner(), cmd)
end


--测试副本
function helper:fb(str)
	for i=1,3 do 
		local creep = ac.creep['刷怪'..i]
		creep.index = tonumber(str) - 1
		if creep.has_started  then 
			creep:next()
		else
			creep:start()
		end		
	end	
end
--测试副本
function helper:wj(str)
	for i=1,3 do 
		local creep = ac.creep['刷怪'..i]
		if creep then 
			creep:finish()
		end	
	end	
	for i=1,3 do 
		local creep = ac.creep['刷怪-无尽'..i]
		creep.index = tonumber(str) - 1
		if creep.timerdialog then 
			creep.timerdialog:remove()
			creep.timerdialog = nil
		end	
		if creep.has_started  then 
			creep:next()
		else
			creep:start()
		end		
	end	
end
--测试商店
function helper:cs()
 --调整镜头锁定区域
	for i = 1,60 do
		xpcall(function ()
			local shop5 = ac.shop.create('图书馆',0,0,270)
		end,runtime.error_handle)
	end
end

local function main()
	ac.game:event '玩家-聊天' (function(self, player, str)
        if str:sub(1, 1) ~= '-' and str:sub(1, 1) ~= '.' then
            return
        end
		local hero = player.hero
		local strs = {}
		for s in str:gmatch '%S+' do
			table.insert(strs, s)
		end
		local str = strs[1]:sub(2)
        strs[1] = str
		print(str)

		if type(helper[str]) == 'function' then
			xpcall(helper[str], error_handle, hero, table.unpack(strs, 2))
            return
		end
		if hero then
			call_method(hero, strs)
            return
		end
	end)

	--按下ESC来重载脚本
	ac.game:event '按下ESC' (function(trg)
		--helper.reload(data.player)
	end)
end

main()
