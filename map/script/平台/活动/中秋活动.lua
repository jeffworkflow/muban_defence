
local mt = ac.skill['中秋活动']
mt{
--等久
level = 1,
--图标
art = [[sldzx.blp]],
--说明
tip = [[ 
|cffffe799【活动时间】|r|cff00ff008月22日-8月25日
|cffffe799【活动说明】|r|cff00ff00传说，蒙娜丽莎的微笑中，含有83%的高兴、 9%的厌恶、 6%的恐惧、 2%的愤怒。 |cff00ffff最近，名画《蒙娜丽莎的微笑》又不见了，这让达芬奇头疼得很。

|cffff0000还请帮忙收集83个“高兴”、9个“厌恶”、6个“恐惧”、2个“愤怒”，交付于我
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
store_name = '|cffdf19d0失落的真相|r',
--物品详细介绍的title
content_tip = ''
}


local mt = ac.skill['五仁月饼']
mt{
--等久
level = 1,
--图标
art = [[bsdqw.blp]],
--说明
tip = [[


|cff00ffff青蛙：|cff00ff00我感觉我还可以救一下，请将我丢进|cffff0000基地右边花园的井里|cffffff00（也可见死不救，点击左键可食用，增加10%生命上限|r）

|cffcccccc抓青蛙活动物品|r]],
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
    hero:add_item(name,true)
end    

local mt = ac.skill['大西瓜']
mt{
--等久
level = 1,
--图标
art = [[bsdqw.blp]],
--说明
tip = [[


|cff00ffff青蛙：|cff00ff00我感觉我还可以救一下，请将我丢进|cffff0000基地右边花园的井里|cffffff00（也可见死不救，点击左键可食用，增加10%生命上限|r）

|cffcccccc抓青蛙活动物品|r]],
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
    hero:add_item(name,true)
end    


local mt = ac.skill['肥美的螃蟹']
mt{
--等久
level = 1,
--图标
art = [[bsdqw.blp]],
--说明
tip = [[


|cff00ffff青蛙：|cff00ff00我感觉我还可以救一下，请将我丢进|cffff0000基地右边花园的井里|cffffff00（也可见死不救，点击左键可食用，增加10%生命上限|r）

|cffcccccc抓青蛙活动物品|r]],
--品质
color = '紫',
--物品类型
item_type = '消耗品',
['力量%'] = 10,
rate = 10,
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
        ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 食用了青蛙，惊喜获得|cffff0000【可存档成就】'..save_name..'|r |cff00ff00+18.8杀怪加全属性|r |cff00ff00+18.8攻击减甲|r |cff00ff00+18.8%物品获取率|r |cff00ff00+18.8%暴击加深|r',6) 
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
    ['强盗领主'] =  {{rand = 35,     name = '五仁月饼'}},
    ['武器boss3'] =  {{ rand = 35,     name = '肥美的螃蟹'}},
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
    local yb_max_cnt = 2 
    local px_max_cnt = 2 

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
    local rate = 50
    --获得最多次数
    local dxg_max_cnt = 10
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
    if has_mall > 0 then 
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
        p:Map_SaveServerValue(key,1)
        --当局生效
        local skl = hero:find_skill(real_name,nil,true) 
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',real_name)
        end 
        --播放特效
        hero:add_effect('chest','Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdx'):remove()
        p:sendMsg('|cffffe799【系统消息】|r任务完成，恭喜获得|cffff0000【可存档成就】蒙娜丽莎的微笑|r 奖励 |cff00ff00+23.8杀怪加全属性|r |cff00ff00+23.8攻击减甲|r |cff00ff00+23.8%火灵加成|r |cff00ff00+23.8%全伤加深|r',6)
    end
end)
