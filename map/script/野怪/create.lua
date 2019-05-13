

local creeps = {}
local table = table
local rect = require 'types.rect'

creeps.group = {
	--位置,怪物名*N,出生时间,刷新时间
	{1000,2000, '火元素',30, 0, 20},

}

--开始刷野
function creeps.start()

	--刷野玩家
	local creep_player = ac.player[13]

	--对每个野怪点分别计算
	for _, data in ipairs(creeps.group) do
		local x,y, name,count, start_time, revive_time = table.unpack(data)

		--野怪单位组
		local group = {}
		--野怪数据

		--第几次刷新
		local revive_count = -1

		--创建该野怪点的野怪
		local function create()
			revive_count = revive_count + 1
			for i = 1, count do
				local data = ac.lni.unit[name]
				local p = ac.point(x,y) - {360 / count * i, 100}

				local u = creep_player:create_unit(name, p, 270)
				--设置奖励
				u.reward_gold = data['金钱'] * 2
				u.reward_exp = data['经验'] * 1.5

				--设置属性
				u:add('生命上限%', revive_count * 40)
				u:add('攻击%', revive_count * 40)
				--u:setMelee(false)
				if data.weapon then
					u.missile_art = data.weapon['弹道模型']
					u.missile_speed = data.weapon['弹道速度']
				end
				
				u:add_ability 'A00V'

				--将单位添加进单位组
				table.insert(group, u)
				--保存单位组
				u.creep_group = group

				--监听这个单位挂掉
				u:event '单位-死亡' (function()
					for _, uu in ipairs(group) do
						if uu:is_alive() then
							return
						end
					end
					ac.wait(revive_time * 1000, create)
				end)
			end
		end

		--刷第一波野
		ac.wait(start_time * 1000, create)
	end
end

return creeps
