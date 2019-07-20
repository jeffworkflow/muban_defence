
local mt = ac.skill['兑换-点金石']
mt{
--等久
level = 1,
store_name = '兑换-点金石',
--图标
art = [[item\shou204.blp]],
--说明
tip = [[

消耗 |cffff0000100|r 挖宝积分 兑换 |cff00ff00点金石|r
|cffff0000点金石： 可提高物品属性10%,每个物品可用10次。|r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_wbjf = 100,
max_cnt = 30,
}   

function mt:on_cast_start()
    local hero = self.owner
    local p = hero:get_owner()
    local wabao_jifen = p.cus_server and p.cus_server['挖宝积分']  or 0 
    if wabao_jifen >= self.need_wbjf then
        if (p.djs_cnt or 0 ) < self.max_cnt then 
            local key = ac.server.name2key('挖宝积分')
            p:Map_AddServerValue(key,-self.need_wbjf)
            p:sendMsg('兑换成功')
            hero:add_item('点金石',true)
            p.djs_cnt = (p.djs_cnt or 0) + 1
        else    
            p:sendMsg('本局已达兑换上限')
        end    
    else
        p:sendMsg('积分不够')
    end    

end    