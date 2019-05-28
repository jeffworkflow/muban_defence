local time =2
local max_cnt = 15
local creep_groop={}

local function create_creep()
    for ix =1,3 do 
        local rect = ac.rect.j_rect('sjjh'..ix)
        if not creep_groop[ix] then 
            creep_groop[ix] = {}
        end    
        local cnt = max_cnt - (#creep_groop[ix] or 0)
        --创建单位
        for i=1,cnt do 
            local u = ac.player(12):create_unit('鸡',rect)
            table.insert(creep_groop[ix],u)

            --移除
            u:event '单位-死亡' (function(_,unit,killer)
                for _, uu in ipairs(creep_groop[ix]) do
                    if uu.handle == unit.handle then 
                        table.remove(creep_groop[ix],_)
                        break
                    end    
                end
                
                unit:remove() --立即删除 不产生尸体
            end)    
        end    
    end 
end    

ac.loop(time*1000,function()
    create_creep()
end)