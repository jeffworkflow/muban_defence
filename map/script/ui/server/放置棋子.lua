local ui = require 'ui.server.util'

local event = {
    on_chess_up = function (x,y)
        local player = ac.player(GetPlayerId(ui.player) + 1)
        local board = player:get_board()
        local unit = player.select_chess_unit

        if unit == nil then 
            return 
        end 

        if unit:get_owner() ~= player then 
            return 
        end 

        local cell = player:point_to_cell_ex(ac.point(x,y))

        if cell == nil then 
            return 
        end 

        board:unit_move( unit,cell:get_point())

    end,
}




ui.register_event('棋子',event)