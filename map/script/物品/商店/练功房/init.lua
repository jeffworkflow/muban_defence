
require '物品.商店.练功房.力量修炼'
require '物品.商店.练功房.敏捷修炼'
require '物品.商店.练功房.智力修炼'
require '物品.商店.练功房.护甲修炼'
require '物品.商店.练功房.溅射修炼'
require '物品.商店.练功房.多重射修炼'
require '物品.商店.练功房.减甲修炼'
require '物品.商店.练功房.进入小黑屋'
require '物品.商店.练功房.退出小黑屋'


require '物品.商店.练功房.金币翻倍'
require '物品.商店.练功房.杀敌数翻倍'


require '物品.商店.练功房.2倍镜像'
require '物品.商店.练功房.5倍镜像'
require '物品.商店.练功房.10倍镜像'
require '物品.商店.练功房.20倍镜像'
require '物品.商店.练功房.35倍镜像'
require '物品.商店.练功房.50倍镜像'

--注册魔兽事件 区域不可其他进入
for i =1 ,6 do 
    local p = ac.player(i)
    if p:is_player() then
        local ret = ac.rect.j_rect('lgfsg'..p.id)
        local minx, miny, maxx, maxy = ret:get()
        ret = ac.rect.create(minx-300, miny, maxx+300, maxy+800)
        local region = ac.region.create(ret)
        region.owner = p
        region:event '区域-进入' (function(trg, hero)
            local player = hero:get_owner()
            --可能会掉线
            if player ==  region.owner or  player == ac.player(11) or player == ac.player(12) or player == ac.player(16) then 
            else
                hero:blink(ac.point(0,0),true,false,true)
                player:sendMsg('不可进入')    
            end    
        end)    
    end   
end    
