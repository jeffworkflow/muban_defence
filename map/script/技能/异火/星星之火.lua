local config = {
    --品阶 =  颜色,减甲，全属性，每秒回血                 
    ['凡'] = {'绿',5,1000000,1},
    ['玄'] = {'蓝',10,2000000,2},
    ['地'] = {'金',20,3500000,3},
    ['天'] = {'红',40,7500000,5},
}

--物品名称
local mt = ac.skill['星星之火']
mt{
    --物品技能
    is_skill = true,
    level = 1 ,
    max_level = 11,
    tip = [[

%color_tip%

%content_tip%
|cffffff00+%全属性% |cff00ff00全属性
|cffffff00+%减甲%     |cff00ff00减甲
|cffffff00+%每秒回血% |cffffff00%|r   |cff00ff00每秒回血|r

]],
    --技能图标
    art = [[huo1.blp]],
    is_order = 1, --没显示等级，注释显示等级
    item_type ='消耗品', --
    not_use_state = true, -- 不可使用消耗品
    -- --名字显示
    title = function(self)
        return '|cff'..ac.color_code[self.color or '白']..'星星之火Lv'..(self.level <self.max_level and self.level or 'max')..'|r'
    end    ,
    --颜色
    color = function(self)
        -- print(config[self.quality][1])
        return config[self.quality][1]
    end , 
    color_tip = function(self)
       return  '|cffffe799【品阶】：|r'..'|cff'..ac.color_code[self.color or '白']..self.quality..'|r'
    end,
    quality = '凡',
    --等级因素，等差数列，给出最小和最大即可
    lv_attr = {0,10,20,30,40,50,60,70,80,90,100},
    ['减甲'] = function (self)
        -- 等级因素 * 品阶因素
        return (1+self.lv_attr/100) * config[self.quality][2] 
    end,
    ['全属性'] = function (self)
        -- 等级因素 * 品阶因素
        return (1+self.lv_attr/100) * config[self.quality][3] 
    end,
    ['每秒回血'] = function (self)
        -- 等级因素 * 品阶因素
        return (1+self.lv_attr/100) * config[self.quality][4] 
    end,
    --升级特效
    effect ='Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdx',
    --物品详细介绍的title
    content_tip = '|cffFFE799【基本属性】：|r',
}

function mt:on_upgrade()
    local hero = self.owner
    hero:add_effect('chest',self.effect):remove()
    -- self:set_name(self.name)
end
function mt:on_add()
    -- self:set('item_type','无') 
end    
function mt:on_cast_start()
    local unit = self.owner
    local hero = self.owner
    local player = hero:get_owner()
    local name = self:get_name()
    hero = player.hero

    local skl = hero:find_skill(self.name,nil,true)
    if skl then 
        if self.add_item_count then  
            player:sendMsg('|cffffe799【系统消息】|r|cffffff00体内已有'..self.name..' 吞噬失败|r',2)
             self:add_item_count(1) 
        end        
    else
        ac.game:event_notify('技能-插入魔法书',hero,'异火',self.name)
        player:sendMsg('|cffffe799【系统消息】|r|cff00ff00吞噬'..self.name..'成功|r 吞噬后的属性可以在异火系统中查看',2)
        --改变技能里面的 item_type 
        local new_skl =  hero:find_skill(self.name,nil,true)
        if new_skl then 
            new_skl.item_type = '装备'
            ac.game:event_notify('技能-升级',hero,new_skl)
        end    
    end   
end



