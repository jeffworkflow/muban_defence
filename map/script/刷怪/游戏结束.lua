local player = require 'ac.player'
local mover = require 'types.mover'
local jass = require 'jass.common'

ac.game.challenge_cnt = 1

-- 同一时间 全部玩家死亡，游戏失败
ac.game:event '游戏-开始' (function()
	print('游戏开始8')
	for i = 1 ,10 do 
		local hero = ac.player(i).hero
		if hero then 
			hero.all_die_trg = hero:event '单位-死亡' (function()
				--标准模式下 1 标准模式
				if ac.g_game_mode and ac.g_game_mode ~= 1 then 
					return
				end	
				--获取死亡人数
				local dead_count = get_dead_count()
				--获取在线人数
				local player_count = get_player_count()
				if dead_count >= player_count then 
					ac.game.challenge_cnt = ac.game.challenge_cnt - 1	
					if ac.game.challenge_cnt < 0 then 
						ac.game:event_notify('游戏-结束') --失败
					else
						ac.player.self:sendMsg('|cff00ffff【系统消息】全部玩家死亡，剩余额外 |r|cffff0000'..ac.game.challenge_cnt..'|r'..' |cff00ffff挑战次数,务必小心中央boss倒计时结束造成80%伤害|r',10)
						ac.player.self:sendMsg('|cff00ffff【系统消息】全部玩家死亡，剩余额外 |r|cffff0000'..ac.game.challenge_cnt..'|r'..' |cff00ffff挑战次数,务必小心中央boss倒计时结束造成80%伤害|r',10)
						ac.player.self:sendMsg('|cff00ffff【系统消息】全部玩家死亡，剩余额外 |r|cffff0000'..ac.game.challenge_cnt..'|r'..' |cff00ffff挑战次数,务必小心中央boss倒计时结束造成80%伤害|r',10)
					end	
				end	
			end);
		end
	end
	print('游戏开始9')
end);
--进入 无尽 改变游戏结束的触发
ac.game:event '游戏-无尽开始' (function()
	print('进入无尽啦')
	--先移除
	-- for i = 1 ,10 do 
	-- 	local hero = ac.player(i).hero
	-- 	if hero and hero.all_die_trg then 
	-- 		hero.all_die_trg:remove()
	-- 	end
	-- end	
	
end)

--基地爆炸的时候结算胜负
ac.game:event '游戏-结束' (function(trg,flag)

	local name 
	if flag then 
		name = '【游戏胜利】'
		ac.player.self:sendMsg("【游戏胜利】")
		ac.player.self:sendMsg("【游戏胜利】")
		ac.player.self:sendMsg("【游戏胜利】")
	else
		name = '【游戏失败】'
		ac.player.self:sendMsg("【游戏失败】")
		ac.player.self:sendMsg("【游戏失败】")
		ac.player.self:sendMsg("【游戏失败】")
	end	
	ac.wait(4000,function()
        for i=1,8 do
            local player = ac.player[i]
            if player:is_player() then
                CustomDefeatBJ(player.handle,name)
                -- player.hero:add_restriction('无敌')
                -- player.hero:add_restriction('缴械')
                -- player.hero:add_restriction('定身')
            end
        end
    end)
	--停止刷兵
	-- if ac.creep['刷怪'] and ac.creep['刷怪'].finish then 
	-- 	ac.creep['刷怪']:finish()
	-- end	
	--聚集地
	local point = ac.map['刷怪中心点']	
	--停止运动
	local group = {}
	for mvr in pairs(mover.mover_group) do
		mvr.mover:set_animation_speed(0)
		mvr.hit_area = nil
		mvr.distance = 99999999
		table.insert(group, mvr.mover)
	end

	for _, u in ac.selector()
		: ipairs()
	do
		--暂停所有单位
		u:add_restriction '硬直'
		--所有单位无敌
		u:add_restriction '无敌'
		--停止动画
		u:set_animation_speed(0)
		if not u:has_restriction '禁锢' then
			table.insert(group, u)
		end
	end
	local u = point
	local dummy = player[16]:create_dummy('e003', u)
	local eff = dummy:add_effect('origin', [[blackholespell.mdl]])
	local dummy2 = player[16]:create_dummy('e003', u)
	local eff2 = dummy2:add_effect('origin', [[void.mdl]])
	local dummy3 = player[16]:create_dummy('e003', u)
	local eff3 = dummy3:add_effect('origin', [[shadowwell.mdl]])
	local dummy4 = player[16]:create_dummy('e003', u)
	local eff4 = dummy4:add_effect('origin', [[shadowwell.mdl]])
	local time =4
	dummy:add_buff '缩放'
	{
		time = 6,
		origin_size = 0.1,
		target_size = 2,
	}
	dummy2:add_buff '缩放'
	{
		time = time,
		origin_size = 0.1,
		target_size = 3,
	}
	dummy3:add_buff '缩放'
	{
		time = time,
		origin_size = 0.1,
		target_size = 5,
	}
	dummy4:add_buff '缩放'
	{
		time = time,
		origin_size = 0.1,
		target_size = 5,
	}
	--dummy:set_size(5)

	--地图全亮
	jass.FogEnable(false)
	
	--镜头动画
	local p = player.self
	p:setCamera(u:get_point() + {0, 300}, 1.5)
	p:hideInterface(1.5)

	local t = ac.wait(10 * 1000, function()
		p:showInterface(1.5)
		eff:remove()
		eff2:remove()
		eff3:remove()
		eff4:remove()
	end)

	--吸进去
	local p0 = u:get_point()
	local n = #group
	for _, u in ipairs(group) do
		local mvr = ac.mover.target
		{
			source = u,
			mover = u,
			super = true,
			speed = 0,
			target = p0,
			target_high = 425,
			accel = 1000,
			skill = false,
		}

		if not mvr then
			n = n - 1
		else
			function mvr:on_remove()
				u:kill()
				u:add_restriction '阿卡林'
				u:add_buff '淡化'
				{
					time = 2,
					remove_when_hit = not u:is_hero(),
				}
				n = n - 1
				if n <= 0 and t then
					p:showInterface(1)
					eff:remove()
					eff2:remove()
					eff3:remove()
					eff4:remove()
					t:remove()
					t = nil
				end
			end
		end
	end

	-- 删掉事件分法
	function ac.event_dispatch()
	end

	function ac.event_notify()
	end
end)
