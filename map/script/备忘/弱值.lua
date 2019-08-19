
    local unit = {}
    setmetatable(unit, unit)
    
    unit.removed_units = {};
    setmetatable(unit.removed_units, {__mode = "kv"});
    
    unit.all_units = {}
    --结构
    local mt = {}
    unit.__index = mt
    
    function mt:create()
	    local u = setmetatable({}, unit)
        u.handle = math.random(100);
        u.name = math.random(100);
        unit.all_units[u.handle] = u
        return u
    end   
    
    function mt:remove()
		unit.all_units[self.handle] = nil
		unit.removed_units[self] = self
    end     
    
    local function test()
        local u1 = unit:create()
        u1:remove()
    end    
    
    test()
    -- 强制进行一次垃圾收集
	collectgarbage("collect")
   
    for key, value in pairs(unit.removed_units) do
        print(key.handle .. ":" .. value.name);
    end