require '刷怪.creep'
require '刷怪.刷怪'
require '刷怪.最终boss'
require '刷怪.刷怪-无尽'
require '刷怪.游戏结束'
require '刷怪.命运花'
require '刷怪.钥匙怪奖励'
require '刷怪.低保户'
require '刷怪.BOSS-AI'

--单位创建 属性增强


ac.game:event '单位-创建' (function(_,unit)
    if not unit then  return end 
    --英雄不增加属性
    if unit:is_hero() then  return end 

    --根据玩家数量，怪物属性倍数 5  20 . 5 40， 20*1.1 = 22
    local attr_mul = ( get_player_count() -1 ) * 5
    --属性
    -- print('打印是否根据玩家数增加属性1',unit:get('攻击'))
    unit:add('攻击%',attr_mul*7)
    unit:add('护甲%',attr_mul*7)
    unit:add('生命上限%',attr_mul*7)
    unit:add('魔法上限%',attr_mul)
    unit:add('生命恢复%',attr_mul)
    unit:add('魔法恢复%',attr_mul)
    --设置魔抗 
    unit:add('魔抗%',attr_mul*7)

    -- print('打印是否根据玩家数增加属性2',unit:get('攻击'))
    -- 最终boss、伏地魔玩家倍数增加
    if finds(unit:get_name(),'最终boss','伏地魔') then 
        --属性
        unit:add('攻击%',(ac.g_game_degree_attr -1)*100)
        unit:add('护甲%',(ac.g_game_degree_attr-1)*100)
        unit:add('生命上限%',(ac.g_game_degree_attr-1)*100)
        unit:add('魔法上限%',(ac.g_game_degree_attr-1)*100)
        unit:add('生命恢复%',(ac.g_game_degree_attr-1)*100)
        unit:add('魔法恢复%',(ac.g_game_degree_attr-1)*100)
        --设置魔抗 
        unit:add('魔抗%',(ac.g_game_degree_attr-1)*100)
    end    
end)


-- require '野怪.BOSS-AI'

-- local mt = ac.creep['测试']{    
--     region = '',
--     creeps_datas = '强盗*40',
--     is_random = true,
--     creep_player = ac.player.com[2],
--     tip ="郊区野怪刷新啦，请速速打怪升级，赢取白富美"

-- }

-- function mt:on_start()
--     local rect = require 'types.rect'
--     local region = rect.create('-2000','-2000','2000','2000')
--     self.region = region
-- end

-- --改变怪物
-- function mt:on_change_creep(unit,lni_data)
--     unit:set('移动速度',400)
--     unit:set_search_range(99999)
-- end
-- mt:start()

-- 如下代码可以释放 内存
-- ac.loop(10*1000,function()
    -- for i=1,40 do 
    --     local unit = ac.player.com[2]:create_unit('强盗',ac.point(0,0))
    --     unit:set('生命上限',10000000000)
    --     unit:set('移动速度',400)
    --     unit:set_search_range(99999)
    -- end    
-- end)



