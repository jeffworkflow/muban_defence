--统一去除物品售价提示
for name,data in pairs(ac.table.ItemData) do
    if name ~= '勇气徽章' then
        data.get_sell_tip =''
    end
end    