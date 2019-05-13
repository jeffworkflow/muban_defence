local ui = require 'ui.server.util'

local mt = japi.task['测试的任务1']

function mt:on_add()
    print(self.player,'添加任务')
end 

--完成事件
function mt:on_finish()
    print('完成')
    
end 

--提交任务事件
function mt:on_submit()
    ui.print(self.player,'恭喜完成任务获得奖励')
    self:get_reward()
end

--点击屏幕上的按钮的 任务指引
function mt:on_guide()
 
end 


function mt:on_remove()

end