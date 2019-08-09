local player = require 'ac.player'
local fogmodifier = require 'types.fogmodifier'
local hero = require 'types.hero'
local game = require 'types.game'
local jass = require 'jass.common'
local japi = require 'jass.japi'
local slk = require 'jass.slk'
local rect = require 'types.rect'
local multiboard = require 'types.multiboard'

--加载预览技能
require '英雄.skills'

local hero_types = {}
-- local cent = rect.j_rect('choose_hero'):get_point() or ac.point(-3000,3000)
local target_angle
local skip
local radius
local last_target
local map = ac.map

--多面板
local mb = nil
local flygroup = {}
local function DEKAN_flyfunction(hero)
	hero:set_high(2*(math.sin(0.7*hero.DEKAN_flyheight_X)+1) + hero.DEKAN_flyheight_base)
end

local function lookAtHero(p, hero, is_skip)
	if p == player.self then
		target_angle = hero:get_facing() + 180
		if is_skip then
			last_target = hero:get_point()
		end
		skip = is_skip
	end
end

--初始化英雄属性
local function setHeroState(u)
	local hero = u
	for i = 1, 4 do
		local skl = hero:add_skill('预览技能' .. i, '预览', i)
		-- print(skl,skl:get_name())
	end
end

local function random(a, b)
	return a + math.floor(ac.clock() / 17) % (b - a + 1)
end

local function show_animation(u)
	local hero_name = u:get_name()
	local hero_data = hero.hero_list[hero_name].data
	local hero = u
	if hero_data.show_animation then
		if type(hero_data.show_animation) == 'table' then
			hero:set_animation(hero_data.show_animation[random(1, #hero_data.show_animation)])
		else
			hero:set_animation(hero_data.show_animation)
		end
	else
		hero:set_animation('spell channel')
	end
end

--显示英雄属性
local function showHeroState(p, u)
	local hero_name = u:get_name()
	local hero_data = hero.hero_list[hero_name].data
	local hero = u

	local tip = [[]]
	local value = (ac.player.self.hero_xp and ac.player.self.hero_xp[hero_name] or 0)
	local tip2 =hero_data.got_tip or ''
	
	local difficulty_level = {
		'|cffffaaaa★|r|cffeeeeee☆☆☆☆☆|r',
		'|cffff8888★★|r|cffeeeeee☆☆☆☆|r',
		'|cffff6666★★★|r|cffeeeeee☆☆☆|r',
		'|cffff4444★★★★|r|cffeeeeee☆☆|r',
		'|cffff2222★★★★★|r|cffeeeeee☆|r',
		'|cffff0000★★★★★★|r|cffeeeeee|r',
	}
	local difficulty_tip = '|cffffcc11【生存】 ' .. difficulty_level[hero_data.survival_lv or 1]..'\n'
	difficulty_tip = difficulty_tip ..'|cffffcc11【攻击】 ' .. difficulty_level[hero_data.attack_lv or 1]..'\n'
	difficulty_tip = difficulty_tip ..'|cffffcc11【成长】 ' .. difficulty_level[hero_data.grow_lv or 1]..'\n'
	difficulty_tip = difficulty_tip ..'|cffffcc11【操作】 ' .. difficulty_level[hero_data.diff_lv or 1]..'\n'


	p:sendMsg(difficulty_tip .. '\n' .. tip:gsub('%%(.-)%%', function(name)
		local data = hero_data
		for path in name:gmatch '[^%.]+' do
			data = data[path]
		end
		return data
	end)..tip2, 60)
	--刷新技能说明
	if p == ac.player.self then
		for i = 1, 4 do
			local skl = hero:find_skill('预览技能' .. i, '预览', true)
			if i == 4 then 
				
			else
				local dest = hero_data.skill_datas[i]
				if dest then
					-- print(dest)
					-- print(dest:get_tip(hero, 0, true))
					skl:set_tip(dest:get_tip(hero, 0, true))
					skl:set_title(dest:get_title(hero, 0, true))
					skl:set_art(dest.art)
				end	
			end	
		end
	end
end

--等待选人完成
local function start()
	--在选人区创建英雄
	local cent	= map.rects['选人区域']:get_point()
	local minx, miny, maxx, maxy = map.rects['选人区域']:get()
	local area = 250
    local ix,iy = 0,0
	local rowx = math.floor((maxx-minx ) / area)
	local rowy = math.floor((maxy-miny ) / area)
	-- local r		= 360 / hero.hero_count
	-- radius		= math.sqrt(hero.hero_count - 1) * 120

	-- print(minx, miny, maxx, maxy)
	for i, name in ipairs(hero.hero_list) do
		ac.wait(i*200,function() 
			
			local shadow01 = jass.CreateImage([[ReplaceableTextures\CommandButtons\BTNPeasant.blp]], 1, 1, 1, 0, 0, 0, 0, 0, 0, 2)
			local shadow02 = jass.CreateImage([[ReplaceableTextures\CommandButtons\BTNPeasant.blp]], 1, 1, 1, 0, 0, 0, 0, 0, 0, 2)
			jass.DestroyImage(shadow01)
			jass.DestroyImage(shadow02)

			if ix > rowx   then 
				--print(i,ix,iy)
				iy = iy + 1 
				ix = 0
			end    
			local x = minx + area * ix +75
			local y = miny + area* iy +150
			local where = ac.point(x,y)
			ix = ix + 1 
			--创建特效
			if name ~='' then 
				local name, hero_data = name,hero.hero_list[name].data
				ac.effect(where,[[xrdh.mdx]],270,1,'origin'):remove()
				local hero = player[16]:createHero(name, where,270)
				--添加淡化buff
				-- hero:add_buff '淡化*改'
				-- {
				-- 	source_alpha = 0,
				-- 	target_alpha = 100,
				-- 	time = 0.4,
				-- 	remove_when_hit = false,
				-- }
				hero.name = name
				hero:remove_ability 'Amov'
				hero:add_restriction '缴械'
				hero:add_restriction '无敌'
				hero:set_data('英雄类型', name)
				setHeroState(hero)
				jass.DestroyImage(shadow01)

				hero:add_effect('origin',[[modeldekan\ui\DEKAN_Tag_Ally.mdl]])
				hero_types[name] = hero
			end
		end)
	end
	-- ac.game.hero_lists = flygroup
	-- ac.wait(#hero.hero_list*200,function()
	-- end)

	
	for i = 1, 10 do
		local p = player[i]
		--在选人区域创建可见度修整器(对每个玩家,永久)
		fogmodifier.create(p, map.rects['选人区域'])
		--设置镜头属性
		p:setCameraField('CAMERA_FIELD_TARGET_DISTANCE', 2000)
		local minx, miny, maxx, maxy = ac.map.rects['选人区域']:get()
		p:setCameraBounds(minx+900, miny+900, maxx-900, maxy-900)  --创建镜头区域大小，在地图上为固定区域大小，无法超出。
		-- p:setCameraBounds('xr')  --创建镜头区域大小，在地图上为固定区域大小，无法超出。
		p:setCamera(map.rects['选人区域'])
		--禁止框选
		p:disableDragSelect()
	end

	

	local player_hero_count = 0

	--注册事件
	local select_unit_trg = ac.game:event '玩家-选择单位' (function(self, p, hero)

		if not p.hero and hero_types[hero:get_data '英雄类型'] == hero then
			p:clearMsg()
			--记录英雄类型
			local hero_name = hero:get_data '英雄类型'
			local current_time = ac.clock()
			if p.last_select_hero_name ~= hero_name
			or not p.last_select_hero_time
			or current_time - p.last_select_hero_time > 1000 then
				if p.last_select_hero then
					p.last_select_hero:set_animation('stand')
				end
				show_animation(hero)
				p.last_select_hero_time = current_time
				p.last_select_hero_name = hero_name
				p.last_select_hero = hero
				p:sendMsg(('双击选择 |cffffcc00%s|r !'):format(hero_name))
				-- lookAtHero(p, hero)
				showHeroState(p, hero)
				return
			else
				show_animation(hero)
			end
			-- print(hero_name,p.mall[hero_name])
			local has_mall = ( p.mall and  p.mall[hero_name] )or (p.cus_server and p.cus_server[hero_name])
			-- print(hero_name,ac.server.need_map_level[hero_name])
			if (has_mall and has_mall > 0)
			--    and p:Map_GetMapLevel() >= (ac.server.need_map_level[hero_name] or 0)) 
			   or finds(hero_name,'剑圣','吉安娜','大地','希尔瓦娜斯','炼金术士','阿尔塞斯')
			--    and p.flag_get_map_test
			then 
				p:event_notify('玩家-选择英雄', p, hero_name)
			else	
				p:sendMsg('|cffFFCC00没资格选! |r')
			end
		end
	end)

	local random_hero_trg = ac.game:event '玩家-聊天' (function(self, player, str)
		if str ~= '-random' then
			return
		end
		if player.hero then
			return
		end
		-- local list = {}
		-- for name, _ in sortpairs(hero_types) do
		-- 	if name ~= '金木研' and name ~= '更木剑八' then
		-- 		table.insert(list, name)
		-- 	end
		-- end
		player:event_notify('玩家-选择英雄', player, hero_types[math.random(1, #hero_types)])
	end)

	ac.game:event '玩家-选择英雄' (function(self, p, hero_name)
		if not p.hero and hero_types[hero_name] then
			p:clearMsg()
			-- local hero = hero_types[hero_name]
			---- 移除选人区马甲
			-- hero_types[hero_name] = nil
			-- hero:setAlpha(50)
			-- hero:set_class '马甲'
	
			--等待初始化
			p:hideInterface(1)
			--创建英雄给选择者
			local pnt	= map.rects['选人出生点']:get_point()
			-- local r		= 360 / 5 * p:get()
			p.hero = p:createHero(hero_name, pnt, 270)
	
			player_hero_count = player_hero_count + 1
			p:event_notify('玩家-注册英雄', p, p.hero)
			p:event_notify('玩家-注册英雄后', p, p.hero)

			local minx, miny, maxx, maxy = ac.map_area:get()
			p:setCameraBounds(minx, miny, maxx, maxy)  --创建镜头区域大小，在地图上为固定区域大小，无法超出。
			-- p:setCameraBounds('sg001')
			--把镜头移动过去
	
			--敌我识别特效
			p.hero:add_enemy_tag()
			
			ac.wait(1000, function()
				p:setCamera(p.hero)
				p:setCameraField('CAMERA_FIELD_TARGET_DISTANCE', 1000)
				p:setCameraField('CAMERA_FIELD_ANGLE_OF_ATTACK', 304)
				p:setCameraField('CAMERA_FIELD_ZOFFSET', 0)
				p:setCameraField('CAMERA_FIELD_ROTATION', 90)
				p:showInterface(1)
				--镜头动画
				p:setCameraField('CAMERA_FIELD_TARGET_DISTANCE', 2000, 1)
				p:setCameraBounds(minx-400, miny-400, maxx+400, maxy+400)  --创建镜头区域大小，在地图上为固定区域大小，无法超出。
	
				--允许框选
				p:enableDragSelect()
				
				--选中英雄
				p:selectUnit(p.hero)
	
				--强制镜头高度
				ac.wait(1000, function()
					p.camera_high = 2000
				end)
			end)
		end
	
		--检查是否还有人没选英雄
		for i = 1, 10 do
			local p = player[i]
			if p:is_player() and not p.hero then
				return
			end
		end

		select_unit_trg:remove()
		random_hero_trg:remove()
	end)

	local has_started = false
	local function f(obj,player)
		--检查是否还有人没选英雄
		--玩家离线时还没选英雄，玩家离线时已选英雄。
		print('检查是否还有人没选英雄',obj.type,player ,ac.clock())
		local flag = true
		if player then 
			for i = 1, 10 do
				local p = ac.player[i]
				if p:is_player() and not p.hero and p ~= player  then --不检查自己
					flag = false
					-- print('标识1',flag)
				end
			end
		end	
		-- print('标识2',flag)

		if obj.type == 'timer' or flag then
			if not has_started then
				has_started = true
				--移除所有英雄
				-- ac.wait(2*1000,function()
				for name,unit in sortpairs(hero_types) do 
					unit:remove()
					unit = nil 
					hero_types[name] = nil 
				end	
				-- end)
			end
		end

		if flag then
			obj:remove()
		end
	end
	
	ac.game:event '玩家-注册英雄后' (f)
	ac.game:event '玩家-离开' (f)
	ac.wait(120*1000, f)
end

ac.choose_hero = start