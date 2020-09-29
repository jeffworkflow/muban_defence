local panel = ac.ui.client.panel
local message = require 'jass.message'
--把魔兽自带的提示框移出屏幕外
-- japi.FrameSetPoint(japi.FrameGetTooltip(),8,game_ui,8,0.3,0.16)
--还原魔兽自带的位置 
-- japi.FrameSetPoint(japi.FrameGetTooltip(),8,game_ui,8,0,0.16)  
--当前指向的按钮
local MouseButton = nil
local shop_icon ={
    ['金币'] = [[UI\Widgets\ToolTips\Human\ToolTipGoldIcon.blp]],
    ['木头'] = [[UI\Widgets\ToolTips\Human\ToolTipLumberIcon.blp]],
    ['杀敌数'] = [[UI\small_kill.blp]],
    ['火灵'] = [[UI\small_fire_seed.blp]],
    ['积分'] = [[UI\small_jifen.blp]],
}

local tool = class.panel:builder
{
    _type = 'tooltip_backdrop',
    x = 1390,
    y = 350,
    w = 530,
    h = 400,
    level = 5,
    is_show = false,
    alpha = 0.8 ,
    title = {type = 'text',x = 16,y = 16,font_size = 15,},

    icon = {
        type = 'texture',x = 16,y = 35+16,w = 22,h = 22,normal_image = '',
        text = {
            type = 'text',
            x = 30,
            y = 0,
            w = 100,
            h = 22,
            font_size = 11,
            align = 'left',
            text = ''
        },
    },
    -- off_tip_x = 
    tip = {type = 'text',x = 16,y = 65+22,align = 'auto_height',font_size = 11},
}

function tool:hide()
    class.panel.hide(self)
    --还原魔兽自带的位置 
    japi.FrameSetPoint(japi.FrameGetTooltip(),8,game_ui,8,0,0.16)
end 


local function tooltip(title, tip)
    tool.title:set_text(title)
    tool.tip:set_text(tip)
    tool:set_position(1390, 800 - tool.h )
    tool:show()
end

local function skill_tooltip(skill,unit)
    local title = skill:get_title()
    local tip = skill:get_tip()
    tool.tip:set_position(16,65+22)
    
    if unit.unit_type == '商店' then
        title = skill.store_name or title
        local item =  skill
        local gold,show_gold,player_gold = item:buy_price()
        local wood,show_wood,player_wood = item:buy_wood()
        local kill_count,show_kill_count,player_kill = item:buy_kill_count()  
        local jifen,show_jifen,player_jifen = item:buy_jifen()
        local rec_ex,show_fire_seed,player_fire_seed = item:buy_fire_seed()
        gold = player_gold or gold
        wood = player_wood or wood
        kill_count = player_kill or kill_count
        jifen = player_jifen or jifen
        rec_ex = player_fire_seed or rec_ex
        if gold >0 then 
            skill.coin = '金币'
            gold = gold
            show_gold = show_gold
        end
        if wood >0 then 
            skill.coin = '木头'
            gold = wood
            show_gold = show_wood
        end
        if kill_count >0 then 
            skill.coin = '杀敌数'
            gold = kill_count
            show_gold = show_kill_count
        end
        if rec_ex >0 then 
            skill.coin = '火灵'
            gold = rec_ex
            show_gold = show_fire_seed
        end

        if jifen >0 then 
            skill.coin = '积分'
            gold = jifen
            show_gold = show_jifen
        end
        -- show_gold = math.tointeger(show_gold) or ('%.2f'):format(show_gold)
        -- print('是否含有拥有多少',wood,show_wood, wood)
        local icon = shop_icon[skill.coin]
        if  icon and gold>0 then   
            tool.icon.text:set_text(show_gold)
            tool.icon:show()
            tool.icon:set_normal_image(icon)
        else
            tool.icon:hide()
            tool.tip:set_position(16,35+22)
        end      
    elseif skill:get_cost() > 0 then
        tool.icon:show()
        tool.icon:set_normal_image([[image\ManaIcon.blp]])
        tool.icon.text:set_text(jass.R2I(skill:get_cost()))
    else
        tool.icon:hide()
        tool.tip:set_position(16,35+22)
    end

    tooltip(title, tip)
end

local function sttr_tooltip()
    local attr_tip = [[|cfff4d135力量：|r|cffff5722|n|r - 每点增加 |cff41c9565|r 点生命上限|n|n|cfff4d135敏捷：|r|n - 每点增加 |cff41c9561|r 点基础攻击|n|n|cfff4d135智力：|r|n - 每 |cff41c95650|r 点增加 |cff41c9561|r 点部分技能的|cffec2453真实伤害|n|n|n【属性介绍】|n|r|cfff4d135 - 穿透：|r|cffec2453|n|r造成|cff41c956非真实伤害|r时无视目标百分比护甲。|cffec2453|n|n|r|cfff4d135 - 破甲：|r|cffec2453|n|r造成|cff41c956非真实伤害|r时无视目标固定护甲。|cffec2453|n|n|r|cfff4d135 - 真伤：|r|cffec2453|n|r无视目标护甲及减伤和免伤，真伤|cfff18f24不享受除技伤加深外|r的其他伤害增幅。|cffec2453|n|n|r|cfff4d135 - 分裂：|r|cffec2453|n|r分裂伤害不享受其他攻击特效(|cff41c956被动技能|r也属攻击特效的一种)。|cffec2453|n|n|r|cfff4d135 - 护甲：|r|cffec2453|n|r除真伤外的所有伤害类型都会计算护甲。|n]]
    tooltip('属性介绍', attr_tip)
end

local function item_tooltip(item,unit)
    local title = item.color_name
    local tip = item:get_tip()..(item.suit_tip or '')
    -- print('物品tip',item.name,item.suit_tip)
    tool.tip:set_position(16,65+22)

    local gold,show_gold,player_gold = item:sell_price()
    local wood,show_wood,player_wood = item:sell_wood()
    local kill_count,show_kill_count,player_kill = item:sell_kill_count()  
    local jifen,show_jifen,player_jifen = item:sell_jifen()
    local rec_ex,show_fire_seed,player_fire_seed = item:sell_fire_seed()
    gold = player_gold or gold
    wood = player_wood or wood
    kill_count = player_kill or kill_count
    jifen = player_jifen or jifen
    rec_ex = player_fire_seed or rec_ex
    
    if gold >0 then 
        item.coin = '金币'
        gold = gold
    end
    if wood >0 then 
        item.coin = '木头'
        gold = wood
    end
    if kill_count >0 then 
        item.coin = '杀敌数'
        gold = kill_count
    end
    if rec_ex >0 then 
        item.coin = '火灵'
        gold = rec_ex
    end

    if jifen >0 then 
        item.coin = '积分'
        gold = jifen
    end

    local icon = shop_icon[item.coin]
    if not icon then   
        tool.icon:hide()
        tool.tip:set_position(16,35+22)
    else
        tool.icon:show()
        tool.icon:set_normal_image(icon)
    end    
    tool.icon.text:set_text(gold)
    
    tooltip(title, tip)
end

function panel.updateToolTip()
    button = MouseButton
    if button == nil then
        tool:hide()
        return
    end

    local unit = ac.unit.j_unit(japi.GetRealSelectUnit())
    if unit == nil then
        tool:hide()
        return
    end

    if button.type_name == '技能栏' then 
        local skill
        if unit.unit_type == '商店' and unit.sell_item_list then 
            --把魔兽自带的提示框移出屏幕外
            japi.FrameSetPoint(japi.FrameGetTooltip(),8,game_ui,8,0.3,0.16)
            -- unit:print_item()
            local item = unit.sell_item_list[button.old_slot_id]
            skill = ac.item.shop_item_map[item and item.name] --再根据名字取shop_item_map的物品
        end   

        local skl = unit:find_skill( button.slot_id, unit.skill_page or '英雄')
        if skl and skl.is_ui_text then 
            --把魔兽自带的提示框移出屏幕外
            japi.FrameSetPoint(japi.FrameGetTooltip(),8,game_ui,8,0.3,0.16)
            skill = skl
        end 
        
        if skill == nil then
            tool:hide()
            return 
        end 
        skill_tooltip(skill,unit)
    elseif button.type_name == '物品栏' then
        local item = unit:get_slot_item(button.slot_id)
        --把魔兽自带的提示框移出屏幕外
        japi.FrameSetPoint(japi.FrameGetTooltip(),8,game_ui,8,0.3,0.16)
        if item  == nil then 
            tool:hide()
            return
        end
        item_tooltip(item,unit)
    -- elseif button.type_name == '属性栏' then
    --     sttr_tooltip()
    end
end

--鼠标进入事件
function panel:on_button_mouse_enter(button)
    MouseButton = button
    panel.updateToolTip(button)
end
--鼠标离开事件
function panel:on_button_mouse_leave(button)
    MouseButton = nil
    tool:hide()
end

--画按钮
local function init()
    local slots = {9,10,11,12,5,6,7,8,1,2,3,4}
    
    local function create_button(p,x,y,w,h)
        local button = p:add_button('',x,y,w,h)
        return button
    end

    local slot_id = 0
    --整个技能栏的面板
    local skillPanel = panel:add_panel('',1480,841,417,230)
    local buttonList = {}
    --画12个技能栏按钮
    for row = 0, 2 do
        local y = 3 + row * 68 + row * 9
        for column = 0, 3 do 
            slot_id = slot_id + 1
            local x = 4 + column * 90 + column * 15
            local button = create_button(skillPanel,x, y, 90, 68)
            button.old_slot_id = slot_id
            button.slot_id = slots[slot_id]
            button.type_name = '技能栏'
            buttonList[slot_id] = button
        end 
    end

    skillPanel.buttonList = buttonList
    panel.skillPanel = skillPanel

    slot_id = 0
    --整个物品栏的面板
    local itemPanel = panel:add_panel('',1235,875,179,201)
    local buttonList = {}
    for row = 0,2 do
        local y = 4 + row * 56 + row * 13
        for column = 0,1 do 
            slot_id = slot_id + 1
            local x = 4 + column * 75 + column * 21
            local button = create_button(itemPanel,x, y, 75, 56)
            button.slot_id = slot_id
            button.type_name = '物品栏'
            buttonList[slot_id] = button
        end 
    end
    itemPanel.buttonList = buttonList
    panel.itemPanel = itemPanel

    local button = create_button(panel,989,908,65,49)
    button.type_name = '属性栏'
end
init()

--每秒刷新
ac.loop(1000,function()
    if ac.player.self then
        ac.ui.client.panel.updateToolTip()
        -- ac.ui.client.panel.updateAttr()
    end
end)

------------==开始复制通用 tooltip-------------------
function get_str_line(str,count)
    local a = 1
    local b = 1
    local c = 0
    local line = 0
    count = count - 3
    str = str:gsub('|c%w%w%w%w%w%w%w%w','')
    str = str:gsub('|r','')
     while (a <= str:len()) do
        local s = str:sub(a,a)
        if s:byte() > 127 then
            c = c+1
            if c == 3 then
                c = 0
            end
        else
            c = 0
        end
        if (b > count and c == 0) or s == '\n' or a == str:len() then
            if s == '\n' then
                s = str:sub(a - b + 1,a - 1)
            else
                s = str:sub(a - b + 1,a)
            end
            line = line + 1
            b = 0
        end
        a = a+1
        b = b+1
    end
    return line
end
local tool2 = class.panel:builder
{
    _type = 'tooltip_backdrop',
    x = 0,--假的
    y = 0,--假的
    w = 350,
    h = 200,
    level = 5,
    is_show = false,
    alpha = 0.8,

    title = {type = 'text',x = 16,y = 16,font_size = 15,},
    -- off_tip_x = 
    tip = {type = 'text',x = 16,y = 65,old_x=16,old_y=65,align = 'auto_height',font_size = 11,},
}
local tools ={
    tooltip = function (self,title,tip,pos,pWidth,pHeight,font_size)
        
        local width,height = pWidth or 350 ,pHeight or 200
        local x,oy = self:get_real_position() 

        local max_height = get_str_line(tip,13*3-1) * 24 + 32
        if max_height < height then 
            max_height = height
        end 
        y = oy - max_height / 2 + self.h / 2 

        if pos == nil or pos == 0 then 
            x = x + self.w + 5 
        elseif pos == 1 or pos == -1 then 
            x = x - width - 5 
        elseif pos == 2 then 
            x = x - width / 2  + self.w / 2
            y = oy - max_height
        end 

        x = math.min(math.max(10,x),1900)
        y = math.min(math.max(10,y),1080)

        local title_str = title
        local title_align = 'auto_newline'
        if type(title) == 'table' then 
            title_str = title[1] 
            title_align = title[2]
        end 

        tool2.tip:set_width(width or 530)
        tool2.title:set_text(title)
        tool2.tip:set_text(tip)
        if title == '' or not title then 
            tool2.tip:set_position(tool2.tip.x,tool2.title.y)
        else 
            tool2.tip:set_position(tool2.tip.old_x,tool2.tip.old_y)
        end    
        if anchor then 
            self:set_tooltip_follow(tool2, anchor)
        else 
            tool2:set_position(x, y)
        end 
        tool2:show()
    end,
    remove_tooltip = function(self)
        tool2:hide()
    end,
}

local real_remove = class.ui_base.remove_tooltip
for name, func in pairs(tools) do 
    class.ui_base[name] = func
end 
tools.old_remove_tooltip =  real_remove