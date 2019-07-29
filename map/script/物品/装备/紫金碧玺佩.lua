--物品名称
local mt = ac.skill['紫金碧玺佩']
mt{
    --物品技能
    is_skill = true,
    
    level = 1 ,
    max_level = 4,
    --颜色
    color = '紫',
    tip = [[

%show_tip%
%level_tip%]],

    --技能图标
    art = [[xianglian402.blp]],
    --全属性
    ['全属性'] = {6000000,8000000,10000000,12000000},
    --每秒加全属性
    ['每秒加全属性'] = {10000,15000,20000,25000},
    --攻击
    ['攻击'] = {6000000,8000000,10000000,12000000},
    --护甲
    ['护甲'] = {6000,8000,10000,12000},
    --每秒加木头
    ['每秒加木头']  = {75,100,125,150},
    --会心几率
    ['会心几率']  = {13,15,18,20},
    --会心伤害
    ['会心伤害'] = {125,150,175,200},
    --吸血
    ['吸血'] = 10,
    --杀敌个数
    kill_cnt = {5000,10000,15000,20000},
    --唯一
    unique = true,
    --显示等级
    show_level = true,
    show_tip = function(self)
        local str = ''
        local attribute = ac.unit.attribute
        if self['全属性'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['全属性'])..'|r 全属性'..'\n'
        end    
        if self['每秒加全属性'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['每秒加全属性'])..'|r 每秒加全属性'..'\n'
        end    
        if self['攻击'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['攻击'])..'|r 攻击'..'\n'
        end    
        if self['护甲'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['护甲'])..'|r 护甲'..'\n'
        end    
        -- if self['每秒加金币'] >0 then 
        --     str = str ..'+|cffffff00'..self['每秒加金币']..'|r 每秒加金币'..'\n'
        -- end   
        if self['每秒加木头'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['每秒加木头'])..'|r 每秒加木头'..'\n'
        end    
        if self['会心几率'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['会心几率'])..'%|r 会心几率'..'\n'
        end    
        if self['会心伤害'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['会心伤害'])..'%|r 会心伤害'..'\n'
        end     
        if self['吸血'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['吸血'])..'%|r 吸血'..'\n'
        end     
        return str
    end,   

    level_tip = function(self)
        local str = ''
        if self.level <=3 then 
            if self.level <=2 then 
            str = str .. '|cffFFE799【进阶】|r收集 %kill_cnt% 灵魂，自动进阶\n|cffffe799【说明】|r杀怪20%获得灵魂|cff00ff00（受杀敌数加成影响）|r'
            else
            str = str ..'|cffFFE799【进阶】|r收集%kill_cnt%灵魂，并|cffff0000挑战伏地魔|r（新手任务处）后，自动进阶'
            end 
        else 
        
        end 
        return str
    end,    
    --升级特效
    effect ='Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdx',
    --物品详细介绍的title
    content_tip = '|cffFFE799基本属性：|r',
    --概率
    chance = 20
}


function mt:on_upgrade()
    local hero = self.owner
    if hero:get_owner().id >10 then 
        return 
    end    
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
                if item.level == item.max_level -1  then 
                    --4级时添加杀死的单位时伏地魔的判断
                    if item._count >= item.kill_cnt and target:get_name() == '伏地魔' then  
                        item:set_item_count(1)
                        item:upgrade(1)  
                        return 
                    end  
                end  
                --判断概率
                if math.random(100) > self.chance then 
                    return 
                end    
                --四舍五入
                local val = math.floor( 1*(1+hero:get('杀敌数加成')/100) +  0.5)
                item:add_item_count(val)
                --倒数第二级不能直接升，要打败伏地魔才能升。
                if item.level < item.max_level -1  then 
                    if item._count >= item.kill_cnt then 
                        item:add_item_count(-item.kill_cnt+1)
                        item:upgrade(1)
                    end      
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