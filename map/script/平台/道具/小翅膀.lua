--物品名称 商店物品
local mt = ac.skill['小翅膀']
mt{
--等级
level = 1,

--图标
art = [[icon\xiaochibang.blp]],

--说明
tip = [[消耗 |cff00ff00 %jifen% 通关积分|r 兑换 小翅膀
|cffff0000兑换后可立即激活，且可在宠物处切换翅膀|r  

|cffFFE799增加属性：|r 
|cffffff00+ %gold_mul% %|r 金币加成
|cffffff00+ %exp_mul% %|r 经验加成
|cffffff00+ %item_mul% %|r 物品获取率]],

--物品类型
item_type = '神符',

content_tip = '物品说明:',

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

--冷却
cool = 0,

--购买价格
jifen = 100000,

auto_fresh_tip = true,
--物品技能
is_skill = true,
--金币加成
gold_mul = 10,
--物品获取率
item_mul = 10,
--经验加成
exp_mul = 10,

--特效翅膀
effect = [[QX_chibang_d.mdx]],

}

function mt:on_add()
    local skill = self
    local hero = self.owner
    local player = hero:get_owner()
    hero = player.hero
    hero:add('金币加成',self.gold_mul)
    hero:add('经验加成',self.exp_mul)
    hero:add('物品获取率',self.item_mul)
    --添加翅膀
    if hero.chibang then 
        hero.chibang:remove()
    end    
    hero.chibang = hero:add_effect('chest',self.effect)
end    

function mt:on_cast_start()
    local hero = self.owner
    local player = hero:get_owner()
    hero = player.hero

    if player.mall and player.mall[self.name] then 
        -- print(2)
        self:buy_failed()
        ac.player.self:sendMsg('|cff00ffff已拥有|r')
        return true 
    end    

end

function mt:buy_failed()
    local skill = self
    local hero = self.owner
    local player = hero:get_owner()
    hero = player.hero

    hero:add('金币加成',-self.gold_mul)
    hero:add('经验加成',-self.exp_mul)
    hero:add('物品获取率',-self.item_mul)
    --添加翅膀
    if hero.chibang then 
        hero.chibang:remove()
    end  
    --已拥有时，再点一次为穿上  
    hero.chibang = hero:add_effect('chest',self.effect)

end