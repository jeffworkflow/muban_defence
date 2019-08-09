local mt = ac.skill['灵丹妙药'] 

mt{
    level = 1,
    title = "灵丹妙药",
    tip = [[
        被动1：死亡必掉消耗品（品质白色，数量=怪物占用人口）
        被动2：提升自己的三维15%
    ]],

    -- 消耗品数量
    cnt = function(self,hero)
        return hero.food or 0 
    end,

    -- 影响三维值 (怪物为：生命上限，护甲，攻击力)
    value = 15,

    -- 几率掉落
    rate = 30,
    
    -- 特效
    effect = [[Abilities\Spells\Items\ResourceItems\ResourceEffectTarget.mdl]]

}

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
    local skill = self
    local hero = self.owner 
    -- 降低三维(生命上限，护甲，攻击)
    hero:add('生命上限%', self.value)
    hero:add('护甲%', self.value)
    hero:add('攻击%', self.value)
    hero:add('魔抗%', self.value)
    -- print('技能被添加',hero.food,self.cnt)

    self.trg = hero:event '单位-死亡' (function(_,unit,killer)
        local rand = math.random(1,100)
        --几率掉落
        if rand <= self.rate then 
            if self.cnt > 0 then 
                -- 死亡随机掉落人口同等数量的消耗品
                -- print('学霸掉落的物品数量：',hero.food,self.cnt)
                -- for i = 1,self.cnt do
                hero:timer(0.1*1000,self.cnt,function()
                    local item_name = cast_item[math.random(#cast_item)]
                    ac.item.create_item(item_name,hero:get_point())
                    -- item:set_item_count(self.cnt)
                end)    
                
                -- end    
            end 
        end       
   end)    


end


function mt:on_remove()

    local hero = self.owner 
    -- 提升三维(生命上限，护甲，攻击)
    hero:add('生命上限%', -self.value)
    hero:add('护甲%', -self.value)
    hero:add('攻击%', -self.value)
    hero:add('魔抗%', -self.value)

    if self.trg then
        self.trg:remove()
        self.trg = nil
    end    

end

