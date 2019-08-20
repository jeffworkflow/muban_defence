--技能事件
ac.game:event '技能-施法完成' (function(trg, _, skill)
    local hero = skill.owner
    if hero:is_type('boss') or hero:is_type('精英') then 
        return 
    end
    if not hero or finds(skill.name,'攻击','移动','停止','保持原位','凌波微步') then 
        return 
    end
    --攻击自己脚下
    hero:issue_order('attack',hero:get_point())
    
    --学习技能后，再刷新一次英雄技能
    -- if not hero:is_hero() then 
    --     for skill in hero:each_skill '英雄' do 
    --         skill:fresh()
    --     end 
    -- end
end)