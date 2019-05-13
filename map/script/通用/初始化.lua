    ac.item_list = {}
    ac.shop_item_list = {}
    --物品列表
    for i=10,999 do
        local id = 'I'
        if i<=100 then
            id = id .. '0'..i
        else
            id = id..i
        end
        ac.item_list[i-9] = id
    end

    --商店物品列表 全部使用神符类物品
    -- 最多可支持 100个商人，1300商店物品 
    for i=1,1300 do
        local id = 'S'
        if i < 120 then
            id = id..'0'..math.floor( (i-1)/12 )
        else
            id=id..math.floor( (i-1)/12 )
        end
        local tx = i % 12
        if tx ==10 then
           tx = "A"
        end   
        if tx ==11 then
           tx = "B"
        end
        if tx ==0 then
           tx = "C"
        end
        id = id .. tx
        -- print(id)
        ac.shop_item_list[id] = true 
    end

    local function prd_id_by_slot_id(slot_id)
        local result ={}
        --商店物品列表 全部使用神符类物品
        for i=1,1000,12 do
            local id = 'S'
            if i < 120 then
                id = id..'0'..math.floor( (i-1)/12 )
            else
                id=id..math.floor( (i-1)/12 )
            end
            local tx = slot_id % 12
            if tx ==10 then
               tx = "A"
            end   
            if tx ==11 then
               tx = "B"
            end
            if tx ==0 then
               tx = "C"
            end
            id = id .. tx
            table.insert(result,id)
        end
        return result
    end      

	--获取一个句柄 - 商店
    function ac.get_shop_item_handle(slot_id)
        local id 
        local res_table = prd_id_by_slot_id(slot_id)
        for k,v in ipairs(res_table) do 
            if ac.shop_item_list[v] then 
                id = v
                ac.shop_item_list[v] = false
                break
            end
        end   
        
		if not id then
			print('物品句柄上限')
			return
		end

		return id
    end
    



    -- --商店物品列表 全部使用神符类物品
    -- for i=10,500 do
    --     local id = 'S'
    --     if i < 100 then
    --         id = id..'0'..i
    --     else
    --         id=id..i
    --     end
    --     ac.shop_item_list[i-9] = id
    -- end


	-- --获取一个句柄 - 商店
	-- function ac.get_shop_item_handle()
	-- 	local id = ac.shop_item_list[#ac.shop_item_list]
	-- 	if not id then
	-- 		print('物品句柄上限')
	-- 		return
	-- 	end

	-- 	table.remove(ac.shop_item_list)
	-- 	return id
	-- end