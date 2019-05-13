
local unit = require 'types.unit'

local heal = {}
setmetatable(heal, heal)

--伤害结构
local mt = {}
heal.__index = mt

--类型
mt.type = 'heal'

--来源
mt.source = nil

--目标
mt.target = nil

--原因
mt.reason = '未知'

--治疗
mt.heal = 0

--关联技能
mt.skill = nil

--创建漂浮文字
local function text(heal)
	local angle = math.random(55,125)
	if heal.target ~= ac.player.self.hero then
		return
	end
	local x, y = heal.target:get_point():get()
	local z = heal.target:get_point():getZ()
	-- while true do
	-- 	angle = math.random(45,135)
	-- 	if  angle < 80  or  angle > 100 then
	-- 		break
	-- 	end	
	-- end	
	local tag = ac.texttag
	{
		string = ('%s +%.f'):format(heal.string or '',heal.heal),
		size = heal.size or 8 ,
		position = ac.point(x-30, y, z - 30),
		speed = 120,
		angle = angle,
		red = 20*2.55,
		green = 100*2.55,
		blue = 20*2.55,
		life = 1.2,
		fade = 0.9,
		heal = heal.heal,
		time = ac.clock(),
	}
	
	
end

--创建治疗
function heal:__call(heal)
	if not heal.target or heal.heal == 0 then
		return
	end

	-- if heal.skill == nil then
	-- 	log.warnning('治疗没有关联技能')
	-- 	log.warnning(debug.traceback())
	-- end
	
	setmetatable(heal, self)

	if heal.target:event_dispatch('受到治疗开始', heal) then
		return heal
	end

	if heal.heal < 0 then
		heal.heal = 0
	end
	
	--进行治疗
	heal.target:add('生命', heal.heal)

	--创建漂浮文字
	text(heal)

	heal.target:event_notify('受到治疗效果', heal)

	return heal
end

--进行治疗
function unit.__index:heal(data)
	data.target = self
	return heal(data)
end

return heal