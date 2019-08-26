--物品名称
--随机技能添加给英雄貌似有点问题。
local mt = ac.skill['点金石']
mt{
--等久
level = 1,
--售价
gold = 5000,
--图标
art = [[item\shou204.blp]],
--类型
item_type = "消耗品",
--模型
specail_model = [[EarthCrystal.mdx]],
--品质
color = "紫",
--冷却
cool = 0,
--描述
tip = [[ 

|cff00ff00点击可对指定物品进行一次强化！

|cffcccccc每个物品最多强化10次，无法强化黑色品质物品|r]],

--物品技能
is_skill = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
auto_fresh_tip = true

}

function mt:on_cast_start()
    local unit = self.owner
    local hero = self.owner
    local player = hero:get_owner()
    local count = 0
    local name = self:get_name()
    hero = player.hero
    local list = {} 

    for i=1,6 do 
        local item = hero:get_slot_item(i)
        if item and item.item_type == '装备' and finds(item.color,'白','蓝','金','红')  and item.level < (item.max_level or 999) then 
            count = count + 1
            local info = {
                name = "|cff"..ac.color_code[item.color or '白']..'点金 '.. item:get_name() .. '|r  (第' .. item.slot_id .. '格)',
                item = item
            }
            table.insert(list,info)
            
        end
    end 
    if count < 1 then 
        player:sendMsg('|cffffe799【系统消息】|r英雄物品栏没有可点金的装备',4)
        if self._count > 1 then 
            -- print('数量')
            self:set_item_count(self._count+1)
        else
            --重新添加给英雄
            unit:add_item(name,true)
        end     
        return 
    end 
    local info = {
        name = '取消 (Esc)',
        key = 512
    }
    table.insert(list,info)

    if not self.dialog  then 
        self.dialog = create_dialog(player,'点金装备',list,function (index)
            self.dialog = nil
            local item = list[index].item
            if item then 
                local lni_data = ac.table.ItemData[item.name]
                if not lni_data then print('没有取到数据') return end 
                for key in sortpairs(ac.unit.attribute) do
                    if item[key] and lni_data[key]  then 
                        item[key] = lni_data[key] * (1+(item.level)*0.1)
                    end 
                    if item[key..'%'] and lni_data[key..'%']  then 
                        item[key..'%'] = lni_data[key..'%'] * (1+(item.level)*0.1)
                    end 
                end
                if item.level <=10 then 
                    item.show_level = true
                    item.max_level = 11
                    item:upgrade(1)
                    item:set_name(item.name)
                    player:sendMsg('|cffffe799点金成功:|r '..item.color_name..' |cffffff00+'..item.level -1 ..'|r ')
                    
                    if self._count > 0 then  
                        self:on_cast_start()
                        self:add_item_count(-1)
                    end  
                else 
                    player:sendMsg(item.color_name..' |cffffff00已满级|r')
                    if self._count > 1 then 
                        -- print('数量')
                        self:set_item_count(self._count+1)
                    else
                        --重新添加给英雄
                        unit:add_item(name,true)
                    end  
                end    

            else
                -- print('取消更换技能')
                if self._count > 1 then 
                    -- print('数量')
                    self:set_item_count(self._count+1)
                else
                    --重新添加给英雄
                    unit:add_item(name,true)
                end        
            end
            
        end)
    else
        self:add_item_count(1)    
    end    


end

function mt:on_remove()
end

