function create_dialog(player,title,list,callback)
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
    TriggerAddAction(trg,function ()
        local button = GetClickedButton()
        if map[button] then 
            callback(map[button])
        end 
        DialogDestroy(dialog)
        DestroyTrigger(trg)
        trg = nil 
        dialog = nil 
    end)
    return dialog
end 
