--先改变 game.timer 
function game.timer(timeout, count, on_timer)
	if count == 0 then
		return game.loop(timeout, on_timer)
	end
	local t = game.loop(timeout, function(t)
        if not t.cnt then 
            t.cnt = 0
        end
        
        t.cnt = t.cnt + 1	
        count = count - 1
        t.count = count
        on_timer(t)
        if count <= 0 then
            if t.on_timeout then 
                t:on_timeout()
            end	
            t:remove()
        end
	end)
	return t
end

--淡化 
--@正数：淡化 负数：渐入
function class.ui_base:fade(time)
    --进行淡化
    local time = time or 0.3
    local source = time>0 and 100 or 0
    local time = math.abs(time)

    game.timer(time/100 * 1000,100,function(t)
        -- print((100-t.cnt)/100) 
        local val = math.abs(source - t.cnt)/100
        self:set_alpha(val)
    end)
end   

--闪烁
function class.ui_base:blink(time,speed,keep)
    local time = time or 1
    local speed = speed or 0.2 --一闪烁来回时间
    local per_speed = 100 /(speed / 2 /0.001) 
    local flag=1
    local current_alpha = 1
    game.timer(0.001*1000,math.floor(time/0.001),function(t)

        current_alpha = (current_alpha*100 - per_speed * flag)/100
        -- print('闪烁:',current_alpha)
        self:set_alpha(current_alpha)
        --变淡
        if current_alpha <= 0 then 
            flag = -1
        elseif current_alpha >= 1 then 
            flag = 1
        end

        if t.count <=0  then 
            local v = keep and 1 or 0 
            self:set_alpha(v)
        end
        
    end)
end   

local process = {}
setmetatable(process, process)
--结构
local mt = {}
process.__index = mt
mt.source = 0 --起始
mt.target = 0 --目标
mt.now = 0 --当前
mt.last_max=0 --上次结束时的值 作为下次起点
mt.min_per_val = 1 --最小步长(%)
mt.tween_speed = 1 --动画速度
mt.tween_flag = false
mt.t=0 --插值因子 动态
function mt:get(str)
    return self[str]
end
function mt:set(k,v)
    self[k] = v
    return v
end

--获取增量时间 Time.deltaTime 理解
function mt:get_deltatime()
    local fps = japi.GetFps()
    return 1/fps
end

function mt:update()
    if self.tween_flag then 
        local target = self:get('target')
        local source = self:get('source')
        
        -- if self.handle =='血条' then
        -- print('起始位置1：',self,source)
        -- end
        self.t = self.t + self.tween_speed * self:get_deltatime()
        -- print('插值因子：',self.t,self.tween_speed,self:get_deltatime(),japi.GetFps())
        if self.t > 1 then
            self.t = 1
            self:set('last_max',target)
            self:set('tween_flag',false)
        end
        local old_now = self:get('now')
        local now = math.lerp(source, target, self.t);
        -- print('现在的位置宽度：',now,now/420*100,now - old_now,(now - old_now)/420*100)
        self:set('now',now)
        self:show(now)
    else
        self:set('now',self:get('target'))
        self:show(self:get('target'))
    end
end
function mt:remove()
    if self.t_timer then 
        self.t_timer:remove()
        self.t_timer = nil
    end
    
end

function mt:start(data)
    if self.t_timer then 
        --刷新数据
        -- self:set_target(data.target)
        for k,v in pairs(data) do 
            self[k] = v 
        end
        -- if self.handle =='血条' then
        --     print('起始位置2：',self,self.source)
        -- end
        --缓慢流动时，改变 source
        if self.tween_flag then 
            self:set('source',self:get('now'))
        else
            self:set('source',self:get('last_max'))
        end
        self:set('target',data.target)
        self:set('t',0)
        self:set('tween_flag',true)
        
        -- local distance = self.source  - self.target
        -- local cur_distance = self.source - self.now 
        -- if math.abs(cur_distance/distance) <= 0.01 then 
        --     self:set('tween_flag',false)
        --     self:set('now',self.target)
        --     self:show(self.target)
        -- else
        -- end

        return 
    end
    
    self:update()
    self.t_timer = game.loop(10,function(t)
        self:update()
    end)

end
--设置动画 handle,target,time,show = function
function class.ui_base:set_process(data)
    local handle = data.handle
    if not handle then return end 

    local pr
    self.all_process = self.all_process  or {}
    --初始化
    if not self.all_process[handle] then 
        pr = setmetatable({}, process)
        for k,v in pairs(data) do 
            pr[k] = v 
        end
        self.all_process[handle] = pr
    else
        pr = self.all_process[handle]
    end
    -- if data.handle =='血条' then
    -- print('起始位置：',pr,data.source,pr.source)
    -- end
    pr:start(data)
end   

function class.ui_base:remove_process(handle)
    if self.all_process[handle] then 
        self.all_process[handle]:remove()
        self.all_process[handle] = nil 
    end
end