local blessing ={
    '蔚蓝石像的祝福',
    '疾风的祝福','幽灵的祝福',
    '战神的祝福','墨翟的祝福','虚灵的祝福',
    '我爱罗的祝福',
    '铁匠的祝福',
    '商人的祝福',
    -- '葛布的祝福'
}
for i,name in ipairs(blessing) do 
    local mt = ac.buff[name]
    mt.cover_type = 1
    mt.cover_max = 1
    function mt:on_add()
        self.target:add_skill(name,'隐藏')
    end    
    function mt:on_remove()
        self.target:remove_skill(name)
    end
end    

local mt = ac.skill['蔚蓝石像的祝福']
mt{
    ['智力%'] = 500,
    ['触发概率加成'] = 50,
    ['技暴几率'] = 50,
    ['技暴加深'] = 4000,
    ['会心伤害'] = 2000,
    ['技能伤害加深'] = 1000,
    ['全伤加深'] = 500,
}
local mt = ac.skill['商人的祝福']
mt{
    ['杀敌数加成'] = 500,
    ['物品获取率'] = 500,
    ['木头加成'] = 500,
    ['火灵加成'] = 500,
}
local mt = ac.skill['疾风的祝福']
mt{
    ['攻击速度'] = 500,
    ['攻击间隔'] = -1,
    -- ['攻击距离'] = 1000,
    ['力量%'] = 100,
    ['智力%'] = 100,
    ['敏捷%'] = 100,
    ['攻击减甲'] = 15000,
    ['移动速度'] = 200,
}
local mt = ac.skill['幽灵的祝福']
mt{
    ['敏捷%'] = 500,
    ['暴击几率'] = 50,
    ['暴击加深'] = 5000,
    ['会心伤害'] = 2500,
    ['物理伤害加深'] = 1250,
    ['全伤加深'] = 625,
}

local mt = ac.skill['战神的祝福']
mt{
    ['力量'] = 500,
    ['攻击%'] = 1000,
    ['分裂伤害'] = 1000,
    ['减少周围护甲'] = 150000,
    ['全伤加深'] = 1250,
}
local mt = ac.skill['墨翟的祝福']
mt{
    ['护甲%'] = 35,
    ['免伤'] = 35,
    ['闪避'] = 35,
    ['免伤几率'] = 35,
    ['每秒回血'] = 35,
    ['杀怪加护甲'] = 75,
    ['攻击加护甲'] = 75,
    ['每秒加护甲'] = 75,
   
}
local mt = ac.skill['虚灵的祝福']
mt{
    ['杀怪加全属性'] = 100000,
    ['攻击加全属性'] = 100000,
    ['每秒加全属性'] = 100000,
    
}
local mt = ac.skill['我爱罗的祝福']
mt{
    ['暴击几率'] = 25,
    ['技暴几率'] = 25,
    ['会心几率'] = 25,
    ['暴击加深'] = 4000,
    ['技暴加深'] = 4000,
    ['会心伤害'] = 4000,

}
local mt = ac.skill['铁匠的祝福']
mt{
}
function mt:on_add()
    local p = self.owner:get_owner()
    local id =p.id
    local point = ac.map.rects['练功房刷怪'..id]:get_point()
    for i=1,2 do 
        ac.item.create_item('随机技能书',point)
    end    
    for i=1,5 do 
        local name = ac.quality_item['红'][math.random(#ac.quality_item['红'])]
        ac.item.create_item(name,point)
    end  
    
    ac.item.create_item('吞噬丹',point):set_item_count(2)
    ac.item.create_item('恶魔果实',point):set_item_count(2)
    ac.item.create_item('点金石',point):set_item_count(20)
    ac.item.create_item('技能升级书Lv1',point):set_item_count(2)
    ac.item.create_item('技能升级书Lv2',point):set_item_count(2)
    ac.item.create_item('技能升级书Lv3',point):set_item_count(2)
    ac.item.create_item('技能升级书Lv4',point):set_item_count(2)
end    


local mt = ac.skill['葛布的祝福']
mt{
}
function mt:on_add()
    local p = self.owner:get_owner()
    p.old_up_fall_wabao = p.up_fall_wabao
    p.up_fall_wabao = p.up_fall_wabao + 500 --挖宝几率提高一倍
    p.peon_wabao = true --宠物可挖宝
    p.cnt_award_wabao = 5 --挖宝收益翻倍
end   
function mt:on_remove()
    local p = self.owner:get_owner()
    p.up_fall_wabao = p.old_up_fall_wabao
    p.peon_wabao = false 
    p.cnt_award_wabao = 1
end    





ac.game:event '选择难度' (function(_,g_game_degree_name)
    if not finds(g_game_degree_name,'乱斗') then 
        return
    end    
    --初始化属性
    ac.game:event '玩家-注册英雄'(function(_,p,hero)
        hero:add('攻击减甲',3500)
        hero:add('减少周围护甲',12500)
        hero:add('每秒加全属性',350000)
        hero:add('每秒加护甲',350)
    end)
    --改变怪物出怪间隔
    for i=1,3 do 
        local mt = ac.creep['刷怪'..i]
        mt.force_cool = 60
        --改变怪物
        function mt:on_change_creep(unit,lni_data)
            --设置搜敌范围
            unit:set_search_range(1000)
            local point = ac.map.rects['主城']:get_point()
            unit:issue_order('attack',point)
            
            --改变怪物极限属性
            unit:set('移动速度',522)
            unit:set('攻击间隔',0.4)
            unit:set('攻击速度',800)
            unit:set('闪避',60)
            unit:add('暴击几率',50)
            unit:add('会心几率',50)
        end
    end

    --改变boss极限属性
    ac.game:event '单位-创建' (function(_,unit)
        local str = table.concat(ac.attack_boss)
        if finds(str,unit:get_name()) then
            unit:set('移动速度',519)
            unit:set('攻击间隔',0.4)
            unit:set('攻击速度',800)
            unit:set('闪避',60)
            unit:add('暴击几率',50)
            unit:add('会心几率',50)
        end    
    end)

    --改变练功房的怪物重生时间  在练功师处完成
    
    --无尽怪的属性和出怪间隔 
    for i=1,3 do 
        local mt = ac.creep['刷怪-无尽'..i]
        mt.force_cool = 10
        --改变怪物
        function mt:on_change_creep(unit,lni_data)
            ac.change_attr(unit,self.index)

            --改变怪物极限属性 再设置一次移速会导致泄漏，原因未知
            -- unit:set('移动速度',519)
            unit:set('攻击间隔',0.4)
            unit:set('攻击速度',800)
            unit:set('闪避',60)
            unit:add('暴击几率',50)
            unit:add('会心几率',50)
        end
    end


    --每5分钟随机一种祝福
    local time =60
    ac.loop(time * 1000,function()
        local name = blessing[math.random(#blessing)]
        for i=1,10 do 
            local p = ac.player(i)
            if p:is_player() then 
                p.hero:add_buff(name){
                    time = time
                }
            end
        end   
        --祝福倒计时
        ac.wait((time-6)*1000,function()
            ac.timer(1*1000,5,function(t)
                ac.player.self:sendMsg('|cffff0000祝福结束倒计时:'..t.count)   
            end)
        end)

        if name == '蔚蓝石像的祝福' then
            local str = [[|cffffe799【系统消息】|r|cff00ff00新的祝福开始：|cff00ffff蔚蓝石像的祝福|r|cffffe799
【祝福属性】|cff00ff00智力+500% 触发概率加成+50% |cffffff00技暴几率+50% 技暴加深+4000% 会心伤害+2000% |cffff0000技能伤害加深+1000% 全伤加深+500%]]
            ac.player.self:sendMsg(str)    
        end    
        if name == '疾风的祝福' then
            local str = [[|cffffe799【系统消息】|r|cff00ff00新的祝福开始：|cff00ffff疾风的祝福|r|cffffe799
【祝福属性】|cff00ff00全属性+100% 攻击减甲+15000 |cffffff00移动速度+200 攻击距离+1000 |cffff0000极致的攻击速度]]
            ac.player.self:sendMsg(str)    
        end    
        if name == '幽灵的祝福' then
            local str = [[|cffffe799【系统消息】|r|cff00ff00新的祝福开始：|cff00ffff幽灵的祝福|r|cffffe799
【祝福属性】|cff00ff00敏捷+500% |cffffff00暴击几率+50% 暴击加深+5000% 会心伤害+2500% |cffff0000物理伤害加深+1250% 全伤加深+625%]]
            ac.player.self:sendMsg(str)    
        end    
        if name == '战神的祝福' then
            local str = [[|cffffe799【系统消息】|r|cff00ff00新的祝福开始：|cff00ffff战神的祝福|r|cffffe799
【祝福属性】|cff00ff00力量+500% 攻击+1000% |cffffff00分裂伤害+1000% 减少周围护甲+150000 |cffff0000全伤加深+1250%]]
            ac.player.self:sendMsg(str)    
        end    
        if name == '墨翟的祝福' then
            local str = [[|cffffe799【系统消息】|r|cff00ff00新的祝福开始：|cff00ffff墨翟的祝福|r|cffffe799
【祝福属性】|cff00ff00护甲/免伤/免伤几率/闪避/每秒回血+35% |cffff0000杀怪/攻击/每秒加护甲+75]]
            ac.player.self:sendMsg(str)    
        end    
        if name == '虚灵的祝福' then
            local str = [[|cffffe799【系统消息】|r|cff00ff00新的祝福开始：|cff00ffff虚灵的祝福|r|cffffe799
【祝福属性】|cff00ff00杀怪/攻击/每秒加全属性+100000]]
            ac.player.self:sendMsg(str)    
        end    
        if name == '我爱罗的祝福' then
            local str = [[|cffffe799【系统消息】|r|cff00ff00新的祝福开始：|cff00ffff我爱罗的祝福|r|cffffe799
【祝福属性】|cff00ff00暴击几率+25% 技暴几率+25% 会心几率+25% |cffff0000暴击加深+4000% 技暴加深+4000% 会心伤害+4000%]]
            ac.player.self:sendMsg(str)    
        end   
        if name == '铁匠的祝福' then
            local str = [[|cffffe799【系统消息】|r|cff00ff00新的祝福开始：|cff00ffff铁匠的祝福|r|cffffe799
【祝福属性】|cff00ff00送5个红装、20个点金石、两个吞噬丹、两本随机技能书、技能升级书Lv1-4各两本、两个恶魔果实，|cffff0000发放到每个人的练功房]]
            ac.player.self:sendMsg(str)    
        end   
        if name == '商人的祝福' then
            local str = [[|cffffe799【系统消息】|r|cff00ff00新的祝福开始：|cff00ffff商人的祝福|r|cffffe799
【祝福属性】|cff00ff00杀敌数加成+500% 物品获取率+500% |cffff0000木头加成+500% 火灵加成+500%]]
            ac.player.self:sendMsg(str)    
        end   

        if name == '葛布的祝福' then
            local str = [[|cffffe799【系统消息】|r|cff00ff00新的祝福开始：|cff00ffff葛布的祝福|r|cffffe799
【祝福属性】|cff00ff00宠物也可以帮助挖宝，藏宝图掉落概率翻五倍，挖宝一次得五次收益]]
            ac.player.self:sendMsg(str)    
        end    
        
    end)
end)





















