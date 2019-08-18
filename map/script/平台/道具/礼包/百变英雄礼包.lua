local mt = ac.skill['百变英雄礼包']
mt{
--等久
level = 0,
--图标
art = [[bbyxlb.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00可解锁全部英雄的皮肤（天赋属性不解锁）
|cff00ff00额外赠送5只精美英雄皮肤（赠送皮肤非固定皮肤，可能随时变更，在 “巅峰神域-英雄皮肤-下一页” 查看）

|cff00ffff杀怪加全属性488，攻击减甲+488，全伤加深+488%
|cffffff00吞噬丹+2，恶魔果实+2，点金石+20

|cffff0000百变英雄礼包+神装大礼包+神技大礼包，激活额外属性：
|cff00ff00吞噬上限额外+2(不与“超越极限”冲突)；技能强化上限额外+2(不与“超越极限”冲突)

|cffdf19d0百变英雄礼包+独孤求败（在 “巅峰神域-称号” 内查看获得方式），激活额外属性：
|cff00ff00杀怪加全属性+150 会心几率+15% 会心伤害+150% 全伤加深+150%

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--几率
chance = 10,
['杀怪加全属性'] = 488,
['攻击减甲'] = 488,
['全伤加深'] = 488,
}
function mt:on_add()
    local hero = self.owner
    local p = hero:get_owner()
    hero = p.hero
    local peon = p.peon
    if hero:has_item(self.name) then 
        return 
    end   
    hero:add_item('百变英雄礼包 ') 
end  


local mt = ac.skill['百变英雄礼包 ']
mt{
--等久
level = 1,
--图标
art = [[bbyxlb.blp]],
is_order = 1,
item_type ='消耗品',
--说明
tip = [[
|cff00ff00点击获得|cffffff00吞噬丹+2，恶魔果实+2，点金石+20|r，|cff00ff00其它属性在 |cff00ffff“巅峰神域-礼包” |cff00ff00中查看
]],
attr_tip = '',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
} 

function mt:on_cast_start()
    local hero = self.owner
    local items = self
    local p = hero:get_owner()
    -- 宠物可以帮忙吃
    hero = hero:get_owner().hero
    if not p.mall_flag[self.name] then 
        --添加物品
        self.owner:add_item('吞噬丹',true)
        self.owner:add_item('吞噬丹',true)
        self.owner:add_item('恶魔果实',true)
        self.owner:add_item('恶魔果实',true)
        local item = ac.item.create_item('点金石',self.owner:get_point())
        item:set_item_count(20)
        self.owner:add_item(item,true)

        --发送消息
        -- p:sendMsg('|cffFFE799【系统消息】|r|cff00ff00百变英雄礼包激活成功|r 激活的套装属性可以在礼包系统中查看',3)

        --添加羁绊1
        if p.mall and (p.mall['神技大礼包'] or 0) >=1 and (p.mall['神装大礼包'] or 0) >=1  then 
            --吞噬上限
            p.max_tunshi_cnt = (p.max_tunshi_cnt or 8) + 2
            --入体上限
            p.max_ruti_cnt = (p.max_ruti_cnt or 8) + 2
        end 
        --羁绊2 
        if hero:find_skill('独孤求败',nil) then
            hero:add('杀怪加全属性',150)
            hero:add('会心几率',15)
            hero:add('会心伤害',150)
            hero:add('全伤加深',150)
        end    
        

        p.mall_flag[self.name] = true
    end    
end    