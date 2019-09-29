
local mt = ac.skill['寿桃庆生辰']
mt{
--等久
level = 1,
--图标
art = [[shoutao.blp]],
--说明
tip = [[ 
|cffffe799【活动时间】|r|cff00ff009月24日-10月9日
|cffffe799【活动说明】|r|cff00ff00华诞盛典普天同庆！从天而降的“庆生蟠桃”散落在三界各地，收集尽量多的蟠桃可激活丰厚奖励！

|cffffe799“庆生蟠桃”超过50个|r 奖励 |cff00ff00【成就】我爱养花种树|r 
|cffffe799“庆生蟠桃”超过150个|r 奖励 |cff00ff00【成就】果实累累
|cffffe799“庆生蟠桃”超过350个|r 奖励 |cff00ffff【成就】辛勤的园丁
|cffffe799“庆生蟠桃”超过650个|r 奖励 |cff00ffff【成就】冷月葬花魂
|cffffe799“庆生蟠桃”超过1000个|r 奖励 |cffff0000【英雄】雅典娜
|cffffe799“庆生蟠桃”超过1350个|r 奖励 |cffffff00【成就】园艺大师

|cffcccccc（可在F4-可存档面板中，查看“庆生蟠桃”数量）]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 1,
--物品技能
is_skill = true,
store_affix = '',
store_name = '|cffdf19d0寿桃庆生辰|r',
--物品详细介绍的title
content_tip = ''
}


local mt = ac.skill['蟠桃种子']
mt{
--等久
level = 1,
--图标
art = [[zhongzi.blp]],
--说明
tip = [[


|cff00ffff在地上，埋下一颗蟠桃种子，数千年后可以收取蟠桃

|cffcccccc国庆活动物品|r]],
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
|cffcccccc国庆活动物品|r]],
--品质
color = '紫',
--物品类型
item_type = '神符',
specail_model = [[Objects\InventoryItems\Shimmerweed\Shimmerweed.mdl]],
model_size = 1.5,


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
    p:sendMsg('|cffffe799【系统消息】|r|cff00ff00庆生蟠桃+1，总量可在“F4-可存档面板”查看',5) 
    --特殊处理
    local has_mall = p.cus_server['庆生蟠桃'] or 0
    if has_mall >=1000 then 
        local key =ac.server.name2key('雅典娜')
        p:Map_SaveServerValue(key,1)
    end   
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
ac.game:event '游戏-开始'(function()
    --1.每5分钟给一个
    local time = 5*60
    ac.wait(time*1000,function()
        give_seed()
        ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00盛世耀华夏，神州共欢腾！百花仙子大发慈悲，给所有玩家发放了一枚|cffff0000蟠桃种子|r',5) 
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
            ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..p:get_name()..'|r 在挖宝时挖塌了|cffff0000种子幼儿园|r，一大堆种子散落|cffff0000老家周围|r，大家快去抢啊|r',5) 

           
        end    
    end    
end)