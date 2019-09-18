--统一去除物品售价提示
for name,data in pairs(ac.table.ItemData) do
    if name ~= '勇气徽章' then
        data.get_sell_tip =''
    end
end    

local function clear_item_bug(u)
    if not u  then  return end
    if not u.item_list then return end
    for i=1,18 do 
        local handle = u.item_list[i] and u.item_list[i].handle
        if not handle then 
            u.item_list[i] = nil 
        end    
    end
end    
--修复卡红装bug
ac.loop(1000,function()
    for i=1,10 do 
        local p = ac.player(i)
        if p:is_player() then 
            clear_item_bug(p.hero)
            clear_item_bug(p.peon)
        end
    end       
end)

