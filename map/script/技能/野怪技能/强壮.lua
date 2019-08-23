local mt = ac.skill['强壮']

mt.title = "强壮"
mt.tip = [[
    被动1：提升自己死亡掉落的经验50%，提升自己死亡掉落的金钱50%
    被动2：提升自己的三维10%
]]

--影响三维值 (怪物为：生命上限，护甲，攻击力)
mt.value = 10
mt.rate = 25

local cast_item ={}
for name,data in pairs(ac.table.ItemData) do 
    local item_type = data.item_type 
    local color = data.color 
    if item_type == '消耗品' and color == '白' then 
        table.insert(cast_item,name)
    end 
end 

table.sort(cast_item,function (a,b)
    return a < b
end)


function mt:on_add()

    local hero = self.owner 
    -- 提升三维(生命上限，护甲，攻击)
    hero:add('生命上限%', self.value)
    hero:add('护甲%', self.value)
    hero:add('攻击%', self.value)
    hero:add('魔抗%', self.value)
    
    -- hero:event '单位-死亡' (function()
    --     if math.random(100) < self.rate then 
    --         local item_name = cast_item[math.random(#cast_item)]
    --         ac.item.create_item(item_name,hero:get_point())
    --     end    
    -- end)

end


function mt:on_remove()
    
    local hero = self.owner 
    -- 降低三维(生命上限，护甲，攻击)
    hero:add('生命上限%', -self.value)
    hero:add('护甲%', -self.value)
    hero:add('攻击%', -self.value)
    hero:add('魔抗%', -self.value)


end

