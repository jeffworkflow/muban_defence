function create_dialog(player,title,list,callback,time)
    local dialog = DialogCreate()
    local trg = CreateTrigger()
    local map = {}
    DialogSetMessage(dialog,title)
    for index,info in ipairs(list) do 
        local button = DialogAddButton(dialog,info.name,info.key)
        map[button] = index 
    end 
    DialogDisplay(player.handle, dialog, true)
    TriggerRegisterDialogEvent(trg,dialog)

    local function remove()
        if dialog and trg then 
            DialogDestroy(dialog)
            DestroyTrigger(trg)
            trg = nil 
            dialog = nil 
        end    
    end 

    local function action()
        local button = GetClickedButton()
        if map[button] then 
            callback(map[button])
        end 
        remove()
    end
    TriggerAddAction(trg,action) 
    
    if time then 
        ac.loop(1000,function(t)
            if not dialog or not trg then 
                t:remove()
                return 
            end  
            time = time -1
            local show_title = title..' '..time
            -- print(show_title)
            DialogSetMessage(dialog,show_title) --设置名字
  
            if time <= 0 then 
                t:remove()
                callback(1) --时间到，默认选择第一个
                remove()
            end   
        end)
    end    


    return dialog
end 
