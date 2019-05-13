local mt = ac.skill['新人寻宝石']

mt{
    --等久
    level = 1,
    
    --图标
    art = [[other\xunbaoshi101.blp]],
    
    --说明
    tip = [[到指定地点，挖开即可得 |cffdf19d0 %target_item% (成长型神器)|r]],
    
    --物品类型
    item_type = '消耗品',
    
    --挖到的物品
    target_item = '勇气之证',
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    
    --物品技能
    is_skill = true,
    --挖图范围
    area = 600,
    --物品详细介绍的title
    content_tip = '使用说明：'
    
}
    
function mt:on_add()
    --全图随机刷
    -- local minx, miny, maxx, maxy = ac.map.rects['刷怪']:get()
    -- self.random_point =  ac.point(math.random(minx,maxx),math.random(miny,maxy))
    self.random_point =  ac.map.rects['刷怪']:get_point()
    
end

function mt:on_cast_start()
    local hero = self.owner
    local player = hero:get_owner()
    local item = self 
    local list = {}
    --需要先增加一个，否则消耗品点击则无条件先消耗
    self:add_item_count(1) 

    local tx,ty = self.random_point:get()
    local rect = ac.rect.create( tx - self.area/2, ty-self.area/2, tx + self.area/2, ty + self.area/2)
    local region = ac.region.create(rect)
    local point = hero:get_point()

    
    --点在区域内
    if region < point  then 
        self:add_item_count(-1) 
        self:on_add() 
        --满了掉地上
        hero:add_item(self.target_item,true)
    else
        player:pingMinimap(self.random_point, 3)
    end    

end    

function mt:on_remove()

end