local time =2
local max_cnt = 20
local creep_groop={}
--刷怪-杀鸡儆猴
local function create_creep()
    for ix =1,3 do 
        local rect = ac.rect.j_rect('sjjh'..ix)
        if not creep_groop[ix] then 
            creep_groop[ix] = {}
        end
        local cnt = max_cnt - (#creep_groop[ix] or 0)
        --创建单位
        for i=1,cnt do 
            local point = rect:get_random_point()
            local u = ac.player(12):create_unit('鸡',point)
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


--刷怪-异火
local time =2
local max_cnt = 15
local creep_groop={}
local function fire_create_creep(where,unit)
    for ix =1,4 do 
        print('异火地区',where..ix)
        local rect = ac.rect.j_rect(where..ix)
        if not creep_groop[ix] then 
            creep_groop[ix] = {}
        end
        local cnt = max_cnt - (#creep_groop[ix] or 0)
        --创建单位
        for i=1,cnt do 
            local point = rect:get_random_point()
            local u = ac.player(12):create_unit(unit,point)
            table.insert(creep_groop[ix],u)
            print('异火单位',u,unit)
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
-- 星星之火boss 
ac.loop(time*1000,function()
    create_creep() 
    fire_create_creep('xxzh1','星星之火守卫')
    fire_create_creep('ylxy1','陨落心炎守卫')
    fire_create_creep('sqyyh1','三千焱炎火守卫')
    fire_create_creep('xwty1','虚无吞炎守卫')
end)