local mt = ac.skill['天空的宝藏会员']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 0,
    --魔法书
    is_order = 1,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--介绍
	tip = [[%active%
|cffffff00特权1：|r每10波赠送一个随机物品（共7个，纯随机，人品好可能出金装红装）
|cffffff00特权2：|r物品获取率+25%]],
    --是否激活状态
    active = function(self)
        local res = [[|cff00bdec需要：
 - 通过【官方商城】获得|r]]
        if self.level >=1 then 
            res = ''
        end    
        return res
    end,   
	--技能图标
	art = [[hy.blp]],
	--特效
	effect = [[]],
	--物品获取率
	fall_rate = 25,
	
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    if not hero:is_hero() then return end
    local player = hero:get_owner()
    hero:add('物品获取率',self.fall_rate)

    
    --开局得一个随机装备,之后每10波随机得到一个装备
    if self.trg then self.trg:remove() end

    local function give_rand_item()
        --给英雄随机添加物品
        local name = ac.all_item[math.random( 1,#ac.all_item)]
        --满时，掉在地上
        if hero:is_alive() then 
            hero:add_item(name,true) 
        else
            ac.item.create_item(name,hero:get_point())
        end    

        local lni_color ='白'
        if  ac.table.ItemData[name] and ac.table.ItemData[name].color then 
            lni_color = ac.table.ItemData[name].color
        end    
        player:sendMsg('【系统消息】生存会员特权触发： 随机获得 |cff'..ac.color_code[lni_color]..name..'|r',10)
    end
    --第0波时先给一个随机物品
    if ac.creep['刷怪'].index == 0 then 
        give_rand_item()
    end    
    self.trg = ac.game:event '游戏-回合开始'(function(trg,index, creep) 
        if creep.name ~= '刷怪' then
            return
        end    
        print('回合开始5')
        --取余数,为0 得给物品
        local value = ac.creep['刷怪'].index % 10
        if value == 0 then 
            give_rand_item()
        end    
    end)    
    
end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
    
    hero:add('物品获取率',-self.fall_rate)
end
