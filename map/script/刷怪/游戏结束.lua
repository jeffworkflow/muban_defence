local player = require 'ac.player'
local mover = require 'types.mover'
local jass = require 'jass.common'
--额外次数
ac.game.challenge_cnt = 0

ac.game:event '单位-死亡' (function(_,unit,killer)
	if unit:get_name() ~= '基地' then 
		return 
	end	
	print('基地死亡：',unit:get_name(),killer:get_name())
	ac.game.challenge_cnt = ac.game.challenge_cnt - 1	
	if ac.game.challenge_cnt < 0 then 
		ac.game:event_notify('游戏-结束') --失败
	else
		ac.player.self:sendMsg('|cff00ffff【系统消息】基地死亡，剩余额外 |r|cffff0000'..ac.game.challenge_cnt..'|r'..' |cff00ffff挑战次数,务必小心中央boss倒计时结束造成80%伤害|r',10)
		ac.player.self:sendMsg('|cff00ffff【系统消息】基地死亡，剩余额外 |r|cffff0000'..ac.game.challenge_cnt..'|r'..' |cff00ffff挑战次数,务必小心中央boss倒计时结束造成80%伤害|r',10)
		ac.player.self:sendMsg('|cff00ffff【系统消息】基地死亡，剩余额外 |r|cffff0000'..ac.game.challenge_cnt..'|r'..' |cff00ffff挑战次数,务必小心中央boss倒计时结束造成80%伤害|r',10)
	end	
end)	

--每秒判断无尽怪的累计数量
ac.game:event '游戏-无尽开始'(function(trg) 
	ac.loop(2*1000,function(t)
		local unit_cnt =0
		local max_cnt = 150
		for i=1,3 do 
			local crep = ac.creep['刷怪-无尽'..i]
			unit_cnt = unit_cnt + crep.current_count
		end	
		ac.unit_cnt = unit_cnt
		if unit_cnt >= max_cnt * 0.5 then 
			ac.player.self:sendMsg("【系统提示】当前怪物存活过多，还剩 |cffE51C23 "..(max_cnt - unit_cnt).." 只|r 游戏结束，请及时清怪",3)
		end	
		if unit_cnt >= max_cnt then 
			t:remove()
			ac.game:event_notify('游戏-结束')
			for i=1,3 do 
				local crep = ac.creep['刷怪-无尽'..i]
				crep:finish()
			end	
		end    
	end)
end)	


--基地爆炸的时候结算胜负
ac.game:event '游戏-结束' (function(trg,flag)

	local name 
	if flag then 
		name = '【游戏胜利】'
		ac.player.self:sendMsg("【游戏胜利】|cff00ff00请尽快挑战神龙 |cffff00005分钟后游戏结束|r")
		ac.timer_ex
        {
            time = 300,
            title = "游戏结束倒计时",
            func = function ()
                EndGame(true)
            end,
        }
		return 
	else
		name = '【游戏失败】'
		ac.player.self:sendMsg("【游戏失败】")
		ac.player.self:sendMsg("【游戏失败】")
		ac.player.self:sendMsg("【游戏失败】")
		ac.wait(30*1000,function()
			EndGame(true)
		end)
	end	
	ac.wait(3000,function()
		panel = class.hero_info_panel.get_instance()
		panel:show()
        for i=1,8 do
            local player = ac.player[i]
            if player:is_player() then
                player.hero:add_restriction('无敌')
                player.hero:add_restriction('缴械')
                player.hero:add_restriction('定身')
                CustomDefeatBJ(player.handle,name)
            end
        end
    end)
	--停止刷兵
	for i=1,3 do 
		if ac.creep['刷怪'..i] and ac.creep['刷怪'..i].finish then 
			ac.creep['刷怪'..i]:finish()
		end	
	end	
	--停止吸怪
	-- if global_test then 
	-- 	return 
	-- end	 
	--聚集地
	local point = ac.map.rects['游戏结束']	
	--停止运动
	local group = {}
	for mvr in pairs(mover.mover_group) do
		-- mvr.mover:set_animation_speed(0)
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
	local time = 2.5 --动画时间
	p:setCamera(u:get_point() + {0, 300}, time)
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



--基地爆炸的时候结算胜负
ac.game:event '游戏-大胜利' (function(trg)

	ac.player.self:sendMsg("|cffffe799【系统消息】|r120秒后自动退出游戏")

	ac.wait(120*1000,function()
		EndGame(true)
	end)

end)