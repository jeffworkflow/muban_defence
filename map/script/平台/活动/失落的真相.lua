
local mt = ac.skill['失落的真相']
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




local mt = ac.skill['真相-点金石']
mt{
--等久
level = 1,
store_name = '兑换-点金石',
--图标
art = [[item\shou204.blp]],
--说明
tip = [[

消耗 |cffff0000四个“高兴”|r 兑换 |cff00ff00一个点金石|r

|cffcccccc当前拥有“高兴”数量：%has_material%|cffcccccc，每局最大兑换次数=20次|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',

has_material = function(self)
    local p = ac.player.self
    return p.cus_server['高兴'] or 0
end,
--物品技能
is_skill = true,
need_material = '高兴*4',
max_cnt = 20,
}   

local mt = ac.skill['真相-吞噬丹']
mt{
--等久
level = 1,
store_name = '兑换-吞噬丹',
--图标
art = [[icon\tunshi.blp]],
--说明
tip = [[

消耗 |cffff0000三个“厌恶”|r 兑换 |cff00ff00一个吞噬丹|r

|cffcccccc当前拥有“厌恶”数量：%has_material%|cffcccccc，每局最大兑换次数=2次|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',

has_material = function(self)
    local p = ac.player.self
    return p.cus_server['厌恶'] or 0
end,
--物品技能
is_skill = true,
need_material = '厌恶*3',
max_cnt = 2,
}   

local mt = ac.skill['真相-恶魔果实']
mt{
--等久
level = 1,
store_name = '兑换-恶魔果实',
--图标
art = [[guoshi.blp]],
--说明
tip = [[

消耗 |cffff0000两个“恐惧”|r 兑换 |cff00ff00一个恶魔果实|r

|cffcccccc当前拥有“恐惧”数量：%has_material%|cffcccccc，每局最大兑换次数=2次|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
has_material = function(self)
    local p = ac.player.self
    return p.cus_server['恐惧'] or 0
end,
--物品技能
is_skill = true,
need_material = '恐惧*2',
max_cnt = 2,
}  
local mt = ac.skill['真相-魔鬼的砒霜']
mt{
--等久
level = 1,
store_name = '兑换-魔鬼的砒霜',
--图标
art = [[mgdps.blp]],
--说明
tip = [[

消耗 |cffff0000一个“愤怒”|r 兑换 |cff00ff00一个魔鬼的砒霜|r

|cffcccccc当前拥有“愤怒”数量：%has_material%|cffcccccc，每局最大兑换次数=1次|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
has_material = function(self)
    local p = ac.player.self
    return p.cus_server['愤怒'] or 0
end,
--物品技能
is_skill = true,
need_material = '愤怒*1',
max_cnt = 1,
}  

local mt = ac.skill['真相-蒙娜丽莎的微笑']
mt{
--等久
level = 1,
store_name = '蒙娜丽莎的微笑',
--图标
art = [[sldzx.blp]],
--说明
tip = [[

|cff00ff00传说，蒙娜丽莎的微笑中，含有83%的高兴、9%的厌恶、6%的恐惧、2%的愤怒。请帮忙收集83个高兴+9个厌恶+6个恐惧+2个愤怒，交给我

 ]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【任务说明】：|r\n',
--物品技能
is_skill = true,
need_material = '愤怒*2',
max_cnt = 1,
}  

for i,name in ipairs({'真相-点金石','真相-吞噬丹','真相-恶魔果实','真相-魔鬼的砒霜'}) do
    local mt = ac.skill[name]
    function mt:on_cast_start()
        local hero = self.owner
        local p = hero:get_owner()
        hero = p.hero
        if not p.max_cnt then 
            p.max_cnt = {} 
        end    
        local real_name = string.gsub(self.name,'真相%-','') 
        local _, _, it_name, cnt = string.find(self.need_material,"(%S+)%*(%d+)")
        cnt = tonumber(cnt)
        local has_cnt = (p.cus_server and p.cus_server[it_name]) or 0
        --处理兑换
        if has_cnt >= cnt  then 
            if (p.max_cnt[real_name] or 0 ) < self.max_cnt then 
                --扣除材料
                local key = ac.server.name2key(it_name)
                p:Map_AddServerValue(key,-cnt)
                self.owner:add_item(real_name,true) 
                p.max_cnt[real_name] = (p.max_cnt[real_name] or 0) + 1
                p:sendMsg('|cffff0000兑换'..real_name..'成功|r')   
            else
                p:sendMsg('本局已达兑换上限')    
            end    
        else 
            p:sendMsg('材料不够')    
        end    
    end    
end    

--注册获得方式
local unit_reward = { 
    ['进攻怪'] =  {
        { rand = 0.166,     name = '高兴'},
        { rand = 0.018,      name = '厌恶'},
        { rand = 0.012,      name = '恐惧'},
        { rand = 0.004,      name = '愤怒'}
    },
}
ac.game:event '单位-死亡' (function (_,unit,killer)
    if unit:get_owner().id < 11 then 
        return
    end    
    local p = killer:get_owner()
    local rand_name = ac.get_reward_name(unit_reward['进攻怪'])  
    if not rand_name then 
        return 
    end    
    local key = ac.server.name2key(rand_name)
    p:Map_AddServerValue(key,1)
    p:sendMsg('|cffffe799【系统消息】|cffff0000'..rand_name..'+1|r，|cff00ff00可按F4查看总量',3)  

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
    local real_name ='蒙娜丽莎的微笑'
    local has_mall = p:Map_GetServerValue(ac.server.name2key(real_name))
    --已有物品的处理
    if has_mall > 0 then 
        -- p:sendMsg('【系统消息】已有'..real_name)   
        return 
    end 
    local temp = {
        {'高兴',83},
        {'厌恶',9},
        {'恐惧',6},
        {'愤怒',2},
    }
    local flag = true 
    --其中有一项不满足就跳出
    for i,data in ipairs(temp) do 
        if p.cus_server[data[1]] < data[2] then 
            flag = false 
            break
        end
    end
    if flag then 
        --扣除存档数据
        for i,data in ipairs(temp) do 
            local key = ac.server.name2key(data[1])
            p:Map_AddServerValue(key,-data[2])
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
