local mt = ac.skill['好多蛋蛋的黄金鸡']
mt{
    is_spellbook = 1,
    level = 1,
    is_order = 2,
    art = [[hjcpj.blp]],
    tip = [[

|cffFFE799【成就属性】：|r
|cff00ff00+5000万 全属性
+2万  护甲
+5%  会心几率
+50%  会心伤害|r
    ]],
    ['全属性'] = 50000000,
    ['护甲'] = 20000,
    ['会心几率'] = 5,
    ['会心伤害'] = 50,
}



local mt = ac.skill['超级彩蛋']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[cjcd.blp]],
    title = '超级彩蛋',
    tip = [[

点击查看 |cff00ff00超级彩蛋|r
    ]],
}
mt.skills = {}

ac.game:event '技能-插入魔法书后' (function (_,hero,book_skill,skl)
    local skl= hero:find_skill('好多蛋蛋的黄金鸡',nil,true)
    if skl then 
        return 
    end 
    local cnt = 0
    local player = hero:get_owner()
    local skl= hero:find_skill('彩蛋',nil,true)
    if skl then 
        for index,skill in ipairs(skl.skill_book) do 
            -- print(index,skill.name)
            if skill.level >=1 then 
                cnt = cnt+1
            end    
        end
    end 
    if cnt >= 11 then 
		ac.game:event_notify('技能-插入魔法书',hero,'超级彩蛋','好多蛋蛋的黄金鸡')
        ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 集齐十八个蛋|r 获得成就|cffff0000 "好多蛋蛋的黄金鸡" |r，奖励 |cffff00005000万全属性，2万护甲，会心几率+5%，会心伤害+50%|r',6)
    end    

end)

