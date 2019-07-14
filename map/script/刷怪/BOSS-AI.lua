local function cast_skill(hero,target)
    -- print(hero,hero.data.type)
    if hero.data and hero.data.type ~= 'boss' then 
        return 
    end   

    local list = {}
    for skill in hero:each_skill '英雄' do 
        table.insert(list,skill)
    end 

    if #list == 0 then 
        return 
    end 
    local skill  = list[math.random(#list)]
    -- print(skill.name)
    if skill == nil then 
        return 
    end 
    -- print(skill.name,skill:is_cooling())
    -- if skill:is_cooling() then 
    --     return 
    -- end    
    if skill.target_type == 0 then 
        skill:cast()
    elseif skill.target_type == 1 then  
        skill:cast(target)
    else 
        skill:cast(target:get_point())
    end    
end    

ac.game:event '造成伤害开始' (function (_,damage)
    if damage:is_common_attack() == false then 
        return 
    end
    local hero = damage.source 
    local target = damage.target
    -- print(rand)
    local rand = math.random(100)
    if rand <= 30 then 
        cast_skill(hero,target)
    end 
end)


-- ac.loop(1000,function()
--     for _,u in ac.selector()
--         : in_rect()
--         : is_type('boss')
--         : ipairs()
--     do
--         cast_skill(u,u)
--     end

-- end)
