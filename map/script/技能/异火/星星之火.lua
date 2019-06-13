local config = {
    --品阶 =  颜色,减甲，全属性，每秒回血                 
    ['凡'] = {'绿',5,100,1},
    ['玄'] = {'蓝',10,200,2},
    ['地'] = {'金',20,350,3},
    ['天'] = {'红',40,750,5},
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
+%全属性% 全属性
+%减甲% 减甲
+%每秒回血% % 每秒回血
]],
    --技能图标
    art = [[huo1.blp]],
    is_order = 1, --没显示等级，注释显示等级
    -- --名字显示
    title = function(self)
        return '|cff'..ac.color_code[self.color or '白']..'星星之火Lv'..(self.level <self.max_level and self.level or 'max')..'|r'
    end    ,
    --颜色
    color = function(self)
        -- print(config[self.quility][1])
        return config[self.quility][1]
    end , 
    color_tip = function(self)
       return  '品阶：'..'|cff'..ac.color_code[self.color or '白']..self.quility..'|r'
    end,
    quility = '凡',
    --等级因素，等差数列，给出最小和最大即可
    lv_attr = {0,10,20,30,40,50,60,70,80,90,100},
    ['减甲'] = function (self)
        -- 等级因素 * 品阶因素
        return (1+self.lv_attr/100) * config[self.quility][2] 
    end,
    ['全属性'] = function (self)
        -- 等级因素 * 品阶因素
        return (1+self.lv_attr/100) * config[self.quility][3] 
    end,
    ['每秒回血'] = function (self)
        -- 等级因素 * 品阶因素
        return (1+self.lv_attr/100) * config[self.quility][4] 
    end,
    --升级特效
    effect ='Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdx',
    --物品详细介绍的title
    content_tip = '|cffFFE799基本属性：|r',
}

function mt:on_upgrade()
    local hero = self.owner
    -- print(self.life_rate_now)   
    hero:add_effect('chest',self.effect):remove()
    -- self:set_name(self.name)
end

