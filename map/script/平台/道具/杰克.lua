local japi = require("jass.japi")
--物品名称 商店物品
local mt = ac.skill['杰克']
mt{
--等级
level = 1,

--图标
art = [[icon\jieke.blp]],

--说明
tip = [[消耗 |cff00ff00 %jifen% 通关积分|r 兑换 |cffdf19d0亚瑟王的皮肤-杰克|r
|cffff0000兑换后可立即激活，且永久拥有|r  

|cffFFE799增加属性：|r 
|cffffff00+ %item_mul% %|r 物品获取率
|cffffff00强化|r 剑刃风暴]],

--物品类型
item_type = '神符',

content_tip = '物品说明:',

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

--冷却
cool = 0,

--购买价格
jifen = 200000,

auto_fresh_tip = true,
--物品技能
is_skill = true,
--物品获取率
item_mul = 10,

--特效翅膀
effect = [[HeroCOCOBlack.mdx]],

}

function mt:on_add()
    local skill = self
    local hero = self.owner
    local player = hero:get_owner()
    hero = player.hero
    if not hero then 
        hero = self.owner 
    end
    if not hero.strong_skill then 
        hero.strong_skill = {}
    end  
    self.old_model = hero:get_slk 'file'
	if not getextension(self.old_model) then 
		self.old_model = self.old_model..'.mdl'
    end	
    if hero.name == '亚瑟王' then 
        hero:add('物品获取率',self.item_mul)
        --没有皮肤时，更换模型
        hero.skin = japi.SetUnitModel(hero.handle,self.effect)
        --增强剑刃风暴
        local skill = hero:find_skill('剑刃风暴')
        if skill then 
            hero.strong_skill['剑刃风暴'] = true
            skill:strong_skill_func()
        end    
       
    end    
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

    if hero.name == '亚瑟王' then 
        hero:add('物品获取率',-self.item_mul)
        --已拥有时，再点一次为穿上
        if hero.skin then 
            japi.SetUnitModel(hero.handle,self.old_model)
            hero.skin = false
        end    
    end    

end