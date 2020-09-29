
local mt = ac.skill['中秋活动']
mt{
--等久
level = 1,
--图标
art = [[shgty.blp]],
--说明
tip = [[ 
|cffffe799【活动时间】|r|cff00ff009月30日-10月15日
|cffffe799【活动说明】|r|cff00ff00年年此夜，华灯盛照，人月圆时。三界众人都忙于筹备盛宴，一时之间各地都人来人往，热闹非凡。|cff00ffff热心的各位少侠，快去三界各地帮助百姓们筹备团圆佳节宴吧！

|cffff0000还请帮忙收集15个“五仁月饼”、15个“大西瓜”、5个“肥美的螃蟹”，交付于我
 ]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 1,
--物品技能
is_skill = true,
store_affix = '',
store_name = '|cffdf19d0四海共团圆|r',
--物品详细介绍的title
content_tip = ''
}


local mt = ac.skill['五仁月饼']
mt{
--等久
level = 1,
--图标
art = [[wryb.blp]],
--说明
tip = [[


|cff00ff00由杏仁、桃仁、橄榄仁、芝麻仁和瓜子仁做成的月饼，|cffff0000点击左键可食用

|cffcccccc中秋活动物品|r]],
--品质
color = '紫',
--物品类型
item_type = '消耗品',
cool = 1,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}

function mt:on_cast_start()
    local hero = self.owner 
    local p = hero:get_owner()
    local player = hero:get_owner()
    --随机装备
    local name = ac.equipment[math.random(1,#ac.equipment)]
    local it = hero:add_item(name,true)
    p:sendMsg('|cffffe799【系统消息】|r |cff00ff00这个月饼里面怎么有东西硬硬的，获得'..it.color_name..'',6) 
    --|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 获得了 |cff'..ac.color_code[lni_color]..name..'|r
end    

local mt = ac.skill['大西瓜']
mt{
--等久
level = 1,
--图标
art = [[xigua.blp]],
--说明
tip = [[


|cff00ff00原名叫稀瓜，意思是水多肉稀的瓜，但后来传着传着就变成了西瓜。|cffff0000点击左键可食用

|cffcccccc中秋活动物品|r]],
--品质
color = '紫',
--物品类型
item_type = '消耗品',
cool = 1,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}

function mt:on_cast_start()
    local hero = self.owner 
    local p = hero:get_owner()
    local player = hero:get_owner()
    --随机消耗品
    local name = ac.consumable_item[math.random(1,#ac.consumable_item)]
    local it = hero:add_item(name,true)
    p:sendMsg('|cffffe799【系统消息】|r |cff00ff00这个绝对不是普通的西瓜，获得'..it.color_name..'',6) 
end    


local mt = ac.skill['肥美的螃蟹']
mt{
--等久
level = 1,
--图标
art = [[jdldpx.blp]],
--说明
tip = [[


|cff00ff00听说很补？|cffff0000点击左键可食用，增加10%力量

|cffcccccc中秋活动物品|r]],
--品质
color = '紫',
--物品类型
item_type = '消耗品',
['力量%'] = 10,

cool = 1,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}

function mt:on_cast_start()
    local hero = self.owner 
    local p = hero:get_owner()
    local player = hero:get_owner()
    hero = p.hero
    local save_name = '第一个吃螃蟹的人'
    -- print(self.rate)
    if ac.flag_hd_cpx then 
        -- p:sendMsg('已有第一个吃螃蟹的人')
        return 
    end    
    ac.flag_hd_cpx = true
    local key = ac.server.name2key(save_name)
    --激活成就（存档） 
    p:Map_AddServerValue(key,1) --网易服务器
    --动态插入魔法书
    local skl = hero:find_skill(save_name,nil,true) 
    if not skl  then 
        ac.game:event_notify('技能-插入魔法书',hero,'精彩活动','第一个吃螃蟹的人')
        ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 食用了“肥美的螃蟹”，成为本局|cffff0000'..save_name..'（可存档成就）|r 成就属性可在“巅峰神域-精彩活动”中查看',6) 
    else
        skl:upgrade(1)
        p:sendMsg('|cffff0000【可存档成就】'..save_name..'+1',6)  
    end  


end   

--注册获得方式
-- 击杀强盗领主35%掉落 五仁月饼
-- 攻击木桩1%掉落 大西瓜
-- 击杀武器BOSS3，35%掉落 肥美的螃蟹
local unit_reward = { 
    ['强盗领主'] =  {{rand = 30,     name = '五仁月饼'}},
    ['武器boss3'] =  {{ rand = 40,     name = '肥美的螃蟹'}},
}
ac.game:event '单位-死亡' (function (_,unit,killer)
    local reward_type = unit:get_name()
    if not finds(reward_type,'强盗领主','武器boss3') then 
        return
    end    
    local p = killer:get_owner()
    local hero = p.hero
    local rand_name = ac.get_reward_name(unit_reward[reward_type])  
    if not rand_name then 
        return 
    end    
    if not p.max_item_fall then 
        p.max_item_fall = {}
    end
    p.max_item_fall[rand_name] = (p.max_item_fall[rand_name] or 0) + 1
    --获得最多次数
    local yb_max_cnt = 20   
    local px_max_cnt = 10

    if reward_type == '强盗领主' and p.max_item_fall[rand_name] <= yb_max_cnt then 
        ac.item.create_item(rand_name,unit:get_point())
    end    
    if reward_type == '武器boss3' and p.max_item_fall[rand_name] <= px_max_cnt then 
        ac.item.create_item(rand_name,unit:get_point())
    end

end)

--游戏说明 攻击1%得大西瓜
ac.game:event '游戏-开始' (function()
    local unit = ac.game.findunit_byname('游戏说明')
    local rate = 1
    --获得最多次数
    local dxg_max_cnt = 20
    unit:event '受到伤害效果'(function(_,damage)
        local p = damage.source:get_owner()
        if not p.max_item_fall then 
            p.max_item_fall = {}
        end
        if math.random(100) <= rate  then 
            p.max_item_fall['大西瓜'] = (p.max_item_fall['大西瓜'] or 0) + 1
            if p.max_item_fall['大西瓜'] <= dxg_max_cnt then 
                p.hero:add_item('大西瓜',true)
            end    
        end    
	end)
end)

--处理区域触发
local minx, miny, maxx, maxy = ac.rect.j_rect('hdsz'):get()
local rect = ac.rect.create(minx-250, miny-250, maxx+250, maxy+250)
local reg = ac.region.create(rect)

reg:event '区域-进入' (function(trg,unit)
    local p = unit:get_owner()
    if p.id>=11 then 
        return 
    end
    if not p.cus_server then 
        return 
    end  
    local hero = p.hero 
    local real_name ='四海共团圆'
    local has_mall = p:Map_GetServerValue(ac.server.name2key(real_name))
    --已有物品的处理
    if has_mall >= 2 then 
        -- p:sendMsg('【系统消息】已有'..real_name)   
        return 
    end 
    local temp = {
        {'五仁月饼',15},
        {'大西瓜',15},
        {'肥美的螃蟹',5},
    }
    local flag = true 
    --其中有一项不满足就跳出
    for i,data in ipairs(temp) do 
        local item = unit:has_item(data[1])
        local has_cnt = item and item:get_item_count() or 0
        if has_cnt < data[2] then 
            flag = false 
            break
        end   
    end
    if flag then 
        --扣除存档数据
        for i,data in ipairs(temp) do 
            local item = unit:has_item(data[1])
            item:add_item_count(-data[2])
        end   
        --保存存档
        local key = ac.server.name2key(real_name)
        p:Map_AddServerValue(key,1)
        --当局生效
        local skl = hero:find_skill(real_name,nil,true) 
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',real_name)
            p:sendMsg('|cffffe799【系统消息】|r任务完成，恭喜获得|cffff0000【可存档成就】四海共团圆|r 奖励 |cff00ff00+26.8杀怪加全属性|r |cff00ff00+26.8攻击减甲|r |cff00ff00+26.8%杀敌数加成|r |cff00ff00+26.8%全伤加深|r',6)
        else 
            skl:upgrade(1)   
            p:sendMsg('|cffff0000【可存档成就】'..real_name..'+1',6)  
        end 
        --播放特效
        hero:add_effect('chest','Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdx'):remove()
    end
end)
