
local rect = require 'types.rect'

--物品名称
local mt = ac.skill['杀鸡敬猴']
mt{
--等久
level = 1,
--图标
art = [[sjjh.blp]],
--说明
tip = [[杀死右边花园里叽叽喳喳的鸡]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 0,
content_tip = '',
--物品技能
is_skill = true,
--杀死鸡数
kill_cnt =100,
--奖励物品
award_item = '五色飞石'
}

function mt:on_cast_start()
    local hero = self.owner
    local p = hero:get_owner()
    hero = p.hero
    --发小地图的ping提示
    for i=1,3 do  
        local point = ac.map.rects['杀鸡敬猴'..i]:get_point()
        p:pingMinimap(point, 3)
    end    
    if p.sjjh_flg then
        p:sendMsg('已接过任务，不许重复接')
    else
        p.sjjh_flg = 0 
        self.trg = ac.game:event '单位-杀死单位' (function(trg, killer, target)
            if target:get_name() ~= '鸡' then
                return
            end    
            --召唤物杀死也继承
            local p = killer:get_owner()
            local hero = p.hero
            if hero  then 
                p.sjjh_flg = p.sjjh_flg + 1
                p:sendMsg('【系统提示】当前杀鸡进度：'..p.sjjh_flg..'/100')

                if p.sjjh_flg == self.kill_cnt then
                    --给物品
                    --创建 猴
		            local point = hero:get_point()-{hero:get_facing(),100}--在英雄附近 100 到 400 码 随机点
                    local unit = ac.player(12):create_unit('猴',point)
                    unit:add_buff '定身'{
                        time = 2
                    }
                    unit:add_buff '无敌'{
                        time = 2
                    }
                    p:sendMsg('【系统提示】猴 已出现，击杀获取成长型装备 ')
                    
                    self.trg:remove()
                    self.trg = nil

                    unit:event '单位-死亡' (function(_,unit,killer) 
                        local item = ac.item.create_item(self.award_item)
                        item.owner_ship = hero 
                        hero:add_item(item,true)
                    end)    

                end    
            end
        end)  
    end    

end
