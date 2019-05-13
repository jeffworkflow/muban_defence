

local creeps = {}
local table = table
local rect = require 'types.rect'

creeps.group = {
	--位置,怪物名*N,出生时间,刷新时间
	{-5900,4750,315, '光之守卫',1, 0,'魔法恢复',5},
	{6100,5750,250, '凤凰',1,0,'生命恢复',5},
	{-5500,-6600,76,'战神',1,0},
	{5100,-6550,155,'美杜莎',1,0,'攻击速度%',20},
}

--开始刷野
function creeps.start()

	--刷野玩家
	local creep_player = ac.player[10]

	--对每个野怪点分别计算
	for _, data in ipairs(creeps.group) do
		local x,y,face, name,count, start_time,state,value = table.unpack(data)

		--野怪单位组
		local group = {}
		--野怪数据

		--第几次刷新
		local revive_count = -1

		--创建该野怪点的野怪
		local function create()
			revive_count = revive_count + 1
			for i = 1, count do
				local data = ac.table.unit[name]
				local p = ac.point(x,y) - {360 / count * i, 100}

				local u = creep_player:create_unit(name, p, face)
				--设置奖励
				--u.reward_gold = data['金钱'] * 2
				--u.reward_exp = data['经验'] * 1.5

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
					local count = get_player_count()
					local gold = 6000 / count 
					local x,y = u:get_point():get()
					ac.item.create('特级技能卡',x,y)
					ac.item.create('特级技能卡',x,y)
					for i = 1,8 do 
						local player = ac.player(i)
						local hero = player:get_hero()
						if hero then 
							player:addGold(gold,hero,true)
							hero:set_level(hero:get_level() + 2)
							if state then 
								player:sendMsg("永久奖励 " .. state .. ' ' .. value )
								hero:add(state,value)
							end
							if name == '战神' then 
								player:sendMsg("永久奖励 伤害10%")
								hero:add_buff '攻击增加伤害'
								{
									value = 10,
								}
							end 
						end 
					end 
					
				end)
			end
		end

		--刷第一波野
		ac.wait(start_time * 1000, create)
	end
end

local mt = ac.buff['攻击增加伤害']

function mt:on_add()
	local hero = self.target 
	self.trg = hero:event'造成伤害效果' (function (_,damage)
		damage:mul(self.value / 100)
	end)
end 

function mt:on_remove()
	if self.trg then 
		self.trg:remove()
		self.trg = nil
	end 
end 

creeps.start()

return creeps
