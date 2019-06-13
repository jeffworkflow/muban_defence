local config = {
    --品阶 =  颜色,全伤加深 全属性 免伤 触发概率
                
    ['凡'] = {'绿',25,100,1,1},
    ['玄'] = {'蓝',50,200,2,2},
    ['地'] = {'金',100,350,3,3},
    ['天'] = {'红',200,750,5,5},
}

--物品名称
local mt = ac.skill['虚无吞炎']
mt{
    --物品技能
    is_skill = true,
    level = 1 ,
    max_level = 11,
    tip = [[
%color_tip%     

%content_tip%   
+%全伤加深% 全伤加深
+%全属性% 全属性
+%免伤% % 免伤
+%触发概率% % 触发概率
]],
    --技能图标
    art = [[huo4.blp]],
    is_order = 1, --没显示等级，注释显示等级
    -- --名字显示
    title = function(self)
        return '|cff'..ac.color_code[self.color or '白']..'虚无吞炎Lv'..(self.level <self.max_level and self.level or 'max')..'|r'
    end    ,
    --颜色
    color = function(self)
        -- print(config[self.quality][1])
        return config[self.quality][1]
    end , 
    color_tip = function(self)
       return  '品阶：'..'|cff'..ac.color_code[self.color or '白']..self.quality..'|r'
    end,
    quality = '凡',
    --等级因素，等差数列，给出最小和最大即可
    lv_attr = {0,10,20,30,40,50,60,70,80,90,100},
    ['全伤加深'] = function (self)
        -- 等级因素 * 品阶因素
        return (1+self.lv_attr/100) * config[self.quality][2] 
    end,
    ['全属性'] = function (self)
        -- 等级因素 * 品阶因素
        return (1+self.lv_attr/100) * config[self.quality][3] 
    end,
    ['免伤'] = function (self)
        -- 等级因素 * 品阶因素
        return (1+self.lv_attr/100) * config[self.quality][4] 
    end,
    ['触发概率'] = function (self)
        -- 等级因素 * 品阶因素
        return (1+self.lv_attr/100) * config[self.quality][5] 
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

