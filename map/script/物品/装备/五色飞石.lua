--物品名称
local mt = ac.skill['五色飞石']
mt{
    --物品技能
    is_skill = true,
    
    level = 1 ,
    max_level = 11,
    --颜色
    color = '紫',
    tip = [[
%show_tip%

|cffFFE799【进阶】|r 杀死 %kill_cnt% 个敌人，自动进阶]],

    --技能图标
    art = [[qiu305.blp]],
    --全属性
    ['全属性'] = {100,500,2500,5000,25000,50000,250000,500000,1250000,2500000,5000000,},
    --每秒加全属性
    ['每秒加全属性'] = {0,1,3,10,30,90,270,810,2430,7290,21870,},
    --攻击
    ['攻击'] = {0,0,2500,5000,25000,50000,250000,500000,1250000,2500000,5000000,},
    --护甲
    ['护甲'] = {1,5,10,50,100,200,400,800,1250,2500,5000,},
    --每秒加金币
    ['每秒加金币'] = {0,50,100,500,1000,5000,5000,5000,5000,5000,5000,},
    --每秒加木头
    ['每秒加木头']  = {0,0,0,0,0,0,1,5,10,50,100,},
    --会心几率
    ['会心几率']  = {0,0,0,1,2,3,4,5,6,8,10,},
    --会心伤害
    ['会心伤害'] = {0,0,0,10,20,30,40,50,60,80,100,},
    --杀敌个数
    kill_cnt = {10,50,100,200,400,800,1600,3200,6400,12800,25600},
    --唯一
    unique = true,
    --显示等级
    show_level = true,
    show_tip = function(self)
        local str = ''
        local attribute = ac.unit.attribute
        if self['全属性'] >0 then 
            str = str ..'+|cffFFE799'..self['全属性']..'|r 全属性'..'\n'
        end    
        if self['每秒加全属性'] >0 then 
            str = str ..'+|cffFFE799'..self['每秒加全属性']..'|r 每秒加全属性'..'\n'
        end    
        if self['攻击'] >0 then 
            str = str ..'+|cffFFE799'..self['攻击']..'|r 攻击'..'\n'
        end    
        if self['护甲'] >0 then 
            str = str ..'+|cffFFE799'..self['护甲']..'|r 护甲'..'\n'
        end    
        if self['每秒加金币'] >0 then 
            str = str ..'+|cffFFE799'..self['每秒加金币']..'|r 每秒加金币'..'\n'
        end   
        if self['每秒加木头'] >0 then 
            str = str ..'+|cffFFE799'..self['每秒加木头']..'|r 每秒加木头'..'\n'
        end    
        if self['会心几率'] >0 then 
            str = str ..'+|cffFFE799'..self['会心几率']..'%|r 会心几率'..'\n'
        end    
        if self['会心伤害'] >0 then 
            str = str ..'+|cffFFE799'..self['会心伤害']..'%|r 会心伤害'..'\n'
        end     
        return str
    end,   
    --升级特效
    effect =[[Hero_CrystalMaiden_N2_V_boom.mdx]],
    --物品详细介绍的title
    content_tip = '基本属性：',
}


function mt:on_upgrade()
    local hero = self.owner
    -- print(self.life_rate_now)   
    hero:add_effect('chest',self.effect):remove()
    self:set_name(self.name)

    if not self.trg and self.level < self.max_level then 
        self.trg = ac.game:event '单位-杀死单位' (function(trg, killer, target)
            --召唤物杀死也继承
            local hero = killer:get_owner().hero
            if hero ~= self.owner then 
                return 
            end    
            if hero and hero:has_item(self.name) and (hero == self.owner) then 
                local item = hero:has_item(self.name)
                if item.level >= item.max_level then 
                    return 
                end
                item:add_item_count(1)
                if item._count >= item.kill_cnt then 
                    item:add_item_count(-item.kill_cnt+1)
                    item:upgrade(1)
                end    
            end    
        end)
    end   
end
function mt:on_add()
    local hero = self.owner
    local player = hero:get_owner()
    local item = self 
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

   
end