Account = inherit(Singleton)

function Account:constructor()	
	self.m_bRegister = false
	
	addEvent("onClientReceiveAccountCheck", true)
	addEventHandler("onClientReceiveAccountCheck", resourceRoot, bind(self.receiveCheck, self))
end

function Account:toggleWindow()
	showCursor(not isElement(self.m_Window))
	guiSetInputEnabled(not (isElement(self.m_Window)))
	if isElement(self.m_Window) then destroyElement(self.m_Window) return end

	self.m_Window = GuiWindow.create((screenWidth / 2) - 148, (screenHeight / 2) - 75.5, 296, 151, "mta-sa.org Communityserver", false)
	self.m_Window:setSizable(false)

	self.editUsername = GuiEdit.create(131, 36, 144, 25, localPlayer:getName(), false, self.m_Window)
	self.editUsername:setEnabled(false)
	
	self.editPasswort = GuiEdit.create(131, 71, 144, 25, "", false, self.m_Window)
	self.editPasswort:setMasked(true)
	
	local idk = GuiLabel.create(26, 38, 94, 23, "Benutzername:", false, self.m_Window)
	idk:setFont("default-bold-small")
	idk:setHorizontalAlign("right", false)
	idk:setVerticalAlign("center")
	
	idk = GuiLabel.create(26, 73, 94, 23, "Benutzername:", false, self.m_Window)
	idk:setFont("default-bold-small")
	idk:setHorizontalAlign("right", false)
	idk:setVerticalAlign("center")
	
	self.m_Button = GuiButton.create(44, 106, 225, 34, (self.m_bRegister and "Registrieren" or "Anmelden"), false, self.m_Window)
	self.m_Button:setFont("default-bold-small")

	addEventHandler("onClientGUIClick", self.m_Button, bind(self.onClick, self), false)
end

function Account:receiveCheck(bRegister)
	self.m_bRegister = bRegister
	self:toggleWindow()
end

function Account:onClick(btn, state)
	if(btn == "left" and state == "up") then
		local passwort = self.editPasswort:getText()
		if(passwort:len() >= 5 and passwort:len() <= 20) then
			triggerServerEvent((self.m_bRegister and "onAccountRegister" or "onAccountLogin"), resourceRoot, passwort)
		else outputChatBox("Das Passwort muss zwischen 5 und 20 Zeichen lang sein!", 255, 100, 100) end
	end
end
