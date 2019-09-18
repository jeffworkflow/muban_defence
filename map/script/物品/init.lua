require '物品.装备'
require '物品.消耗品'
require '物品.杂类'
require '物品.商店'
require '物品.合成装备'
require '物品.套装'
require '物品.特殊处理'
require '物品.黑色物品'
require '物品.超神器'

local unit = require 'types.unit'



--创建技能物品
function ac.item.create_skill_item(name,poi,is)

    local item = ac.item.create_item('学习技能',poi,is)
    -- 技能需要被添加时部分信息才能被调用
    local skill = ac.dummy:add_skill(name,'隐藏')
    local tip = skill:get_simple_tip(ac.dummy,1)
    local title = skill:get_title(ac.dummy,1)
    local art = skill:get_art()
    item.gold = skill.gold
    skill:remove()

    item:set_name(name) 
    item.skill_name = name
    item.tip =  (tip or '') .. '|cff808080当技能学满后，点击可替换已学技能|r' 
    item:set_art(art)
    item.art = art
	--混合图标处理
	local blend = item.blend or ac.blend_file[item.color or 'nil'] 
	if blend then 
		item.owner = ac.dummy
		item:add_blend(blend, 'frame', 2)
		item.owner = nil
    end
    
    item:set_tip(item.tip)
    
    -- print(skill.name,item.tip,art,item.art)
	-- if not is then 
	-- 	item._eff = ac.effect(item:get_point(),item._model,270,1,'origin')
    -- end
    
    item.item_type = '消耗品'
    --设置使用次数
    item:set_item_count(1)
    
    return item
    -- item:update()
    -- item:update_ui()
end 

--给英雄添加技能物品
--默认是 满格掉落地上，从商店购买时才阻止返回
--英雄死亡时，添加物品没法添加
function ac.item.add_skill_item(it,hero,is_drop)
	if type(it) =='string'  then 	
		it = ac.item.create_skill_item(it,nil,true)
		it:hide()
		it.recycle = true
    end	
    if not is_drop then 
        --如果英雄满物品，创建在地上
        hero:add_item(it,true)
    else
        hero:add_item(it)
    end    

    
    return it
end 

function unit.__index:add_skill_item(it,is_drop)
	if type(it) =='string'  then 	
		it = ac.item.create_skill_item(it,nil,true)
		it:hide()
		it.recycle = true
    end	
    if not is_drop then 
        --如果英雄满物品，创建在地上
        self:add_item(it,true)
    else
        self:add_item(it)
    end    
    return it
end    
