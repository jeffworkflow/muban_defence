
local slots = {9,10,11,12,5,6,7,8,1,2,3,4}

ac.game:event '技能-获得' (function (_,hero,self)
    if self.is_spellbook == nil or self.skills == nil then 
        return 
    end 
    local player = hero:get_owner()
    local skill_list = {}
    local skill_map = {}
    local page_type = self:get_type() .. '_' .. string.format("%01x",self.slotid)
    
    local skill_book = {}

    for index,name in ipairs(self.skills) do 
        local skill = hero:add_skill(name,page_type,slots[index],{
            book = self,
        })
        skill_map[name] = skill
        table.insert(skill_list,skill)
        table.insert(skill_book,skill)
    end 
    local skill = hero:add_skill('关闭',page_type,slots[12],{
        book = self,
    })
    table.insert(skill_list,skill)

    --包含关闭技能的列表
    self.skill_list = skill_list
    self.skill_map = skill_map
    
    --不包含关闭技能的列表
    self.skill_book = skill_book

    for index,skill in ipairs(self.skill_list) do 
        if not skill:is_hide() then 
            skill:hide()
            skill:remove_ability(skill.ability_id)
        end
    end 
end)

ac.game:event '技能-施法完成' (function (_,hero,self)
    if self.is_spellbook == nil or self.skills == nil then 
        return 
    end 
    local player = hero:get_owner()
    local page_type = self:get_type() .. '_' .. string.format("%01x",self.slotid)

    hero.skill_page = page_type

    self.parent_skill.hide_book = true 
    for skill in hero:each_skill(self:get_type(),true) do 
        skill:hide()
        skill:fresh()
    end 

    for index,skill in ipairs(self.skill_list) do 
        if skill:is_hide() then 
            skill:add_ability(skill.ability_id)
            skill:show()
        end

        skill:fresh()
    end 

    if player:is_self() then 
        ClearSelection()
        SelectUnit(hero.handle,true)
    end 

end)

ac.game:event '单位-失去技能'(function (_,hero,self)
    if self.is_spellbook == nil or self.skills == nil then 
        return 
    end 
    local skl = hero:find_skill('关闭',hero.skill_page or '英雄')
    if skl and not skl:is_hide() then 
        skl:close()
    end 
    if self.skill_list then 
        for index,skill in ipairs(self.skill_list) do 
            skill:remove()
        end 
        self.skill_list = nil
    end 
    self.skill_book = nil
end)


local mt = ac.skill['关闭']
mt{
    art = [[ReplaceableTextures\CommandButtons\BTNCancel.blp]],
    title = '关闭',
    tip = [[
关闭，回到上一级。
    ]],
    instant = 1,
    is_order = 1,
    key = 'Esc',
}
-- ['魔法书']
-- is_order = 2
-- art = [[ReplaceableTextures\CommandButtons\BTNSpellBookBLS.blp]]
-- title = '打开魔法书'
-- tip = [[
-- 打开魔法书
-- ]]
-- instant = 1

-- is_spellbook = 1

-- skills = {

-- }

function mt:on_cast_start()
    local hero = self.owner
    local player = hero:get_owner()
    local book = self.book
    if book.hide_book == nil then 
        return 
    end 
    hero.skill_page = book:get_type()

    book.hide_book = nil 
    for index,skill in ipairs(book.skill_list) do 
        if not skill:is_hide() then 
            skill:hide()
            skill:remove_ability(skill.ability_id)
        end
    end 

    for skill in hero:each_skill(book:get_type(),true) do 
        if skill:is_hide() then 
            skill:add_ability(skill.ability_id)
            skill:show()
            skill:fresh()
        end
    end 
end 

function mt:close()
    local hero = self.owner
    local player = hero:get_owner()
    local book = self.book
    -- hero = player.selected
    if book.hide_book == nil then 
        return 
    end 
    hero.skill_page = nil
    book.hide_book = nil 
    for index,skill in ipairs(book.skill_list) do 
        if not skill:is_hide() then 
            skill:hide()
            skill:remove_ability(skill.ability_id)
        end
    end

    for skill in hero:each_skill('英雄',true) do 
        if skill:is_hide() then 
            skill:show()
            skill:fresh()
        end
    end 
end 

ac.game:event'单位-获得技能' (function (_,hero,skill)
    if skill and skill.slot_type == '英雄' then 
        local skl = hero:find_skill('关闭',hero.skill_page or '英雄')
        if skl and not skl:is_hide() then 
            skl:close()
        end 
    end
end)

-- ac.game:event '玩家-选择单位' (function (_,player,unit)
--     local hero = player:get_hero()
--     -- print(unit,hero)
--     if hero == unit or hero == nil then 
--         return 
--     end 
--     local skl = unit:find_skill('关闭',unit.skill_page or '英雄')
--     if skl and not skl:is_hide() then 
--         skl:close()
--     end 
-- end)


ac.game:event '玩家-选择单位' (function (_,player,unit)
    local hero = player:get_hero()
    local pet = player.peon
    
    if pet and pet ~= unit then
        local skl = pet:find_skill('关闭',pet.skill_page or '英雄')
        -- print(skl.name,pet.skill_page)
        if skl and not skl:is_hide() then
            skl:close()
        end 
    end

    
    if hero == unit or hero == nil then 
        return 
    end 

    local skl = hero:find_skill('关闭',hero.skill_page or '英雄')
    if skl and not skl:is_hide() then 
        skl:close()
    end 
    
end)


