LobbyForm = inherit(Singleton)

function LobbyForm:constructor()
	self.m_Window = guiCreateWindow(screenWidth/2-435/2, screenHeight/2-351/2, 435, 351, "Gamemode wechseln", false)
	self.m_Window:setSizable(false)
	self.m_Window:setVisible(false)

	GuiLabel.create(10, 26, 38, 17, "Name:", false, self.m_Window):setFont("default-bold-small")
	self.m_GamemodeName = GuiLabel.create(62, 26, 203, 17, "Stunting", false, self.m_Window)
	GuiLabel.create(10, 48, 48, 17, "Autoren:", false, self.m_Window):setFont("default-bold-small")
	self.m_GamemodeAuthor = GuiLabel.create(62, 48, 203, 17, "Jusonex", false, self.m_Window)
	self.m_Image = guiCreateStaticImage(255, 26, 163, 137, ":core/files/images/Game.png", false, self.m_Window)
	GuiLabel.create(10, 71, 83, 17, "Beschreibung:", false, self.m_Window):setFont("default-bold-small")
	self.m_GamemodeDescription = GuiLabel.create(10, 88, 239, 75, "Dieser Gamemode umfasst im Wesentlichen eine Stuntmap\n mit verschiedenen Warps, um Stunts von bestimmten Stellen aus zu starten.\nDies ist ein zweiter Satz, der so unnötig ist, dass er Platz verschwendet, aber genau damit seinen Zweck erfüllt.", false, self.m_Window)
	GuiLabel.create(10, 167, 83, 17, "Spieler:", false, self.m_Window):setFont("default-bold-small")
	self.m_GridPlayers = GuiGridList.create(10, 189, 415, 113, false, self.m_Window)
	self.m_GridPlayers:addColumn("Spieler", 0.9)
	self.m_ButtonJoin = GuiButton.create(11, 309, 205, 32, "Betreten", false, self.m_Window)
	self.m_ButtonClose = GuiButton.create(220, 309, 205, 32, "Schließen", false, self.m_Window)

	addEventHandler("onClientGUIClick", self.m_ButtonJoin, bind(self.ButtonJoin_Click, self), false)
	addEventHandler("onClientGUIClick", self.m_ButtonClose, function() self:close() end, false)
	
	-- Da es sich um eine Singleton-Klasse handelt, wird der Konstruktur nur einmalig aufgerufen und folgendes ist in Ordnung
	addEvent("lobbyWindowOpen", true)
	addEventHandler("lobbyWindowOpen", root,
		function(id, name, author, description, players)
			self.m_CurrentId = id
			self.m_GamemodeName:setText(name)
			self.m_GamemodeAuthor:setText(author)
			self.m_GamemodeDescription:setText(description)
			
			for player in pairs(players) do
				local row = self.m_GridPlayers:addRow()
				self.m_GridPlayers:setItemText(row, 1, player:getName(), false, false)
			end
			
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
	triggerServerEvent("lobbyJoin", root, self.m_CurrentId)
end
