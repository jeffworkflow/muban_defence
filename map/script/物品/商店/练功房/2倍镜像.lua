
local rect = require 'types.rect'

--物品名称
local mt = ac.skill['2倍镜像']
mt{
--等久
level = 1,

--图标
art = [[ReplaceableTextures\CommandButtons\BTNMirrorImage.blp]],

--说明
tip = [[挑战2倍全属性的镜像，成功奖励：
|cffffff00+25000|r 全属性
|cffffff00+1|r 英雄熟练度]],

--特殊id 带cd
type_id = 'EX00',

--物品类型
item_type = '神符',

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

--冷却
cool = 0,

content_tip = '',
--物品技能
is_skill = true,

}

function mt:on_cast_start()
    local hero = self.owner
    local p = hero:get_owner()
    hero = p.hero
    local ret = 'lgfsg'..p.id
    local name = '2倍镜像'..p.id

    -- local region = ac.map.rects['刷怪']

    -- 根据点击玩家 决定 小金币怪的刷新区域
    -- 只需要传入string 就行
    local cep = ac.creep[name]
    -- cep.region = region
    cep:set_region(ret)
    cep.owner = p
    local unit_name = hero.name
    cep.creeps_datas = unit_name .. '*1'
    cep.hero = hero
    cep:start()
    
end

ac.wait(10,function()
    for i = 1,10 do 
        local player = ac.player(i)
        if player:is_player() then 
            local name = '2倍镜像'..i
            local mt = ac.creep[name]{    
                creeps_datas = '',
                cool = 5*60,
                is_leave_region_replace = true,
                is_region_replace = true,
                ctime = 5*60 , --镜像持续时间
                cattr_mul = 1 , --镜像额外倍数
                call_attr = 25000 , --奖励全属性
                cmodel_size = 2 , --模型倍数
                chero_xp = 1 , --奖励英雄熟练度

            }  
            function mt:on_change_creep(unit,lni_data)
                -- print('打印：',name,self.index)
                local hero = self.hero
                unit.unit_type = 'unit'
                unit:remove_ability 'AInv'
                if self.cmodel_size then 
                    unit:set_size(self.cmodel_size) 
                end    
                local data = {}
                data.attribute ={
                    ['攻击'] = hero:get('攻击'),
                    ['护甲'] = hero:get('护甲') ,
                    ['攻击速度'] = hero:get('攻击速度'),
                    ['生命上限'] = hero:get('生命上限'),
                    ['魔法上限'] = hero:get('魔法上限'),
                    ['生命恢复'] = hero:get('生命恢复'),
                    ['魔法恢复'] = hero:get('魔法恢复'),
                    ['移动速度'] = hero:get('移动速度'),
                    ['暴击几率'] = hero:get('暴击几率'),
                    ['暴击加深'] = hero:get('暴击加深'),
                    ['会心几率'] = hero:get('会心几率'),
                    ['会心伤害'] = hero:get('会心伤害'),
                    ['魔抗'] = hero:get('护甲') ,
                }
                unit:add_buff '召唤物' {
                    time = self.ctime,
                    attribute = data.attribute,
                    attr_mul = self.cattr_mul, --增加倍数
                    skill = self.name
                }
               
                --设置搜敌范围
                unit:set_search_range(2000)

                unit:event '单位-死亡' (function(_,unit,killer) 
                    --召唤物杀死的也是算英雄的
                    local p = killer:get_owner()
                    local hero = p.hero
                    local name = hero.name
                    hero:add('力量',self.call_attr)
                    hero:add('敏捷',self.call_attr)
                    hero:add('智力',self.call_attr)
                    --增加英雄熟练度 
                    hero:add_hero_xp(self.chero_xp)
                end)    
            end
        end    
    end    

end)
