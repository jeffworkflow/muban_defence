
local table = table
local rect = require 'types.rect'
local creeps = {}
creeps.group = {
	--位置,怪物名*N,出生时间,刷新时间
	{'sjjh1', '鸡*15', 10, 2},
	{'sjjh2', '鸡*15', 10, 2},
    {'sjjh3', '鸡*15', 10, 2},
    
	{'xxzh11', '星星之火守卫*15', 10, 2},
	{'xxzh12', '星星之火守卫*15', 10, 2},
	{'xxzh13', '星星之火守卫*15', 10, 2},
    {'xxzh14', '星星之火守卫*15', 10, 2},
    
	{'ylxy11', '陨落心炎守卫*15', 10, 2},
	{'ylxy12', '陨落心炎守卫*15', 10, 2},
	{'ylxy13', '陨落心炎守卫*15', 10, 2},
	{'ylxy14', '陨落心炎守卫*15', 10, 2},
    
	{'sqyyh11', '三千焱炎火守卫*15', 10, 2},
	{'sqyyh12', '三千焱炎火守卫*15', 10, 2},
	{'sqyyh13', '三千焱炎火守卫*15', 10, 2},
	{'sqyyh14', '三千焱炎火守卫*15', 10, 2},
    
	{'xwty11', '虚无吞炎守卫*15', 10, 2},
	{'xwty12', '虚无吞炎守卫*15', 10, 2},
	{'xwty13', '虚无吞炎守卫*15', 10, 2},
    {'xwty14', '虚无吞炎守卫*15', 10, 2},
    
	{'cbt11', '强盗*15', 10, 2},
    {'cbt12', '强盗*15', 10, 2},
    
}
--开始刷野
function creeps.start()
	--刷野玩家
	local creep_player = ac.player[13]
	--对每个野怪点分别计算
	for _, data in ipairs(creeps.group) do
		local rect_name, creeps_names, start_time, revive_time = table.unpack(data)
		--刷怪区域
		local rct = rect.j_rect(rect_name)
		--野怪单位组
        local creep_groop = {}
        local creeps_datas = {}
		--野怪数据
        for k,v in creeps_names:gmatch '(%S+)%*(%d+%s-)' do
            creeps_datas[k]=v
        end
		--创建该野怪点的野怪
		local function create()
            for k,v in pairs(creeps_datas) do 
                local name  = k
                local max_cnt = tonumber(v)
                local count = max_cnt - (#creep_groop or 0)
                for i = 1, count do
                    local point = rct:get_random_point()
                    -- print(name,point)
                    local u = ac.player(12):create_unit(name, point, 270)
                    -- print(u)
                    -- u:add_ability 'A00V'
                    --将单位添加进单位组
                    table.insert(creep_groop, u)
                    --监听这个单位挂掉
                    u:event '单位-死亡' (function(_,unit,killer)
                        for _, uu in ipairs(creep_groop) do
                            if uu.handle == unit.handle then 
                                table.remove(creep_groop,_)
                                break
                            end    
                        end
                        unit:remove() --立即删除 不产生尸体
                    end)  
                end
            end    
		end
        
		--刷第一波野
        ac.wait(start_time * 1000, create)
        --每2秒检测一次，不满最大单位数量，就补充
        ac.loop(revive_time *1000,create)
	end
end
--加载完直接刷怪
creeps.start()













