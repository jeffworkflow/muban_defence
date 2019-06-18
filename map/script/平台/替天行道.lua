
-- 替天行道兑换


--商品名称
local mt = ac.skill['兑换-势不可挡']
mt{
--等久
level = 1,
store_name = '兑换-势不可挡',
--图标
art = 'sbkd.blp',
--说明
tip = [[消耗20个徽章]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【任务说明】：|r\n',
--物品技能
is_skill = true,
need_yshz = 20,
need_map_level = 3,
}   

local mt = ac.skill['兑换-君临天下']
mt{
--等久
level = 1,
store_name = '兑换-君临天下',
--图标
art = 'sbkd.blp',
--说明
tip = [[消耗20个徽章]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【任务说明】：|r\n',
--物品技能
is_skill = true,
need_yshz = 20,
need_map_level = 3,
}   
 

local mt = ac.skill['兑换-神帝']
mt{
--等久
level = 1,
store_name = '兑换-神帝',
--图标
art = 'sbkd.blp',
--说明
tip = [[消耗20个徽章]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【任务说明】：|r\n',
--物品技能
is_skill = true,
need_yshz = 20,
need_map_level = 3,
}   

local mt = ac.skill['兑换-王者归来']
mt{
--等久
level = 1,
store_name = '兑换-王者归来',
--图标
art = 'sbkd.blp',
--说明
tip = [[消耗20个徽章]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【任务说明】：|r\n',
--物品技能
is_skill = true,
need_yshz = 20,
need_map_level = 3,
}   

local mt = ac.skill['兑换-力量']
mt{
--等久
level = 1,
store_name = '兑换-力量',
--图标
art = 'sbkd.blp',
--说明
tip = [[消耗1徽章兑换25万力量，限量20个]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【任务说明】：|r\n',
--物品技能
is_skill = true,
need_yshz = 1,
need_map_level = 0,
['力量'] = 250000,
max_buy_cnt = 20,--最大兑换次数
}   

local mt = ac.skill['兑换-敏捷']
mt{
--等久
level = 1,
store_name = '兑换-敏捷',
--图标
art = 'sbkd.blp',
--说明
tip = [[消耗1徽章兑换25万敏捷，限量20个]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【任务说明】：|r\n',
--物品技能
is_skill = true,
need_yshz = 1,
need_map_level = 0,
['敏捷'] = 250000,
max_buy_cnt = 20,--最大兑换次数
}   

local mt = ac.skill['兑换-智力']
mt{
--等久
level = 1,
store_name = '兑换-智力',
--图标
art = 'sbkd.blp',
--说明
tip = [[消耗1徽章兑换25万智力，限量20个]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【任务说明】：|r\n',
--物品技能
is_skill = true,
need_yshz = 1,
need_map_level = 0,
['智力'] = 250000,
max_buy_cnt = 20,--最大兑换次数
}   

local mt = ac.skill['兑换-全属性']
mt{
--等久
level = 1,
store_name = '兑换-全属性',
--图标
art = 'sbkd.blp',
--说明
tip = [[消耗1徽章兑换25万全属性，限量20个]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【任务说明】：|r\n',
--物品技能
is_skill = true,
need_yshz = 1,
need_map_level = 0,
['全属性'] = 100000,
max_buy_cnt = 20, --最大兑换次数
}   

--存档称号相关
for i,name in ipairs({'兑换-势不可挡','兑换-君临天下','兑换-神帝','兑换-王者归来'}) do
    local mt = ac.skill[name]
    function mt:on_cast_start()
        local hero = self.owner
        local p = hero:get_owner()
        hero = p.hero
        local real_name = string.gsub(self.name,'兑换%-','')
        -- print(real_name)
        local has_yshz = p.cus_server and (p.cus_server['勇士徽章'] or 0 )
        local map_level = p:Map_GetMapLevel()
        local has_mall = p.mall[real_name] or (p.cus_server and p.cus_server[real_name])
    
        --已有物品的处理
        if has_mall then 
            p:sendMsg('【系统消息】已有'..real_name)    
            return 
        end
        --处理兑换
        if has_yshz >= self.need_yshz and map_level >= self.need_map_level then 
            p:AddServerValue('yshz',-self.need_yshz)
            local key = ac.server.name2key(real_name)
            p:SetServerValue(key,1)
            p:sendMsg('兑换成功：'..real_name)   

            --先扣当前消费者的勋章数，不足的话扣除单位下的另一个人的勋章
            local first_item = self.owner:has_item('勇士徽章',all)
            local unit = (self.owner == hero and p.peon or hero )
            local second_item = unit:has_item('勇士徽章',all)
            if first_item  then
                if first_item._count>= self.need_yshz then 
                    first_item:add_item_count(-self.need_yshz)
                else
                    local dis_cnt = self.need_yshz - first_item._count
                    first_item:add_item_count(-self._count)
                    second_item:add_item_count(-dis_cnt)
                end    
            else
                second_item:add_item_count(-self.need_yshz)
            end    

        else
            p:sendMsg('【系统消息】勇气徽章不足或地图等级不够')    
        end    
    end    
end    

--属性相关
for i,name in ipairs({'兑换-力量','兑换-敏捷','兑换-智力','兑换-全属性'}) do
    local mt = ac.skill[name]
    function mt:on_cast_start()
        local hero = self.owner
        local p = hero:get_owner()
        hero = p.hero

        local has_yshz = p.cus_server and (p.cus_server['勇士徽章'] or 0 )
        local map_level = p:Map_GetMapLevel()

        --处理最大购买次数
        local shop_item = ac.item.shop_item_map[self.name]
        if not shop_item.player_buy_cnt then 
            shop_item.player_buy_cnt = {}
        end
        shop_item.player_buy_cnt[p] = (shop_item.player_buy_cnt[p] or 1) + 1

         --处理兑换
         if has_yshz >= self.need_yshz  then 
            p:AddServerValue('yshz',-self.need_yshz)
            -- p:sendMsg('【系统消息】 获得25W'..)   

            --先扣当前消费者的勋章数，不足的话扣除单位下的另一个人的勋章
            local first_item = self.owner:has_item('勇士徽章',all)
            local unit = (self.owner == hero and p.peon or hero )
            local second_item = unit:has_item('勇士徽章',all)
            if first_item  then
                if first_item._count>= self.need_yshz then 
                    first_item:add_item_count(-self.need_yshz)
                else
                    local dis_cnt = self.need_yshz - first_item._count
                    first_item:add_item_count(-self._count)
                    second_item:add_item_count(-dis_cnt)
                end    
            else
                second_item:add_item_count(-self.need_yshz)
            end   
        else
            p:sendMsg('【系统消息】勇气徽章不足')    
        end    
    end    
end    
