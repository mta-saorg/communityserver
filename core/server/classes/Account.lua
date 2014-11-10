local passwortSalt = ""
local maxAccounts = 2

local dataToSave =
{
	"Account",
	"Passwort",
	"Punkte",
	"Geld",
	"Gruppe"
}

Account = inherit(Singleton)

function Account:constructor()
	addEvent("onAccountRegister", true)
	addEvent("onAccountLogin", true)
	
	addEventHandler("onAccountRegister", resourceRoot, bind(self.createAccount, self))
	addEventHandler("onAccountLogin", resourceRoot, bind(self.checkLogin, self))
end

function Account:checkAccount()
	local result = MySQL:queryFetch("SELECT `ID` FROM `accounts` WHERE `Account` = ?", client:getName())
	triggerClientEvent(client, "onClientReceiveAccountCheck", resourceRoot, not (result and #result >= 1))
end

function Account:checkLogin(passwort)
	if(type(passwor) and passwort:len() >= 5 and passwort:len() <= 20) then
		passwort = self:generatePasswort(passwort)
		local result = MySQL:queryFetch("SELECT * FROM `accounts` WHERE `Account` = ? AND `Passwort` = ?", client:getName(), passwort)	
		if(result and #result >= 1) then
			for field, value in pairs(result[1]) do
				client:setInfo(field, value)
			end
			triggerClientEvent(client, "onClientReceiveAccountCheck", resourceRoot, nil)
			
			client:setInfo("loggedin", true)
			PlayerManager:getSingleton():onPlayerLogin(client)
		end
	else outputChatBox("Das Passwort muss zwischen 5 und 20 Zeichen lang sein!", client, 255, 100, 100) end
end

function Account:createAccount(passwort)
	if(type(passwort) == "string" and passwort:len() >= 5 and passwort:len() <= 20) then
		local result = MySQL:queryFetch("SELECT `ID` FROM `accounts` WHERE `Serial` = ?", getPlayerSerial(client))
		if(result and #result < maxAccounts) then
			result = MySQL:queryFetch("SELECT `ID` FROM `accounts` WHERE `Account` = ?", client:getName())
			if(result and #result == 0) then
				passwort = self:generatePasswort(passwort)
				local result, _, ID = MySQL:queryFetch("INSERT INTO `accounts` (`Account`, `Passwort`, `Serial`) VALUES(?, ?, ?)", client:getName(), passwort, getPlayerSerial(client))
				if(result and ID) then
					client:setInfo("ID", ID)
					client:setInfo("loggedin", true)
					triggerClientEvent(client, "onClientReceiveAccountCheck", resourceRoot, nil)
					PlayerManager:getSingleton():onPlayerRegister(client)
				end				
			else outputChatBox("Dieser Account existiert bereits!", client, 255, 100, 100) end
		else outputChatBox("Du kannst keine weiteren Accounts erstellen!", client, 255, 100, 100) end
	else outputChatBox("Das Passwort muss zwischen 5 und 20 Zeichen lang sein!", client, 255, 100, 100) end
end

function Account:generatePasswort(passwort)
	return sha256(md5(passwort..passwortSalt))
end

function Account:saveAccount(player)
	if(player:isLoggedIn()) then
		local query = "UPDATE `accounts` SET "
		local arguments = {}

		for i, data in pairs(dataToSave) do
			query = ("%s`%s` = ?, "):format(query, data)
			arguments[i] =  player:getInfo(data)
		end
		query = query:sub(1, query:len() - 2)
		query = ("%s WHERE `ID` = ?"):format(query)
		arguments[#arguments + 1] = player:getInfo("ID")
		
		MySQL:queryExec(query, unpack(arguments))
		
		
	end
end
