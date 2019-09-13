--异火升级
local fire = {
    --技能名 = 商店名，火灵基本价格，留空,培养，图标,tip
    ['星星之火'] = {'|cffff0000炼化|r 星星之火',20000,'',[[huo1.blp]],[[|n可重置|cff00ff00异火品阶|r |cffff0000顶级品阶的异火|r属性很可怕|n|n|cffcccccc炼化异火不会重置异火等级|r]]},
    ['陨落心炎'] = {'|cffff0000炼化|r 陨落心炎',50000,'',[[huo2.blp]],[[|n可重置|cff00ff00异火品阶|r |cffff0000顶级品阶的异火|r属性很可怕|n|n|cffcccccc炼化异火不会重置异火等级|r]]},
    ['三千焱炎火'] = {'|cffff0000炼化|r 三千焱炎火',100000,'',[[huo3.blp]],[[|n可重置|cff00ff00异火品阶|r |cffff0000顶级品阶的异火|r属性很可怕|n|n|cffcccccc炼化异火不会重置异火等级|r]]},
    ['虚无吞炎'] = {'|cffff0000炼化|r 虚无吞炎',150000,'',[[huo4.blp]],[[|n可重置|cff00ff00异火品阶|r |cffff0000顶级品阶的异火|r属性很可怕|n|n|cffcccccc炼化异火不会重置异火等级|r]]}, 
    ['陀舍古帝'] = {'|cffff0000炼化|r 陀舍古帝',250000,'',[[tsgd.blp]],[[|n可重置|cff00ff00异火品阶|r |cffff0000顶级品阶的异火|r属性很可怕|n|n|cffcccccc炼化异火不会重置异火等级|r]]}, 
    ['无尽火域'] = {'|cffff0000炼化|r 无尽火域',350000,'',[[wjhy.blp]],[[|n可重置|cff00ff00异火品阶|r |cffff0000顶级品阶的异火|r属性很可怕|n|n|cffcccccc炼化异火不会重置异火等级|r]]},
}

for key,val in pairs(fire) do 
    local mt = ac.skill['炼化'..key]
    mt{
    --等久
    level = 1,
    --正出售商品名
    store_name = val[1],
    --图标
    art = val[4],
    --说明
    tip =val[5],
    content_tip = '|cffFFE799【任务说明】：|r|n',
    --物品类型
    item_type = '神符',
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --购买价格
    fire_seed = val[2],
    --物品技能
    is_skill = true,
    }

    function mt:on_cast_start()
        local hero = self.owner
        local player = hero:get_owner()
        hero = player.hero
        
        --培养星星之火
        local rand_name = ac.get_reward_name(ac.unit_reward['炼化异火'])
        if not rand_name then 
            return
        end    
        local skl = hero:find_skill(key,nil,true)
        if skl then 
            skl:set('quality',rand_name)
            skl:fresh()
            ac.game:event_notify('技能-升级',hero,skl) --真正添加属性（刷新）
            player:sendMsg('|cffFFE799【系统消息】|r|cff00ff00炼化成功|r 获得|cffff0000'..key..' （'..rand_name..'）|r 炼化后的属性可以在异火系统中查看',2)    
        else
            player:sendMsg('|cffFFE799【系统消息】|r|cffff0000条件不符，炼化失败|r',2)    
            return true
        end      

    end

end    