
local rect = require 'types.rect'

--根据重数 给商店添加10技能，并让第一技能为可点击状态
--单位，重数
local function add_skill_by_lv(shop,lv)
    if not ac.devil_deal[lv] then 
        return 
    end    
    for num,value in ipairs(ac.devil_deal[lv]) do    
        if num <= 4 then 
            -- print(value[1])
            shop:add_skill(value[1],'英雄',num + 8 )
        elseif num <= 8 then 
            shop:add_skill(value[1],'英雄',num)
        else
            shop:add_skill(value[1],'英雄',num - 8)
        end   
        if num ==1 then 
            local skl = shop:find_skill(value[1],'英雄',true)
            skl:set_level(1)
        end 
    end   
end   

-- 传送 快速达到 兑换 交易
ac.devil_deal ={
    --商品名（map.table.单位.商店）,是否激活 属性名，数值，耗费币种，数值，图标,说明
    [1] = {
{'无所不在lv1',false,'分裂伤害',5,'金币',1000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在LV1|r

|cffFFE799【奖励】|r|cff00ff00+5%分裂伤害|r

]]
},

{'无所不在lv2',false,'分裂伤害',5,'金币',5000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在LV2|r

|cffFFE799【奖励】|r|cff00ff00+5%分裂伤害|r

]]},

{'无所不在lv3',false,'分裂伤害',5,'金币',10000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在LV3|r

|cffFFE799【奖励】|r|cff00ff00+5%分裂伤害|r

]]},

{'无所不在lv4',false,'分裂伤害',5,'金币',25000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在LV4|r

|cffFFE799【奖励】|r|cff00ff00+5%分裂伤害|r

]]},

{'无所不在lv5',false,'分裂伤害',5,'金币',50000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在LV5|r

|cffFFE799【奖励】|r|cff00ff00+5%分裂伤害|r

]]},

{'无所不在lv6',false,'攻击速度',5,'金币',70000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在LV6|r

|cffFFE799【奖励】|r|cff00ff00+5%攻速|r

]]},

{'无所不在lv7',false,'攻击速度',5,'金币',80000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在LV7|r

|cffFFE799【奖励】|r|cff00ff00+5%攻速|r

]]},

{'无所不在lv8',false,'攻击速度',5,'金币',90000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在LV8|r

|cffFFE799【奖励】|r|cff00ff00+5%攻速|r

]]},

{'无所不在lv9',false,'攻击速度',5,'金币',100000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在LV9|r

|cffFFE799【奖励】|r|cff00ff00+5%攻速|r

]]},

{'无所不在lvmax',false,'攻击速度',5,'金币',200000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在LVmax|r

|cffFFE799【奖励】|r|cff00ff00+5%攻速|r

]]},


} ,
    [2] = {
{'无所不能lv1',false,'力量',1000,'金币',1000,[[ReplaceableTextures\CommandButtons\BTNTomeBrown.blp]],[[
%show_tip% \n
兑换100全属性
]]},

{'无所不能lv2',false,'全属性',1000,'金币',1000,[[ReplaceableTextures\CommandButtons\BTNTomeBrown.blp]],[[
%show_tip% \n
兑换100全属性
]]},

} ,
   
   
}

for _,tab in ipairs(ac.devil_deal) do 
    --每重魔法书
    -- local mt2 = ac.skill['商城管理']
    -- mt2{
    --     is_spellbook = 1,
    --     is_order = 2,
    --     art = [[sc.blp]],
    --     title = '商城管理',
    --     tip = [[
    -- 查看商城道具
    --     ]],
    -- }
    -- mt.skills = {
    --     '天空的宝藏会员','永久超级赞助','天使之光','战斗机器','魔龙之心','金币多多','寻宝小达人','双倍积分卡'
    -- }

    -- function mt:on_add()
    --     local hero = self.owner 
    --     local player = hero:get_owner()
    --     -- print('打开魔法书')
    --     for index,skill in ipairs(self.skill_book) do 
    --         local count = player.mall[skill.name] 
    --         if count  then 
    --             skill:set_level(1)
    --         end
    --     end 
    -- end 

    for num,value in ipairs(tab) do 
        --物品名称
        local mt = ac.skill[value[1]]
        mt{
        --等久
        level = 0,
        --图标
        art = value[7],
        --说明
        tip = value[8],
        --属性名
        attr_name = value[3],
        --属性值
        attr_val = value[4],
        --物品类型
        item_type = '神符',
        --目标类型
        target_type = ac.skill.TARGET_TYPE_NONE,
        --施法动作
        cast_animation = '',
        --冷却
        cool = 0,
        show_tip = function(self)
            local str = ''
            if self.gold then 
                str = '' .. self.gold .. '金币'
            end   
            if self.kill_count then 
                str = '消耗杀敌数' .. self.kill_count 
            end   
            if self.mutou then 
                str = '消耗木头' .. self.mutou
            end    
            return str
        end,
        content_tip = '',
        is_skill = true,
        }
        
        if value[5]=='金币' then
            mt.gold = tonumber(value[6])
        end
        if value[5]=='杀敌数' then
            mt.kill_count = tonumber(value[6])
        end
        if value[5]=='木头' then
            mt.mutou = tonumber(value[6])
        end   

        --模拟商店点击
        function mt:on_cast_shot()
            local hero = self.owner
            local p = hero:get_owner()
            local seller = self.owner
            hero = p.hero
            local name = self.name 
            local item = setmetatable(self,ac.item)
            item.name = name
            print(item.name,item.gold)

            hero:event_notify('单位-点击商店物品',seller,hero,item)
            self.owner = seller
            --停止继续执行
            self:stop()
        end
        --商品实际被点击时的执行效果
        function mt:on_cast_finish()
            local hero = self.owner
            local p = hero:get_owner()
            local seller = self.seller
            hero = p.hero
            print('施法结束啦')
            --增加属性
            print(self.attr_name,self.attr_val)
            hero:add(self.attr_name,self.attr_val)
            --处理下一个
            --local next = self.position + 1 
            -- self:remove()
            -- print(seller,hero,self.name)
            seller:remove_skill(self.name)
            local skl_name = ''
            if num == #tab then 
                add_skill_by_lv(seller,_+1)
            else
                skl_name = tab[num +1][1] --下一个技能名
            end   
            -- print(skl_name) 
            local skl = seller:find_skill(skl_name,'英雄',true)
            if skl then 
                skl:set_level(1)
            end    
            --标记激活
            value[2] = true

        end
    end    

end     

ac.game:event '单位-创建商店'(function(trg,shop)
    print('单位-创建商店',shop)
    local hero 
    if not ac.flag_test_1  then 
        hero = ac.player(1).hero
        ac.flag_test_1  =true 
    end   
    --测试
    -- local shop = ac.player(1):create_unit('魔鬼的交易',ac.point(1000,0)) 
    -- shop:add_restriction('无敌')
    -- 添加第一重 1+8  
    -- 9 10 11 12
    -- 5 6  7  8
    -- 1 2  3  4
    add_skill_by_lv(shop,1)

end)



