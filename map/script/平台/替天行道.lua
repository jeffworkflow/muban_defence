
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
tip = [[

消耗 |cffff0000十五枚徽章|r 兑换 |cff00ff00势不可挡|r

|cffFFE799【称号属性】：|r
|cff00ff00+50   杀怪加攻击|r
|cff00ff00+500  护甲|r
|cff00ff00+10% 物品获取率|r

|cffff0000【所有称号外观可更换，所有称号属性可叠加】|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_yshz = 15,
need_map_level = 3,
}   

local mt = ac.skill['兑换-君临天下']
mt{
--等久
level = 1,
store_name = '兑换-君临天下',
--图标
art = 'jltx.blp',
--说明
tip = [[

消耗 |cffff0000七十五枚徽章|r 兑换 |cff00ff00君临天下|r

|cffFFE799【称号属性】：|r
|cff00ff00+250  杀怪加攻击|r
|cff00ff00+15%   全伤加深|r
|cff00ff00+35%   分裂伤害|r

|cffff0000【所有称号外观可更换，所有称号属性可叠加】|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_yshz = 75,
need_map_level = 4,
}   
 

local mt = ac.skill['兑换-神帝']
mt{
--等久
level = 1,
store_name = '兑换-神帝',
--图标
art = 'shendi.blp',
--说明
tip = [[

消耗 |cffff0000两百枚徽章|r 兑换 |cff00ff00神帝|r

|cffFFE799【称号属性】：|r
|cff00ff00+500  杀怪加攻击|r
|cff00ff00+800  减少周围护甲|r
|cff00ff00-0.05 攻击间隔|r

|cffff0000【所有称号外观可更换，所有称号属性可叠加】|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_yshz = 200,
need_map_level = 9,
}   

local mt = ac.skill['兑换-傲世天下']
mt{
--等久
level = 1,
store_name = '兑换-傲世天下',
--图标
art = 'wzgl.blp',
--说明
tip = [[

消耗 |cffff0000三百五十枚徽章|r 兑换 |cff00ff00傲世天下|r

|cffFFE799【称号属性】：|r
|cff00ff00+268  杀怪加全属性|r
|cff00ff00+10%   免伤几率|r
|cff00ff00+10%   对boss额外伤害|r

|cffff0000【所有称号外观可更换，所有称号属性可叠加】|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_yshz = 350,
need_map_level = 10,
}   

local mt = ac.skill['兑换-力量']
mt{
--等久
level = 1,
store_name = '兑换-力量',
--图标
art = 'yshz.blp',
content_tip = '|cffFFE799【兑换说明】：|r\n',
--说明
tip = [[

消耗 |cffff0000一枚徽章|r 兑换 |cff00ff006万点永久力量|r

|cffcccccc兑换属性永久存档，兑换上限次数=地图等级*2|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

--物品技能
is_skill = true,
need_yshz = 1,
need_map_level = 0,
['力量'] = 60000,
}   

local mt = ac.skill['兑换-敏捷']
mt{
--等久
level = 1,
store_name = '兑换-敏捷',
--图标
art = 'yshz.blp',
--说明
tip = [[

消耗 |cffff0000一枚徽章|r 兑换 |cff00ff006万点永久敏捷|r

|cffcccccc兑换属性永久存档，兑换上限次数=地图等级*2|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_yshz = 1,
need_map_level = 0,
['敏捷'] = 60000,
}   

local mt = ac.skill['兑换-智力']
mt{
--等久
level = 1,
store_name = '兑换-智力',
--图标
art = 'yshz.blp',
--说明
tip = [[

消耗 |cffff0000一枚徽章|r 兑换 |cff00ff006万点永久智力|r

|cffcccccc兑换属性永久存档，兑换上限次数=地图等级*2|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_yshz = 1,
need_map_level = 0,
['智力'] = 60000,
}   

local mt = ac.skill['兑换-全属性']
mt{
--等久
level = 1,
store_name = '兑换-全属性',
--图标
art = 'yshz.blp',
--说明
tip = [[

消耗 |cffff0000一枚徽章|r 兑换 |cff00ff003万点永久全属性|r

|cffcccccc兑换属性永久存档，兑换上限次数=地图等级*2|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_yshz = 1,
need_map_level = 0,
['全属性'] = 30000,
}   

--存档称号相关
for i,name in ipairs({'兑换-势不可挡','兑换-君临天下','兑换-神帝','兑换-傲世天下'}) do
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
        if has_mall > 0 then 
            p:sendMsg('【系统消息】已有'..real_name)    
            return 
        end
        --处理兑换
        if has_yshz >= self.need_yshz and map_level >= self.need_map_level then 
            -- p:AddServerValue('yshz',-self.need_yshz) --自定义服务器
            p:Map_AddServerValue('yshz',-self.need_yshz) --网易服务器
            
            local key = ac.server.name2key(real_name)
            -- p:SetServerValue(key,1) 自定义服务器
            p:Map_SaveServerValue(key,1) --网易服务器
            p:sendMsg('|cffff0000兑换'..real_name..'成功 部分效果在下一局生效|r')   

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
            p:sendMsg('|cffffe799【系统消息】|r勇气徽章不足或地图等级不够')    
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

        local real_name = string.gsub(self.name,'兑换%-','')
        local has_yshz = p.cus_server and (p.cus_server['勇士徽章'] or 0 )
        local map_level = p:Map_GetMapLevel() * 2
        local has_mall = p.cus_server and (p.cus_server[real_name] or 0 )

        --处理上限问题
        if has_mall >= map_level then 
            --已经加了属性，需要重新扣除
            -- print_r(self.old_status)
            -- print(real_name,-self[real_name])
            hero:add(real_name,-self[real_name])
            p:sendMsg('|cffffe799【系统消息】|r已达兑换上限次数：'..real_name)    
            return true
        end
        --处理兑换
        if has_yshz >= self.need_yshz  then 
            -- p:AddServerValue('yshz',-self.need_yshz) 自定义服务器
            p:Map_AddServerValue('yshz',-self.need_yshz)  --网易义服务器
            local key = ac.server.name2key(real_name)
            -- p:AddServerValue(key,1)  自定义服务器
            p:Map_AddServerValue(key,1)  --网易义服务器
            p:sendMsg('|cffff0000兑换'..real_name..'成功 部分效果在下一局生效|r')   
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
            --已经加了属性，需要重新扣除
            -- print(real_name,-self[real_name])
            hero:add(real_name,-self[real_name])
            p:sendMsg('|cffffe799【系统消息】|r勇气徽章不足')    
        end    
    end    
end    
