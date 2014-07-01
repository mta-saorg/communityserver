addEventHandler("onClientResourceStart", resourceRoot,
	function()
		Core:new()
	end
)

addEventHandler("onClientResourceStop", resourceRoot,
	function()
		delete(Core:getSingleton())
	end
)
