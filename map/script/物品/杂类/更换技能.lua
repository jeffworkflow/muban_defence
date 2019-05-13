

local function random_skill(hero,slot_id,not_name,level)
    local player = hero:get_owner()
    
    local list = get_rand_skill_list(level) 

    local name = nil 
    for index,value in ipairs(list) do 
        if hero:find_skill(value) == nil and value ~= not_name then 
            name = value 
            break 
        end 
    end 

    if name == nil then 
        player:sendMsg('没有可以更换的技能了') 
        return 
    end 

    local skill = hero:find_skill(slot_id,'英雄')
    if skill then 
        skill:remove()
    end 
    

    local skill = hero:add_skill(name,'英雄',slot_id,{level = 1})
    if skill then 
        player:sendMsg('更换成功 : ' .. name .. '\n'.. skill:get_simple_tip(nil,1)) 
    else 
        player:sendMsg('更换失败') 
    end 
end


local mt = ac.item {'更换技能','精准更换1','精准更换2'}




function mt:on_add()
    local hero = self.owner 
    local player = hero:get_owner()


    local tbl = {}
    local skill = hero:find_skill(7,'英雄')
    if skill then 
        tbl[#tbl + 1] = skill
    end

    local skill = hero:find_skill(8,'英雄')
    if skill then 
        tbl[#tbl + 1] = skill
    end
    self:remove()

    if self:get_name() == '更换技能' then 
        if #tbl == 0 then 
            player:sendMsg('没有技能无法更换') 
        elseif #tbl == 2 then 
            random_skill(hero,tbl[1].slotid,tbl[2]:get_name(),10)
            random_skill(hero,tbl[2].slotid,tbl[1]:get_name(),10)
        else 
            random_skill(hero,tbl[1])
        end 
    elseif self:get_name() == '精准更换1' then 
        if tbl[1] == nil then 
            player:sendMsg('该槽位没有技能，无法更换')
        else 
            random_skill(hero,tbl[1].slotid,nil,10)
        end 
    elseif self:get_name() == '精准更换2' then 
        if tbl[2] == nil then 
            player:sendMsg('该槽位没有技能，无法更换')
        else 
            random_skill(hero,tbl[2].slotid,nil,10)
        end 
    end 

    
end 


function mt:on_remove()

end 


local mt = ac.item {'更换技能Q','更换技能W','更换技能E','更换技能R'}

function mt:on_add()
    local hero = self.owner 
    local player = hero:get_owner()
    local slot_id = self.skill.value 

    local lv = 1 
    local list = {69,25,5,1}

    local rand = math.random(100)
    local num = 0
    local level = 0
    for index,value in ipairs(list) do 
        num = num + value 
        if rand <= num then 
            level = lv + (index - 1)
            break 
        end 
    end 
    if level ~= 0 then 
        random_skill(hero,slot_id,nil,level)
    end

    self:remove()
end 

function mt:on_remove()

end 