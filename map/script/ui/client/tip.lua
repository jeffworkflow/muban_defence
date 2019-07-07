local game_ui = japi.GetGameUI()
--背景和tip
local backdrop = japi.CreateFrame('mtp_text_backdrop',game_ui,0)
local tip_text = japi.CreateFrame('mtp_text_tip',backdrop,0)
--指向锚点
japi.FrameSetAllPoints(backdrop,tip_text)
--跟随偏移
japi.FrameSetPoint(backdrop,0,tip_text,0,-0.0054,0.04)
japi.FrameSetPoint(backdrop,8,tip_text,8,0.0054,-0.007)

japi.FrameSetPoint(tip_text,8,game_ui,8,-0.006,0.16777)


--标题
local title_text = japi.CreateFrame('mtp_text_title',backdrop,0)
japi.FrameSetPoint(title_text,0,backdrop,0,0.0054,-0.006)
japi.FrameSetSize(title_text,0.2,0.015)
japi.FrameSetText(title_text,'我是标题ABc')

--所有货币的父节点
local currency = japi.CreateFrame('currency_backdrop',backdrop,0)
japi.FrameSetSize(currency,0.1972,0.0104)
japi.FrameSetPoint(currency,0,title_text,6,0,-0.0037)

--金币
local gold_icon = japi.CreateFrame('mtp_gold_icon',currency,0)
japi.FrameSetSize(gold_icon,0.0103,0.0104)
japi.FrameSetPoint(gold_icon,0,currency,0,0,0)

local gold_text = japi.CreateFrame('mtp_gold_text',currency,0)
japi.FrameSetPoint(gold_text,3,gold_icon,5,0.003,0)
--japi.FrameSetText(gold_text,'123450')

--木头
local wood_icon = japi.CreateFrame('mtp_wood_icon',currency,0)
japi.FrameSetSize(wood_icon,0.0103,0.0104)
japi.FrameSetPoint(wood_icon,3,gold_text,5,0.0054,0)

local wood_text = japi.CreateFrame('mtp_wood_text',currency,0)
japi.FrameSetPoint(wood_text,3,wood_icon,5,0.003,0)
--japi.FrameSetText(wood_text,'123450')

--杀敌数
local kill_icon = japi.CreateFrame('mtp_kill_icon',currency,0)
japi.FrameSetSize(kill_icon,0.0103,0.0104)
japi.FrameSetPoint(kill_icon,3,wood_text,5,0.0054,0)

local kill_text = japi.CreateFrame('mtp_kill_text',currency,0)
japi.FrameSetPoint(kill_text,3,kill_icon,5,0.003,0)
--japi.FrameSetText(kill_text,'123450')

--火灵
local fire_icon = japi.CreateFrame('mtp_fire_icon',currency,0)
japi.FrameSetSize(fire_icon,0.0103,0.0104)
japi.FrameSetPoint(fire_icon,3,kill_text,5,0.0054,0)

local fire_text = japi.CreateFrame('mtp_fire_text',currency,0)
japi.FrameSetPoint(fire_text,3,fire_icon,5,0.003,0)

--积分
local jifen_icon = japi.CreateFrame('mtp_jifen_icon',currency,0)
japi.FrameSetSize(jifen_icon,0.0103,0.0104)
japi.FrameSetPoint(jifen_icon,3,fire_text,5,0.0054,0)

local jifen_text = japi.CreateFrame('mtp_jifen_text',currency,0)
japi.FrameSetPoint(jifen_text,3,jifen_icon,5,0.003,0)

--魔兽的提示框
local tsk = japi.FrameGetTooltip()

japi.FrameShow(currency,false)
japi.FrameShow(backdrop,false)

japi.FrameShow(gold_icon,false)
japi.FrameShow(wood_icon,false)

ac.game:event '玩家-选择单位'(function(_,p,u)
    p.my_selection = u
end)

mtp_tip.shop_hide_tip = function()
    japi.FrameShow(backdrop,false)
end

mtp_tip.shop_show_tip = function()
    japi.FrameShow(backdrop,true)
    --把魔兽自带的提示框移出屏幕外
    japi.FrameSetPoint(tsk,8,game_ui,8,0.3,0.16)
end


mtp_tip.set_skill_tip = function(button)
    if button.type ~= '技能栏' then
        return
    end

    --取到当前玩家的选择对象
    local u = ac.player.self.my_selection
    if not u then
        return
    end

    --如果是商店
    if u.unit_type and u.unit_type == '商店' and u.sell_item_list then
        local item = u.sell_item_list[button.slot_id]
        if not item then
            return
        end
        --再根据名字取shop_item_map的物品
        item = ac.item.shop_item_map[item.name]
        mtp_tip.shop_show_tip()
        --标题
        local title = item.store_name 
        japi.FrameSetText(title_text,title)

        --货币
        local gold,show_gold,player_gold = item:buy_price()
        local wood,show_wood,player_wood = item:buy_wood()
        local kill_count,show_kill_count,player_kill = item:buy_kill_count()
        -- print(item.name,kill_count,show_kill_count,player_kill)
        -- print('本地玩家',ac.player.self)
        -- if item.player_kill then 
        --     print(kill_count,show_kill_count,player_kill,item.player_kill[ac.player.self])
        -- end    

        local jifen,show_jifen,player_jifen = item:buy_jifen()
        local fire_seed,show_fire_seed,player_fire = item:buy_fire_seed()
        gold = player_gold or gold
        wood = player_wood or wood
        kill_count = player_kill or kill_count
        jifen = player_jifen or jifen
        fire_seed = player_fire or fire_seed


        if gold<=0 and wood<=0 and kill_count<=0 and jifen <= 0 and fire_seed<=0 then 
            japi.FrameShow(currency,false)
            japi.FrameSetPoint(backdrop,0,tip_text,0,-0.0054,0.0265)
        else
            japi.FrameShow(currency,true)
            japi.FrameSetPoint(backdrop,0,tip_text,0,-0.0054,0.04)
        end    
        --隐藏全部
        japi.FrameShow(gold_icon,false)
        japi.FrameShow(gold_text,false)
        japi.FrameShow(wood_icon,false)
        japi.FrameShow(wood_text,false)
        japi.FrameShow(kill_icon,false)
        japi.FrameShow(kill_text,false)
        japi.FrameShow(fire_icon,false)
        japi.FrameShow(fire_text,false)
        japi.FrameShow(jifen_icon,false)
        japi.FrameShow(jifen_text,false)
        
        -- print(show_kill_count,show_jifen,show_fire_seed)
        if gold and gold >0 then
            japi.FrameShow(gold_icon,true)
            japi.FrameShow(gold_text,true)
            japi.FrameSetTexture(gold_icon,[[UI\Widgets\ToolTips\Human\ToolTipGoldIcon.blp]],0) --0为拉伸
            --设置价格
            japi.FrameSetText(gold_text,gold)
        end
        if wood and wood >0 then
            japi.FrameShow(gold_icon,true)
            japi.FrameShow(gold_text,true)
            japi.FrameSetTexture(gold_icon,[[UI\Widgets\ToolTips\Human\ToolTipLumberIcon.blp]],0) --0为拉伸
            --设置价格
            japi.FrameSetText(gold_text,wood)
        end
        --暂不支持 2个以上币种一起
        if kill_count and kill_count >0 then
            japi.FrameShow(gold_icon,true)
            japi.FrameShow(gold_text,true)
            japi.FrameSetTexture(gold_icon,[[UI\small_kill.blp]],0) --0为拉伸
            --设置价格
            japi.FrameSetText(gold_text,show_kill_count)
        end
        --暂不支持 2个以上币种一起
        if fire_seed and fire_seed >0 then
            japi.FrameShow(gold_icon,true)
            japi.FrameShow(gold_text,true)
            japi.FrameSetTexture(gold_icon,[[UI\small_fire_seed.blp]],0) --0为拉伸
            --设置价格
            japi.FrameSetText(gold_text,show_fire_seed)
        end
        --暂不支持 2个以上币种一起
        if jifen and jifen >0 then
            japi.FrameShow(gold_icon,true)
            japi.FrameShow(gold_text,true)
            japi.FrameSetTexture(gold_icon,[[UI\small_jifen.blp]],0) --0为拉伸
            --设置价格
            japi.FrameSetText(gold_text,show_jifen)
        end
        
        --tip
        japi.FrameSetText(tip_text,item:get_tip())
    else
        --不是商店,是英雄 宠物 召唤物等 直接显示魔兽自带的提示框
        japi.FrameShow(backdrop,false)  --隐藏自己画的
        japi.FrameSetPoint(tsk,8,game_ui,8,0,0.16)  --还原魔兽自带的位置
    end
end


mtp_tip.hide_skill_tip = function(button)
    if button.type ~= '技能栏' then
        return
    end

    --取到当前玩家的选择对象
    local u = ac.player.self.my_selection
    if not u then
        return
    end

    if u.unit_type and u.unit_type == '商店' then
        mtp_tip.shop_hide_tip()
        -- japi.FrameSetPoint(tsk,8,game_ui,8,0,0.16)  --还原魔兽自带的位置
    else
        japi.FrameSetPoint(tsk,8,game_ui,8,0,0.16)  --还原魔兽自带的位置    
    end

    



end