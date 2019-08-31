local setmetatable = setmetatable
local ipairs = ipairs
local pairs = pairs
local table_insert = table.insert
local math_max = math.max
local math_floor = math.floor

local cur_frame = 0
local max_frame = 0
local cur_index = 0
local free_queue = {}
local timer = {}

local function alloc_queue()
	local n = #free_queue
	if n > 0 then
		local r = free_queue[n]
		free_queue[n] = nil
		return r
	else
		return {}
	end
end

local function execute(self,timeout)
	local ti = cur_frame + timeout
	local q = timer[ti]
	if q == nil then
		q = alloc_queue()
		timer[ti] = q
	end
	self.timeout_frame = ti
	q[#q + 1] = self
end

local function m_timeout(self, timeout)
	execute(self,timeout)
	--pcall(execute,self,timeout)
end

local function m_wakeup(self)
	if self.removed then
		return
	end
	self:on_timer()
	if self.removed or self.pause_remaining then
		return
	end
	if self.timeout then
		m_timeout(self, self.timeout)
	else
		self.removed = true
	end
end

local function on_tick()
	local q = timer[cur_frame]
	if q == nil then
		cur_index = 0
		return
	end
	for i = cur_index + 1, #q do
		local callback = q[i]
		cur_index = i
		q[i] = nil
		if callback then
			m_wakeup(callback)
		end
	end
	cur_index = 0
	timer[cur_frame] = nil
	free_queue[#free_queue + 1] = q
end

function ac.clock()
	return cur_frame
end

function ac.timer_size()
	local n = 0
	for _, ts in pairs(timer) do
		n = n + #ts
	end
	return n
end

local jass = require 'jass.common'
local jtimer = jass.CreateTimer()
require('jass.debug').handle_ref(jtimer)
jass.TimerStart(jtimer, 0.01, true, function ()
	local delta = 10
	if cur_index ~= 0 then
		cur_frame = cur_frame - 1
	end
	max_frame = max_frame + delta
	while cur_frame < max_frame do
		cur_frame = cur_frame + 1
		on_tick()
	end
end)


local mt = {}
local api = {}
mt.__index = api
mt.type = 'timer'

function api:remove()
	self.removed = true
end

function api:get_remaining()
	if self.removed then
		return 0
	end
    if self.pause_remaining then
        return self.pause_remaining
    end
    if self.timeout_frame == cur_frame then
        return self.timeout or 0
    end
    return self.timeout_frame - cur_frame
end

function api:pause()
	self.pause_remaining = self:get_remaining()
	local ti = self.timeout_frame
	local q = timer[ti]
	if q then
		for i= #q, 1, -1 do
			if q[i] == self then
				q[i] = false
				return
			end
		end
	end
end

function api:resume()
	if self.pause_remaining then
		m_timeout(self, self.pause_remaining)
		self.pause_remaining = nil
	end
end

function ac.wait(timeout, on_timer)
	if type(timeout) ~= 'number'  or type(on_timer) ~= 'function' then 
		print("计时器参数错误2",timeout,on_timer)
		return 
	end 
	local timeout = math_max(math_floor(timeout) or 1, 1)
	local t = setmetatable({
		['on_timer'] = on_timer,
	}, mt)
	m_timeout(t, timeout)
	return t
end

function ac.loop(timeout, on_timer)
	if type(timeout) ~= 'number' or type(on_timer) ~= 'function' then 
		print("计时器参数错误1",timeout,on_timer)
		return 
	end 
	local t = setmetatable({
		['timeout'] = math_max(math_floor(timeout) or 1, 1),
		['on_timer'] = on_timer,
	}, mt)
	m_timeout(t, t.timeout)
	return t
end

function ac.timer(timeout, count, on_timer)
	if type(timeout) ~= 'number' or type(count) ~= 'number' or type(on_timer) ~= 'function' then 
		print("计时器参数错误1",timeout,count,on_timer)
		return 
	end 

	if count == 0 then
		return ac.loop(timeout, on_timer)
	end
	local t = ac.loop(timeout, function(t)
		if not t.cnt then 
			t.cnt = 0
		end
		t.cnt = t.cnt + 1	
		t.count = count
		on_timer(t)
		count = count - 1
		if count <= 0 then
			if t.on_timeout then 
				t:on_timeout()
			end	
			t:remove()
		end
	end)
	return t
end

local function utimer_initialize(u)
	if not u._timers then
		u._timers = {}
	end
	if #u._timers > 0 then
		return
	end
	u._timers[1] = ac.loop(10000, function()
		local timers = u._timers
		for i = #timers, 2, -1 do
			if timers[i].removed then
				local len = #timers
				timers[i] = timers[len]
				timers[len] = nil
			end
		end
		if #timers == 1 then
			timers[1]:remove()
			timers[1] = nil
		end
	end)
end

function ac.uwait(u, timeout, on_timer)
	utimer_initialize(u)
	local t = ac.wait(timeout, on_timer)
	table_insert(u._timers, t)
	return t
end

function ac.uloop(u, timeout, on_timer)
	utimer_initialize(u)
	local t = ac.loop(timeout, on_timer)
	table_insert(u._timers, t)
	return t
end

function ac.utimer(u, timeout, count, on_timer)
	utimer_initialize(u)
	local t = ac.timer(timeout, count, on_timer)
	table_insert(u._timers, t)
	return t
end


--计时器原始计时器+窗口
ac.timer_ex = function(data)
	local time = data.time
	local loop = data.loop or false
	local func = data.func
	local title = data.title
	local player = data.player

	local jtm = jass.CreateTimer()
	local timer = {
		handle = jtm,
		time = time,
	}
	jass.TimerStart(jtm,time,false,function ()
		timer:remove()
		if func then 
			func()
		end 
	end)
	
	function timer:PauseTimer()
		jass.PauseTimer(timer.handle)
	end

	function timer:ResumeTimer()
		jass.ResumeTimer(timer.handle)
	end

	function timer:create_timer_dialog(title)
		local time_dialog = jass.CreateTimerDialog(jtm)
		jass.TimerDialogSetTitle(time_dialog, title)

		if player then
			if player == ac.player.self then
				jass.TimerDialogDisplay(time_dialog, true)
			end
		else
			jass.TimerDialogDisplay(time_dialog, true)
		end

		timer.timer_dialog = time_dialog
	end

	function timer:remove()
		if timer.timer_dialog then
			jass.DestroyTimerDialog(timer.timer_dialog)
		end
		jass.PauseTimer(jtm)
		jass.DestroyTimer(jtm)
		jtm = nil
		timer = nil
	end
	
	if title then
		timer:create_timer_dialog(title)
	end

	return timer
end