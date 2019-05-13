--物品名称
local mt = ac.skill['力量之书']
mt{

--等久
level = 1,

--图标
art = [[ReplaceableTextures\CommandButtons\BTNTome.blp]],

--说明
tip = [[
提升10点力量
]],

--物品类型
item_type = '神符',

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

--冷却
cool = 0,

--购买价格
gold = 1000,

--模型
_model = [[Objects\InventoryItems\tomeRed\tomeRed.mdl]],

}

function mt:on_add()
    print('施法-添加技能',self.name)
end

function mt:on_cast_start()
    print('施法-使用技能',self.name)

    local hero = self.owner
    local target = self.target
    hero:add('生命上限',100)
end

function mt:on_remove()
    print('施法-删除技能',self.name)
end