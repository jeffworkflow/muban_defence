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


--测试合成
function helper:test_hc()
	for i=1,1000 do 
		self:add_item('超级扭蛋(百连抽)')
	end
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
function helper:move(flag)
	local data = self:get_owner():getCamera()

	if flag then 
		local rct = ac.rect.create(-200,-200,200,200)
		local point = ac.point(-300,0)
		self:blink(point, true)
		self:add_restriction '飞行'
	else
		self:get_owner():sync(data, function(data)
			self:blink(ac.point(data[1], data[2]), true)
		end)
	end
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
	-- for n=1,#ac.mall do
	-- 	local need_map_level = ac.mall[n][3] or 999999999999
	-- 	-- print(ac.mall[n][1],need_map_level)
	-- 	if     (p:Map_HasMallItem(ac.mall[n][1]) 
	-- 		or (p:Map_GetServerValue(ac.mall[n][1]) == '1') 
	-- 		or (p:Map_GetMapLevel() >= need_map_level) 
	-- 		or (p.cheating)) 
	-- 	then
	-- 		local key = ac.mall[n][2]  
	-- 		p.mall[key] = 1  
	-- 	end  
	-- end    
end

--允许控制所有单位
function helper:god()
	--允许控制中立被动的单位
	local player = self.owner
	local p = self.owner
	for y = 1,16 do
		player:enableControl(ac.player(y))
	end	
	for i=1,12 do 
		local p = ac.player(i)
		p:add_wood(100000000)
		p:addGold(700000)
		p:add_rec_ex(7000000)
	end
	if ac.main_unit then 
		ac.main_unit:add_buff '无敌'{}
	end
	local minx, miny, maxx, maxy = ac.map_area:get()
	p:setCameraBounds(minx, miny, maxx, maxy)  --创建镜头区域大小，在地图上为固定区域大小，无法超出。
end	
function helper:reload_mall(flag)
	local p = self and self:get_owner() or ac.player(ac.player.self.id) 
	local peon = p.peon
	--先初始化地图等级
	ac.init_map_level()
	--挖宝熟练度在读取存档数据后就赋值。
	p:event_notify '读取存档数据'

	local skl = self:find_skill('最强魔灵')
	if skl then skl:remove() end
	self:add_skill('最强魔灵','英雄',12)	
	
	local skl = peon:find_skill('宠物纪念册')
	if skl then skl:remove() end
	peon:add_skill('宠物纪念册','英雄',12)

	local skl = peon:find_skill('宠物技能')
	if skl then skl:remove() end
	peon:add_skill('宠物技能','英雄',8)

	--宠物重载身上技能
	if p:Map_GetMapLevel() >= 3 then 
		local skl = peon:find_skill('一键合成')
		if skl then skl:remove() end
		peon:add_skill('一键合成','英雄',6)
		
		local skl = peon:find_skill('一键丢弃')
		if skl then skl:remove() end
		peon:add_skill('一键丢弃','英雄',7)
		
		local skl = peon:find_skill('一键分类')
		if skl then skl:remove() end
		peon:add_skill('一键分类','英雄',10)
    end

	--重载 一键神魂修炼
	-- if p and p:Map_GetMapLevel() >=3 then 
    --     shop:add_skill('一键修炼','英雄',4)
    -- end
end	


--服务器存档 保存 
function helper:save(key,value)
	local p = self and self:get_owner() or ac.player(ac.player.self.id)
	-- p:SetServerValue(key,tonumber(value) or 1) 自定义服务器
	if not key then 
		for i,data in ipairs(ac.cus_server_key) do 
			local key = data[1]
			p:Map_SaveServerValue(key,tonumber(value) or nil) --网易服务器
		end		
	elseif key == 'qd' then 	
		p:SetServerValue(key,tonumber(value) or nil) --自定义服务器
	else
		p:Map_SaveServerValue(key,tonumber(value) or nil) --网易服务器
	end	
end	

--服务器存档 读取 
function helper:get_server(key)
	local p = self and self:get_owner() or ac.player(ac.player.self.id)
	if key == 'all' then 
		for name,val in pairs(p.cus_server) do
			local key = ac.server.name2key(name)
			print('服务器存档:'..key,p:Map_GetServerValue(key))
			print('自定义服务器存档:'..key,p.cus_server[name])
			print('游戏中存档:',key,p.cus_server[name])
		end
	else		
		local name = ac.server.key2name(key)	
		print('服务器存档:'..key,p:Map_GetServerValue(key))
		print('自定义服务器存档:'..key,p.cus_server[name])
		print('游戏中存档:'..key,p.cus_server[name])
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


--伤害自己
function helper:damage(damage)
	self:damage
	{
		source = self,
		damage = damage,
		skill = false,
	}
end


function helper:hotfix()
	require('types.hot_fix').main(self:get_owner())
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
	-- if not ac.wtf then
	-- 	helper.wtf(self)
	-- end
	local player = self:get_owner()
	self:add_restriction '免死'
	player:addGold(599999)
	player:add_wood(599999)
	player:add_kill_count(599999)
	player:add_rec_ex(599999)
end

--强制游戏结束
function helper:over(flag)
	ac.game:event_notify('游戏-结束',flag)
end
--强制游戏结束
function helper:add_restriction(str)
	self:add_restriction(str)
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
	local data = ac.table.UnitData[str]
	if not data  then 
		print('没有对应的物编数据')
		return 
	end
	local is_hero = data.unit_type == '英雄' 

	local p = ac.player[tonumber(playerid)]
	for i = 1 ,(cnt or 1) do
		local point = ac.map.rects['出生点']
		if is_hero then 
			local hero = p:createHero(str,point,270);
			p.hero = hero
			p:event_notify('玩家-注册英雄', p, p.hero)
		else  
			p:create_unit(str,point)
		end
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
function helper:add(key,cnt)
	-- local str = table.concat( ac.player_attr,' ' )
	if _in(key,ac.player_attr) then 
		self.owner:add(key,tonumber(cnt))
		print('玩家属性：',key,self.owner:get(key))
	else 
		self:add(key,tonumber(cnt))
		print('英雄属性：',key,self:get(key))
	end	

end
--读取 属性
function helper:get(key)
	if _in(key,ac.player_attr) then 
		print('玩家属性：',key,self.owner:get(key))
	else 
		print('英雄属性：',key,self:get(key),self['属性'][key],self['属性'][key..'%'])
	end	
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
function helper:remove_skill(str,type)
	local type = type or '英雄'
	local skill = self:find_skill(str,type,true)
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
function helper:add_item(str,cnt,flag)
	local cnt = cnt or 1
	for i=1,cnt do
		self:add_item(str,true,flag and self.owner)
	end	
end

function helper:create_item(str,cnt,flag)
	local cnt = cnt or 1
	for i=1,cnt do
		ac.item.create_item(str,self:get_point())
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
	local cnt = 1 
	local point = self:get_point()
	for i=1,cnt do 
		local unit = ac.player(12):create_unit('甲虫',point)
		unit:set('生命上限',100000000000000)
		unit:set('生命恢复',100000000000000)
		unit:set('护甲',10000)
		unit:set('攻击',0)
		unit:add_restriction '定身'
		unit:add_restriction '缴械'
		
		unit:add_restriction '免死'
		unit:set_size(2)
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

--测试 warning ring
function helper:eff(time)
	local hero =self
	local range = range or 200
	local type=  tonumber(type) or 1
	local time = time or 5
	for i=1,3 do 
		local type = i
		if type == 1 then 
			model = [[F2_model\warming_ring_red.mdl]]
		elseif type == 2 then  
			model =[[F2_model\warming_ring_red2.mdx]]
		else
			model = [[F2_model\warming_ring.mdl]]
		end
		ac.effect_ex{
			model = model,
			point = hero:get_point() - {0,(i-1)*400*5},
			size = 5,
			time = time,

			speed = 1/time 
		}
	end
end
--测试 warning ring
function helper:ring(type,range)
	local hero =self
	local range = range or 200
	local type=  tonumber(type) or 1
	if type == 1 then 
		ac.warning_effect_ring
		{
			point = hero:get_point(),
			area = range,
			time = 5,
		}
	elseif type ==2 then  
		ac.warning_effect_circle
		{
			point = hero:get_point(),
			area = range,
			time = 5,
		}
	else
		ac.warning_effect_rect
		{
			point = hero:get_point(),
			len = 100,
			wid = 200,
			angle = 0,
			time = 5,
		}
	end


end	



--进入地狱，7个光环
function helper:tt(flag)
	local function strong(hero)
		local self = hero
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
		self:add('全伤加深',10030000000)
		self:add('暴击伤害',1003000)
		self:add('攻击速度',500)
		self:add('攻击间隔',-1)
		self:add_restriction '免死'
		self:addGold(300000)
		self:add_kill_count(10000000)
		self:add_wood(10000000)
		self:add_rec_ex(10000000)
		helper.dtdj(self,60)
		helper.reload_mall(self)
	end

	if flag then 
		self:remove_restriction '免死'
		self:add('杀怪加全属性',-3000)
		-- self:add('攻击距离',2000)
		self:add('暴击几率',-90)
		self:add('会心几率',-90)
		self:add('多重射',-10)
		self:add('分裂伤害',-100)
		self:add('全属性',-10000000000)
		self:add('护甲',-1000000000)
		self:add('会心伤害',-10000000000)
		-- self.flag_dodge = true --突破极限
		self:add('全伤加深',-10030000000)
		self:add('暴击伤害',-1003000)
		self:add('攻击速度',-500)
		self:add('攻击间隔',1)
	else
		strong(self)
	end
	
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
function helper:fmi(num)
	local num = tonumber(num) or 1
	for i=1,num do 
		ac.fall_move{
			name = '新手剑',
			source = self:get_point()
		}
	end	
end	
--模糊添加技能
function helper:as(str,cnt)
	if not str or str =='' then 
		return 
	end	
	for i,data in pairs(ac.skill) do 
		if type(data) == 'table' then 
			if finds(data.name,str) then 
				for i=1,tonumber(cnt) or 1 do 
					ac.item.add_skill_item(data.name,self)
				end	
			end	
		end	
	end	
end

--模糊添加物品
function helper:ai(str,cnt)
	if not str or str =='' then 
		return 
	end	
	--优先添加品质物品
	if ac.quality_item and ac.quality_item[str] then 
		local name = ac.quality_item[str][math.random(#ac.quality_item[str])]
		for i=1,tonumber(cnt) or 1 do 
			self:add_item(name)
		end	
		return 
	end

	local ok 
	for name,data in pairs(ac.table.ItemData) do 
		if finds(name,str) and data.category ~='商品' then 
			ok = true
			for i=1,tonumber(cnt) or 1 do 
				self:add_item(name,true)
			end	
		end	
	end	
	if not ok then 
		for i,data in pairs(ac.skill) do 
			if type(data) == 'table' then 
				if finds(data.name,str) then 
					for i=1,tonumber(cnt) or 1 do 
						self:add_item(data.name,true)
					end	
				end	
			end	
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


function helper:point()
	local p = self.owner 
	p:pingMinimap(ac.point(0,0),3)
end

--测试 魔法书功能
function helper:test_b1(str,cnt)
	local p = self and self:get_owner() or ac.player(ac.player.self.id)
	local hero = p.hero
	local cnt = cnt or 1 
	for i=1,cnt do 
		ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',str or '有趣的灵魂')
	end

end	
function helper:test_b2(str)
	local p = self and self:get_owner() or ac.player(ac.player.self.id)
	local hero = p.hero
	ac.game:event_notify('技能-删除魔法书',hero,'精彩活动',str or '有趣的灵魂')
end	


function helper:test_b3(str)
	local p = self and self:get_owner() or ac.player(ac.player.self.id)
	local hero = p.hero
	ac.game:event_notify('技能-插入魔法书',hero,'吞噬神丹',str or '索利达尔之怒')
end	
function helper:test_i1()
	local type_id = 'I013'
	ac.test_nav = {}
	local x,y = self:get_point():get()
	for i=1,500 do 
		local a = jass.CreateItem(base.string2id(type_id),x,y)
		table.insert( ac.test_nav, a )
	end	
end	

function helper:test_i2(name)
	ac.test_nav = {}
	local x,y = self:get_point():get()
	for i=1,500 do 
		local a = ac.item.create_item(name,self:get_point())
		table.insert( ac.test_nav, a )
		-- a:item_remove()
	end	
end	

function helper:test_i3(str)
	local p = self and self:get_owner() or ac.player(ac.player.self.id)
	local hero = p.hero
	local it = self:add_item('真圣剑')
	for i=1,1000 do 
		self:event_dispatch('单位-合成装备', self, it) 
	end
end	

function helper:test_e1(name)
	local x,y = self:get_point():get()
	ac.test_eff = {}
	for i=1,500 do 
		local model = name =='暗影战斧' and [[File00000376 - W.mdx]] or ac.skill[name].specail_model or ac.skill['强化石'].specail_model
		local eff = ac.effect_ex{
			point = self:get_point(),
			model = model
		}
		--[[File00000376 - W.mdx]]
		table.insert( ac.test_eff, eff )
	end	
end	


function helper:test_c1()
	for i,handle in ipairs(ac.test_nav) do 
		jass.RemoveItem(handle)
	end	
end	

function helper:test_c2()
	for i,it in ipairs(ac.test_nav) do 
		it:item_remove()
		ac.test_nav[i] = nil
	end	
end	

function helper:test_ce1()
	for i,eff in ipairs(ac.test_eff) do 
		eff:remove()
		ac.test_eff[i] = nil
	end	
end	

function helper:test_s(num)
	for i=1,(tonumber(num) or 1000) do 
		self.owner:showSysWarning('物品栏已满')
	end
end	
--测试通行点
function helper:pp()
	local function add_block(where,fly)
		local x0,y0=where:get()
		for x = x0 - 64, x0 + 64, 32 do
			for y = y0 - 64, y0 + 64, 32 do
				jass.SetTerrainPathable(x, y, 1, false)
				if fly then
					jass.SetTerrainPathable(x, y, 2, false)
				end
			end
		end
	end
	--测试不可通行点
	local point = self:get_point()
	local distance = 200
	for i=1,12 do 
		local new_point = point -{(i-1)*30,distance}
		add_block(new_point,true)
		ac.effect_ex{
			point = new_point,
			model = [[File00000376 - W.mdx]]
		}
	end
    
end	
--测试血条
function helper:start()
	local self = ac.ui.damage 
	ac.ui.damage:show()
    ac.ui.damage.t_t = ac.loop(1000,function()
        for i,tab in ipairs(self.bg.player_damages) do 
            -- print(i,tab,temp,temp[i])
            -- tab:set_width(temp[i].rate/100*420)
            local rate = math.random(1,100)
            -- print('进度:',rate)
            --设置动画
            tab:set_process({
                handle = '伤害统计_背景',
				target = rate/100*420,
				time = 1,
                show = function(self,source)
                    --底层 黑色动画延迟
                    tab:set_width(source)
                    tab.img:set_width(self.target)
                end
			})
			
			local damage = math.random(1,10000000)
			ac.ui.damage.total_damage = (ac.ui.damage.total_damage or 0) + damage
            tab.img.player.damage:set_process({
                handle = '伤害统计_文字',
                target = damage,
                -- rate = temp[i].rate,
                show = function(self,source)
                    -- tab.player.damage:set_text((temp[i].color..'%s [%s%%]|r'):format(bn2str(temp[i].damage),temp[i].rate)) 
                    tab.img.player.damage:set_text(('%s [%s%%]|r'):format(  bn2str(source), string.format("%.f",(source / ac.ui.damage.total_damage * 100))))  
                end
            })
        end
    end)
end	

function helper:stop()
	local self = ac.ui.damage 
	if ac.ui.damage.t_t then 
		ac.ui.damage.t_t:remove()
		ac.ui.damage.t_t = nil
	end
end	
local npc = {'基地','第一幕·圣龙气运','第二幕·一个人的踢馆','第三幕·突破','第四幕·狩猎','第五幕·战就战','第六幕·魔神之路'}
local function get_random_point()
	local flag
	local point
	while not flag do 
		point = ac.map.rects['藏宝区']:get_random_point(true)
		for i,name in ipairs(npc) do 
			local where = ac.table.UnitData[name].where
			local npc_point = ac.rect.j_rect(where[1]) and ac.rect.j_rect(where[1]):get_point() 
			-- print(name,npc_point,point)
			if point:is_in_range(npc_point,150) then 
				-- print('点在npc周围',name,point,npc_point,point*npc_point)
				-- get_random_point()
				break
			else
				if i ==#npc then 
					flag = true
				end
			end
		end
	end
	return point
end

local ret1 = ac.rect.j_rect('cbt2')
local ret2 = ac.rect.j_rect('cbt3')
local region = ac.region.create(ret1,ret2)
function helper:cc()
	ac.loop(10,function()
		local point = region:get_point()
		print('藏宝区随机的点：',point)
		ac.effect_ex{
			-- model = 'wbdd.mdx',
			model = 'biaoji_gantanhao.mdx',
			point = point
		}
	end)
end	
function helper:mall(str)
	local str = string.upper(str)
	local name = ac.server.key2name(str)
	local p = self.owner
	p.mall[name] = 1
end	
function helper:test_sm()
	local rd= 0
	ac.loop(1000,function()
		for i=1,200 do 
		rd= rd + 1
		ac.player.self:sendMsg('|cffebb608【系统】|r 使用|cff00ff00藏宝图|r 什么事sdfadfewfewfwefwefwef情都没有发生 |cffffff00(挖宝熟练度+1，当前挖宝熟练度 '..rd..' )|r',2)
		end
	end)
end	
--测试播放背景音乐
function helper:sd()
	-- print('播放背景音乐:',ac.final_sound)
	-- jass.StartSound(ac.final_sound)
	--PlayMusic
	--SetMapMusic
	--PlayThematicMusic --播放主题音乐

	--会掉线 resource\yinyue1_11.wav
	if self.owner:is_self() then 
		jass.PlayThematicMusic([[resource\shouchao.mp3]])
	end


	-- for i=1,6 do 
	-- 	local p = ac.player(i)
	-- 	if p:is_player() then 
	-- 		if p:is_self() then 
	-- 			p:play_sound([[resource\yinyue1_11.wav]])
	-- 		end
	-- 	end
	-- end
end
--测试天选之人
function helper:ts2()
	local p = self.owner
	ac.game:event_notify('任务-圣龙气运',p) 
end
--测试 绝世神剑
function helper:ts3()
	local p = self.owner
	ac.check_txzr(true)
end
--测试双层字
function helper:test_sm_ui()
	local new_ui = class.panel:builder
	{
		x = 700,--假的
		y = 700,--假的
		w = 200,
		h = 50,
		level = 5,
		is_show = true,
		normal_image = '',
		
		title = {
			type = 'text',
			font_size = 15,
			level = 3,
			align = 'center',
            text = '开始' ,
			color = 0xffff0000,
			
		},
		shawdow = {
			x=1.5,
			y=1.5,
			type = 'text',
			level = 1,
			font_size = 15,
			align = 'center',
			text = '开始' ,
			color = 0xff000000,
		}
	}
end

--重改难度
function helper:degree(cnt)
	local cnt = tonumber(cnt)
	local list = {}
	--翻转
	for i=#ac.g_game_degree_list,1,-1 do 
		table.insert(list,ac.g_game_degree_list[i])
	end

	ac.g_game_degree = cnt
	ac.g_game_degree_attr = cnt
	ac.g_game_degree_name = list[cnt] or '没有'
	--多面板
	ac.game.multiboard:setTitle('【'..(ac.server_config and ac.server_config['map_name'] or '魔灵降世')..'】难度：'..(ac.g_game_degree_name or ''))
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

--test_print_all_unit
function helper:test_print()
	for handle,u in pairs(ac.unit.all_units) do 
		print(handle,u,u.handle,u.id,u:get_name(),u.unit_type,ac.unit.remove_handle_map[handle])
	end
end

--搜敌范围
function helper:set_range(distance)
	self:set_search_range(tonumber(distance))
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

--测试副本
function helper:mk(str,cnt)
	local creep = ac.creep['贪婪魔窟']
	creep.index = tonumber(str) - 1
	if creep.has_started  then 
		creep:next()
	else
		creep:start()
	end	
end

--测试副本
function helper:fb(str,cnt)
	local cnt = cnt or 1
	for x = 1,cnt do 
		for i=1,3 do 
			local creep = ac.creep['刷怪'..i]
			creep.index = tonumber(str) - 1
			if i==1 then 
				creep.timer_ex_title ='距离 第'..(creep.index+2)..'波 怪物进攻'
			end
			if creep.has_started  then 
				creep:next()
			else
				creep:start()
			end		
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

--测试加属性0 引起的玩家崩溃
function helper:attr()
	self:add('攻击减甲',5000)
	self:add('分裂伤害',100)
end
--测试加属性0 引起的玩家崩溃
function helper:test_sx()
	ac.loop(1000,function()
		print('开始测试',self)
		for i = 1,60 do
			--生命上限
			japi.SetUnitState(self.handle, jass.UNIT_STATE_MAX_LIFE, self:get('生命上限'))
			--攻击速度
			japi.SetUnitState(self.handle, jass.ConvertUnitState(0x51), 1+(self:get('攻击速度')/100))
			--魔法上限
			japi.SetUnitState(self.handle, jass.UNIT_STATE_MAX_MANA, self:get('魔法上限'))
		end
	end)
end

--测试玩家random 唯一值
function helper:rd()
	local p = self.owner
	for i=1,10 do 
		local it_name = p:random(ac.tm_item,true)
		print(it_name)
	end
end
local temp = {}
local timer 
local tags ={}
local last_unit
--用漂浮文字展示怪物属性
function helper:show(str,attr)
	local unit = ac.find_unit(str)
	if not unit then 
		unit = last_unit
		temp[str] = true
	end
	last_unit = unit

	if attr then 
		temp[attr] = true
	end
	if  timer then 
		return
	end
	timer = ac.loop(1000,function()
		for i,tag in ipairs(tags) do 
			tag:remove()
			tags[i] = nil
		end
		local i = 0
		for key in pairs(temp) do 
			local str = key..' : '..unit:get(key)
			-- if not tags[key] then
			-- 	tags[key] = ac.nick_name(str,unit,i*50,100,i*50,10)
			-- else
			-- 	tags[key]:setText(str)
			-- end
			-- print('z,x,y:',i*50,100,i*50)
			local tag = ac.nick_name(str,unit,i*50,100,i*50,10)
			table.insert(tags,tag)
			i = i + 1
		end
	end)
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
		--modify by jeff 默认给选中的单位 添加对应的数据
		hero = player.selected or hero
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
