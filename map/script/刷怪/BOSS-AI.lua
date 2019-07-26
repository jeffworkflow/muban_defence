local function cast_skill(hero,target)
    -- print(hero,hero.data.type)
    if hero.data and hero.data.unit_type ~= 'boss' then 
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
    if skill:is_cooling() then 
        return 
    end     
    if skill.target_type == 0 then 
        skill:cast()
    elseif skill.target_type == 1 then
        if target then  
            skill:cast(target)
        end    
    else 
        if target then  
            skill:cast(target:get_point())
        end   
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


ac.loop(1000,function()
    for _,u in ac.selector()
        : in_rect()
        : is_type('boss')
        : ipairs()
    do
        cast_skill(u,nil)
    end

end)

--boss 技能释放结束时，需要再次寻找英雄进行攻击。否则施法结束会返回原地。
--技能事件
ac.game:event '技能-施法停止' (function(trg, _, skill)
    local unit = skill.owner
    local skill_str = table.concat(ac.skill_list3)
    if unit and finds(skill_str,skill.name) then 
        ac.attack_hero(unit)
    end
end)
--boss 杀死英雄马上进攻其他英雄
ac.game:event '单位-杀死单位' (function(trg, killer, target)
    
    local unit_str = table.concat(ac.attack_unit) .. table.concat(ac.attack_boss)
    if not target:is_hero() or not finds(unit_str,killer:get_name()) then 
        return 
    end    
    ac.attack_hero(killer)

    for i=1 ,3 do
        local creep = ac.creep['刷怪'..i]
        for _, unit in ipairs(creep.group) do
            -- print('刷怪单位',unit:get_name())
            ac.attack_hero(unit)
        end    
    end    

end)    

