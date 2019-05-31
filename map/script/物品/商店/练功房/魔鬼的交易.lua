
local rect = require 'types.rect'


-- 传送 快速达到 兑换 交易
local devil_deal ={
    --商品名（map.table.单位.商店）,是否激活 属性名，数值，耗费币种，数值，图标,说明
    [1] = {
{'无所不在lv1',false,'分裂伤害',5,'全属性',1000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv1|r

|cffFFE799【奖励】|r|cff00ff00+5%分裂伤害|r

]]
},

{'无所不在lv2',false,'分裂伤害',5,'全属性',50000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv2|r

|cffFFE799【奖励】|r|cff00ff00+5%分裂伤害|r

]]},

{'无所不在lv3',false,'分裂伤害',5,'杀敌数',10000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv3|r

|cffFFE799【奖励】|r|cff00ff00+5%分裂伤害|r

]]},

{'无所不在lv4',false,'分裂伤害',5,'金币',25000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv4|r

|cffFFE799【奖励】|r|cff00ff00+5%分裂伤害|r

]]},

{'无所不在lv5',false,'分裂伤害',5,'金币',50000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv5|r

|cffFFE799【奖励】|r|cff00ff00+5%分裂伤害|r

]]},

{'无所不在lv6',false,'攻击速度',5,'金币',70000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv6|r

|cffFFE799【奖励】|r|cff00ff00+5%攻速|r

]]},

{'无所不在lv7',false,'攻击速度',5,'金币',80000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv7|r

|cffFFE799【奖励】|r|cff00ff00+5%攻速|r

]]},

{'无所不在lv8',false,'攻击速度',5,'金币',90000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv8|r

|cffFFE799【奖励】|r|cff00ff00+5%攻速|r

]]},

{'无所不在lv9',false,'攻击速度',5,'金币',100000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv9|r

|cffFFE799【奖励】|r|cff00ff00+5%攻速|r

]]},

{'无所不在lvmax',false,'攻击速度',5,'金币',200000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lvmax|r

|cffFFE799【奖励】|r|cff00ff00+5%攻速|r

]]},

} ,

    [2] = {
{'无所不知lv1',false,'攻击',500000,'木头',20,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv1|r
    
|cffFFE799【奖励】|r|cff00ff00+50w攻击|r
    ]]},

{'无所不知lv2',false,'每秒加攻击',300,'木头',40,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv2|r
    
|cffFFE799【奖励】|r|cff00ff00+300每秒加攻击|r
    ]]},

{'无所不知lv3',false,'杀怪加攻击',30,'木头',60,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv3|r
    
|cffFFE799【奖励】|r|cff00ff00+30杀怪加攻击|r
    ]]},

{'无所不知lv4',false,'每秒加攻击',300,'木头',80,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv4|r
    
|cffFFE799【奖励】|r|cff00ff00+300每秒加攻击|r
    ]]},

{'无所不知lv5',false,'杀怪加攻击',30,'木头',100,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv5|r
    
|cffFFE799【奖励】|r|cff00ff00+30杀怪加攻击|r
    ]]},

{'无所不知lv6',false,'攻击',500000,'木头',120,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv6|r
    
|cffFFE799【奖励】|r|cff00ff00+50w攻击|r
    ]]},

 {'无所不知lv7',false,'每秒加攻击',300,'木头',140,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv7|r
    
|cffFFE799【奖励】|r|cff00ff00+300每秒加攻击|r
    ]]},

{'无所不知lv8',false,'杀怪加攻击',30,'木头',160,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv8|r
    
|cffFFE799【奖励】|r|cff00ff00+30杀怪加攻击|r
    ]]},

{'无所不知lv9',false,'每秒加攻击',300,'木头',180,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv9|r
    
|cffFFE799【奖励】|r|cff00ff00+300每秒加攻击|r
    ]]},

{'无所不知lvmax',false,'杀怪加攻击',30,'木头',200,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lvmax|r
    
|cffFFE799【奖励】|r|cff00ff00+30杀怪加攻击|r
   ]]},
},

[3] = {
{'无所不贪lv1',false,'杀怪加全属性',50,'金币',200000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv1|r
    
|cffFFE799【奖励】|r|cff00ff00+50杀怪加全属性|r
    ]]},

{'无所不贪lv2',false,'攻击加全属性',250,'全属性',200000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv2|r
    
|cffFFE799【奖励】|r|cff00ff00+250攻击加全属性|r
    ]]},

{'无所不贪lv3',false,'每秒加全属性',500,'全属性',200000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv3|r
    
|cffFFE799【奖励】|r|cff00ff00+500每秒加全属性|r
    ]]},

{'无所不贪lv4',false,'杀怪加全属性',100,'全属性',200000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv4|r
    
|cffFFE799【奖励】|r|cff00ff00+100杀怪加全属性|r
    ]]},

{'无所不贪lv5',false,'攻击加全属性',500,'全属性',200000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv5|r
    
|cffFFE799【奖励】|r|cff00ff00+500攻击加全属性|r
    ]]},

{'无所不贪lv6',false,'每秒加全属性',1000,'全属性',200000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv6|r
    
|cffFFE799【奖励】|r|cff00ff00+1000每秒加全属性|r
    ]]},

 {'无所不贪lv7',false,'杀怪加全属性',150,'全属性',200000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv7|r
    
|cffFFE799【奖励】|r|cff00ff00+150杀怪加全属性|r
    ]]},

{'无所不贪lv8',false,'攻击加全属性',750,'全属性',200000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv8|r
    
|cffFFE799【奖励】|r|cff00ff00+750攻击加全属性|r
    ]]},

{'无所不贪lv9',false,'每秒加全属性',1500,'全属性',200000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv9|r
    
|cffFFE799【奖励】|r|cff00ff00+1500每秒加全属性|r
    ]]},

{'无所不贪lvmax',false,'全伤加深',2.5,'全属性',200000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lvmax|r
    
|cffFFE799【奖励】|r|cff00ff00+2.5%全伤加深|r
   ]]},
},

}

--根据重数 给商店添加10技能，并让第一技能为可点击状态
--单位，重数
local function add_skill_by_lv(shop,lv)
    if not devil_deal[lv] then 
        return 
    end    
    for num,value in ipairs(devil_deal[lv]) do    
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

local mt = ac.skill['魔鬼的交易']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[mgdjy.blp]],
    title = name,
    tip = '\n查看 |cff00ff00魔鬼的交易\n|r',
}
for _,tab in ipairs(devil_deal) do 
    if not mt.skills then 
        mt.skills ={}
    end    
    local name = string.sub(tab[_][1],1,12)
    --每重魔法书
    table.insert(mt.skills,name)

    print('魔鬼的交易',name)
    local mt2 = ac.skill[name]
    mt2{
        is_spellbook = 1,
        is_order = 2,
        art = tab[_][7],
        title = name,
        tip = '\n查看 |cff00ff00'.. name ..'\n|r',
    }
    if not mt2.skills then 
        mt2.skills ={}
    end    
    for num,value in ipairs(tab) do 
        --插入到魔法书
        table.insert(mt2.skills,value[1])
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
            if self.wood then 
                str = '' .. self.wood .. '木头'
            end    
            if self.cost_allattr then 
                str = '' .. self.cost_allattr .. '全属性'
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
            mt.wood = tonumber(value[6])
        end   
        if value[5]=='全属性' then
            mt.cost_allattr = tonumber(value[6])
        end   

        --模拟商店点击
        function mt:on_cast_shot()
            local hero = self.owner
            local p = hero:get_owner()
            local seller = self.owner
            hero = p.hero
            local name = self.name 
            
            -- print(owner_value,self.cost_allattr)
            if self.cost_allattr then 
                local owner_value = math.min(hero:get('力量'),hero:get('敏捷'),hero:get('智力'))
                -- print(owner_value,self.cost_allattr)
                --有足够的全属性
                if owner_value > self.cost_allattr  then 
                    self.seller = seller
                    --扣除全属性
                    hero:add('全属性',-self.cost_allattr)
                    --给与奖励
                    self:on_cast_finish()
                else
                    p:sendMsg('全属性不足',10) 
                    --停止继续执行   
                    self:stop()
                    return
                end    
            end

            local item = setmetatable(self,ac.item)
            item.name = name
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
            -- print('施法结束啦')
            --增加属性
            -- print(self.attr_name,self.attr_val)
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
    -- print('单位-创建商店',shop)
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



