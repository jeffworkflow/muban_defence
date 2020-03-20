
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
    if page_id > 0 then 
        page = page_type .. '_0' .. page_id
    end

    -- print('隐藏页面：',page)
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
    -- print('显示页面：',page)
    for i = 1, 12 do 
        local skill = hero:find_skill(slots[i],page,true)
        if skill then 
            show(skill)
        end 
    end

end
local function update_last_skill(hero,page_type,current_page,book)
    current_page = current_page or 0 
    local page = page_type
    if current_page > 0 then 
        page = page_type .. '_0' .. current_page
    end

    local skill = hero:find_skill(slots[12],page,true)
    if skill then 
        skill:remove()
    end
    local max_page_count = math.max(math.modf((table.maxnum(book.skill_list)-1) / 12),0)
    local end_name = '下一页'
    if current_page == max_page_count then 
        end_name = '关闭'
    end
    -- print('改变了了最后一个技能：',end_name,page,current_page,max_page_count)
    local skl = hero:add_skill(end_name,page,slots[12],{
        book = book,
        page_count = max_page_count,
        current_page = current_page,
    })
    if not book.is_opening  --or (hero.book_page ~= current_page) 
    then
        hide(skl)
    end
    --当前页从0开始
    book.skill_list[(current_page+1)*12] = skl 
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
    local real_max_page_count = math.max(math.modf((table.maxnum(skill_list)-1) / 12),0)
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
                    page_count = real_max_page_count,
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
            page_count = real_max_page_count,
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
    
    local name = skl
    local old_max_page = math.max(math.modf((table.maxnum(self.skill_list)-1) / 12),0)
    local index = get_nil_slot(self.skill_list)
    self.skill_list[index] = name
    --最大页数
    local new_max_page = math.max(math.modf((table.maxnum(self.skill_list)-1) / 12),0)

    --当前页面
    local current_page = math.modf(index/ 12)
    local page = page_type
    if current_page > 0 then 
        page = page_type .. '_0' .. current_page
    end 
    local i = index - current_page * 12
    -- print('插入魔法书',index,page,current_page,old_max_page,new_max_page)
    local skill = hero:add_skill(name,page,slots[i],{
        book = self,
        page_count = new_max_page,
        current_page = current_page,
    })

    skill.book_slot_id = i
    self.skill_list[index] = skill
    self.skill_book[index] = skill
    --改变当前页最后一个按钮
    update_last_skill(hero,page_type,current_page,self)
    --当前页 >老的最大页。 
    if current_page > old_max_page then 
        --改变上一页最后一个按钮
        update_last_skill(hero,page_type,current_page -1,self)
    end 
    --如果魔法书是打开状态 且 英雄当前选择的页面和即将插入的魔法书的页面一致时，显示该技能
    if not self.is_opening --or (hero.book_page ~= current_page)  
    then
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
    -- print('删除魔法书：',slot,skills_slot,page_id,page_count)
    self.skill_list[slot] = nil
    self.skill_book[slot] = nil
    
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
    hero.book_page = 0
    self.parent_skill.is_opening = true 
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
    -- print(self.book.name,self.name,self.is_opening)
    if book.is_opening == nil then 
        return 
    end 
    hero.skill_page = book:get_type()
    hero.book_page = nil

    book.is_opening = nil 
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
    if book.is_opening == nil then 
        return 
    end 
    hero.skill_page = nil
    hero.book_page = nil
    book.is_opening = nil 

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
    
    if book.is_opening == nil then 
        return 
    end 
    hero.book_page = hero.book_page + 1
    local page_type = book:get_type() .. '_' .. string.format("%01x",book.slotid)
    local current_page = self.current_page
    hide_page(hero,page_type,current_page)
    hide_page(hero,page_type,current_page + 1)
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