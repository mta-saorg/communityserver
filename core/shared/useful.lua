function removeHexCodes(str)
	assert(type(str) == 'string', 'Bad Argument @removeHexCodes')
	
	return str:gsub('#%x%x%x%x%x%x', '')
end

function isNumric(number)
	return tonumber(number) ~= false
end

function getCurrentTime(timestamp)
	if type(timestamp) ~= 'number' then
		timestamp = getRealTime().timestamp
	end
	
	timestamp = getRealTime(timestamp)
	return ('%02:%02d:%02d'):format(timestamp.hour, timestamp.minute, timestamp.second)
end

function getCurrentDate(timestamp)
	if type(timestamp) ~= 'number' then
		timestamp = getRealTime().timestamp
	end
	
	timestamp = getRealTime(timestamp)
	return ('%02d.%02d.%d'):format(timestamp.monthday, timestamp.month + 1, timestamp.year + 1900)
end

-- Element Functions
function getElementSpeed(element,unit)
	if (unit == nil) then unit = 0 end
	if (isElement(element)) then
		local x,y,z = getElementVelocity(element)
		if (unit=="mph" or unit==1 or unit =='1') then
			return (x^2 + y^2 + z^2) ^ 0.5 * 100
		else
			return (x^2 + y^2 + z^2) ^ 0.5 * 1.8 * 100
		end
	else
		outputDebugString("Not an element. Can't get speed")
		return false
	end
end

function setElementSpeed(element, unit, speed)
	if (unit == nil) then unit = 0 end
	if (speed == nil) then speed = 0 end
	speed = tonumber(speed)
	local acSpeed = getElementSpeed(element, unit)
	if (acSpeed~=false) then
		local diff = speed/acSpeed
		local x,y,z = getElementVelocity(element)
		setElementVelocity(element,x*diff,y*diff,z*diff)
		return true
	end
 
	return false
end

-- Math Functions
function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

-- Table Functions
function table.copy(tab, recursive)
    local ret = {}
    for key, value in pairs(tab) do
        if (type(value) == "table") and recursive then ret[key] = table.copy(value)
        else ret[key] = value end
    end
    return ret
end

function table.compare( a1, a2 )
	if 
		type( a1 ) == 'table' and
		type( a2 ) == 'table'
	then
 
		local function size( t )
			if type( t ) ~= 'table' then
				return false 
			end
			local n = 0
			for _ in pairs( t ) do
				n = n + 1
			end
			return n
		end
 
		if size( a1 ) == 0 and size( a2 ) == 0 then
			return true
		elseif size( a1 ) ~= size( a2 ) then
			return false
		end
 
		for _, v in pairs( a1 ) do
			local v2 = a2[ _ ]
			if type( v ) == type( v2 ) then
				if type( v ) == 'table' and type( v2 ) == 'table' then
					if size( v ) ~= size( v2 ) then
						return false
					end
					if size( v ) > 0 and size( v2 ) > 0 then
						if not table.compare( v, v2 ) then 
							return false 
						end
					end	
				elseif 
					type( v ) == 'string' or type( v ) == 'number' and
					type( v2 ) == 'string' or type( v2 ) == 'number'
				then
					if v ~= v2 then
						return false
					end
				else
					return false
				end
			else
				return false
			end
		end
		return true
	end
	return false
end

function table.merge(table1,...)
    for _,table2 in ipairs({...}) do
        for key,value in pairs(table2) do
            if (type(key) == "number") then
                table.insert(table1,value)
            else
                table1[key] = value
            end
        end
    end
    return table1
end

