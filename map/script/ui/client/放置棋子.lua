

local ui = require 'ui.client.util'

local unit = ac.player(16):create_unit('e001',ac.point(0,0),270)

local timer 




local function create_selector(target)
    local selector = {}

    local path = target:get_model()
    unit:set_model_force(path)
    unit:setColor(100,100,100,100)
    local size = tonumber(target:get_slk 'modelScale') or 1

    jass.SetUnitScale(unit.handle,size,size,size)


    selector.timer = game.loop(0.03,function ()
        local x,y = japi.GetMouseX(),japi.GetMouseY()


        local cell = ac.player.self:point_to_cell_ex(ac.point(x,y))
        if cell == nil then 
            unit:setColor(100,20,20,100)
            japi.SetUnitPosition(unit.handle,x,y)
        else
            unit:setColor(0,100,0,100)
            japi.SetUnitPosition(unit.handle,cell.point_x,cell.point_y)
        end
    end) 

    function selector:remove()
        if self.timer then 
            self.timer:remove()
            self.timer = nil 
        end

        unit:set_model_force('')
    end

    return selector
end 

local selector

ac.chess_select = function (msg)

    if selector == nil then 
        return true
    end 

    if msg.code == 512 then 
        selector:remove()
        selector = nil
        return true 
    end

    if msg.type ~= 'mouse_down' then 
        return true
    end


    --右键
    if msg.code == 4 then 

    --左键
    elseif msg.code == 1 then 
        local info = {
            type = '棋子',
            func_name = 'on_chess_up',
            params = {
                [1] = math.modf(japi.GetMouseX()),
                [2] = math.modf(japi.GetMouseY()),
            }
        }
        ui.send_message(info)
     
    end

    selector:remove()
    selector = nil
 
    return true 
end

ac.game:event '玩家-选择移动棋子' (function (_,player,hero,target)
    if ac.battle.prepare == false then
        return
    end
    player.select_chess_unit = target
    if not player:is_self() then 
        return 
    end
    if selector then 
        selector:remove()
        selector = nil 
    end
 
    ForceUIKey('P')

    selector = create_selector(target)
end)

