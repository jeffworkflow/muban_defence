--物品名称
local mt = ac.skill['霸者之证']
mt{
    --物品技能
    is_skill = true,
    level = 1 ,
    max_level = 5,

    --颜色
    color = '紫',

    tip = [[
|cffffff00+|r%attack% 攻击
|cffffff00+|r%life% 生命
|cffffff00+|r%defence% 护甲
%lv2_tip%]],

    --技能图标
    art = [[other\zheng_401.blp]],
    --攻击
    attack = 250000,
    --生命
    life = 500000,
    --护甲
    defence = 650,

    --暴击几率
	physical_rate = {0,5,10,15,15},
	--会爆
	heart_rate = {0,5,10,15,15},
	--法爆
    magic_rate = {0,5,10,15,15},
    
	--对boss 全伤加深
    boss_damage = 250,
    
    --等级>=2 时新增的描述
    lv2_tip = function(self,hero)
        local tip = ''
        if self.level == 1  then 
            tip = tip .. '\n|cffFFE799【进阶】|r100级的英雄，携带此物，|cff00ffff找出生点的 天洁散人 |r'
        else    
            if self.level >=2  then 
                tip = tip .. '|cffffff00+'..self.physical_rate ..'%|r 暴击几率\n'
                tip = tip .. '|cffffff00+'..self.magic_rate ..'%|r 技暴几率\n'
                tip = tip .. '|cffffff00+'..self.heart_rate ..'%|r 会心几率\n'
                tip = tip .. '|cffffff00+20|r 杀怪获得全属性'..'\n'
                tip = tip .. '|cffffff00+20%|r 杀怪收集灵魂（受物品获取率影响）\n'
            end   
            if self.level >=2 and self.level <=3  then  
                tip = tip .. '\n|cffFFE799【进阶】|r收集%upgrade_cnt%个灵魂，自动进阶为|cffdf19d0 霸者之证LV'..(self.level+1)..'|r'
            end   
            if self.level ==4 then  
                tip = tip .. '\n|cffFFE799【进阶】|r收集%upgrade_cnt%个灵魂，找|cff00ffff出生点的 天洁散人 |r挑战伏地魔'
            end
            if self.level ==5 then  
                tip = tip .. '|cffffff00+'..self.boss_damage ..'%|r 对BOSS额外伤害'
            end
        end    
        return tip
    end,  

   
    --杀怪加全属性 
    kill_add_attr = 20,
    --概率收集
    chance = function(self,hero)
        if self and self.owner then 
            return 20 * ( 1 + self.owner:get('物品获取率')/100 )
        else
            return 20    
        end
    end,       
    --唯一
    unique = true,
    --升级所需要的杀敌数
    upgrade_cnt = {0,100,150,200,999999},
    --显示等级
    show_level = true,
    --升级特效
    effect =[[Hero_CrystalMaiden_N2_V_boom.mdx]],
    content_tip = '基本属性：',
    specail_model = [[Objects\InventoryItems\TreasureChest\treasurechest.mdl]]
}


mt.physical_rate_now = 0
mt.heart_rate_now = 0
mt.magic_rate_now = 0

function mt:on_upgrade()
    local hero = self.owner
    -- print(self.life_rate_now)   
    hero:add_effect('chest',self.effect):remove()
    self:set_name(self.name)
	hero:add('暴击几率', -self.physical_rate_now)
	self.physical_rate_now = self.physical_rate
	hero:add('暴击几率', self.physical_rate)

	hero:add('会心几率', -self.heart_rate_now)
	self.heart_rate_now = self.heart_rate
	hero:add('会心几率', self.heart_rate)

	hero:add('技暴几率', -self.magic_rate_now)
	self.magic_rate_now = self.magic_rate
    hero:add('技暴几率', self.magic_rate)
    
    if self.level >=2 then 
        if not self.trg then 
            self.trg = ac.game:event '单位-杀死单位' (function(trg, killer, target)
                --召唤物杀死也继承
                local hero = killer:get_owner().hero
                if hero and hero:has_item(self.name) then 
                    local rand = math.random(100)
                    if rand <= self.chance then 
                        self:add_item_count(1)
                        if self._count >= self.upgrade_cnt and self.level < (self.max_level-1) then 
                            self:add_item_count(-self.upgrade_cnt+1)
                            self:upgrade(1)
                        end  
                    end  
                    --杀怪加全属性 
                    hero:add('力量',self.kill_add_attr)
                    hero:add('智力',self.kill_add_attr)
                    hero:add('敏捷',self.kill_add_attr)
                end    
            end) 
        end    
    end  

    if self.level == self.max_level then 
        hero:add('对BOSS额外伤害',self.boss_damage)
        self.chance = 0   
    end     
    -- local tip = '升级时加的文字描述'
    -- self.tip = self:get_tip() .. tip .. '\n'
    -- self:fresh_tip()
end


function mt:on_add()
    local hero = self.owner
    local player = hero:get_owner()
    local item = self 
    hero:add('攻击',self.attack)
    hero:add('生命上限',self.life)
    hero:add('护甲',self.defence)

	hero:add('暴击几率', self.physical_rate)
	hero:add('会心几率', self.heart_rate)
    hero:add('技暴几率', self.magic_rate)

    if self.level >=2 then 
        if not self.trg then 
            self.trg = ac.game:event '单位-杀死单位' (function(trg, killer, target)
                --召唤物杀死也继承
                local hero = killer:get_owner().hero
                if hero ~= self.owner then 
                    return 
                end    
                if hero and hero:has_item(self.name) then 
                    local item = hero:has_item(self.name)
                    local rand = math.random(100)
                    if rand <= self.chance then 
                        item:add_item_count(1)
                        if item._count >= item.upgrade_cnt and item.level < (item.max_level-1) then 
                            item:add_item_count(-item.upgrade_cnt+1)
                            item:upgrade(1)
                        end  
                    end  
                    --杀怪加全属性 
                    hero:add('力量',self.kill_add_attr)
                    hero:add('智力',self.kill_add_attr)
                    hero:add('敏捷',self.kill_add_attr)
                end    
            end) 
        end    
    end  

end
function mt:on_cast_start()
    local hero = self.owner
    local player = hero:get_owner()
    --需要先增加一个，否则消耗品点击则无条件先消耗
    self:add_item_count(1) 

end  

--实际是丢掉
function mt:on_remove()
    local hero = self.owner
    if self.trg then 
        self.trg:remove()
        self.trg = nil
    end    
    hero:add('攻击',-self.attack)
    hero:add('生命上限',-self.life)
    hero:add('护甲',-self.defence)
	
	hero:add('暴击几率',-self.physical_rate)
	hero:add('会心几率',-self.heart_rate)
    hero:add('技暴几率',-self.magic_rate)
    
    if self.level == self.max_level then 
        hero:add('对BOSS额外伤害',-self.boss_damage)
    end  

end