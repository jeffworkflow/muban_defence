local japi = require("jass.japi")
local dbg = require 'jass.debug'
local unit = require 'types.unit'
local mt = ac.skill['宠物天赋']
mt{
    --必填
    is_skill = true,
    --初始等级
    max_level = 50,
    --标题颜色
    color =  '青',
    -- auto_fresh_tip = true,
	--介绍
    tip = [[可用天赋点：%remain_point%
%strong_attr_tip%
|cff00ffff点击可学习宠物天赋，可存档，食用宠物经验书|r
%need_xp_tip%
]],
    -- level = function(self,hero)
    --     if self and self.owner and self.owner:get_owner() then 
    --         local value = ac.GetServerValue(self.owner:get_owner(),'CWTF') or 0
	-- 		return math.max(value,1)
	-- 	end	
    -- end,   
    level = 1, 
	--技能图标
    art = [[chongwugou.blp]],
    model_size = function(self,hero)
        return 1 + self.level * 0.01
    end,    
    --已学习点数
    used_point = 0,
    --剩余学习点数
    remain_point = function(self,hero)
        return (self.level - self.used_point)
    end,
    strong_attr_tip = function(self,hero)
        local tip = ''
        local hero = self.owner:get_owner().hero 
        if hero.strong_attr then 
            for k,v in sortpairs(hero.strong_attr) do 
                -- print(hero,k,v[1],v[2])
                local sigle_value = v[1]
                local total_value = v[1] * v[2]
                local affict = '+'
                if v[1] < 0 then 
                    affict = ''
                end    

                local str = k:sub(-1)
                if str =='%' then 
                    k = k:sub(1,-2)
                    -- print('截取之后的字符串',k,k:sub(1,-2))
                    sigle_value = tostring(sigle_value) .. '%'
                    total_value = tostring(total_value) .. '%'
                end    
                -- print(value)
                v[4] = '|cff'..ac.color_code['淡黄']..affict.. sigle_value .. ' '..k..' ('..v[2]..'/'..v[3]..')'

                local total_tip = '|cff'..ac.color_code['淡黄']..affict.. total_value .. ' '..k..' ('..v[2]..'/'..v[3]..')'

                if v[2] ~= 0 then 
                    tip = tip ..total_tip..'|r\n' 
                end    
            end    
        end    
        return tip 
    end,  
    need_xp_tip =  function(self,hero )
        return '升级还需经验：'..'|cff'..ac.color_code['红']..self.need_xp..'|r'
    end,
    need_xp = 1000,
    effect =  [[Hero_CrystalMaiden_N2_V_boom.mdx]],   
    
    --测试
    -- test21 =0
	
}
-- local strong_attr = {
-- }

-- local strong_attr = {
--     {'力量 3% 5'},
--     {'敏捷 3% 5'},
--     {'智力 3% 5'},
--     {'攻击 3% 5'},
--     {'减免 3% 5'},
--     {'攻击间隔 -2% 5'},
--     {'物品获取率 3% 5'},
--     {'金币获取率 3% 5'},
--     {'技能获取率 3% 5'},
--     {'积分加成 3% 5'},
-- }
--每次升级增加 宠物模型大小
function mt:on_upgrade()
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    hero:set_size(self.model_size)
    -- print(self.effect)
    --升级特效
    local eff = ac.effect(hero:get_point(),self.effect,0,1,'chest'):remove()
end    
function mt:on_add()
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    hero:set_size(self.model_size) 
    p.hero.strong_attr = {
        ['力量%'] = {3,0,5},
        ['敏捷%'] = {3,0,5},
        ['智力%'] = {3,0,5},
        ['攻击%'] = {3,0,5},
        ['减免%'] = {3,0,5},
        ['攻击间隔'] = {-0.02,0,5},
        ['物品获取率%'] = {3,0,5},
        ['金币加成%'] = {3,0,5},
        ['经验加成%'] = {3,0,5},
        ['积分加成'] = {0.02,0,5},
    }

    local value = tonumber(p:Map_GetServerValue('CWTF'))
    if not value or value == '' or value == "" then
        value = 0 
    end
    if value > 0 then
        hero:peon_add_xp(value)
    end    

end
function mt:on_cast_start()
    -- if self.is_choosed then 
    --     player:sendMsg("已经选择称号，不可修改")
    --     return 
    -- end   
    local skill = self 
    local hero = self.owner
    local player = hero:get_owner()
    hero = player.hero
    
    if self.remain_point <=0 then 
        player:sendMsg('天赋技能点数不足')
        return 
    end    
    -- print(self.auto_fresh_tip)
    -- local tab = self.strong_attr
    -- -- tab['力量%'][2] = 10
    -- self:set('strong_attr',tab) 
    -- print(tab['力量%'][4])
    local strong_attr = hero.strong_attr
    local list = {}
    
        
    for k,v in sortpairs(strong_attr) do 
        -- print(hero,k,v[1],v[2])
        if v[2] < v[3] then
            local info = {
                name = v[4],
                attr = k,
                value = v[1],
            }
            table.insert(list,info)     
        end    
    end    


    if #list <= 0 then
        player:sendMsg("没有可学习的技能了")
        return
    end 

    local info = {
        name = '取消',
        key = 512
    }
    table.insert(list,info)
    
    if not self.dialog  then 
        self.dialog = create_dialog(player,'学习天赋，剩余('..self.remain_point..')',list,
        function (index)
            self.dialog = nil
            local attr = list[index].attr
            local value = list[index].value
            if attr then 
                hero.strong_attr[attr][2] =  hero.strong_attr[attr][2] + 1
                -- self:set('strong_attr',tab) 
                self.used_point = self.used_point + 1
                self:set('used_point',self.used_point) 
                self:fresh_tip()
                --增加属性
                hero:add_tran(attr,value)
                self.remain_point = self.level - self.used_point
                if self.remain_point >0 then
                    self:on_cast_start()
                end    
            else       
                  
            end 
        end)
    end   

end    
--移除会出错，不能移除
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    hero = p.hero
   
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
    if self.eff then 
        self.eff:remove()
        self.eff = nil
    end   
    
    -- hero:add('金币加成',-self.map_level)
    -- hero:add('经验加成',-self.map_level)
    -- hero:add('物品获取率',-self.map_level)
    
end
-- 1 1000
-- 2 3000
-- 3 6000
--获得升级所需要的经验
function unit.__index:peon_get_upgrade_xp(lv)
    local lv = lv or 0
    if lv >0 then 
        return self:peon_get_upgrade_xp(lv-1) + lv *1000	 
    else 
        return 0
    end        
end   

--获得经验对应的等级
function unit.__index:peon_get_lv_by_xp(xp)
    local xp = xp or 0
    local lv = 1
  
    local flag = true 
    while flag do
        flag = false  
        local total_xp = self:peon_get_upgrade_xp(lv)
        if xp < total_xp then 
            lv = lv + 1
            flag = true
        end    
    end    
	return lv 
end   

--增加经验
function unit.__index:peon_add_xp(xp)
    local player = self:get_owner()
    self.peon_xp = (self.peon_xp or 0) + xp 
    --保存经验到服务器存档
    player:Map_SaveServerValue('CWTF',tonumber(self.peon_xp))

        --升级
    self.peon_lv = self.peon_lv or 1
    local flag = true 
    while flag do
        flag = false  
        local need_xp = self:peon_get_upgrade_xp(self.peon_lv) - self.peon_xp
        local name = self:get_name()
        -- name = name ..'-Lv'..self.peon_lv ..'(升级所需经验：'..need_xp..')'
        -- name = '升级所需经验：'..'|cff'..ac.color_code['红']..need_xp..'|r'
        -- print(name)
        local skill = self:find_skill('宠物天赋')
        if skill then
            --更改宠物天赋的tip显示
            skill:set('need_xp',need_xp)
            skill:fresh_tip()
        end 

        if self.peon_xp >= self:peon_get_upgrade_xp(self.peon_lv) then
            flag = true
            self.peon_lv = self.peon_lv + 1
            skill:upgrade(1)
            ac.game:event_notify('宠物升级',self)
        end 
    end
   

    --改变宠物的名字 不是英雄单位无法修改
    -- japi.EXSetUnitArrayString(base.string2id(self.id), 61, 0, name)

	return unit	 
end  



--宠物经验书处理
--物品名称
local mt = ac.skill['宠物经验书']
mt{
--等久
level = 1,

--图标
art = [[ReplaceableTextures\CommandButtons\BTNScroll.blp]],

--说明
tip = [[+%xp% 宠物天赋经验]],

--品质
color = '紫',

--物品类型
item_type = '消耗品',

--不能被当做合成的材料，也不能被合出来 后续处理。
-- is_not_hecheng = true,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

--冷却
cool = 0.5,
--经验
xp = 200,
--购买价格
gold = 0,

--物品数量
_count = 1,
--物品模型
specail_model = [[ScrollHealing.mdx]],
model_size = 2,
titile = '|cffff0000宠物经验书|r',
--物品详细介绍的title
content_tip = '使用说明：'
}


function mt:on_cast_start()
    local hero = self.owner
    local player = hero:get_owner()
    hero = player.peon
    hero:peon_add_xp(self.xp)
end


--宠物经验书掉落
-- 8%掉落
local rate = 8
ac.game:event '单位-死亡' (function (_,unit,killer)
    -- 无尽可掉落
    -- if ac.creep['刷怪-无尽'].index >= 1 then 
    --     return 
    -- end    
    if unit and unit.data and unit.data.type =='boss' then 
        -- print(unit)
        local rand = math.random(1,100)
        if rand < rate then 
           ac.item.create_item('宠物经验书',unit:get_point())
        end
    end    
end)