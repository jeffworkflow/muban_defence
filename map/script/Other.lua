-- local Base64 = require 'ac.Base64'

--开启FPS
japi.ShowFpsText(true)
ac.loop(1000,function()
    if ac.player.self then
        c_ui.kzt.top_panel.fps:set_text('FPS:'..math.floor(japi.GetFps()))
    end
end)

--添加新手buff及新手礼包
if ac.Gamemode == '新手' then
    --给所有玩家添加新手BUFF
    for i=1,8 do
        local p = ac.player[i]
        if p:is_player() then
            p.hero:add_item('新手礼包',1)

            local skl = p.hero:find_skill('新手buff','隐藏')
            if skl then
                p.hero:add_buff '新手buff'
                {
                    source = p.hero,
                    skill = skl,
                }
            end
        end
    end
end


--记录最大单位数
ac.game:event '单位-创建'(function(_,u)
    if not u.owner:is_player() then
        ac.yg_count = ac.yg_count + 1
    end
end)

ac.game:event '单位-死亡'(function(_,u)
    if not u.owner:is_player() then
        ac.yg_count = ac.yg_count - 1
    end
end)

--读取玩家的商城道具
local item = {
    {'JBLB','金币礼包'},
    {'MTLB','木头礼包'},
    {'ZYLB','资源礼包'},
    {'ZZLB','赞助礼包'},
    {'ZSCB','紫色翅膀'},
    {'AFY','奥菲娅'},
    {'WL','维拉'},
    {'XV','雪女'},
    {'TMXRW','糖梅希尔瓦娜斯'},
    {'CJLM','春节李敏'},
    {'HRZJ','环绕之剑'},
    {'FB','飞镖'},
    {'JF','季风'},
}

for i=1,8 do
    local p = ac.player[i]
    if p:is_player() then
        for n=1,#item do
            if p:Map_HasMallItem(item[n][1]) then
                p.hero:add_item(item[n][2],1)
            end
        end
        --永久积分角色卡
        if p:Map_GetServerValue('yltg') == '1' then
            p.hero:add_item('幽灵特工',1)
        end
        if p:Map_GetServerValue('assjan') == '1' then
            p.hero:add_item('奥术师吉安娜',1)
        end
        if p:Map_GetServerValue('yssjan') == '1' then
            p.hero:add_item('银-奥术法师吉安娜',1)
        end
    end
end

--随机天赋一次
for i=1,8 do
    local player = ac.player[i]
    if player:is_player() then
        player:event '玩家-聊天'(function(_,p,str)
            
            if p.tianfu_sj then
                p:sendMsg('已经随机过了')
                return
            end
        
            if not p.hero then
                return
            end
        
            if str == '-sj' then
                if ac.ui.skillcolumn.tianfu_remove_skill(p.hero) then
                    p.tianfu_sj = true
                    --随机给与一个天赋技能
                    local skill_name = qj_talent_group[math.random(#qj_talent_group)]
                    p.hero:add_skill_item(skill_name)
                    p:sendMsg('恭喜你随机到'..skill_name)
                else
                    p:sendMsg('随机失败，技能栏内没有找到天赋技能')
                end
            end
        end)
    end
end

--创建NPC装饰物
local npc = ac.player[16]:create_unit('我是装饰物2',ac.point(- 1134.5, 602.5),298.830)
npc.name = '我是装饰物2'
npc:add_restriction '无敌'

local npc = ac.player[16]:create_unit('我是装饰物3',ac.point(- 22.1, - 434.9),162.960)
npc.name = '我是装饰物3'
npc:add_restriction '无敌'

local npc = ac.player[16]:create_unit('我是装饰物1',ac.point(- 1310.6, - 331.0),39.670)
npc.name = '我是装饰物1'
npc:add_restriction '无敌'

local npc = ac.player[16]:create_unit('我是装饰物4',ac.point(- 98.1, 504.7),235.870)
npc.name = '我是装饰物4'
npc:add_restriction '无敌'



--清理地上的物品
local bag = require 'ui.server.bag'
ac.game:event '玩家-聊天'(function(_,p,str)

    if str ~= '-ql' then
        return
    end

    --记录物品数量
    local item_count = 0
    --记录累计金额
    local gold_count = 0

    for id,item in pairs(bag.item_map) do
        local data = Table.ItemData[item:get_name()].SellPrice
        item_count = item_count + 1
        if data then
            gold_count = gold_count + data
        end
        local eff = s_ui.item_eff[id]
        eff:remove()
        jass.RemoveItem(jass.ConvertUnitState(id))
    end

    --计算一下平均值
    local value = gold_count / ac.player.count
    ac.player.self:sendMsg('本次共清理:'..item_count..'个物品,价值:'..gold_count..'元，每位玩家获得:'..value)
    for i = 1,ac.player.count do
        local p = ac.player[i]
        p:addGold(value)
    end

end)


local function dw_jiangli()
    --创建一只王者马甲
    local wz = ac.player[16]:create_dummy('e001',ac.point(0,0))
    wz.name = '王者'
    wz:add_restriction '无敌'
    local wz_skl = wz:add_skill('王者','隐藏')


    --创建一只大师马甲
    local ds = ac.player[16]:create_dummy('e001',ac.point(0,0))
    ds.name = '大师'
    ds:add_restriction '无敌'
    local ds_skl = ds:add_skill('大师','隐藏')

    --记录一下王者人数
    local wz_count = 0
    --记录一下大师人数
    local ds_count = 0

    --段位奖励
    if ac.nandu_id == 3 then
        --遍历一下英雄组
        for _, u in ipairs(ac.player_hero_group) do
            --如果是王者
            if u.owner.rank == 8 then
                wz_count = wz_count + 1
            end

            --如果是大师
            if u.owner.rank == 7 then
                ds_count = ds_count + 1
            end
        end
    end

    --给所有玩家添加王者buff
    for i=1,wz_count do
        for _, u in ipairs(ac.player_hero_group) do
            u:add_buff '王者'
            {
                source = wz,
                skill = wz_skl
            }
        end
    end

    --给所有玩家添加大师buff
    for i=1,ds_count do
        for _, u in ipairs(ac.player_hero_group) do
            u:add_buff '大师'
            {
                source = ds,
                skill = ds_skl
            }
        end
    end

    --修改一下buff层数
    if wz_count > 0 then
        wz_skl:set_stack(wz_count)
    end

    if ds_count > 0 then
        ds_skl:set_stack(ds_count)
    end

end
dw_jiangli()

--地图等级奖励
for i=1,8 do
    local p = ac.player[i]
    if p:is_player() then
        local lv = p:Map_GetMapLevel()
        if lv == 0 then

        elseif lv == 1 then
            p:sendMsg('地图等级1级')
            p:sendMsg('奖励10全属性')
            p.hero:add('力量',10)
            p.hero:add('敏捷',10)
            p.hero:add('智力',10)
        elseif lv == 2 then
            p:sendMsg('地图等级2级')
            p:sendMsg('奖励20全属性')
            p.hero:add('力量',20)
            p.hero:add('敏捷',20)
            p.hero:add('智力',20)
        elseif lv < 5 then
            p:sendMsg('地图等级'..lv..'级')
            p:sendMsg('奖励30全属性')
            p.hero:add('力量',30)
            p.hero:add('敏捷',30)
            p.hero:add('智力',30)
        elseif lv < 10 then
            p:sendMsg('地图等级'..lv..'级')
            p:sendMsg('奖励50全属性')
            p:sendMsg('奖励20攻速奖励')
            p.hero:add('力量',50)
            p.hero:add('敏捷',50)
            p.hero:add('智力',50)
            p.hero:add('攻击速度',20)
        elseif lv < 15 then
            p:sendMsg('地图等级'..lv..'级')
            p:sendMsg('奖励100全属性')
            p:sendMsg('奖励30攻速奖励')
            p:sendMsg('奖励30技能加成奖励')
            p.hero:add('力量',100)
            p.hero:add('敏捷',100)
            p.hero:add('智力',100)
            p.hero:add('攻击速度',50)
            p.hero:add('技能伤害',50)
        elseif lv < 20 then
            p:sendMsg('地图等级'..lv..'级')
            p:sendMsg('奖励200全属性')
            p:sendMsg('奖励50攻速奖励')
            p:sendMsg('奖励50技能加成奖励')
            p.hero:add('力量',200)
            p.hero:add('敏捷',200)
            p.hero:add('智力',200)
            p.hero:add('攻击速度',50)
            p.hero:add('技能伤害',50)
        elseif lv < 25 then
            p:sendMsg('地图等级'..lv..'级')
            p:sendMsg('奖励250全属性')
            p:sendMsg('奖励60攻速奖励')
            p:sendMsg('奖励60技能加成奖励')
            p.hero:add('力量',250)
            p.hero:add('敏捷',250)
            p.hero:add('智力',250)
            p.hero:add('攻击速度',60)
            p.hero:add('技能伤害',60)
        elseif lv < 30 then
            p:sendMsg('地图等级'..lv..'级')
            p:sendMsg('奖励300全属性')
            p:sendMsg('奖励70攻速奖励')
            p:sendMsg('奖励70技能加成奖励')
            p.hero:add('力量',300)
            p.hero:add('敏捷',300)
            p.hero:add('智力',300)
            p.hero:add('攻击速度',70)
            p.hero:add('技能伤害',70)
        end
    end
end
