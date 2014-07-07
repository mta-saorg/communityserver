addEventHandler("onResourceStart", resourceRoot,
	function()
		Core:new()
	end
)

addEventHandler("onResourceStop", resourceRoot,
	function()
		delete(Core:getSingleton())
	end
)