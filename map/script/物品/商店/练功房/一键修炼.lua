local slot={9,10,11,12,5,6,7,8,1,2,3,4}

local mt = ac.skill['一键修炼']
mt{
    level = 1,
    is_order = "1",
    art = "yijianxiulian.blp",
    tip = [[

|cff00ff00点击进行|cffffff00 一键修炼
 ]],
}
function mt:on_cast_start()
    local owner = self.owner
    local p = owner.owner
    local hero = p.hero 

    ac.wait(0,function()
    for i=1,10 do 
        local skl = owner:find_skill(slot[i],'英雄')
        if skl then
            -- print(skl.name,skl.level)
            skl:cast_force() --开始施法
        end
    end
end)

end