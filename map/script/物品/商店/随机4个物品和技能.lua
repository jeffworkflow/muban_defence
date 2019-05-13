

local function fresh_shop_item(shop)
    -- for k,v in sortpairs(ac.quality_item) do
    --     print('商店随机4物品：',k,#v)
    --     for _,v1 in ipairs(v) do
    --         print(k,v1)
    --     end    
    -- end  
    for i = 9, 12 do 
        local rand_list = ac.unit_reward['商店随机物品']
        local rand_name = ac.get_reward_name(rand_list)
        if not rand_name then 
            return
        end    
        -- print(1)
        -- for k,v in sortpairs(ac.quality_item) do
        --     print('商店随机4物品：',k,#v)
        --     -- for _,v1 in ipairs(v) do
        --     --     print(k,v1)
        --     -- end    
        -- end    
        local list = ac.quality_item[rand_name]  
        -- print(2) 
        -- print('商店随机4物品：',rand_name,#list)
        -- local list = {'敏捷丹','敏捷丹','敏捷仙丹','巫术丹','召唤丹'} 物品少于4种会死循环
        --添加 
        -- for i=1,#list do 
        --     print(rand_name,list[i])
        -- end    
        local name 
        local flag =true
        while flag do
            name = list[math.random(#list)] 
            flag = false 
            for i=9,12 do 
                if shop.sell[i] == name then 
                    flag = true
                    break
                end
            end     
        end    
        -- print(3,name) 
        shop.sell[i] = name
        shop.sell_new_gold[i] = true
        -- shop:add_sell_item(name,i)
    end 
    -- print(4) 
    -- shop.sell[5] = '翔龙'
    --刷新商店物品，先全部删除，再挨个添加
    shop:fresh()
    -- print(5) 

    --再循环一次，添加物品被购买时移除的触发。
    for i = 9, 12 do 
        local old_item = shop.sell_item_list[i]
        old_item.on_selled_remove = true 
    end    
    -- print(6) 

end    

local function fresh_shop_skill(shop)
    for i = 9, 12 do 
        --删除商店的物品
        -- local old_item = shop.sell_item_list[i]
        -- if old_item then 
        --     -- print('即将删除商店技能：',old_item.name)
        --     shop:remove_sell_item(old_item.name)
        -- end    

        local rand_list = ac.unit_reward['商店随机技能']
        local rand_name = ac.get_reward_name(rand_list)
        if not rand_name then 
            return
        end    
        
        local list = ac.skill_list2
        --添加 
        local name
        local flag =true
        while flag do
            name = list[math.random(#list)] 
            flag = false 
            for i=9,12 do 
                if shop.sell[i] == name then 
                    flag = true
                    break
                end
            end     
        end    
        -- print('即将添加商店物品：',name,i)
        -- shop:add_sell_item(name,i)
        shop.sell[i] = name
        shop.sell_new_gold[i] = true
        
    end   
    --刷新商店物品，先全部删除，再挨个添加
    shop:fresh()
    --再循环一次，添加物品被购买时移除的触发。
    for i = 9, 12 do 
        local old_item = shop.sell_item_list[i]
        old_item.on_selled_remove = true 
    end    
    
end   
ac.map.fresh_shop_skill = fresh_shop_skill
ac.map.fresh_shop_item = fresh_shop_item