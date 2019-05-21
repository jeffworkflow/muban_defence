for i =1,3 do 
    local mt = ac.creep['杀鸡敬猴'..i]{    
        region = 'sjjh'..i,
        creeps_datas = '鸡*15',
        cool = 1,
        is_random = true,
        creep_player = ac.player.com[2],
    }
    --进攻怪刷新时的初始化
    function mt:on_start()
    end

    function mt:on_next()
    end
    --改变怪物
    function mt:on_change_creep(unit,lni_data)
        --设置搜敌范围
        unit:set_search_range(500)
    end

    --刷怪结束
    function mt:on_finish()  
    end   
end 

ac.game:event '游戏-开始' (function()
    for i =1,3 do 
        local creep = ac.creep['杀鸡敬猴'..i]
        creep:start()
    end    

end)