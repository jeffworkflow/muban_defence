
ac.game:event'单位-获得技能' (function (_,hero,skill)
    local p = hero:get_owner()
    --获得技能的单位不是玩家此时选择的单位，需要刷新玩家此时选择单位同槽位的技能
    if p.selected and (p.selected.handle ~= hero.handle) then 
        -- print(skill.slotid)
        local skl = p.selected:find_skill(skill.slotid,'英雄',true)
        if skl then 
            skl:fresh() 
        end
    end    
end)

ac.game:event'技能-升级' (function (_,hero,skill)
    local p = hero:get_owner()
    --获得技能的单位不是玩家此时选择的单位，需要刷新玩家此时选择单位同槽位的技能
    if p.selected and (p.selected.handle ~= hero.handle) then 
        -- print(skill.slotid)
        local skl = p.selected:find_skill(skill.slotid,'英雄',true)
        if skl then 
            skl:fresh() 
        end
    end    
end)