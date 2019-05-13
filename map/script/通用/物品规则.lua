--[[
    
物品类型：
    神符： 如力量书，副本传送，练功房刷怪
        主动创建：创建一个没有所属，没有技能的物品在地上 > 拾取时绑定所属 绑定技能给单位 > 直接触发施法事件 > 删除技能 > 触发on_remove事件 > 删除物品
        商店点击: 创建一个没有所属，没有技能的物品在地上 > 关联所属单位 绑定技能给单位 > 直接触发施法事件 > 删除技能 > 触发on_remove事件 > 删除物品

    消耗品：消耗品初始count必须>=1，每次使用都会-1，为0是被删除，获得时叠加  
        拾取与商店：
            判断1：判断当前页面是否有同类物品 > 没有则判断是否有空位 > 没有空位则跳出
            判断2：判断当前页面是否有同类物品 > 没有则判断是否有空位 > 有空位则添加新物品 > 触发获得物品事件 
            判断3：判断当前页面是否有同类物品 > 有则修改物品数量

        给与：满格时无法给与物品，所以只能通过 获得物品事件来捕捉 > 有同类物品则叠加 > 没有则不再做处理

    装备：
        拾取与商店：   
            有空位 > 判断是否唯一 > 唯一则不执行 > 否则添加
        给与：
            判断是否唯一 > 唯一则执行丢弃


    商店购买：
        符文类：钱够则直接依次响应 on_add on_cast_start on_remove 三个事件
        消耗品：钱够 1.物品栏满时 叠加or购买失败 2.物品栏未满：叠加or新建物品(新建物品会触发获得物品事件)
        其他类：判断是否唯一 判断是否同类超出数量 判断是否有空位，全部符合则新建物品(新建物品会触发获得物品事件)

    拾取物品：
        符文类：直接依次响应 on_add on_cast_start on_remove 三个事件
        消耗品：1.物品栏满时 叠加or拾取失败 2.物品栏未满：叠加or添加物品(添加物品会触发获得物品事件)
        其他类：判断是否唯一 判断是否同类超出数量 判断是否有空位，全部符合则添加物品(添加物品会触发获得物品事件)

    给与物品：(先触发source单位的丢弃事件,在触发target单位的获得事件)
        符文类：符文类永远不会存在于身上,所以不存在给与
        消耗品：target单位物品栏满时魔兽机制会丢弃物品在地上(不触发target单位的事件),所以不管是叠加还是添加物品，都会触发target的获得物品事件
        其他类：同上


    获得物品事件的作用：1.初始化物品技能(依次触发：on_add on_cast_start on_remove 三个事件) 2.绑定所属单位 3.保存物品所在槽位 4.可能触发【给与物品事件】
    能触发获得物品事件的：商店购买，给与物品，拾取物品
    所有逻辑处理都在这三个事件内完成了，也就是说【获得物品事件】一定是满足条件后才会触发的，不需要在做逻辑处理

]]
 

    ac.game:event '单位-即将获得物品'(function(_,u,it)
        if not it then 
            print('物品已被删除')
            return true
        end    
        -- print(it.item_type,it.type_count)
        --先判断是否为神符类
        if it.item_type == '神符' then
          
            -- local items = ac.item.create_item(it.name)
            -- it.slot_id = 1
            it.owner = u
            --为物品添加技能
            it:item_init_skill()

            --进入施法流程
            if it:_call_event 'on_cast_start' then 
                it.owner = nil
                return true
            end    
            --使用物品，类似消耗品
            it:on_use_state()

            it:_call_event 'on_remove'
            --表示购买成功
            u.buy_suc = true
            --回收句柄
            it.recycle = true
            return true
        end

        --判断物品类型数量
        if u:get_type_count(it) then
            u:get_owner():sendMsg('该类型的物品只能携带一个')
            return true
        end

        --判断物品是否唯一
        if it.unique then
            if u:get_unique_name(it) then
                u:get_owner():sendMsg('该物品唯一,只能携带一个')
                return true
            end
        end
        
        --判断是否为消耗品
        if it.item_type == '消耗品' then
            --先判断是否有同类物品
            local item 
            for i=1,6 do
                local items = u:get_slot_item(i)
                if items and items.item_type == '消耗品' and items.name == it.name then
                    item = items
                    break
                end
            end

            --有同类物品 物品数量加1 返回不继续加物品
            --地上的物品需要删除
            if item then
                --加数量
                item:add_item_count(it._count)
                --刷新tip
                item:set_tip(item:get_tip())
                --回收句柄
                it.recycle = true
                --表示购买成功
                u.buy_suc = true 
                
                return true
            end

        end




    end)    
     --注册出售物品事件 商店出售给玩家 商店 购买者 点击的物品名
    ac.game:event '单位-卖出物品'(function(_,u,it)
        -- print('触发卖出物品',it)
        local player = u.owner
        local golds = it:sell_price()
        
        if golds > 0  then
            player:addGold(golds,u)
        end
        it:item_remove()

    end)   

    --注册出售物品事件 商店出售给玩家 商店 购买者 点击的物品名
    ac.game:event '单位-点击商店物品'(function(_,seller,u,it)
        --先判断钱是否够
        local player = u.owner
        local gold = u.owner.gold
        local mutou = player:getlumber()
        local kill_count = player.kill_count or 0
        local jifen = 0
        -- if ac.GetServerValue then  
        jifen= tonumber(ZZBase64.decode(player.jifen)) or 0
        -- end

        local golds = it:buy_price()
        local mutous = it:buy_mutou()
        local kill_counts = it:buy_kill_count()
        local jifens = it:buy_jifen()
        --如果有玩家自身价格，则售价为玩家自身价
        if it.player_gold then 
            golds = it.player_gold[player] or golds
        end    
        if gold < golds  then
            u:get_owner():sendMsg('钱不够')
            return
        end 
        if mutou < mutous then
            u:get_owner():sendMsg('木头不够')
            return
        end
        if kill_count < kill_counts then
            u:get_owner():sendMsg('杀敌数不够')
            return
        end
        --以免积分负数购买不了其他物品。
        if jifens > 0 then 
            if jifen < jifens then
                u:get_owner():sendMsg('积分不够')
                return
            end
        end    
        if it.max_buy_cnt and it.player_buy_cnt then
            if it.player_buy_cnt[player] and (it.player_buy_cnt[player] > (it.max_buy_cnt or 9999999)) then
                u:get_owner():sendMsg('超出购买上限')
                return
            end
        end    

        --购买成功才扣钱
        u.buy_suc = false 
        -- print(it.name)
        local flag 
        for i,v in ipairs(ac.skill_list2) do
            if v == it.name then 
                flag = true
                break
            end    
        end    
        if flag then 
            ac.item.add_skill_item(it.name,u,true)
        else    
            u:add_item(it.name)   
        end    
        --给单位添加物品时，会进行一系列逻辑处理，处理完后会改变 buy_suc 状态
        if u.buy_suc then 
            -- print('扣钱')
            player:addGold( - golds,u)
            player:addlumber( - mutous)
            player.kill_count =  player.kill_count - kill_counts

            if jifens > 0 then 
                --扣除积分
                ac.jiami(player,'jifen',-jifens)
                -- player:event_notify('积分变化',player,-jifens)
                --保存服务器存档 永久性的物品
                -- print(it.name)
                local key = ac.get_mallkey_byname(it.name)
                if key then 
                    -- print(it.name,key,1)
                    player:Map_SaveServerValue(key,1)
                    if not player.mall then 
                        player.mall ={}
                    end
                    player.mall[it.name] = true    
                end    
            end   

            -- 购买成功，删掉商店在售物品
            if it.on_selled_remove then 
                seller:remove_sell_item(it)
            end    

        end
    end)

    --单位 - 拾取物品
    ac.game:event '单位-拾取物品'(function(_,u,it)

        

    end)



    --丢在地上 给与其他玩家 都会触发
    ac.game:event '单位-丢弃物品'(function(_,u,it)
        
        if it.is_discard_event then 
            return
        end    
        
        --触发丢弃物品时，没有马上返回物品位置。
        -- ac.wait(10,function()
        --     print(it:get_point())
        --     it:show(true)
        -- end)            
        --true,掉落，不删除
        u:remove_item(it)
        -- u:print_item()
    end)


    --会触发获得物品事件的 1.拾取物品 2.购买物品 3.给与物品
    ac.game:event '单位-获得物品'(function(_,u,it)
		-- 如果物品没有所有者，表示为别人给与的。因为 拾取和从商店获得，以及代码添加都被代码模拟。
        -- 不触发丢弃物品事件
        -- 如果单位身上已经有这个物品的handle了，再添加一次会触发先丢弃再获得物品事件。
		if not it.owner then 
            it.is_discard_event = true
            it.geiyu = true
        else 
            it.geiyu = false
        end	
        
	    -- u:print_item(true)
        if it.is_pickup_event then
            return
        end
        
        -- print('获得物品',it.handle,it.owner,it.name,it.slot_id)

        u:add_item(it,true)
    end)



    --监听在物品栏中移动物品
    local it_ids = {
        ['移动物品到第1格'] = 1,
        ['移动物品到第2格'] = 2,
        ['移动物品到第3格'] = 3,
        ['移动物品到第4格'] = 4,
        ['移动物品到第5格'] = 5,
        ['移动物品到第6格'] = 6,}
    ac.game:event '单位-发布指令' (function(trg, unit, order, target, player_order, order_id)
        -- print(order_id)
        if order == '' then
            return
        end
        
        if not it_ids[order] then
            return
        end

        --source_id为物品原位置 target_id为移动到的位置
        local id = order_id - 852001
        local j_it = jass.GetOrderTargetItem()
        local item = ac.item.item_map[j_it]
        local source_id = item.slot_id
        local target_id = id

        --取出当前页面 如果没有切换背包的话，默认为第一页
        local page = unit.currentpage or 1
        target_id = (page - 1) * 6 + target_id

        --切换背包不响应移动物品事件
        if item.is_pickup_event then
            return
        end

        --放回原位置则跳出
        if source_id == target_id then
            print('移动物品-放回原位')
            return
        end

        --先判断目标位置是否有物品，如果有物品则是交换
        local target_item = unit:get_slot_item(id)
        if target_item then
            print('物品交换位置')
            --修改table
            unit.item_list[source_id] = target_item
            unit.item_list[target_id] = item
            
            --修改slot_id
            target_item.slot_id = source_id
            item.slot_id = target_id
        end

        --否则就是物品移动了位置
        if not target_item then
            --原位置清空
            unit.item_list[source_id] = nil
            unit.item_list[target_id] = item

            --修改slot_id
            item.slot_id = target_id
        end
    end)

    --使用物品
    local it_id = {
        ['使用第1格物品'] = 1,
        ['使用第2格物品'] = 2,
        ['使用第3格物品'] = 3,
        ['使用第4格物品'] = 4,
        ['使用第5格物品'] = 5,
        ['使用第6格物品'] = 6,}
        ac.game:event '单位-发布指令' (function(self, hero, order, target, player_order)
            -- print('发布使用物品命令1：',order)
            if order == '' then
                return
            end

            -- print('发布使用物品命令2：')
            if not it_id[order] then
                return
            end

            local slot_id = it_id[order]
            -- print('发布使用物品命令：',slot_id)
            --取出单位身上的物品
            local item = hero:get_slot_item(slot_id)
            -- print('发布使用物品命令3：',item)
            if not item then
                return
            end

            -- print('发布使用物品命令：',slot_id,item.name,target)
            --判断施法条件是否满足
            if item:conditions(item,target) ~= true then
                --如果施法条件不满足，重置CD
                japi.EXSetAbilityState(item:get_handle(), 0x01, 0.01)
                return
            end

            item:_call_event 'on_cast_start'
            --额外支持施法出手
			if item.cast_start_time > 0 then
				hero:wait(math_floor(item.cast_start_time * 1000), function()
					item:_call_event 'on_cast_shot'
				end)
			else
				item:_call_event 'on_cast_shot'
            end
            
            -- print('调用物品施法：',slot_id,item.name)
            if item.item_type == '消耗品'  then
                -- print('使用消耗品',item.name,item.type_id)
                -- 数量-1
                item._count = item._count - 1
                --消耗品使用 增加对应的属性值
                item:on_use_state()

                if item._count < 1 then 
                    item:item_remove()
                end
            else 
                if item._count > 0 then 
                    item._count = item._count - 1
                end
            end    

            hero:event_notify('物品-施法完成', hero,item)
        end)
