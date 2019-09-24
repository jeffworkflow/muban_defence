
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


    local  skill ={}
    local  mt = {}
    setmetatable(skill,skill)
    skill.__index = mt 
    -- mt.__index = mt
    mt.b = 12
    function mt:in_range()
        print(' in_range')
    end    
    local baba = {
        aaa=2
    }
    local cast_mt = {
        __index = function(baba, key)
            -- local value = read_value(skill.parent_skill, skill, key)
            print('__index',233333333)
            baba[key] = 1
            return 1
        end,
    }
    function mt:create_cast()
        print('create_cast')
        local new_skill = {}
        setmetatable(new_skill, cast_mt)
		for i=1,10 do 
		    new_skill['bb'..i] = i 
		end    
-- 		new_skill.__index = new_skill
        setmetatable(new_skill,self)
        return new_skill
    end  
    
    function mt:new()
        local new_skill = {}
        setmetatable(new_skill, skill)
        -- new_skill.__index = new_skill
        -- mt.__index = mt
        return new_skill
    end    
      
    
    local a = skill:new():create_cast()
    print(a.in_range)
    print(a.bb3)
    

    --子类基础 教程 
    --https://www.jianshu.com/p/c05ba09add81?tdsourcetag=s_pctim_aiomsg

   --  print(skill.a)
   --  print(skill.b)









