Main = {}

function Main.onStartup ()
	core = Core:constructor()

	triggerServerEvent("onClientReady", localPlayer, localPlayer)
end
Main.onStartup()

function Main.onStop ()
	core:destructor() 
end
addEventHandler("onClientResourceStop", resourceRoot, Main.onStop, true, "low-9999")