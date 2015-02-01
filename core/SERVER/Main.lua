Main = {}

function Main.onStartup ()
	core = Core:constructor()
end
Main.onStartup()

function Main.onStop ()
	core:destructor() 
end
addEventHandler("onResourceStop", resourceRoot, Main.onStop, true, "low-9999")