//TESH.scrollpos=0
//TESH.alwaysfold=0
globals
    string array Player_name
endglobals

library Mtpplayername initializer initgetname
    private function initgetname takes nothing returns nothing
        local integer i= 0
        local string name
        set i=0
        loop
            exitwhen ( i > 12 )
            set i=i + 1
            
            set name = "|cff000000" + GetPlayerName(ConvertedPlayer(i)) + "|r"
            set Player_name[i]=name
        endloop


    endfunction
endlibrary