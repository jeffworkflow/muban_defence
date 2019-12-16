local math = math

--弧度去死吧
local deg = math.deg(1)
local rad = math.rad(1)

--正弦
local sin = math.sin
function math.sin(r)
	return sin(r * rad)
end

--余弦
local cos = math.cos
function math.cos(r)
	return cos(r * rad)
end

--正切
local tan = math.tan
function math.tan(r)
	return tan(r * rad)
end

--反正弦
local asin = math.asin
function math.asin(v)
	return asin(v) * deg
end

--反余弦
local acos = math.acos
function math.acos(v)
	return acos(v) * deg
end

--反正切
local atan = math.atan
function math.atan(v1, v2)
	return atan(v1, v2) * deg
end

function math.frexp(n)
	if n == 0 then 
		return 0,0
	end	
	for i=64,0,-1 do 
		local t = math.floor(n / 2^i)
		if t >0 then 
			return tonumber(string.format("%.f",n/2^(i+1))),i+1
		else 	
			n = n % 2^i
		end	
	end	
end	
