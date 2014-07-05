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

function table.size(tab)
	local i = 0
	for k in pairs(tab) do
		i = i + 1
	end
	return i
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

-- Hacked in from runcode
function runString (commandstring, outputTo, source)
	local sourceName
	if source then
		sourceName = getPlayerName(source)
	else
		sourceName = "Console"
	end
	outputChatBox(sourceName.." executed command: "..commandstring, root)
	local notReturned
	--First we test with return
	local commandFunction,errorMsg = loadstring("return "..commandstring)
	if errorMsg then
		--It failed.  Lets try without "return"
		notReturned = true
		commandFunction, errorMsg = loadstring(commandstring)
	end
	if errorMsg then
		--It still failed.  Print the error message and stop the function
		outputChatBox("Error: "..errorMsg)
		return
	end
	--Finally, lets execute our function
	results = { pcall(commandFunction) }
	if not results[1] then
		--It failed.
		outputChatBox("Error: "..results[2])
		return
	end
	if not notReturned then
		local resultsString = ""
		local first = true
		for i = 2, #results do
			if first then
				first = false
			else
				resultsString = resultsString..", "
			end
			local resultType = type(results[i])
			if isElement(results[i]) then
				resultType = "element:"..getElementType(results[i])
			end
			resultsString = resultsString..tostring(results[i]).." ["..resultType.."]"
		end
		outputChatBox("Command results: "..resultsString)
	elseif not errorMsg then
		outputChatBox("Command executed!")
	end
end

function outputDebug(errmsg)
	if DEBUG then
		outputDebugString((triggerServerEvent and "CLIENT " or "SERVER ")..tostring(errmsg))
	end
end

LOREM_IPSUM = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."
