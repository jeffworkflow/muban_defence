local player = require 'ac.player'
local mover = require 'types.mover'
local jass = require 'jass.common'

--基地爆炸的时候结算胜负
ac.game:event '游戏-结束' (function(trg,flag)

	if flag then 
		ac.player.self:sendMsg("【游戏胜利】")
		ac.player.self:sendMsg("【游戏胜利】")
		ac.player.self:sendMsg("【游戏胜利】")
	else
		ac.player.self:sendMsg("【游戏失败】")
		ac.player.self:sendMsg("【游戏失败】")
		ac.player.self:sendMsg("【游戏失败】")
	end	

	--停止刷兵
	-- if ac.creep['刷怪'] and ac.creep['刷怪'].finish then 
	-- 	ac.creep['刷怪']:finish()
	-- end	

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
	local u = ac.point(0,0)
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
