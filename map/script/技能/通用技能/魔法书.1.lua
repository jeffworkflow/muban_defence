
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

    -- for index,name in ipairs(self.skills) do 
    for i = 1,#self.skills do     
        local name = self.skills[i]
        if name then 
            local skill = hero:add_skill(name,page_type,slots[i],{
                book = self,
            })
            skill_map[name] = skill
            table.insert(skill_list,skill)
            table.insert(skill_book,skill)
            --记录一下所在位置
            skill.book_slot_id = #skill_list
        end    
    end 
    local skill = hero:add_skill('关闭',page_type,slots[12],{
        book = self,
    })

    skill.book_slot_id = 12
    skill_list[12] = skill
    
    --记录一下魔法书内技能数量
    self.skill_count = #skill_list + 1 --吧关闭按钮也算进去

    --包含关闭技能的列表
    self.skill_list = skill_list
    self.skill_map = skill_map
    
    --不包含关闭技能的列表
    self.skill_book = skill_book

    for i=1,12 do
        local skill = self.skill_list[i]
        if skill then
            if not skill:is_hide() then 
                skill:hide()
                skill:remove_ability(skill.ability_id)
            end
        end
    end
end)
local function get_nil_slot(tab)
    for i=1,11 do 
        if not tab[i]  then 
            return i 
        end 
    end
    return     
end   
  
ac.game:event '技能-插入魔法书' (function (_,hero,book_skill,skl)
    if type(book_skill) == 'string' then 
        book_skill = hero:find_skill(book_skill,nil,true)
    end    
    if not book_skill then 
        return 
    end 
    local self = book_skill

    -- print(hero,book_skill,skl)
    local player = hero:get_owner()
    local page_type = self:get_type() .. '_' .. string.format("%01x",book_skill.slotid)
    
    local name = skl
    local index = get_nil_slot(self.skill_list)
    --判断魔法书是否满了
    if not index then
        print('该魔法书已满',self.name,name)
        return
    end

    local skill = hero:add_skill(name,page_type,slots[index],{
            book = self,
        })

    skill.book_slot_id = index
    self.skill_map[name] = skill
    self.skill_list[index] = skill
    self.skill_book[index] = skill
    
    local skl = hero:find_skill('关闭',hero.skill_page or '英雄')
    if not skl then
        if not skill:is_hide() then 
            skill:hide()
            skill:remove_ability(skill.ability_id)
        end
    end
    ac.game:event_notify('技能-插入魔法书后',hero,book_skill,skl)
end)


ac.game:event '技能-删除魔法书' (function (_,hero,book_skill,skl)
    if type(book_skill) == 'string' then 
        book_skill = hero:find_skill(book_skill,nil,true)
    end    
    if not book_skill then 
        return 
    end 
    local self = book_skill

    if type(skl) == 'string' then
        skl = self.skill_map[skl]
    elseif type(skl) == 'table' then
        if not skl.book then
            return
        end
        skl = skl
    else
        skl = self.skill_list[skl]
    end
    
    if not skl then
        return
    end
    
    local slot = skl.book_slot_id
    skl.book_slot_id = nil
    self.skill_map[skl.name] = nil
    self.skill_list[slot] = nil
    self.skill_book[slot] = nil
    
    skl:remove()

    ac.game:event_notify('技能-删除魔法书后',hero,book_skill,skl)
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
    for i=1,12 do
        local skill = self.skill_list[i]
        if skill then
            if skill:is_hide() then 
                skill:add_ability(skill.ability_id)
                skill:show()
            end
            skill:fresh()
        end
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
        for i=1,12 do
            local skill = self.skill_list[i]
            if skill then
                skill:remove()
            end
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

关闭，回到上一级
    ]],
    instant = 1,
    is_order = 1,
    key = 'Esc',
}

-- local mt = ac.skill['下一页']
-- mt{
--     art = [[ReplaceableTextures\CommandButtons\BTNReplay-Play.blp]],
--     title = '下一页',
--     tip = [[

-- 查看 下一页
--     ]],
--     instant = 1,
--     is_order = 1,
-- }
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
    for i = 1,12 do
        local skill = book.skill_list[i]
        if skill then
            if not skill:is_hide() then 
                skill:hide()
                skill:remove_ability(skill.ability_id)
            end
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
    if book.hide_book == nil then 
        return 
    end 
    hero.skill_page = nil
    book.hide_book = nil 
    for i = 1,12 do
        local skill = book.skill_list[i]
        if skill then
            if not skill:is_hide() then 
                skill:hide()
                skill:remove_ability(skill.ability_id)
            end
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


