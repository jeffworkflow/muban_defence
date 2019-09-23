
local mt = ac.skill['寿桃庆生辰']
mt{
--等久
level = 1,
--图标
art = [[shgty.blp]],
--说明
tip = [[ 
|cffffe799【活动时间】|r|cff00ff009月7日-9月25日
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


local mt = ac.skill['蟠桃种子']
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
--目标类型
target_type = ac.skill.TARGET_TYPE_POINT,
--施法距离
range = 1000,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}
function mt:on_cast_start()
    local hero = self.owner 
    local p = hero:get_owner()
    local player = hero:get_owner()
    local u = p:create_unit('桃树',self.target)
    u:set('生命',1)
    u:add_restriction('无敌')
    --动画
    local time = 15
    u:add_buff '缩放' {
		time = time,
		origin_size = 0.1,
		target_size = 1.5,
    }
    ac.wait((time+1)*1000,function()
        --创建蟠桃
        ac.item.create_item('庆生蟠桃',u:get_point())
        --移除桃树
        u:remove()
    
    end)

end   


local mt = ac.skill['庆生蟠桃']
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
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}
function mt:on_cast_start()
    local hero = self.owner 
    local p = hero:get_owner()
    local player = hero:get_owner()
    local key = ac.server.name2key(self.name)
    p:Map_AddServerValue(key,1)
    p:sendMsg('蟠桃+1',5) 
end   


--获得事件
--[[蟠桃种子的获得途经：
1.神奇的5分钟，游戏开始5分钟，给每个玩家发放一个蟠桃种子，系统提示：华诞盛典普天同庆！XXXXX
2.每隔8分钟，基地区域随机生成一个蟠桃种子(一局12个)
3.打伏地魔获得35%概率掉落，每局限5个
4.挖宝0.75%概率触发，掉落5-10个随机蟠桃种子，每局限一次（参考碎片幼儿园），系统提示：华诞盛典普天同庆！XXXXX
]]
local function give_seed()
    for i=1,6 do 
        local p= ac.player(i)
        if p:is_player() then 
            if p.hero then 
                p.hero:add_item('蟠桃种子',true)
            end
        end
    end
end    
ac.game:event '游戏开始'(function()
    --1.每5分钟给一个
    local time = 5*60
    ac.loop(time1*1000,function()
        give_seed()
    end)
    
    --2.每8分钟随机创建一个在地上
    local time = 8*60
    ac.loop(time*1000,function()
        local point = ac.map.rects['藏宝区']:get_random_point()
        ac.item.create_item('蟠桃种子',point)
    end)
end)

--3.打伏地魔获得35%概率掉落，每局限5个
ac.game:event '单位-死亡'(function(_,unit,killer)
    if unit:get_name() ~='食人魔' then 
        return 
    end
    print('1213131')
    --概率  
    local rate = 35 
    local max_cnt = 5 --每人一局最大掉落次数
    local p= killer:get_owner()
    if unit:is_ally(killer) then
        return
    end
    p.kill_srm_guoshi = (p.kill_srm_guoshi or 0) 
    if p.kill_srm_guoshi < max_cnt and math.random(100) <= rate then 
        ac.item.create_item('蟠桃种子',unit:get_point())
        p.kill_srm_guoshi = (p.kill_srm_guoshi or 0) + 1  
    end    
end)

--4.挖宝0.75%概率触发，掉落5-10个随机蟠桃种子，每局限一次（参考碎片幼儿园），系统提示：华诞盛典普天同庆！XXXXX
local temp = {'蟠桃种子'}
ac.game:event '挖图成功'(function(trg,hero)
    local p = hero:get_owner()
    local rate = 0.75
    -- local rate = 10 --测试
    if math.random(10000)/100 <= rate then 
        if not ac.flag_ptzj then 
            ac.func_give_suipian(hero:get_point(),temp)
            ac.flag_ptzj = true 
        end    
    end    
end)