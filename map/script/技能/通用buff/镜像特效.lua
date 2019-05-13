local mt = ac.buff['镜像特效']
--BUFF在镜像创建时添加
--负责显示创建镜像时的特效
--和镜像单位死亡时的特效
mt.create = [[Abilities\Spells\Orc\MirrorImage\MirrorImageCaster.mdl]]
mt.dead = [[Abilities\Spells\Orc\MirrorImage\MirrorImageDeathCaster.mdl]]

function mt:on_add()
	self.target:add_effect('origin',self.create)
end

function mt:on_remove()
	ac.point_effect(self.target:get_point(),{model = self.dead}):remove()
	--ac.effect(self.target:get_point(),self.dead,0,1)
end