local ui = require 'ui.server.util'

local mt = japi.task['测试的任务3']

function mt:on_add()
    print(self.player,'添加任务')
end 

function mt:on_finish()

end 

function mt:on_submit()
    ui.print(self.player,'恭喜完成任务获得奖励')
    self:get_reward()
end


function mt:on_guide()
    if self.finish and self.player:get_hero() then
        --如果任务已经完成 则跑到npc的位置提交任务
        self.player:get_hero():issue_order('move',ac.point(0,2000))
    else 
        ui.print(self.player,'任务指引:按30次X键 30次Y键')
    end
end 



function mt:on_remove()

end