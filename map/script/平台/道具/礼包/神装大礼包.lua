local mt = ac.skill['神装大礼包']
mt{
--等久
level = 0,
--图标
art = [[szdlb.blp]],
is_order = 1,
item_type ='消耗品',
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00随机物品1个|cffff0000（纯随机，人品好直接出红装）
|cff00ff00吞噬丹1个 |cffff0000（可直接吞噬某件装备）
|cff00ff00开局随机激活一套套装属性|cffff0000（不和套装洗练冲突）|r
|cff00ff00随机套装属性：|r
%attr_tip%
]],
attr_tip = '',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
}
function mt:on_add()
    local hero = self.owner
    local target = self.target
    local p = hero:get_owner()
    local peon = p.peon
    if peon:has_item(self.name) then 
        return 
    end   
    peon:add_item('神装大礼包 ') 
end  


local mt = ac.skill['神装大礼包 ']
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
|cff00ff00随机物品1个|cffffff00（纯随机，人品好直接出红装）
|cff00ff00吞噬丹1个 |cffffff00可直接吞噬某件装备
|cff00ff00开局随机激活一套套装属性|cffffff00（不和套装洗练冲突）|r
随机套装属性：|r
%attr_tip%
]],
attr_tip = '',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
} 
function mt:on_cast_start()
    local hero = self.owner
    local target = self.target
    local items = self
    local p = hero:get_owner()
    -- 宠物可以帮忙吃
    hero = hero:get_owner().hero
    if not p.mall_flag[self.name] then 
        --添加吞噬丹
        self.owner:add_item('吞噬丹',true)
        --随机添加物品
        local name = ac.all_item[math.random( 1,#ac.all_item)]
        self.owner:add_item(name,true)

        --给英雄随机添加套装属性
        local suit = ac.item.suit[math.random(1,#ac.item.suit)]
        local little_name,name, type,attr3,attr5= table.unpack(suit)
        local attr_tip =''
        --增加套装属性
        for k,v in string.gsub(attr3,'-','+-'):gmatch '(%S+)%+([-%d.]+%s-)' do
            hero:add(k,v)
            local ex_tip =  finds(ac.base_attr,k) and '' or '%'
            attr_tip = attr_tip ..'+'..v..ex_tip.. k ..'\n'

        end 
        for k,v in string.gsub(attr5,'-','+-'):gmatch '(%S+)%+([-%d.]+%s-)' do
            hero:add(k,v)
            local ex_tip =  finds(ac.base_attr,k) and '' or '%'
            attr_tip = attr_tip ..'+'..v..ex_tip.. k ..'\n'
        end 
        --文本显示
        local skl = hero:find_skill('神装大礼包',nil,true)
        if skl then 
            skl:set('attr_tip',attr_tip)
        end    
        --发送消息
        p:sendMsg('恭喜您，随机到了 '..little_name..' 套装属性: '..attr_tip)

        p.mall_flag[self.name] = true
    end    
end    
