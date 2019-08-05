local mt = ac.skill['缘定三生']
mt{
--等级
level = 1, --要动态插入
--图标
art = [[ydss.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff消耗勇士徽章  500  兑换获得

|cffFFE799【称号属性】：|r
|cff00ff00+268  杀怪加全属性|r
|cff00ff00+10%   免伤几率|r
|cff00ff00+10%   对BOSS额外伤害|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 750,
['木头加成'] = 13.8,
['攻击减甲'] = 13.8,
['会心伤害'] = 13.8,
need_map_level = 5,
}




local mt = ac.skill['精彩活动']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[jchd.blp]],
    title = '精彩活动',
    tip = [[

查看精彩活动
    ]],
    
}
mt.skill_name ={
    '缘定三生'
}
mt.skills = {
}

function mt:on_add()
    local hero = self.owner 
    local player = hero:get_owner()
    for index,name in ipairs(self.skill_name) do 
        local has_mall = player.mall[name] or (player.cus_server and player.cus_server[name])
        if has_mall and has_mall > 0 then 
            ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',name)
        end
    end 
end    
