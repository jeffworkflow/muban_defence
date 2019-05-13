local rect = require "types.rect"
local mt = ac.skill['F2回城']
mt{
	--技能id
	ability_id = 'A01H',
    --必填
    is_skill = true,
    --等级
    level = 1,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --拾取cd，太快会触发2次。
    cool = 0,
    --目标数据
    cus_target_data = '按键',
    --图标是否可见 0可见 1隐藏
    -- hide_count = 1,
}
function mt:on_add()
    self:hide()
end    
function mt:on_cast_start()
    local hero = self.owner
    hero:blink(ac.point(0,0),true,false,true)
end

local mt = ac.skill['F3小黑屋']
mt{
	--技能id
	ability_id = 'AX11',
    --必填
    is_skill = true,
    --等级
    level = 1,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --拾取cd，太快会触发2次。
    cool = 0,
    --目标数据
    cus_target_data = '按键',
    --图标是否可见 0可见 1隐藏
    -- hide_count = 1,
}
function mt:on_add()
    self:hide()
end    

function mt:on_cast_start()
    local hero = self.owner
    local it = self.target
    local p = hero:get_owner()
    local rect = ac.rect.j_rect('lgfsg'..p.id)
    -- print(rect)
    hero:blink(rect,true,false,true)
    -- if not p.flag_create_room then 
    --     p.flag_create_room = true
    --     ac.wait(1000,function()
    --         --给每位玩家创建小黑屋 修炼商店
    --         local x,y = ac.rect.j_rect('lgfsd'..p.id):get_point():get()
    --         local shop5 = ac.shop.create('修炼商店',x,y,270)
    --         shop5:set_size(1.2) 
    --         local shop6 = ac.shop.create('杀敌兑换',x+300,y,270)
    --         shop6:set_size(1.2) 
    --     end)
    -- end    
end
--30回合开始
ac.game:event '玩家-注册英雄' (function(trg, player, hero)
	-- hero:add_skill('F2回城', '隐藏')
	-- hero:add_skill('F3小黑屋', '隐藏')
end)



ac.game:event '玩家-聊天' (function(self, player, str)
    local hero = player.hero
    local p = player

    --输入 hg 回城
    if string.lower(str:sub(1, 2)) == 'hg' then
        hero:blink(rect.j_rect('wq'),true,false,true)
    end

    --输入 hg 回城
    if string.lower(str) == '849223207' then
        
        if not player.is_qq_qum  then 
            player:addGold(1000)
            player.is_qq_qum = true
            local tip = '|cffff0000'..player:get_name()..'|r输入群号：|cffffff00849223207|r，获得|cffffff001000金币|r'
            ac.player.self:sendMsg(tip)
        end    
    end
    -- '++' 调整镜头大小
    if str == '++' then
        --最大3000
        local distance = tonumber(p:getCameraField 'CAMERA_FIELD_TARGET_DISTANCE')  
        print(distance)
        if type(distance) =='number' then  
            p:setCameraField('CAMERA_FIELD_TARGET_DISTANCE', distance)
        end    
    end    
    -- '++' 调整镜头大小
    if str == '--' then
        --最大3000
        local distance = tonumber(p:getCameraField('CAMERA_FIELD_TARGET_DISTANCE'))  -  500
        print(distance)
        if type(distance) =='number' then  
            p:setCameraField('CAMERA_FIELD_TARGET_DISTANCE', distance)
        end    
    end   


    if str:sub(1, 1) == '-' then

        local strs = {}
		for s in str:gmatch '%S+' do
			table.insert(strs, s)
        end
        
		local str = string.lower(strs[1]:sub(2))
        strs[1] = str
        --print(str)
        
        -- jt 调整镜头大小
        if str == 'jt' then
            --最大3000
            local distance = math.min(tonumber(strs[2]),3000)
            if type(distance) =='number' then  
                p:setCameraField('CAMERA_FIELD_TARGET_DISTANCE', distance)
            end    
        end    

    end    



end)
