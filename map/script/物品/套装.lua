
--需要考虑套装在地上时的文字显示
--套装
local item ={}
item.suit_type = '召唤'

ac.item.suit = {
    --套装名，套装要求类型，符合类型个数及对应加成属性，符合类型个数及对应加成属性
    {'【召唤师】','召唤师的赠礼','召唤','3 召唤物+1 召唤物属性+100%','5 召唤物+1 召唤物属性+250%'},
    {'【雅典娜】','雅典娜的赠礼','智力','3 法爆几率+20 ','5 法爆伤害+4000%' },
    {'【安泰】','安泰的赠礼','力量','3 物爆几率+20 ','5 物爆伤害+4000%' },
    {'【闪电侠】','闪电侠的赠礼','敏捷','3 会心几率+20 ','5 会心伤害+4000%' },
    {'【不死鸟】','不死鸟的赠礼','护甲','3 减免+15%','5 减免+25%' },
    {'【海贼王】','海贼王的赠礼','收益','3 经验加成+50% 金币加成+50% 物品获取率+75%','5 经验加成+50% 金币加成+50% 物品获取率+75%' },
}
local function get_suit_count(unit,suit_type)
    local cnt =0 
    for i=1,6 do
        local items = unit:get_slot_item(i)
        if items and items.suit_type == suit_type then
            cnt = cnt + 1
        end
    end
    return cnt 
end    
local function fresh_suit_tip(unit,type,tip)
--刷新单位身上的所有物品说明
    for i =1,6 do 
        -- print(tip)
        local items = unit:get_slot_item(i)
        if items and type == items.suit_type  then
            items:set_tip(items:get_tip()..tip)
        end
    end    
end    

local function unit_add_suit(unit,item)
    if not item.suit_type then 
        return
    end    

    for _, data in ipairs(ac.item.suit) do
        local little_name,name, type,attr1,attr2,attr3,attr4,attr5,attr6 = table.unpack(data)
        local temp_attr ={}
        temp_attr[1] = attr1 
        temp_attr[2] = attr2 
        temp_attr[3] = attr3 
        temp_attr[4] = attr4 
        temp_attr[5] = attr5 
        temp_attr[6] = attr6 

        if type == item.suit_type then 
            local tip = '' 
            local unit_suit_cnt = get_suit_count(unit,item.suit_type) or 0 
            tip = tip ..'|cffFFE799'.. name..' (套装)|r'..'\n'
            item.suit_name = name
            for i = 1,6 do
                if temp_attr[i] then 
                    local dest_rate 
                    local t_attr = {} 
                    -- 匹配 召唤物+1   (%S+)%+(%d+%s-)
                    local first_flag = true
                    local active_flag = false
                    local cnt = 0
                    local attr_tip =''
                    for value in temp_attr[i]:gmatch '%S+' do
                        if first_flag  then 
                            -- print(value)
                            first_flag=false
                            cnt = tonumber(value)
                        else
                            -- print(value)
                            attr_tip = attr_tip.. value ..' '
                        end    
                    end

                    --如果满足条件就增加属性
                    if not unit.suit  then 
                        unit.suit ={}
                    end
                    if not unit.suit[name] then 
                        unit.suit[name]={}
                    end
                    if not unit.suit[name][cnt] then 
                        unit.suit[name][cnt]={}
                        unit.suit[name][cnt][1] = false
                        unit.suit[name][cnt][2] = type
                        unit.suit[name][cnt][3] = attr_tip
                    end
                    if unit_suit_cnt >= cnt   then 
                        active_flag = true
                        if not unit.suit[name][cnt][1]  then   
                            for k,v in attr_tip:gmatch '(%S+)%+(%d+%s-)' do
                                --额外增加人物属性
                                --多个物品会额外增加套装属性
                                -- print(attr_tip,k,v)
                                unit:add(k,v)
                            end   
                        end   
                        unit.suit[name][cnt][1] = true
                    end    
                    if active_flag then 
                        tip = tip..'|cff00FF00'..attr_tip..' ('..unit_suit_cnt..'/'..cnt..')|r\n'
                    else
                        tip = tip..attr_tip..' ('..unit_suit_cnt..'/'..cnt..')|r\n'
                    end    
                    unit.suit[name][cnt][4] = tip  
                end
            end     
            --刷新单位身上的所有物品说明
            fresh_suit_tip(unit,type,tip)
        end    
    end    

end     

local function unit_remove_suit(unit,item)
    if not unit.suit or not item.suit_type or not item.suit_name  then 
        return
    end    
    local tip = ''
    local item_self_tip = ''
    -- unit.suit[]
    --只需要减属性即可
    local suit_count = get_suit_count(unit,item.suit_type)
    local name = item.suit_name 
   
    tip = tip ..'|cffFFE799'.. name..' (套装)|r'..'\n'
    item_self_tip = item_self_tip ..'|cffFFE799'.. name..' (套装)|r'..'\n'
    -- print(tip)
    --刷新tip
                 
    for k,v in sortpairs(unit.suit) do 
        for i = 1,6 do 
            if v[i] and v[i][2] == item.suit_type then 
                --如果类型一样且已激活
                if v[i][1]   and suit_count < i then 
                    --减属性
                    for k,v in v[i][3]:gmatch '(%S+)%+(%d+%s-)' do
                        --额外增加人物属性
                        --多个物品会额外增加套装属性
                        unit:add(k,-v)
                    end
                    v[i][1] = false
                end   
                if v[i][1] then 
                    tip = tip..'|cff00FF00'..v[i][3]..'('..suit_count..'/'..i..')\n'
                else
                    tip = tip..v[i][3]..'('..suit_count..'/'..i..')\n'
                end    
                item_self_tip = item_self_tip ..'|cffffffff'..v[i][3]..'('..suit_count..'/'..i..')\n'
            end 
        end 
    end 
    --先刷新丢地上的物品
    item:set_tip(item:get_tip()..item_self_tip)
    --刷新 套装说明 
    fresh_suit_tip(unit,item.suit_type,tip)

end    


ac.game:event '单位-获得物品后' (function (_,unit,item)
    unit_add_suit(unit,item)
end)

ac.game:event '单位-丢弃物品后' (function (_,unit,item)
    --需要移除属性
    --移除激活标志
    unit_remove_suit(unit,item)
end)

ac.game:event '物品-创建' (function (_,item)
    if not item or not item.suit_type then 
        return 
    end
    
    for _, data in ipairs(ac.item.suit) do
        local little_name,name, type,attr1,attr2,attr3,attr4,attr5,attr6 = table.unpack(data)
        local temp_attr ={}
        temp_attr[1] = attr1 
        temp_attr[2] = attr2 
        temp_attr[3] = attr3 
        temp_attr[4] = attr4 
        temp_attr[5] = attr5 
        temp_attr[6] = attr6 

        if type == item.suit_type then 
            local tip = '' 
            tip = tip ..'|cffFFE799'.. name..' (套装)|r'..'\n'
            item.suit_name = name
            for i = 1,6 do
                if temp_attr[i] then  
                    local first_flag = true
                    local cnt = 0
                    local attr_tip =''
                    for value in temp_attr[i]:gmatch '%S+' do
                        if first_flag  then 
                            first_flag=false
                            cnt = tonumber(value)
                        else
                            attr_tip = attr_tip.. value ..' '
                        end    
                    end  
                    tip = tip..attr_tip..'('..cnt..')\n'
                end
            end    
            -- print(item:get_tip()..tip)
            item:set_tip(item:get_tip()..tip)    
            --更改物品名字
        end    
    end   
         
end)
