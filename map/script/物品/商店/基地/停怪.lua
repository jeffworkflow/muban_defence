
local rect = require 'types.rect'

--物品名称
local mt = ac.skill['停怪']
mt{
--等久
level = 1,

--图标
art = [[ReplaceableTextures\CommandButtons\BTNMagicLariet.blp]],

--说明
tip = [[


使得怪物|cff00ff00暂停进攻90秒|r
]],

--特殊id 带cd
type_id = 'EX00',

--物品类型
item_type = '神符',
--售价 500000
wood = 500,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 600,
--停怪时长
stu_time = 90,

content_tip = '|cffFFE799【使用说明】：|r',

--物品技能
is_skill = true,

}

function mt:on_cast_start()
    local unit = self.seller
    
    for i=1,3 do 
        local creep = ac.creep['刷怪'..i]
        creep:PauseTimer(self.stu_time)
    end
    
end
