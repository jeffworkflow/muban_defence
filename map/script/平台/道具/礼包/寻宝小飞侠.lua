local mt = ac.skill['寻宝小飞侠']
mt{
--等久
level = 0,
--图标
art = [[xbxfx.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00移速+200 每秒加全属性888|r
|cff00ffff开局赠送5张藏宝图
藏宝图掉落概率提高一倍
可自动寻宝（点击藏宝图试试）|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['移动速度'] = 200,
['每秒加全属性'] = 888,
}
function mt:on_add()
    local hero = self.owner
    local target = self.target
    local items = self
    local p = hero:get_owner()
    local peon = p.peon
    -- 宠物可以帮忙吃
    hero = hero:get_owner().hero
    hero.wabao_auto = true
    p.up_fall_wabao = 100 --挖宝几率提高一倍
    for i=1,5 do
        peon:add_item('藏宝图',true)
    end    
end    
