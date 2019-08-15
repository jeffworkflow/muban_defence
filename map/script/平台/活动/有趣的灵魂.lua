
local mt = ac.skill['祭祀-有趣的灵魂']
mt{
--等久
level = 1,
--图标
art = [[jdzw.blp]],
--说明
tip = [[ 
|cffffe799【活动时间】|r|cff00ff008月11日-8月14日
|cffffe799【活动说明】|r|cff00ff00雨过不知龙去处，一池草色万蛙鸣。|cff00ffff这几天刮台风，基地经常出现一些青蛙，天天在那里哇哇叫。|cff00ff00还请帮忙|cffff0000把青蛙抓起来|r|cff00ff00，放到|cffffff00右边花园的井里|r
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
-- store_name = '|cffdf19d0挑战 |r',
--物品详细介绍的title
content_tip = ''
}




local mt = ac.skill['祭祀-点金石']
mt{
--等久
level = 1,
store_name = '兑换-点金石',
--图标
art = [[item\shou204.blp]],
--说明
tip = [[

消耗 |cffff0000一根喜鹊翎毛|r 兑换 |cff00ff00点金石|r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_material = '完美的鸡翅*1',
max_cnt = 10,
}   

local mt = ac.skill['祭祀-吞噬丹']
mt{
--等久
level = 1,
store_name = '兑换-吞噬丹',
--图标
art = [[icon\tunshi.blp]],
--说明
tip = [[

消耗 |cffff0000十根喜鹊翎毛|r 兑换 |cff00ff00吞噬丹|r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_material = '完美的鸡腿*5',
max_cnt = 2,
}   
local mt = ac.skill['祭祀-恶魔果实']
mt{
--等久
level = 1,
store_name = '兑换-恶魔果实',
--图标
art = [[guoshi.blp]],
--说明
tip = [[

消耗 |cffff0000十五根喜鹊翎毛|r 兑换 |cff00ff00恶魔果实|r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_material = '完美的鸡头*10',
max_cnt = 1,
}  
local mt = ac.skill['祭祀-格里芬']
mt{
--等久
level = 1,
store_name = '兑换-格里芬',
--图标
art = [[gelifen.blp]],
--说明
tip = [[

消耗 |cffff0000四根喜鹊翎毛|r 兑换 |cff00ff00恶魔果实合成材料-格里芬|r

|cffdf19d0格里芬|cff00ffff+黑暗项链+最强生物心脏+白胡子的大刀=恶魔果实（食用后可以获得惊人能力！)|r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_material = '完美的鸡汤*2',
max_cnt = 1,
}  

local mt = ac.skill['祭祀-黑暗项链']
mt{
--等久
level = 1,
store_name = '兑换-黑暗项链',
--图标
art = [[heianxianglian.blp]],
--说明
tip = [[

消耗 |cffff0000四根喜鹊翎毛|r 兑换 |cff00ff00恶魔果实合成材料-黑暗项链|r

|cff00ffff格里芬+|cffdf19d0黑暗项链|cff00ffff+最强生物心脏+白胡子的大刀=恶魔果实（食用后可以获得惊人能力！)|r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_material = '完美的鸡汤*2',
max_cnt = 1,
}  

local mt = ac.skill['祭祀-最强生物心脏']
mt{
--等久
level = 1,
store_name = '兑换-最强生物心脏',
--图标
art = [[zqswxz.blp]],
--说明
tip = [[

消耗 |cffff0000四根喜鹊翎毛|r 兑换 |cff00ff00恶魔果实合成材料-最强生物心脏|r

|cff00ffff格里芬+黑暗项链+|cffdf19d0最强生物心脏|cff00ffff+白胡子的大刀=恶魔果实（食用后可以获得惊人能力！)|r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_material = '完美的鸡汤*2',
max_cnt = 1,
}  

local mt = ac.skill['祭祀-白胡子的大刀']
mt{
--等久
level = 1,
store_name = '兑换-白胡子的大刀',
--图标
art = [[zhidao.blp]],
--说明
tip = [[

消耗 |cffff0000四根喜鹊翎毛|r 兑换 |cff00ff00恶魔果实合成材料-白胡子的大刀|r

|cff00ffff格里芬+黑暗项链+最强生物心脏+|r|cffdf19d0白胡子的大刀|r|cff00ffff=恶魔果实（食用后可以获得惊人能力！)|r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_material = '完美的鸡汤*2',
max_cnt = 1,
}  


for i,name in ipairs({'祭祀-格里芬','祭祀-黑暗项链','祭祀-最强生物心脏','祭祀-白胡子的大刀','祭祀-点金石','祭祀-吞噬丹','祭祀-恶魔果实','祭祀-缘定三生'}) do
    local mt = ac.skill[name]
    function mt:on_cast_start()
        local hero = self.owner
        local p = hero:get_owner()
        hero = p.hero
        if not p.max_cnt then 
            p.max_cnt = {} 
        end    

        local real_name = string.gsub(self.name,'祭祀%-','')
        local _, _, it_name, cnt = string.find(self.need_material,"(%S+)%*(%d+)")
        cnt = tonumber(cnt)
        local has_cnt = 0
        local has_item = self.owner:has_item(it_name)
        if has_item then 
            has_cnt = has_item:get_item_count()
        end    
        --处理兑换
        if has_cnt >= cnt  then 
            if (p.max_cnt[real_name] or 0 ) < self.max_cnt then 
                --扣除材料
                has_item:add_item_count(-cnt)
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


ac.game:event '游戏-开始'(function()
    -- 注册材料获得事件
    -- local time = 60 * 12 
    local rate = 80
    local time = 10
    ac.loop(time*1000,function()
        local point = ac.map.rects['藏宝区']:get_random_point()
        local unit = ac.player(16):create_unit('灵魂',point)

        unit:add_buff '随机逃跑' {}
        ac.nick_name('摸我一下试试',unit,250)

        unit:event '单位-死亡'(function(_,unit,killer)
            local p = killer:get_owner()
            if p.id >= 11 then 
                return 
            end    
            local player = killer:get_owner()
            local hero = p.hero
            local save_name = '有趣的灵魂'
            -- print(self.rate)
            if math.random(100) <= rate then 
                local key = ac.server.name2key(save_name)
                --激活成就（存档） 
                p:Map_AddServerValue(key,1) --网易服务器
                --动态插入魔法书
                local skl = hero:find_skill(save_name,nil,true) 
                if not skl  then 
                    ac.game:event_notify('技能-插入魔法书',hero,'精彩活动','有趣的灵魂')
                    ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 食用了青蛙，惊喜获得|cffff0000【可存档成就】'..save_name..'|r |cff00ff00+18.8杀怪加全属性|r |cff00ff00+18.8攻击减甲|r |cff00ff00+18.8%物品获取率|r |cff00ff00+18.8%暴击加深|r',6) 
                else
                    --有魔法书的情况下，升级
                    skl:upgrade(1)
                    ac.player.self:sendMsg('|cffffe799有趣的灵魂升级了。',6) 
                end   
            end     
        end)
    end)

end)
