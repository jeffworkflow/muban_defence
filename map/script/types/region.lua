
local jass = require 'jass.common'
local rect = require 'types.rect'
local unit = require 'types.unit'
local dbg = require 'jass.debug'

local region = {}
setmetatable(region, region)

--不规则区域结构
local mt = {}
region.__index = mt
ac.region = region

--类型
mt.type = 'region'

--句柄
mt.handle = 0

--4个数值
mt.minx = nil
mt.miny = nil
mt.maxx = nil
mt.maxy = nil

--获取4个值
function mt:get()
	return self.minx, self.miny, self.maxx, self.maxy
end

--创建不规则区域
function region.create(...)
	local rgn = setmetatable({}, region)
	rgn.handle = jass.CreateRegion()
	dbg.handle_ref(rgn.handle)
	for _, rct in ipairs{...} do
		rgn = rgn + rct
	end

	return rgn
end

--移除不规则区域
function mt:remove()
	if self.removed then
		return
	end
	self.removed = true
	jass.RemoveRegion(self.handle)
	if self.event_enter then
		war3.DestroyTrigger(self.event_enter)
	end
	if self.event_leave then
		war3.DestroyTrigger(self.event_leave)
	end
	dbg.handle_unref(self.handle)
	self.handle = nil
end

--进入区域事件
mt.event_enter = nil

--离开区域事件
mt.event_leave = nil

local ac_game = ac.game

--注册区域事件
--	event_type是字符串,包含e时注册进入事件,包含l时注册离开事件
function mt:event(name)
	if name == '区域-进入' and not self.event_enter then
		self.event_enter = war3.CreateTrigger()
		jass.TriggerRegisterEnterRegion(self.event_enter, self.handle, nil)
		jass.TriggerAddCondition(self.event_enter, jass.Condition(function()
			local unit = unit.j_unit(jass.GetTriggerUnit())
			if unit then
				ac.event_notify(self, name, unit, self)
				ac.game:event_notify(name, unit, self)
			end
		end))
	end
	
	if name == '区域-离开' and not self.event_leave then
		self.event_leave = war3.CreateTrigger(function()
			local unit = unit.j_unit(jass.GetTriggerUnit())
			if unit then
				ac.event_notify(self, name, unit, self)
				ac.game:event_notify(name, unit, self)
			end
		end)
		jass.TriggerRegisterLeaveRegion(self.event_leave, self.handle, nil)
	end

	return ac.event_register(self, name)
end

function mt:compare_set(other)
	
	local minx, miny, maxx, maxy = self:get()
	local minx1, miny1, maxx1, maxy1 = other:get()
	--排除0,0,0,0区域
	if not minx or not miny or not maxx or not maxy  then
		self.minx = minx1
		self.miny = miny1
		self.maxx = maxx1
		self.maxy = maxy1
		return 
	end	
	
	if minx1 < self.minx then
		self.minx = minx1
	end	
	if miny1 < self.miny then
		self.miny = miny1
	end
	if maxx1 > self.maxx then
		self.maxx = maxx1
	end
	if maxy1 > self.maxy then
		self.maxy = maxy1
	end
end	
-- 获得不规则区域内的随机一点
-- true 获取中心点
function mt:get_point(flag)
	local minx, miny, maxx, maxy = self:get()
	local x1 = math.modf(minx/32)
	local x2 = math.modf(maxx/32)
	local y1 = math.modf(miny/32)
	local y2 = math.modf(maxy/32)
	if not flag then 
		while true do
			local point = ac.point(
				math.random(x1,x2)*32,
				math.random(y1,y2)*32
			)
			local x,y = point:get_point():get()
			-- print('不规则区域内的随机一点',x,y)
			--modify by jeff 20190412 添加判断，点必须为可通行的点
			if  self < point and not point:is_block()  then
				self.point = point
				return self.point
			end	
		end
	else
		local point = ac.point((maxx + minx)/2,(maxy + miny)/2)
		return point
	end	
end

--在不规则区域中添加/移除区域
--	region = region + other
function region:__add(other)
	if other.type == 'rect' then
		--添加矩形区域
		jass.RegionAddRect(self.handle, rect.j_temp(other))
		self:compare_set(other)
		
	elseif other.type == 'point' then
		--添加单元点
		jass.RegionAddCell(self.handle, other:get())
		self:compare_set(other)
	elseif other.type == 'circle' then
		--添加圆形
		local x, y, r = other:get()
		local p0 = other:get_point()
		for x = x - r, x + r + 32, 32 do
			for y = y - r, y + r + 32, 32 do
				local p = ac.point(x, y)
				if p * p0 <= r + 16 then
					jass.RegionAddCell(self.handle, x, y)
				end
			end
		end
	else
		jass.RegionAddCell(self.handle, other:get_point():get())
	end
	

	return self
end

--	region = region - other
function region:__sub(other)
	if other.type == 'rect' then
		--添加矩形区域
		jass.RegionClearRect(self.handle, rect.j_temp(other))
	elseif other.type == 'point' then
		--移除单元点
		jass.RegionClearCell(self.handle, other:get())
	elseif other.type == 'circle' then
		--移除圆形
		local x, y, r = other:get()
		local p0 = other:get_point()
		for x = x - r, x + r + 32, 32 do
			for y = y - r, y + r + 32, 32 do
				local p = ac.point(x, y)
				if p * p0 <= r + 16 then
					jass.RegionClearCell(self.handle, x, y)
				end
			end
		end
	else
		jass.RegionClearCell(self.handle, other:get_point():get())
	end

	return self
end

--点是否在不规则区域内
--	result = region < point
function region:__lt(dest)
	local x, y = dest:get_point():get()
	return jass.IsPointInRegion(self.handle, x, y)
end

function region:__call(...)
	return self.create(...)
end

return region