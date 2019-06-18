--物品名称
local mt = ac.skill['勇气之证']
mt{
    --物品技能
    is_skill = true,
    
    level = 1 ,
    max_level = 7,
    --颜色
    color = '紫',
    tip = [[
+%attack% 攻击
+%life% 生命
+%defence% 护甲

|cffFFE799【进阶】|r 杀死 %kill_cnt% 个敌人，自动进阶]],

    --技能图标
    art = [[other\zheng_201.blp]],
    --攻击
    attack = {250,1000,4000,15000,50000,120000,120000},
    --生命
    life = {500,2000,8000,30000,100000,240000,240000},
    --护甲
    defence = {25,50,100,200,300,450,450},
    --杀敌个数
    kill_cnt = {125,125,125,125,125,125,125},
    --唯一
    unique = true,
    --显示等级
    show_level = true,
    --物品详细介绍的title
    content_tip = '基本属性：'
}


mt.attack_now = 0
mt.life_now = 0
mt.defence_now = 0

function mt:on_upgrade()
    local hero = self.owner
    -- print(self.life_rate_now)   
    hero:add_effect('chest',self.effect)
    self:set_name(self.name)

	hero:add('攻击', -self.attack_now)
	self.attack_now = self.attack
	hero:add('攻击', self.attack)

	hero:add('生命上限', -self.life_now)
	self.life_now = self.life
	hero:add('生命上限', self.life)

	hero:add('护甲', -self.defence_now)
	self.defence_now = self.defence
    hero:add('护甲', self.defence)

    if not self.trg then 
        self.trg = ac.game:event '单位-杀死单位' (function(trg, killer, target)
            --召唤物杀死也继承
            local hero = killer:get_owner().hero
            if hero ~= self.owner then 
                return 
            end    
            if hero and hero:has_item(self.name) and (hero == self.owner) then 
                local item = hero:has_item(self.name)
                item:add_item_count(1)
                if item._count >= item.kill_cnt then 
                    item:add_item_count(-item.kill_cnt+1)
                    item:upgrade(1)

                    if item.level >= item.max_level then 
                        item:item_remove()
                        -- hero:remove_item(self)
                        hero:add_item('霸者之证',true)
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
    
    hero:add('攻击',self.attack)
    hero:add('生命上限',self.life)
    hero:add('护甲',self.defence)

    if not self.trg then 
        self.trg = ac.game:event '单位-杀死单位' (function(trg, killer, target)
            --召唤物杀死也继承
            local hero = killer:get_owner().hero
            if hero ~= self.owner then 
                return 
            end    
            if hero and hero:has_item(self.name) and (hero == self.owner) then 
                local item = hero:has_item(self.name)
                item:add_item_count(1)
                if item._count >= item.kill_cnt then 
                    item:add_item_count(-item.kill_cnt+1)
                    item:upgrade(1)

                    if item.level >= item.max_level then 
                        item:item_remove()
                        -- hero:remove_item(self)
                        hero:add_item('霸者之证',true)
                    end
                end    
            end    
        end)
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

end