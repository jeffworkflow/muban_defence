local mt = ac.item['删除技能']


function mt:on_add()
    
    local hero = self.owner
    local player = hero:get_owner()

    local list = {}
    for skill in hero:each_skill '英雄' do 
        if skill.card_level and skill.card_level <= 5 then 
            local info = {
                name = skill:get_name() .. ' 价格 200 (' .. skill:get_hotkey() ..')' ,
                key = skill:get_hotkey():byte(),
                skill = skill,
            }
            table.insert(list,info)
        end
    end 
    self:remove()
    
    if #list == 0 then
        player:sendMsg("没有可以删的技能了。")
        return
    end 
    local info = {
        name = '取消 (Esc)',
        key = 512
    }
    table.insert(list,info)
    create_dialog(player,'选择你要删除的技能',list,
    function (index)
        local skill = list[index].skill
        if skill then 
            local gold = player:getGold()
            if gold < 200 then 
                player:sendMsg("钱不够，删除技能失败")
                return 
            end 
            player:addGold(-200)
            skill:remove()
        end 
    end)
    
end 