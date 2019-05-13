



ac.game:event '造成伤害开始' (function (_,damage)
    if damage:is_common_attack() == false then 
        return 
    end

    local hero = damage.source 
    local target = damage.target 
    if hero.is_boss == nil  then 
        if target.is_boss == nil then 
            return 
        else 
            hero = damage.target
            target = damage.source
        end 
    end 

   

    local list = {}
    for skill in hero:each_skill '英雄' do 
        table.insert(list,skill)
    end 

    if #list == 0 then 
        return 
    end 
    local skill  = list[math.random(#list)]

    if skill == nil then 
        return 
    end 
   
    local rand = math.random(100)
    if rand <= 30 then 
        if skill.target_type == 0 then 
            skill:cast()
        elseif skill.target_type == 1 then  
            skill:cast(target)
        else 
            skill:cast(target:get_point())
        end 
    end 
end)