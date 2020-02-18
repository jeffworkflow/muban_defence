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
    local point = ac.map.rects['出生点']:get_point()
    hero:blink(point,true,false,true)
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

    local point = ac.map.rects['练功房刷怪'..p.id]:get_point()
    hero:blink(point,true,false,true)
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
	hero:add_skill('F2回城', '隐藏')
	hero:add_skill('F3小黑屋', '隐藏')
end)

local practise_room =ac.region.create(ac.map.rects['练功房刷怪1'],ac.map.rects['练功房刷怪2'],ac.map.rects['练功房刷怪3'],ac.map.rects['练功房刷怪4'],ac.map.rects['练功房刷怪5'],ac.map.rects['练功房刷怪6'])
--物品是否在练功房内
ac.game.is_in_room = function(self,it)
    if not it then return end 
    -- print(it,it.name)
    return practise_room < it:get_point()
end    
ac.game.clear_item = function(self,all)
    local tbl = {}
    for _,v in pairs(ac.item.item_map) do
        if not v.owner  then 
            if not all then
                if not (practise_room < v:get_point()) then 
                    table.insert(tbl,v)
                end    
            else 
                table.insert(tbl,v)
            end    
        end	
    end
    table.sort(tbl,function (a,b)
        local p = ac.point(0,0)
        return a:get_point() * p <  b:get_point() * p
    end)

    for index,item in ipairs(tbl) do 
        item:item_remove()
    end 
end



ac.game:event '玩家-聊天' (function(self, player, str)
    local hero = player.hero
    local p = player
	local peon = player.peon

    --输入 hg 回城
    if string.lower(str:sub(1, 2)) == 'hg' then
        local point = ac.map.rects['出生点']:get_point()
        hero:blink(point,true,false,true)
    end

    -- '++' 调整镜头大小
    if str == '++' then
        --最大3000
        local distance = tonumber(p:getCameraField 'CAMERA_FIELD_TARGET_DISTANCE')  + 250
        -- print(distance)
        if type(distance) =='number' then  
            p:setCameraField('CAMERA_FIELD_TARGET_DISTANCE', distance)
        end    
        return  
    end    
    -- '++' 调整镜头大小
    if str == '--' then
        --最大3000
        local distance = tonumber(p:getCameraField('CAMERA_FIELD_TARGET_DISTANCE'))  -  250
        -- print(distance)
        if type(distance) =='number' then  
            p:setCameraField('CAMERA_FIELD_TARGET_DISTANCE', distance)
        end   
        return  
    end   

    if str == 'qlwp' then
        --开始清理物品
        ac.game:clear_item()
	end  
    --测试卡怪
	if str == 'test_uu' then
        print('当前怪物数量：',ac.unit_cnt)
        for i=1,3 do 
            local crep = ac.creep['刷怪-无尽'..i]
            print(i,#crep.group)
            for i,u in ipairs(crep.group) do 
                if u:is_in_range(ac.point(0,0),500) then 
                    print(u:get_name(),'是否活着：',u:is_alive(),u:get_point())
                end	
            end	
        end	
    end  
    --测试卡怪
	if str == '盛世嘉年，普天同庆' then
        -- print('当前怪物数量：',ac.unit_cnt)
        if not p.flag_pttq then 
            p.flag_pttq = true
            local it = hero:add_item('蟠桃种子',true)
            p:sendMsg('|cffffe799【系统消息】|r |cff00ff00恭喜获得|cffff0000蟠桃种子|r',4)
        end    
    end      

	if str == 'qx' then
		if not peon or not hero then return end 
		--取消特效
		if hero.effect_chibang then 
			hero.effect_chibang:remove()
		end	
		if hero.effect_wuqi then 
			hero.effect_wuqi:remove()
		end
		if hero.effect_chenghao then 
			hero.effect_chenghao:remove()
		end
		if hero.effect_lingyu then 
			hero.effect_lingyu:remove()
		end
		local old_model = peon:get_slk 'file'
		if not getextension(old_model) then 
			old_model = old_model..'.mdl'
		end	
		japi.SetUnitModel(peon.handle,old_model)
	end  
	if str == 'jixu' then
		player.flag_get_map_test = true 
    end  
    --取消扭蛋文本
	if str == 'nd' then
        player.flag_nd_text = not player.flag_nd_text  and true or false
        if player.flag_nd_text then 
            player:sendMsg('扭蛋提示|cffff0000关闭|r')
        else
            player:sendMsg('扭蛋提示|cffff0000开启|r')
        end  

    end   
    --取消技能特效
    if str == 'tx' then
        --文字特效开关
        player.flag_damage_texttag = not player.flag_damage_texttag  and true or false
        --技能特效开关
        player.flag_qxtx = not player.flag_qxtx  and true or false

        --关技能特效
        -- print(p.flag_qxtx)
        if player.flag_qxtx then 
            player:sendMsg('特效|cffff0000关闭|r |cffFFE799(只关闭已学技能特效)|r')
        else
            player:sendMsg('特效|cffff0000开启|r')
        end    
        if player:is_self() then 
            --异步使所有玩家英雄学的技能。
            for i=1,10 do 
                local hero = ac.player(i).hero 
                if hero then 
                    if player.flag_qxtx then 
                        ac.low = true 
                        ac.low_effect_model=[[]]
                    else
                        ac.low = false 
                    end
                    --干掉英雄身上的技能特效
                    -- for skl in hero:each_skill() do  
                    --     local allstr = table.concat(ac.skill_list2) .. table.concat(ac.skill_list4)..table.concat(ac.skill_list6)
                    --     if finds(allstr,skl.name) then
                    --         if player.flag_qxtx then 
                    --             skl.old_model = skl.model
                    --             skl.model = ''
                    --             -- print(skl.name,skl.model,skl.old_model)
                    --             skl.old_effect = skl.effect
                    --             skl.effect = ''
                    --             skl.old_effect1 = skl.effect1
                    --             skl.effect1 = ''
                    --             skl.old_effect2 = skl.effect2
                    --             skl.effect2 = ''
                    --         else
                    --             skl.effect = skl.old_effect or skl.effect
                    --             skl.effect1 = skl.old_effect1 or skl.effect1
                    --             skl.effect2 = skl.old_effect2 or skl.effect2
                    --             skl.model = skl.old_model or skl.model
                    --         end	
                    --     end    
                    -- end	 
                end    
            end    
            
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
        if str == 'qlwp' then
            --开始清理物品
            ac.game:clear_item(strs[2])
        end 

    end    



end)
