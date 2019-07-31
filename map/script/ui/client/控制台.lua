local ui = require 'ui.client.util'
local message = require 'jass.message'
local slk = require 'jass.slk'

local console = {}

local types = {
    ['小地图按钮']  = 'FrameGetMinimapButton',
    ['小地图']      = 'FrameGetMinimap',
    ['头像模型']    = 'FrameGetPortrait',
	['技能按钮']    = 'FrameGetCommandBarButton',
	['物品按钮']	= 'FrameGetItemBarButton',
    ['头像图标']    = 'FrameGetHeroBarButton',
    ['血条']        = 'FrameGetHeroHPBar',
    ['蓝条']        = 'FrameGetHeroManaBar',
	['提示框']      = 'FrameGetTooltip',
	['控制台'] 		= 'FrameGetSimpleConsole',
	['物品栏背景'] 	= 'FrameGetItemBackground',
	['物品栏背景图片'] 	= 'FrameGetItemBackgroundTexture',
	['物品栏'] 	= 'FrameGetItemBar',
    ['聊天消息']    = 'FrameGetChatMessage',
    ['单位消息']    = 'FrameGetUnitMessage',

	--只有释放技能后 才能获取有效的模型对象
	['按钮冷却模型'] = 'FrameGetButtonCooldownModel',
}
local controls = {}

console.get = function (name,...)
    local args = {...}
    local row = args[1]
    local column = args[2]
    local func_name = types[name]
	if func_name == nil then 
		print(name,'函数名是空的')
        return 
    end 
    local key = string.format('%s%s%s',name,tostring(row or ''),tostring(column or ''))
    local instance = controls[key]
    if instance == nil then 
        local control_id = japi[func_name](row,column)
		if control_id == nil or control_id == 0 then 
			print('获取id是0',name,id)
            return 
        end 
        instance = extends(class.button){
            id = control_id,
            w = 0,
            h = 0,
        }
        if name == '血条' or name == '蓝条' then 
            instance.set_position = function (self,x,y)
                self.x = x
                self.y = y
                x =  (x + self.w / 2) / 1920 * 0.8
                y = (1080 - y) / 1080 * 0.6
                japi.FrameSetPoint(self.id,1,game_ui,6,x,y)
            end
        elseif name == '头像模型' then 
            instance.set_position = function (self,x,y)
                self.x = x
                self.y = y
                x =  x / 1920 * 0.8
                y = (1080 - y - self.h) / 1080 * 0.6
                japi.FrameSetPoint(self.id,6,game_ui,6,x,y)
            end
        elseif name == '小地图' then 
            instance.set_position = function (self,x,y)
                self.x = x
                self.y = y
                local ax =  x / 1920 * 0.8
                local ay = (1080 - y - self.h) / 1080 * 0.6
                local bx = (x + self.w) / 1920 * 0.8
                local by = (1080 - y) / 1080 * 0.6
                japi.FrameSetPoint(self.id,6,game_ui,6,ax,ay)
                japi.FrameSetPoint(self.id,2,game_ui,6,bx,by)
            end
        elseif name == '技能按钮' then 
            instance.w = 91
            instance.h = 69
            instance.row = row 
			instance.column = column
			instance.set_cooldown_size = function (self,size)
				japi.FrameSetButtonCooldownModelSize(self.id,size)
			end
		elseif name == '物品按钮' then 
			instance.num = row
			instance.set_cooldown_size = function (self,size)
				japi.FrameSetButtonCooldownModelSize(self.id,size)
			end
		elseif name == '聊天消息' then
            instance.set_position = function (self,x,y)
                self.x = x
                self.y = y
                x =  x / 1920 * 0.8
                y =  -y / 1080 * 0.6
                japi.FrameSetPoint(self.id,0,game_ui,0,x,y)
            end
        elseif name == '单位消息' then
            instance.set_position = function (self,x,y)
                self.x = x
                self.y = y
                x =  x / 1920 * 0.8
                y =  -y / 1080 * 0.6
                japi.FrameSetPoint(self.id,0,game_ui,0,x,y)
            end
        elseif name == '提示框' then 
            instance.set_position = function (self,x,y)
                self.x = x
                self.y = y
                x =  (x - self.w * 1.5) / 1920 * 0.8
                y =  -y / 1080 * 0.6
                japi.FrameSetPoint(self.id,8,game_ui,1,x,y)
			end
		elseif name == '按钮冷却模型' then 
			instance = extends(class.model)(instance)
        end 
        controls[key] = instance
    end 
    return instance
end 


local skill_slots = {
	{2,0},{2,1},{2,2},{2,3},
	{1,1},{1,2},{1,3},{1,0},
	{0,0},{0,1},{0,2},{0,3}
}
local button_list = {}
local on_button_mouse_enter = function (self)

	if self.is_head then 
		local hero = ac.player.self:get_hero()
		if hero then 
			self:tooltip(hero:get_name(),'点击选中该英雄,双击镜头切到英雄位置。',nil,200,64)
		end 
		
		return 
	end 
	local unit_handle = japi.GetRealSelectUnit()
	local unit = ac.unit.j_unit(unit_handle)
	if unit == nil then 
		return 
	end
	local skill
	if self.slot_type == '技能' then 
		skill = unit:find_skill(self.slot_id,'英雄')

	elseif self.slot_type == '物品' then 
		local item = unit:find_item(self.slot_id)
		if item then 
			skill = item.skill
		end 
	end 
	if skill then 
		self:skill_tooltip(skill,1)
	end 
end 


ac.wait(0,function ()
	--------------------控制台背景-----------------------------------
	local id = japi.CreateFrameByTagName('SIMPLEFRAME','MyConsole1',0,'MyConsole',0)
	japi.FrameSetLevel(id,2)


	--------------------小地图------------------------------

	local map = console.get('小地图')
	map:set_control_size(292,216)
	map:set_position(12,857)
	for i=0,4 do
		local map = console.get('小地图按钮',i)
		map:set_position(312,857 + i*42)
		map:set_control_size(32,32)
	end	
	
	-- local texture = class.texture.create('image\\控制台\\minimap.tga',18,818,284,244)

	-- local texture2 = class.texture.create('image\\控制台\\minimap_line.tga',texture.x,texture.y + texture.h-15,texture.w,20)
	-- local texture2 = class.texture.create('image\\控制台\\minimap_line.tga',texture.x,texture.y + texture.h-15,texture.w,20)
	-- local button = texture2:add_button('image\\控制台\\minimap_button.tga',texture2.w/2-32/2,texture2.h - 28,32,32)
	-- button.on_button_clicked = function (button)
	-- 	if texture.is_show then 
	-- 		map:hide()
	-- 		texture:hide()
	-- 	else 
	-- 		map:show()
	-- 		texture:show()
	-- 	end 
	-- end 
	
	local chat = console.get('聊天消息')
	chat:set_position(20,500)
		
	---------------------------模型观察器-----------------------------------------

	local model = console.get('头像模型')
	model:set_control_size(225,112)
	model:set_position(500,1080 - 170)

	-- --屏幕上的单位模型
	-- local actor = class.actor.create('卓尔游侠',550,1080-70)
	-- actor:set_size(0.6)

	-- --模型上面附带的按钮
	-- local observe = class.button.create('',430,900,230,174)

	-- observe.text = observe:add_text('卓尔游侠',0,140,230,32,11,'center')

	
	-- local info_button = observe:add_button('',0,140,230,40)
	-- info_button:set_message_stop(true)

	-- --经验条
	-- local exp_texture = info_button:add_texture('image\\控制台\\lv_bar.blp',32,27,192,6)

	-- --等级按钮
	-- local level_texture = info_button:add_texture('image\\控制台\\lv_round.blp',0,2,40,32)
	-- level_texture.text = level_texture:add_text('10',0,0,40,32,8,'center')
	-- level_texture.text:set_color(0xffffff00)
	


	-- function info_button:on_button_mouse_enter()
	-- 	local hero = actor.hero 
	-- 	if hero then 
	-- 		if hero.get_exp_info then 
	-- 			local info = hero:get_exp_info()
	-- 			local str = string.format("等级 : %.0f\n经验 : %.0f / %.0f (%.0f%%)",
	-- 				info.level,
	-- 				info.exp,info.exp_max,
	-- 				math.max(0,math.min(info.exp / info.exp_max * 100,100))
	-- 			)
	-- 			self:tooltip({'信息','center'},str,2,300,36)
	-- 		else
	-- 			self:tooltip({'等级 : ' .. tostring(hero:get_level()),'center'},'',2,200,36)
	-- 		end
	-- 	end
	-- end
	



	-- --打开鼠标在按钮之上的移动事件
	-- observe:set_enable_move_event(true)


	-- --点击按钮时 跳转镜头到单位上
	-- function observe:on_button_clicked()

	-- 	local hero = actor.hero 
	-- 	if hero then 
	-- 		ac.player.self:setCamera(hero)
	-- 		--并且响应选择单位事件
	-- 		ClearSelection()
	-- 		SelectUnit(hero.handle,true) 

	-- 	end 
	-- end

	-- local angle = 0 

	-- local facing = 0

	-- local last = 0

	-- local center_x,center_y = observe:get_real_position()
	-- center_x = center_x + observe.w / 2 
	-- center_y = center_y + observe.h / 2 

	-- --当鼠标移动的时候 判断鼠标位置距离按钮正中心来控制模型旋转角度
	-- --由于设置旋转轴 是累加数值的接口，所以要单独记录每次的数值 以便恢复
	-- function observe:on_button_mouse_move(mouse_x,mouse_y)

	-- 	local distance = center_x - mouse_x 
	
	-- 	local old = (angle + 280) % 360 

	-- 	local target = (280 - distance) % 360 

	-- 	local value = target - old

	-- 	actor:set_rotate_y(value)

	-- 	angle = angle + value

	-- 	if value > last then 
	-- 		facing = -1 
	-- 	else
	-- 		facing = 1
	-- 	end 

	-- 	last = value

	-- end 

	

	-- --当鼠标离开按钮的时候 平滑的恢复面向角度
	-- function observe:on_button_mouse_leave()
	-- 	self.timer = ac.loop(5,function ()
	-- 		local value = math.abs(math.floor(angle % 360))
	-- 		if value == 0 then 
	-- 			if self.timer then 
	-- 				self.timer:remove()
	-- 				self.timer = nil
	-- 			end 
	-- 			angle = 0 
	-- 		else 
	-- 			actor:set_rotate_y(facing)
	-- 			angle = angle + facing
	-- 		end 
	-- 	end)
	-- end

	-- --当鼠标重新进入的时候 如果平滑计时器还在执行的话 则删除该计时器
	-- function observe:on_button_mouse_enter()
	-- 	if self.timer then 
	-- 		self.timer:remove()
	-- 		self.timer = nil
	-- 	end 
	-- end 


	
	
	---------------------------技能跟物品按钮--------------------------------

	--local tooltip = console.get('提示框')
	--tooltip:set_control_size(400,400)
	--tooltip:set_position(400,400)
	-- local buttons = {}
	-- for i=1,5 do 
	-- 	local v = skill_slots[i]
	-- 	local x,y = v[1],v[2]
	-- 	local skill = console.get('技能按钮',x,y)
	-- 	skill:set_cooldown_size(0.6)
	-- 	skill:set_control_size(56,42)
	-- 	skill:set_position(778 + i * 77,944)
	-- 	local button = class.button.create('',skill.x,skill.y,skill.w,skill.h)
	-- 	button:set_enable(false)
	-- 	button.on_button_mouse_enter = on_button_mouse_enter
	-- 	button.slot_id = i
	-- 	button.slot_type = '技能'
	-- 	button.skill = skill 
	-- 	skill.button = button
	-- 	table.insert(buttons,button)
	-- end 

	-- local x = 1261
	-- local y = 946
	-- for i=0,5 do
	-- 	local item = console.get('物品按钮',i)
	-- 	item:set_cooldown_size(0.6)
	-- 	item:set_control_size(56,42)
	-- 	item:set_position(x,y)
	-- 	item.button = class.button.create('',x,y,item.w,item.h)
	-- 	item.button:set_enable(false)
	-- 	item.button.on_button_mouse_enter = on_button_mouse_enter
	-- 	item.button.slot_id = i + 1
	-- 	item.button.slot_type = '物品'

	-- 	x = x + 73

	-- 	if i == 2 then 
	-- 		x = 1261
	-- 		y = y + 57
	-- 	end 
	-- end 

--------------------左上角 英雄头像图标----------------------------
	--local head_icon = class.button.create('x.blp',20,20,91,69)

	-- local head = console.get('头像图标',0)
	-- head:set_control_size(91,69)
	-- head:set_position(20,20)

	-- local head_icon = class.button.create('',head.x,head.y,head.w,head.h)
	-- head_icon:set_enable(false)
	-- head_icon.on_button_mouse_enter = on_button_mouse_enter
	-- head_icon.is_head = true



--------------------------血条蓝条-------------------------------------------
	-- local hp_model = class.progress.create
	-- {
	-- 	path = 'bar.mdx',
	-- 	--x = 685,
	-- 	x = 827,
	-- 	y = 1014,
	-- 	w = 388,
	-- 	h = 21,
	-- 	offset_x = 14,
	-- 	offset_y = 4,
	-- }
	-- hp_model:set_scale(0.75,1,1)
	-- hp_model:replace_id_texture('bar_green.tga',1)

	-- local mp_model = class.progress.create
	-- {
	-- 	path = 'bar_mp.mdx',
	-- 	--x = 685,
	-- 	x = 827,	
	-- 	y = 1038,
	-- 	w = 388,
	-- 	h = 21,
	-- 	offset_x = 14,
	-- 	offset_y = 5,
	-- }
	-- mp_model:set_scale(0.75,1,1)


-------------------------属性面板---------------------------
	local attr_panel = class.attr_panel.create(492,934)



-------------------当选中单位时 更新UI内容--------------------------------- 

	console.update_timer = ac.loop(100,function ()

		local unit_handle = japi.GetRealSelectUnit()
		local unit = ac.unit.j_unit(unit_handle)

		if unit  then 
			--如果这个单位 有这个base_id属性 则更新 模型观察器中的模型
			local name = unit:get_name()
			attr_panel:set_hero(unit)
		else
			attr_panel:set_hero(nil)	
		end 
	end)
	

end)




-- console.on_key_down = function ()
-- 	game.wait(10,function ()
-- 		console.update_timer:on_timer()
-- 	end)
-- end 

-- console.on_mouse_up = function ()

-- 	game.wait(10,function ()
-- 		console.update_timer:on_timer()
-- 	end)

-- 	game.wait(200,function ()

-- 		local unit_handle = japi.GetRealSelectUnit()
-- 		local unit = ac.unit.j_unit(unit_handle)

-- 		--当弹起按钮的时候 如果 当前是有选择单位 并且 技能按钮状态是打开的情况下
-- 		--也就是非准星状态下 刷新 锁定唯一的选择单位 以此避免 框选多个单位的时候 多个技能出现在同一个控制台上
-- 		if unit and enable_skill_button  then 
-- 			ClearSelection()
-- 			SelectUnit(unit.handle,true) 
-- 		end 
		
-- 	end)

-- end 


game.register_event(console)

return console



