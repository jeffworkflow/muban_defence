
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
    local object = controls[key]
    if object == nil then 
        local control_id = japi[func_name](row,column)
		if control_id == nil or control_id == 0 then 
			print('获取id是0',name,id)
            return 
        end 
        object = extends(class.button){
            _id = control_id,
            w = 0,
            h = 0,
        }
        if name == '血条' or name == '蓝条' then 
            object.set_position = function (self,x,y)
                self.x = x
                self.y = y
                x =  (x + self.w / 2) / 1920 * 0.8
                y = (1080 - y) / 1080 * 0.6
                japi.FrameSetPoint(self._id,1,game_ui,6,x,y)
            end
        elseif name == '头像模型' then 
            object.set_position = function (self,x,y)
                self.x = x
                self.y = y
                x =  x / 1920 * 0.8
                y = (1080 - y - self.h) / 1080 * 0.6
                japi.FrameSetPoint(self._id,6,game_ui,6,x,y)
            end
        elseif name == '小地图' then 
            object.set_position = function (self,x,y)
                self.x = x
                self.y = y
                local ax =  x / 1920 * 0.8
                local ay = (1080 - y - self.h) / 1080 * 0.6
                local bx = (x + self.w) / 1920 * 0.8
                local by = (1080 - y) / 1080 * 0.6
                japi.FrameSetPoint(self._id,6,game_ui,6,ax,ay)
                japi.FrameSetPoint(self._id,2,game_ui,6,bx,by)
            end
        elseif name == '技能按钮' then 
            object.w = 94
            object.h = 70
            object.row = row 
            object.column = column
            object.x = 1485 + column * (94 + 12) 
            object.y = 839 + (2 - row) * (70 + 12) 
  
			object.set_cooldown_size = function (self,size)
				japi.FrameSetButtonCooldownModelSize(self._id,size)
            end
 
		elseif name == '物品按钮' then 
            object.num = row
            object.w = 78
            object.h = 59
            object.x = 1235 + row % 2 * (78 + 18)
            object.y = 874 + math.floor(row / 2) * (59 + 10)
			object.set_cooldown_size = function (self,size)
				japi.FrameSetButtonCooldownModelSize(self._id,size)
            end

		elseif name == '聊天消息' then
            object.set_position = function (self,x,y)
                self.x = x
                self.y = y
                x =  x / 1920 * 0.8
                y =  -y / 1080 * 0.6
                japi.FrameSetPoint(self._id,0,game_ui,0,x,y)
            end
        elseif name == '单位消息' then
            object.set_position = function (self,x,y)
                self.x = x
                self.y = y
                x =  x / 1920 * 0.8
                y =  -y / 1080 * 0.6
                japi.FrameSetPoint(self._id,0,game_ui,0,x,y)
            end
        elseif name == '提示框' then 
            object.set_position = function (self,x,y)
                self.x = x
                self.y = y
                x =  (x - self.w * 1.5) / 1920 * 0.8
                y =  -y / 1080 * 0.6
                japi.FrameSetPoint(self._id,8,game_ui,1,x,y)
			end
		elseif name == '按钮冷却模型' then 
			object = extends(class.model)(object)
        end 
        controls[key] = object
    end 
    return object
end 


ac.wait(0,function ()
	--------------------黑边-----------------------------------
    japi.FrameEditBlackBorders(0.023,0.11)
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

	---------------------------头像模型-----------------------------------------
	local model = console.get('头像模型')
	model:set_control_size(225,112)
	model:set_position(500,1080 - 170)

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
return console