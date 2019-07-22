base = require 'base'
japi = require 'jass.japi'
jass = require 'jass.common'
storm = require 'jass.storm'
dzapi = require 'jass.dzapi'
japi.SetOwner("mtp")
--官方存档和商城
require 'util'
-- print(1)
require 'war3'
-- print(2)
require 'types'
-- print(3)
require 'ac'
-- print(4)
require 'ui'
-- print(5)
require '通用'
require '平台'
-- print(6)
require '游戏'
-- print(7)
require '物品'
-- print(8)
require '技能'
-- print(9)
require '英雄'
-- print(10)
require '刷怪'
-- print(11)
-- -- print(12)
require '测试'
-- print(13)
--设置天空模型 
-- jass.SetSkyModel([[sky.mdx]])
-- jass.CreateDestructable(base.string2id('B04E'), 0, 0, 0, 1, 0) 


ac.wait(100,function ()
    local function light(type)
        local light = {
            'Ashenvale',
            'Dalaran',
            'Dungeon',
            'Felwood',
            'Underground',
            'Lordaeron',
        }
        if not tonumber(type) or tonumber(type) > #light or tonumber(type) < 1 then
            return
        end
        local name = light[tonumber(type)]
        jass.SetDayNightModels(([[Environment\DNC\DNC%s\DNC%sTerrain\DNC%sTerrain.mdx]]):format(name, name, name), ([[Environment\DNC\DNC%s\DNC%sUnit\DNC%sUnit.mdx]]):format(name, name, name))
    end
    -- light(3)

    --开局锁定镜头
    -- local point = ac.map.rects['出生点']:get_point()
    -- local p = ac.player(1)
    -- local hero = p:createHero('希尔瓦娜斯',point);
    -- p.hero = hero
    -- p:event_notify('玩家-注册英雄', p, p.hero)
    -- hero:add_skill('神兵','英雄')
    -- local book_skl = hero:add_skill('洗练石','英雄')
    -- hero:add_skill('境界','英雄')

    -- hero:add_skill('阿尔塞斯天赋','英雄')
    
    -- p:setCamera(ac.map.rects['出生点'])

    --创建测试怪
	-- local cnt = 5 
	-- local x,y = ac.map.rects['出生点']:get_point():get()
	-- for i=1,cnt do 
	-- 	local unit = ac.player(12):create_unit('甲虫',ac.point(x-1000,y))
	-- 	unit:set('生命上限',1000000000)
	-- 	unit:set('生命恢复',1000000000)
	-- 	unit:set('护甲',10000)
	-- 	unit:set('攻击',1000)
    --     unit:set('移动速度',0)
    --     unit:set_search_range(500)
    --     print(unit:get('攻击距离'))
    -- end	
    
    --测试 动态插入魔法书
-- ac.game:event '技能-插入魔法书' (function (_,hero,book_skill,skl)
    -- print(hero,book_skl,'F4战斗机')
    -- ac.wait(1000,function()
    --     ac.game:event_notify('技能-插入魔法书',hero,book_skl,'F4战斗机')
        
    --     ac.loop(1000,function()
    --         for i=1,10 do
    --             ac.player(12):create_unit('民兵',ac.point(0,4000))
    --         end
    --     end)

    -- end)
    
    -- local unit =ac.player(16):create_unit('民兵',ac.point(x+1000,y))unit:set('生命上限',1000000000)
    -- unit:set('生命恢复',1000000000)
    -- unit:set('护甲',10000)
    -- unit:set('攻击',1000)
    


    -- 没10分钟切换一次光照模型
    -- local time = 2*60
    -- -- local time = 10
    -- local i = 0
    -- ac.loop(time * 1000,function()
    --     i = i + 1
    --     if i > 6 then 
    --         i = 1
    --     end    
    --     light(i)
    -- end)
   
    --设置联盟模式0,1,2
    -- jass.SetAllyColorFilterState(0)
    -- --设置玩家16（中立被动颜色 绿） 1-16
    ac.player(16):setColor(7)
    -- ac.player(13):setColor(1) --中立敌对 红色


    -- ac.game:event '游戏-开始' (function()
    --     -- local item = ac.item.create_item('生锈剑')
    --     -- local item = ac.item.create_skill_item('万箭齐发')
    --     --创建商店 - 神龙
    --     local x,y = ac.map.rects['选人出生点']:get_point():get()
    --     local shop4 = ac.shop.create('神龙',x,y+300,270)

    -- end)
    

end);