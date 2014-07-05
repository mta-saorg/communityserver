LobbyForm = inherit(Singleton)
GuiGridList = GuiGridlist

function LobbyForm:constructor()
	self.m_Window = guiCreateWindow(screenWidth/2-435/2, screenHeight/2-351/2, 435, 351, "Gamemode wechseln", false)
	self.m_Window:setSizable(false)
	self.m_Window:setVisible(false)

	GuiLabel.create(10, 26, 38, 17, "Name:", false, self.m_Window):setFont("default-bold-small")
	self.m_GamemodeName = GuiLabel.create(68, 26, 203, 17, "", false, self.m_Window)
	GuiLabel.create(10, 48, 48, 17, "Autoren:", false, self.m_Window):setFont("default-bold-small")
	self.m_GamemodeAuthor = GuiLabel.create(68, 48, 203, 17, "", false, self.m_Window)
	GuiLabel.create(10, 70, 40, 17, "Spieler:", false, self.m_Window):setFont("default-bold-small")
	self.m_PlayerCount = GuiLabel.create(68, 70, 203, 17, "", false, self.m_Window)

	self.m_Image = guiCreateStaticImage(255, 26, 163, 137, ":core/files/images/Game.png", false, self.m_Window)
	GuiLabel.create(10, 92, 83, 17, "Beschreibung:", false, self.m_Window):setFont("default-bold-small")
	self.m_GamemodeDescription = GuiLabel.create(10, 114, 239, 75, "", false, self.m_Window)
	GuiLabel.create(10, 167, 83, 17, "Spieler:", false, self.m_Window):setFont("default-bold-small")
	self.m_GridPlayers = GuiGridList.create(10, 189, 415, 113, false, self.m_Window)
	guiGridListAddColumn(self.m_GridPlayers, "Spieler", 0.9)
	self.m_ButtonJoin = GuiButton.create(11, 309, 205, 32, "Betreten", false, self.m_Window)
	self.m_ButtonClose = GuiButton.create(220, 309, 205, 32, "Schließen", false, self.m_Window)

	addEventHandler("onClientGUIClick", self.m_ButtonJoin, bind(self.ButtonJoin_Click, self), false)
	addEventHandler("onClientGUIClick", self.m_ButtonClose, function() self:close() end, false)
	
	-- Da es sich um eine Singleton-Klasse handelt, wird der Konstruktur nur einmalig aufgerufen und folgendes ist in Ordnung
	addEvent("lobbyWindowOpen", true)
	addEventHandler("lobbyWindowOpen", root,
		function(id, name, author, description, players, maxPlayers)
			self.m_CurrentId = id
			self.m_GamemodeName:setText(name)
			self.m_GamemodeAuthor:setText(author)
			self.m_GamemodeDescription:setText(description)
			
			guiGridListClear(self.m_GridPlayers)
			local counter = 0
			for player in pairs(players) do
				local row = guiGridListAddRow(self.m_GridPlayers)
				--self.m_GridPlayers:setItemText(row, 1, player:getName(), false, false)
				guiGridListSetItemText(self.m_GridPlayers, row, 1, string.gsub(player:getName(), "#%x%x%x%x%x%x", ""), false, false)
				counter = counter + 1
			end
			self.m_PlayerCount:setText(("%d / %d"):format(counter, maxPlayers))
			
			self:open()
		end
	)
end

function LobbyForm:open()
	self.m_Window:setVisible(true)
	showCursor(true)
end

function LobbyForm:close()
	self.m_Window:setVisible(false)
	showCursor(false)
end

function LobbyForm:ButtonJoin_Click()
	if not self.m_CurrentId then return end
	triggerServerEvent("onGamemodeJoin", resourceRoot, self.m_CurrentId)
	self:close()
end
