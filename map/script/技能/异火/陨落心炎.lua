local config = {
    --品阶 =  颜色,物暴加深，几率，全属性，免伤几率，免伤几率                 
    ['凡'] = {'绿',200,2,3000000,50,2},
    ['玄'] = {'蓝',400,4,5000000,100,4},
    ['地'] = {'金',600,6,7000000,150,6},
    ['天'] = {'红',1000,10,8500000,200,10},
}

--物品名称
local mt = ac.skill['陨落心炎']
mt{
    --物品技能
    is_skill = true,
    level = 1 ,
    max_level = 11,
    tip = [[

%xxzhtip%
|cffFFE799【基本属性】
|cffffff00+%全属性%  |cff00ff00全属性
|cffffff00+%暴击几率% |cffffff00%  |cff00ff00暴击几率
|cffffff00+%暴击加深% |cffffff00% |cff00ff00暴击加深
|cffffff00+%物理伤害加深% |cffffff00%  |cff00ff00物理伤害加深
|cffffff00+%免伤几率% |cffffff00%  |cff00ff00免伤几率|r
]],
    xxzhtip = function(self)
        return  '|cffffe799【品阶】|r'..'|cff'..ac.color_code[self.color or '白']..self.quality..'|r \n'
    end,

    item_type_tip = function(self)
        return  ''
    end,  

    color_tip = function(self)
        return  ''
    end,

    content_tip = '|cffFF0000【点击可吞噬入体，相同异火只能吞噬一次】|r\n',

    --技能图标
    art = [[huo2.blp]],
    is_order = 1, --没显示等级，注释显示等级
    item_type ='消耗品', --
    not_use_state = true, -- 不可使用消耗品
    -- --名字显示
    title = function(self)
        return '|cff'..ac.color_code[self.color or '白']..'陨落心炎Lv'..(self.level <self.max_level and self.level or 'max')..'|r'
    end    ,
    --颜色
    color = function(self)
        -- print(config[self.quality][1])
        return config[self.quality][1]
    end , 
    
    quality = '凡',
    --等级因素，等差数列，给出最小和最大即可
    lv_attr = {0,10,20,30,40,50,60,70,80,90,100},
    ['暴击加深'] = function (self)
        -- 等级因素 * 品阶因素
        return (1+self.lv_attr/100) * config[self.quality][2] 
    end,
    ['暴击几率'] = function (self)
        -- 等级因素 * 品阶因素
        return (1+self.lv_attr/100) * config[self.quality][3] 
    end,
    ['全属性'] = function (self)
        -- 等级因素 * 品阶因素
        return (1+self.lv_attr/100) * config[self.quality][4] 
    end,
    ['物理伤害加深'] = function (self)
        -- 等级因素 * 品阶因素
        return (1+self.lv_attr/100) * config[self.quality][5] 
    end,
    ['免伤几率'] = function (self)
        -- 等级因素 * 品阶因素
        return (1+self.lv_attr/100) * config[self.quality][6] 
    end,
    --升级特效
    effect ='Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdx',
}

function mt:on_upgrade()
    local hero = self.owner
    -- print(self.life_rate_now)   
    hero:add_effect('chest',self.effect):remove()
    -- self:set_name(self.name)
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
