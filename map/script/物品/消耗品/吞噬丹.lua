--物品名称
--随机技能添加给英雄貌似有点问题。
local mt = ac.skill['吞噬丹']
mt{
--等久
level = 1,

--冷却
cool = 0,

--描述
tip = [[
能吞噬一个装备，永久增加对应的属性（套装效果无法加成）
已吞噬 %cnt%|cffffff00/8|r 个： %content%]],
cnt = function(self) 
    local cnt = 0
    if self and self.owner and self.owner:is_hero() then 
        local hero = self.owner
        local player = hero:get_owner()
        cnt = player.tunshi_cnt or 0 
    end    
    return cnt
end,
content = function(self) 
    local content = '' 
    --吞噬丹在宠物也可以展示
    if self and self.owner  then 
        local hero = self.owner
        local player = hero:get_owner()
        if player.tunshi then 
            for i,item in ipairs(player.tunshi) do
                content = content ..'\n'.. item.store_name
            end
        end    
    end    
    return content
end,
--物品技能
is_skill = true,
--物品详细介绍的title
content_tip = '使用说明：',
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
    --只能吞噬 10 个 物品类的，没法更新数据
    local cnt = 8
    if (player.tunshi_cnt or 0) >= cnt then 
        self:add_item_count(1)
        player:sendMsg('吞噬丹吞噬个数已满，不可吞噬')
        return 
    end    

    for i=1,6 do 
        local item = hero:get_slot_item(i)
        if item and item.item_type == '装备' then 
            count = count + 1
            local info = {
                name = "|cff"..ac.color_code[item.color or '白']..'吞噬'.. item:get_name() .. '|r  (第' .. item.slot_id .. '格)',
                item = item
            }
            table.insert(list,info)
        end
    end 
    if count < 1 then 
        player:sendMsg('没有可吞噬的装备')
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
        self.dialog = create_dialog(player,'吞噬装备',list,function (index)
            local item = list[index].item
            if item then 
                --宠物吞噬自己身上的装备，给英雄加属性
                -- item.owner = hero:get_owner().hero
                --再加一次属性
                item:on_add_state()
                --移除装备，移除一次属性
                item:item_remove()
                --吞噬个数 +1
                if not player.tunshi_cnt then 
                    player.tunshi_cnt =0
                end    
                player.tunshi_cnt = player.tunshi_cnt + 1

                --吞噬名
                if not player.tunshi then 
                    player.tunshi = {}
                end    
                table.insert(player.tunshi,item)

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
            
            self.dialog = nil
        end)
    else
        self:add_item_count(1)    
    end    


end

function mt:on_remove()
end