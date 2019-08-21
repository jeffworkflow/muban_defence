
local mt = ac.skill['失落的真相']
mt{
--等久
level = 1,
--图标
art = [[zyj.blp]],
--说明
tip = [[ 
|cffffe799【活动时间】|r|cff00ff008月16日-8月19日
|cffffe799【活动说明】|r
|cff00ff001.时至中元，举办祭祀活动，以慰在基地游玩的众家鬼魂，并祈求大家全年的平安顺利。|cff00ff00还请少侠帮忙|cffff0000贡献一些食物|r

|cff00ff002.好看的皮囊千篇一律，有趣的灵魂万里挑一。|cff00ffff基地经常出现一些有趣的灵魂。|cff00ff00还请少侠帮忙|cffff0000击败并超度它们|r
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
store_name = '|cffdf19d0中元节活动|r',
--物品详细介绍的title
content_tip = ''
}




local mt = ac.skill['真相-点金石']
mt{
--等久
level = 1,
store_name = '真相-点金石',
--图标
art = [[item\shou204.blp]],
--说明
tip = [[
拥有 ： %has_material%
贡献 |cffff0000一个完美的鸡翅|r 奖励 |cff00ff00点金石|r

|cffcccccc最大贡献次数=10次|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【真相说明】：|r\n',

has_material = function(self)
    local p = ac.player.self
    return p.cus_server['高兴'] or 0
end,
--物品技能
is_skill = true,
need_material = '高兴*1',
max_cnt = 10,
}   

local mt = ac.skill['真相-吞噬丹']
mt{
--等久
level = 1,
store_name = '真相-吞噬丹',
--图标
art = [[icon\tunshi.blp]],
--说明
tip = [[

贡献 |cffff0000五个完美的鸡腿|r 奖励 |cff00ff00吞噬丹|r

|cffcccccc最大贡献次数=2次|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【真相说明】：|r\n',
--物品技能
is_skill = true,
need_material = '厌恶*5',
max_cnt = 2,
}   

local mt = ac.skill['真相-恶魔果实']
mt{
--等久
level = 1,
store_name = '真相-恶魔果实',
--图标
art = [[guoshi.blp]],
--说明
tip = [[

贡献 |cffff0000十个完美的鸡头|r 奖励 |cff00ff00恶魔果实|r

|cffcccccc最大贡献次数=1次|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【真相说明】：|r\n',
--物品技能
is_skill = true,
need_material = '恐惧*10',
max_cnt = 1,
}  
local mt = ac.skill['真相-魔鬼的砒霜']
mt{
--等久
level = 1,
store_name = '真相-魔鬼的砒霜',
--图标
art = [[gelifen.blp]],
--说明
tip = [[

贡献 |cffff0000两个完美的鸡汤|r 奖励 |cff00ff00格里芬|r

|cffdf19d0格里芬|cff00ffff+黑暗项链+最强生物心脏+白胡子的大刀=恶魔果实（食用后可以获得惊人能力！)|r

|cffcccccc最大贡献次数=1次|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【祭祀说明】：|r\n',
--物品技能
is_skill = true,
need_material = '愤怒*2',
max_cnt = 1,
}  

local mt = ac.skill['真相-蒙娜丽莎的微笑']
mt{
--等久
level = 1,
store_name = '真相-蒙娜丽莎的微笑',
--图标
art = [[gelifen.blp]],
--说明
tip = [[

贡献 |cffff0000两个完美的鸡汤|r 奖励 |cff00ff00格里芬|r

|cffdf19d0格里芬|cff00ffff+黑暗项链+最强生物心脏+白胡子的大刀=恶魔果实（食用后可以获得惊人能力！)|r

|cffcccccc最大贡献次数=1次|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【祭祀说明】：|r\n',
--物品技能
is_skill = true,
need_material = '愤怒*2',
max_cnt = 1,
}  

for i,name in ipairs({'真相-点金石','真相-吞噬丹','真相-恶魔果实','真相-魔鬼的砒霜','真相-蒙娜丽莎的微笑'}) do
    local mt = ac.skill[name]
    function mt:on_cast_start()
        local hero = self.owner
        local p = hero:get_owner()
        hero = p.hero
        if not p.max_cnt then 
            p.max_cnt = {} 
        end    
        local real_name = string.gsub(self.name,'真相%-','')
        --特殊处理 蒙娜丽莎的微笑
        if real_name == '蒙娜丽莎的微笑' then 
            local has_mall = p.mall[real_name] or (p.cus_server and p.cus_server[real_name])
            --已有物品的处理
            if has_mall > 0 then 
                p:sendMsg('【系统消息】已有'..real_name)    
                return 
            end
            if not p.cus_server then 
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
                p:sendMsg('|cffff0000兑换'..real_name..'成功|r')   
            end
            return
        end    

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
        { rand = 10.166,     name = '高兴'},
        { rand = 0.018,      name = '厌恶'},
        { rand = 0.012,      name = '恐惧'},
        { rand = 0.005,      name = '愤怒'}
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
    p:sendMsg('|cffff0000'..rand_name..'+1|r')   

end)
