local event = {}

event.on_add_task = function (task)
    if task.on_add ~= nil then 
        task:on_add(task)
    end 
    print('任务-添加')
    ac.game:event_notify('任务-添加',task)
end

event.on_remove_task = function (task)
    if task.on_remove ~= nil then 
        task:on_remove(task)
    end 
    ac.game:event_notify('任务-删除',task)
end

event.on_guide_task = function (task)
    if task.on_guide ~= nil then 
        task:on_guide(task)
    end 
    ac.game:event_notify('任务-引导',task)
end

event.on_finish_task = function (task)
    if task.on_finish ~= nil then 
        task:on_finish(task)
    end 
    ac.game:event_notify('任务-完成',task)
end

event.on_submit_task = function (task)
    if task.on_submit ~= nil then 
        task:on_submit(task)
    end 
    ac.game:event_notify('任务-提交',task)
end

return event