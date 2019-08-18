local mt = ac.skill['百变大礼包']
mt{
--等久
level = 0,
--图标
art = [[yjcjzz.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00杀怪加288全属性，攻击加488全属性，每秒加888全属性，
|cff00ffff暴击几率+25% 暴击加深+500% 
技暴几率+25% 技暴加深+500%
攻击减甲+125 全伤加深+250% |r
|cffffff00杀敌数额外+1|r

杀怪加全属性488，攻击减甲+488，全伤加深+488%，吞噬丹+2，恶魔果实+2，点金石+20

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
    hero:add_item('百变大礼包 ') 
end  


local mt = ac.skill['百变大礼包 ']
mt{
--等久
level = 1,
--图标
art = [[szdlb.blp]],
is_order = 1,
item_type ='消耗品',
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00随机物品1个|cffffff00（纯随机，人品好直接出黑装）
|cff00ff00吞噬丹1个 |cffffff00可直接吞噬某件装备
|cff00ff00开局随机激活一套套装属性|cffffff00（不和套装洗练冲突）|r
|cffffff00神装大礼包+神技大礼包激活：吞噬丹*1，点金石*10，恶魔果实*1
随机套装属性：|r
%attr_tip%
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
        p:sendMsg('|cffFFE799【系统消息】|r|cff00ff00神装大礼包激活成功|r 激活的套装属性可以在礼包系统中查看',3)

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