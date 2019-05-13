local mt = ac.item{'兑换覆海蛟龙套','兑换圣炎套','兑换远古套','兑换大日套','兑换恶灵套'}

function mt:on_add()
    local hero = self.owner
    local data = ac.table.skill[self:get_name()]
    local list = {}
    for i=1,4 do 
        print(data['item' .. i] )
        if data['item' .. i] then 
            hero:add_item(data['item' .. i] .. '-' .. data.color )
        end 
    end 

    self:remove()
end 

local mt = ac.item['兑换单件随机武器']

function mt:on_add()
    local hero = self.owner
    local data = ac.table.skill[self:get_name()]
    local list = {}
    local rand = math.random(5)
    if data['item' .. rand] then 
        hero:add_item(data['item' .. rand] .. '-' .. data.color )
    end 
    self:remove()
end 