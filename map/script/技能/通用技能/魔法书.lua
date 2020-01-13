
local slots = {9,10,11,12,5,6,7,8,1,2,3,4}
-- local s2s = {9,10,11,12,5,6,7,8,1,2,3,4}


local function hide(skill)
    if not skill:is_hide() then 
        skill:hide()
        skill:remove_ability(skill.ability_id)
    end
end 

local function show(skill)
    if skill:is_hide() then 
        skill:add_ability(skill.ability_id)
        skill:show()
    end
    skill:fresh()
end 

local function update_page(hero)
    local player = hero:get_owner()
    if player:is_self() then 
        ClearSelection()
        SelectUnit(hero.handle,true)
    end 
end

local function hide_page(hero,page_type,page_id)

    page_id = page_id or 0 

    local page = page_type
    if page_id > 1 then 
        page = page_type .. '_0' .. page_id
    end

    for i = 1, 12 do 
        local skill = hero:find_skill(slots[i],page,true)
        if skill then 
            hide(skill)
        end 
    end
end 

local function show_page(hero,page_type,page_id)

    page_id = page_id or 0 
    local page = page_type
    if page_id > 0 then 
        page = page_type .. '_0' .. page_id
    end

    for i = 1, 12 do 
        local skill = hero:find_skill(slots[i],page,true)
        if skill then 
            show(skill)
        end 
    end

end
local function upgrade_last_skill(hero,page_type,page_id,book)

    page_id = page_id or 0 

    local page = page_type
    if page_id > 0 then 
        page = page_type .. '_0' .. page_id
    end

    local skill = hero:find_skill(slots[12],page,true)
    if skill then 
        skill:remove()
    end
    local end_name = '下一页'
    local max_page_count = math.modf( table.maxnum(book.skills)/11 )
    local old_max_page2 = math.max(math.modf((table.maxnum(book.skill_list)-1) / 12),0)
    
    if page_id == max_page_count or (page_id+1)*11 == table.maxnum(book.skills) then 
        end_name = '关闭'
    end
    -- print('改变了了最后一个技能：',end_name,page_id)
    local skl = hero:add_skill(end_name,page,slots[12],{
        book = book,
        page_count = old_max_page2,
        current_page = page_id,
    })
    if not book.hide_book then 
        hide(skl)
    end
    book.skill_list[(page_id+1)*12] = skl 
    return skl
end 

ac.game:event '技能-获得' (function (_,hero,self)
    if self.is_spellbook == nil or self.skills == nil then 
        return 
    end 
    local player = hero:get_owner()
    local skill_list = {}
    local page_type = self:get_type() .. '_' .. string.format("%01x",self.slotid)
    local skill_book = {}
    local max_page_count = math.modf(table.maxnum(self.skills) / 11)
    local real_page_count = math.max(math.modf((table.maxnum(skill_list)-1) / 12),0)
    local page = page_type

    for page_id = 0,max_page_count do 
        if page_id > 0 then 
            page = page_type .. '_0' .. page_id
        end 
        for i = 1, 11 do 
            local id = page_id * 11 + i 
            local name = self.skills[id]
            if name then 
                local skill = hero:add_skill(name,page,slots[i],{
                    book = self,
                    page_count = real_page_count,
                    current_page = page_id,
                })
                skill_list[page_id * 12 + i ] = skill 
                skill_book[page_id * 12 + i ] = skill
            end 
        end
        local end_name = '下一页'
        if page_id == max_page_count or (page_id+1)*11 == table.maxnum(self.skills)  then 
            end_name = '关闭'
        end 
        -- print('魔法书，最后一个技能名，页面',self.name,end_name,page)
        local skill = hero:add_skill(end_name,page,slots[12],{
            book = self,
            page_count = real_page_count,
            current_page = page_id,
        })
        hide(skill)
        skill_list[(page_id+1) * 12] = skill 

        if (page_id+1)*11 == table.maxnum(self.skills) then 
            break 
        end
    end 
    self.skill_list = skill_list   
    --不包含关闭技能的列表
    self.skill_book = skill_book
    for i=1,table.maxnum(self.skill_list) do 
        local skill = self.skill_list[i]
        if skill then
            hide(skill)
        end    
    end 
end)
local function get_nil_slot(tab)
    for i=1,table.maxnum(tab) do 
        -- print(i,tab[i])
        if not tab[i]  then 
            return i 
        end 
    end
    return table.maxnum(tab) +1   
end   
  
ac.game:event '技能-插入魔法书' (function (_,hero,book_skill,skl)
    if type(book_skill) == 'string' then 
        book_skill = hero:find_skill(book_skill,nil,true)
    end    
    if not book_skill then 
        return 
    end 
    local self = book_skill
    local player = hero:get_owner()
    local page_type = self:get_type() .. '_' .. string.format("%01x",book_skill.slotid)
    
    local old_max_page = math.modf(table.maxnum(self.skills)/ 11)
    local old_max_page2 = math.max(math.modf((table.maxnum(self.skill_list)-1) / 12),0)
    local name = skl
    local index = get_nil_slot(self.skills)
    self.skills[index] = name
    local max_page_count = math.modf(table.maxnum(self.skills)/ 11)

    local page_id = math.modf((index+old_max_page)/ 12)
    local page = page_type
    if page_id > 0 then 
        page = page_type .. '_0' .. page_id
    end 
    local i = index - page_id * 12 + old_max_page 
    -- print('插入魔法书',index,index + old_max_page,name,page_id,max_page_count)
    local skill = hero:add_skill(name,page,slots[i],{
        book = self,
        page_count = old_max_page2,
        current_page = page_id,
    })

    skill.book_slot_id = i
    self.skill_list[index + old_max_page] = skill
    self.skill_book[index + old_max_page] = skill
    --改变当前页最后一个按钮
    upgrade_last_skill(hero,page_type,page_id,self)
    --当前页 >老的最大页。 
    if page_id > old_max_page2 then 
        --改变上一页最后一个按钮
        upgrade_last_skill(hero,page_type,page_id -1,self)
    end 

    if not self.hide_book then
        hide(skill)
    end

    ac.game:event_notify('技能-插入魔法书后',hero,book_skill,skl)
    return skill
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
        skl = hero:find_skill(skl,nil,true)
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
    local page_id = skl.current_page
    local slot = slots[skl.slotid] + page_id * 12
    local page_count = skl.page_count --第11个就为第二页。
    local skills_slot = slot - page_count
    -- local slot = skl.book_slot_id
    -- skl.book_slot_id = nil
    print('删除魔法书：',slot,skills_slot,page_id,page_count)
    self.skill_list[slot] = nil
    self.skill_book[slot] = nil
    self.skills[skills_slot] = nil
    
    skl:remove()

    ac.game:event_notify('技能-删除魔法书后',hero,book_skill,skl)
end)


ac.game:event '技能-施法完成' (function (_,hero,self)
    if self.is_spellbook == nil or self.skills == nil then 
        return 
    end 
    local page_type = self:get_type() .. '_' .. string.format("%01x",self.slotid)
    --如果是自动下一页页面
    if self.page_count and self.page_count > 0 then 
        page_type = self:get_type() .. '_0' .. string.format("%01x",self.slotid)
    end
    hero.skill_page = page_type
    self.parent_skill.hide_book = true 
    hide_page(hero,self:get_type(),0)
    show_page(hero,page_type,0)
    update_page(hero)
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
        for i=1,table.maxnum(self.skill_list) do
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

local mt = ac.skill['关闭']

function mt:on_cast_start()
    local hero = self.owner
    local player = hero:get_owner()
    local book = self.book
    -- print(self.book.name,self.name,self.hide_book)
    if book.hide_book == nil then 
        return 
    end 
    hero.skill_page = book:get_type()

    book.hide_book = nil 
    for i=1,table.maxnum(book.skill_list) do 
        local skill = book.skill_list[i]
        if skill then 
            hide(skill)
        end
    end

    for skill in hero:each_skill(book:get_type(),true) do 
        show(skill)
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

    for i=1,table.maxnum(book.skill_list) do 
        local skill = book.skill_list[i]
        if skill then 
            hide(skill)
        end
    end

    for skill in hero:each_skill('英雄',true) do 
        show(skill)
    end 
end 

local mt = ac.skill['下一页']
mt.art =[[ReplaceableTextures\CommandButtons\BTNReplay-Play.blp]]

function mt:on_cast_start()
    local hero = self.owner
    local player = hero:get_owner()
    local book = self.book
    
    if book.hide_book == nil then 
        return 
    end 

    local page_type = book:get_type() .. '_' .. string.format("%01x",book.slotid)
    local current_page = self.current_page
    hide_page(hero,page_type,current_page)
    show_page(hero,page_type,current_page + 1)
    hero.skill_page = page_type .. '_0' .. current_page + 1
end 


ac.game:event'单位-获得技能' (function (_,hero,skill)
    if skill and skill.slot_type == '英雄' then 
        local skl = hero:find_skill('关闭',hero.skill_page or '英雄')
        if skl and not skl:is_hide() then 
            skl:close()
        end 
    end
end)


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

--临时测试
-- local i=0
-- ac.game:event '玩家-聊天' (function(self, player, str)
--     local hero = player.hero
--     local p = player
--     local peon = player.peon
--     if str =='1' then 
--         print('插入魔法书')
--         i=i+1
--         local name = '测1试技能'..i
--         ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',name)
--     else 
--         print('删除魔法书')
--         local name = '测1试技能'..str
--         ac.game:event_notify('技能-删除魔法书',hero,'精彩活动',name)
--     end

-- end)