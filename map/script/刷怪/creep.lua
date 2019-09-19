
local player = require 'ac.player'
-- local timerdialog = require 'types.timerdialog'
local rect = require 'types.rect'
local region = require 'types.region'
local fogmodifier = require 'types.fogmodifier'

local creep = {}
setmetatable(creep, creep)

local mt = {}
creep.__index = mt

--类型
mt.type = nil
--当前波数
mt.index = 0
--最大波数数量
mt.max_index = 999999
--野怪刷新状态  开始，下一波，结束
mt.state = nil
--计时器窗口
mt.timerdialog = nil
-- 数量
mt.count =20
-- 当前数量
mt.current_count =0
--刷新区域
mt.region  = nil
--是否随机刷
mt.is_random  = nil
-- 刷新时间 (怪物符合刷新条件后，还需要等待的时间)
mt.cool= nil
-- 强制刷新时间 (不需要等待怪物全死亡，直接刷新下一波)
mt.force_cool= nil
--怪物数量 - 刷新条件 达到后进入刷新时间计时 
mt.cool_count = nil

-- 说明
mt.tip =nil
mt.creeps_datas = nil
-- 野怪所有者
mt.creep_player = ac.player[12]
-- 单位组
mt.group = {}
-- 触发玩家
mt.trg_player = nil
-- 是否已经开始 防止重复创建
mt.has_started = nil
-- 是否完成
mt.is_finish = false
-- 移除时是否也把单位杀死
mt.is_unit_kill = false
-- 移除时是否移除掉所指区域现在的刷怪。
mt.is_region_replace = false

local function register_creep(self, name, data)
	
    setmetatable(data, data)
    data.__index = creep

    local cep = {}
    setmetatable(cep, cep)
    cep.__index = data
    cep.__call = function(self, data)
        self.data = data
        return self
    end
    cep.name = name
    cep.data = data
    
    self[name] = cep
    creep.all_creep[name] = cep


    return cep
end
--外部new
function creep.new(name)
    -- print(name)
    local data = ac.creep[name or self.name]
    if type(data) == 'function' then
        print('没有被注册')
        return false
    end

	local new = {}
	setmetatable(new, new)
    new.__index = data
	new.id = name
	new.name = name
	new.group = {}
    
    creep.all_creep[name] = new

    return new
end


--搜索离单位最近的一个英雄
local function find_hero(unit)
    local point = unit:get_point()
    local num = 99999
    local ret = nil 
    for i = 1,10 do 
        local player = ac.player(i)
        local hero = player.hero
        if hero and hero:is_alive() then 
            local dis = hero:get_point() * point
            if dis < num then 
                ret = hero 
                num = dis 
            end 
        end 

    end 
    return ret 
end 
ac.find_hero = find_hero
-- 通过 region 名 找到 creep 刷怪,然后返回
-- region table 的话 无法判断。
function creep:find_creep_by_region(region_str)
    local region_str = region_str 
    if not region_str  then 
        return
    end    
    local name 
    local ceps = {}
    
    for k,v in sortpairs(creep.all_creep) do
        -- print(k,v.region_str ,region_str)
        if v.region_str == region_str then 
            name = k
            table.insert(ceps,creep.all_creep[name])
        end
    end

    if not name  then 
        print('没有找到region')
        return false
    end

    return ceps
end    

function mt:set_region(rgn)
    local rect_name = rgn or self.region
	--已经转化过了
    if type(rect_name) ~= 'string' then 
        self.region = rect_name 
        return
    end    

    local reg =region.create()
    local _ = 0
    local region_str = ''

    for name in rect_name:gmatch '%S+' do
        -- 只有一个区域时，默认为矩形区域，get_point 取中心点
        _ = _ + 1
        region_str = region_str ..' '.. name
        if _ ==1 then 
            reg = rect.j_rect(name)	
        else
           reg = region.create(rect.j_rect(name)) + reg 
        end   
    end
    
    self.region = reg 
    self.region_str = region_str
end   
function mt:get_region()
    return self.region  
end     
--转化野怪数据
function mt:set_creeps_datas()
	--野怪数据
    local creeps_names =  self.creeps_datas
    if type(creeps_names) ~= 'string' then 
        return 
    end   

    local creeps_datas = {}  
    for k,v in creeps_names:gmatch '(%S+)%*(%d+%s-)' do
        creeps_datas[k]=v
    end
    self.creeps_datas = creeps_datas
end

function creep:remove_by_region_str(region_str)
    -- finde_region
    -- is_region_replace true 停止上个在这个region 刷兵的动作，进行这个刷兵，默认是false
end
function mt:start(player)
    
    if self.has_started  then 
        return 
    end    
    self.has_started = true
    self.is_finish =false
    self.group = {}
    self.creep_timer ={}
    

    --转化字符串 为真正的区域
    self:set_region()
    --转化字符串 为真正的野怪数据
    self:set_creeps_datas()

    -- 刷怪前，是否清除原来的刷怪 动作
    -- print(self.is_region_replace )
    if self.is_region_replace then 
        local ceps = creep:find_creep_by_region(self.region_str)
        if ceps then 
            for i =1, #ceps do
                -- 移除该区域内每个刷怪 动作,如果是自己就不删 跳过。
                if ceps[i].name ~= self.name then 
                    -- print('2 移除:',ceps[i].name)
                    ceps[i]:finish(true)
                end    
            end    
        end    
    end    
    --可能会引起掉线
    -- local p = player or ac.player.self
    local tip = self.tip 
    if tip then 
        ac.player.self:sendMsg(tip, 5)
    end    
    -- self.trg_player = p

    if self.is_leave_region_replace then 
        local reg = self.region
        if self.region.type ~='region' then 
            reg = region.create(reg)
        end
        self.event_region = reg:event '区域-离开' (function(trg, hero)
            -- local loc_hero = ac.player.self.hero
            if hero == self.owner.hero then 
                -- self:print_group()
                -- self:finish(true)
                self.owner.current_creep = self
                local ceps = creep:find_creep_by_region(self.region_str)
                if ceps then 
                    for i =1, #ceps do
                        -- 移除该区域内每个刷怪 动作,包含自己
                        -- if ceps[i].name ~= self.name then 
                            -- print('2 移除:',ceps[i].name)
                            ceps[i]:finish(true)
                        -- end    
                    end    
                end 
            end    
        end)    
    end  

    if self.on_start then 
        self:on_start()
    end 
    --等待1秒后才开始
    if self.first_wait_time then 
        self.wait_timer = ac.wait(self.first_wait_time * 1000,function() 
            self:next()   
        end)
    else
        self:next()     
    end  
    
end
--暂停计时
function mt:PauseTimer(time)
    if not self.timerdialog then 
        return 
    end
    self.timerdialog:PauseTimer() 
    if time then 
        self.remaining_time = (self.remaining_time or 0) + time
        if not self.flag_pause then  
            -- print('设置倒计时',self.remaining_time)
            self.flag_pause = ac.loop(1000,function(t)
                self.remaining_time = self.remaining_time - 1
                -- print('倒计时：',self.remaining_time)
                if self.remaining_time <=0 then 
                    self:ResumeTimer()
                    t:remove()
                    self.remaining_time = 0
                    self.flag_pause = nil
                end    
            end)
        end    
    end    
    return self.timerdialog
end    

--恢复计时
function mt:ResumeTimer()
    if not self.timerdialog then 
        return 
    end
    self.timerdialog:ResumeTimer()   
    return self.timerdialog
end  

function mt:next()
    --已经结束
    if is_finish then
        return
    end   
    --当前波数加1,若限定最大波数，则下一波大于最大波数时，跳出
    self.index = self.index +1

    if self.index > self.max_index then 
        self.allow_next = false
        self:finish() 
        return
    end    
    -- if self.timerdialog then 
    --     self.timerdialog:remove()
    --     self.timerdialog = nil
    -- end    
    if  self.force_cool then 
        --创建计时器窗口
        self.timerdialog = ac.timer_ex 
        {
            time = self.force_cool,
            title = self.timer_ex_title ,
            func = function ()
                self:next()   
            end,
        }
    end    

    if ac.game:event_dispatch('游戏-回合开始',self.index,self)  then 
        return 
    end  
    if self.on_next then 
        self:on_next()
    end 
    
    local creeps_datas = self.creeps_datas
    local region = self.region
    local creep_player = self.creep_player

    if not creeps_datas then 
        print('没有野怪数据')
        return
    end
    local cnt = 0
    local max_cnt =0
    for k,v in pairs(creeps_datas) do 
        max_cnt =max_cnt+1
    end    
    if max_cnt == 0 then 
        print('野怪数据格式出错')
        return 
    end    
    -- creeps_datas[u] = count ，单位，数量
    for k,v in sortpairs(creeps_datas) do 
        -- print('检测单位名称',k,v)
        cnt = cnt +1 
        local name = k
        local data = ac.table.UnitData[name]
        
        if not data then 
            print('lni数据没有被加载')
            return 
        end
        local timer = ac.timer((self.create_unit_cool or 0.1) * 1000,tonumber(v),function(t)
            local where 
            if region.type == 'rect' and self.is_random then
                local minx, miny, maxx, maxy = region:get()
                where = ac.point(math.random(minx,maxx),math.random(miny,maxy))
            else
                --如果是region,不规则区域，只能随机刷
                where = region:get_point()
            end    
            local u = creep_player:create_unit(name, where)    
            -- print('检测单位名称',name, where,u)
            self.current_count = self.current_count + 1
            
            --设置奖励
            if data.gold  then
                u.gold = data.gold
            end    
            u.exp = data.exp
            u.wood = data.wood
            u.fire_seed = data.fire_seed

            u.data = data

            --设置模型大小
            if data.model_size  then
                u:set_size(data.model_size)
            end  
            --不主动攻击 
            -- u:add_ability 'A00B'

            if self.on_change_creep then 
                self:on_change_creep(u,data)
            end    
            --将单位添加进单位组
            table.insert(self.group,u)
            
            --监听这个单位挂掉
            self.trg = u:event '单位-死亡' (function(_,unit,killer)
                self.current_count = self.current_count - 1
                for _, uu in ipairs(self.group) do
                    if uu.handle == unit.handle then 
                        table.remove(self.group,_)
                        break
                    end    
                end
                if(self.is_finish) then 
                    return
                end     
                -- 不允许下一波 则返回
                if  not self.allow_next then 
                    return
                end    
                -- print('进攻怪死亡:3',#self.group)
                local i = 0
                local cool_count = self.cool_count or 0 
                for _, uu in ipairs(self.group) do
                    -- print('存活数量:'..#self.group..'当前死亡:'..uu:get_name())
                    if uu:is_alive() then
                        i = i + 1
                        --如果怪物存活数量 > 刷新数量条件 直接返回，不进行下一波的刷新
                        if i > cool_count  then 
                            -- print('存活数量>0')
                            return
                        end    
                      
                    end
                end
                -- 在当前怪没清完前 不允许下一波
                self.allow_next = false

                if ac.game:event_dispatch('游戏-回合结束',self.index,self)  then 
                    return 
                end    
                --防守时刷怪倒计时，如果怪物全杀死也不进入下一波
                if self.timerdialog then 
                    return 
                end    
                --如果有刷新时间配置 则 按照时间等待后刷新，没有的话立即刷新
                if self.cool  then 
                    if not self.wait_trg then 
                        self.wait_trg = ac.wait(self.cool  * 1000, function()
                            self.wait_trg = nil
                            self:next()
                        end)
                    end    
                else
                    --最小刷新时间
                    if not self.wait_trg then 
                        self.wait_trg = ac.wait(0.3 * 1000, function()
                            self.wait_trg = nil
                            self:next()
                        end)
                    end    
                end	
                   
            end)
            
        end);
        -- 如果同时杀死100只，每只怪物死亡都循环遍历下表，可能波数会出现问题
        -- 如果 创建出来的兵 要大于刷的条件兵才允许再次刷新，那出来一只，打死一只的情况下，怎么处理
        -- 创建完兵，给标识说可以刷新
        -- 如果 每杀死一只并就判断一次数量 小于 某个值就刷新，这又会导致一瞬间多刷很多只。
        -- print(t.count,v )
        --[[ self.creep_timer = {},table.insert(self.creep_timer,timer)
              timer:on_timeout()

        ]]
        timer.creep_name = k
        self.creep_timer[timer.creep_name] = timer

        local temp_self =self
        function timer:on_timeout()
            temp_self.creep_timer[self.creep_name] = nil
        end  
        if cnt == max_cnt then 
            function timer:on_timeout()
                temp_self.allow_next = true
            end  
        end    

    end


end    
function mt:print_group()
    for _, uu in ipairs(self.group) do
        print(_,uu)
        -- uu:remove()
        -- table.remove(self.group,_)
    end     

end    
function mt:finish(is_unit_kill)
    self.is_finish = true
    self.has_started = false

    if  self.trg then 
        self.trg:remove()
        self.trg = nil
    end
    if  self.timer then 
        self.timer:remove()
        self.timer = nil
    end
    if  self.timerdialog then 
        self.timerdialog:remove()
        self.timerdialog = nil
    end
    if self.event_region then 
        self.event_region:remove()
        self.event_region = nil
    end
    if self.wait_trg then 
        self.wait_trg:remove()
        self.wait_trg = nil
    end
    if self.wait_timer then 
        self.wait_timer:remove()
        self.wait_timer = nil
    end
    if self.creep_timer then 
        for k,v in sortpairs(self.creep_timer) do
            --print('移除计时器',k,v)
            if v then 
                v:remove()
                self.creep_timer[k] = nil
            end    
        end	
    end    
    
    if self.on_finish then
        self:on_finish()
    end    
 
    local is_unit_kill = is_unit_kill or self.is_unit_kill 
 
    if is_unit_kill then 
        for _, uu in ipairs(self.group) do
            -- print('开始删除',_,uu)
            uu:remove()
            self.group[_] = nil
            -- table.remove(self.group,_)
        end     
        self.group = {}
    end
    --creep.all_creep[self.name] = nil
    
    
end    

local function init()
    creep.all_creep ={}
    ac.all_creep = creep.all_creep
    ac.creep = setmetatable({}, {__index = function(self, name)
        return function(data)
            return register_creep(self, name, data)
        end
    end})

end
init()

return creep