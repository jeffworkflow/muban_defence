
--宠物经验书处理
local suipian ={
    {'耐瑟龙碎片',[[ReplaceableTextures\CommandButtons\BTNNetherDragon.blp]]},
    {'冰龙碎片',[[ReplaceableTextures\CommandButtons\BTNAzureDragon.blp]]},
    {'精灵龙碎片',[[ReplaceableTextures\CommandButtons\BTNFaerieDragon.blp]]},
    {'奇美拉碎片',[[ReplaceableTextures\CommandButtons\BTNChimaera.blp]]},
    {'Pa碎片',[[ReplaceableTextures\CommandButtons\BTNHeroWarden.blp]]},
    {'手无寸铁的小龙女碎片',[[xiaolongnv.blp]]},
    {'关羽碎片',[[guanyu.blp]]},
    {'霸王莲龙锤碎片',[[wuqi10.blp]]},
    {'梦蝶仙翼碎片',[[chibang2.blp]]},
    {'魅影碎片',[[meiying.blp]]},
    {'紫霜幽幻龙鹰碎片',[[zsyhly.blp]]},
    
}
ac.shenlong_suipin = {}
for i,data in ipairs(suipian) do
    table.insert(ac.shenlong_suipin,data[1])
    --物品名称
    local mt = ac.skill[data[1]]
    mt{
    --等久
    level = 1,
    --图标
    art = data[2],
    --说明
    tip = [[


|cff00ffff点击可增加对应存档数据|r]],
    --品质
    color = '紫',
    --物品类型
    item_type = '消耗品',
    --物品模型
    specail_model = [[RedCrystalShard.mdx]],
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0.1,
    --物品数量
    _count = 1,
    --物品详细介绍的title
    content_tip = '|cffffe799使用说明：|r',
    --物品技能
    is_skill = true,
    }
    function mt:on_cast_start()
        local hero = self.owner
        local player = hero:get_owner()
        local key = ac.server.name2key(self.name)
        player:Map_AddServerValue(key,1) --网易服务器
        player:sendMsg('|cffffe799'..self.name..'|cffff0000 +1|r')
    end
end