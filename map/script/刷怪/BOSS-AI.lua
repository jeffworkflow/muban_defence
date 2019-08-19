local function cast_skill(hero,target,type)
    -- print(hero,hero.data.type)
    if not finds(hero.unit_type,'boss','精英') then 
        return 
    end   

    local list = {}
    for skill in hero:each_skill '英雄' do 
        table.insert(list,skill)
    end 

    if #list == 0 then 
        return 
    end 
    local skill  
    --@type=1 攻击概率触发， 2 每秒触发 
    if type ==1 then 
        skill = list[math.random(#list)]
    else
        for i=1,#list do 
            skill = list[i]
            if not skill:is_cooling() and skill.target_type == 0 then 
                break
            end    
        end    
    end    
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
        cast_skill(hero,target,1)
    end 
end)


ac.loop(1000,function()
    for _,u in ac.selector()
        : in_rect()
        : add_filter(function(dest)
            return (dest:is_type('boss') or dest:is_type('精英'))
        end)
        : ipairs()
    do
        cast_skill(u,nil,2)
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

