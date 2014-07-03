addEventHandler("onResourceStart", resourceRoot,
	function()
		-- Instantiate Core
		Core:new()
		
	end
)

addEventHandler("onResourceStop", resourceRoot,
	function()
		-- Release Core
		delete(Core:getSingleton())
		
	end
)
