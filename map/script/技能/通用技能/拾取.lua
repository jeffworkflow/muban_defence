local mt = ac.skill['拾取']
mt{
    --必填
    is_skill = true,
    
    --等级
    level = 1,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_UNIT,

    --拾取距离 测试没用
	range = 150,

    --目标允许
    target_data = '物品',

    --图标是否可见 0可见 1隐藏
    hide_count = 1,
    
    --拾取cd，太快会触发2次。
    cool = 5,
}

function mt:on_add()
    
end

function mt:on_cast_start()
    local hero = self.owner
    local it = self.target
    -- hero:event_notify('单位-拾取物品',hero,it)
    -- 点太快 重复触发两次拾取。
    if it.owner then 
        print('重复拾取') 
        return
    end    

    hero:add_item(it) 
end


