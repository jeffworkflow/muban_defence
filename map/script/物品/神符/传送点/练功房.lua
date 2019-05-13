--物品名称
local mt = ac.skill['练功房']
mt{
--等久
level = 1,

--图标
art = [[ReplaceableTextures\CommandButtons\BTNSnazzyScrollPurple.blp]],

--说明
tip = [[
传送到中心点 练功房
]],

--物品类型
item_type = '神符',

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

--冷却
cool = 0,

--购买价格
gold = 1000,

}

function mt:on_add()
    print('施法-添加技能',self.name)
end

function mt:on_cast_start()
    print('施法-使用技能',self.name)

    local hero = self.owner
    local target = self.target
    hero:setPoint(ac.point(0,0))
end

function mt:on_remove()
    print('施法-删除技能',self.name)
end