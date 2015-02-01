Downloadmanager = {}

Downloadmanager.cache = {
	files = {},
	data = {
		currPercent = 0,
		currFiles = 0,
		compFiles = 0,
		compSize = 0
	},
	render = {}
}

addEvent("Downloadmanager.prepareDownload", true)
addEvent("Downloadmanager.verifyFiles", true)
addEvent("Downloadmanager.receiveData", true)

function Downloadmanager.verifyFiles (...)
	local oldArgs = {...}
	local newArgs = {{}, oldArgs[2]}

	for _, v in ipairs(oldArgs[1]) do
		if not fileExists(v[1]) then
			table.insert(newArgs[1], v[1])
		else
			local file = fileOpen(v[1])
			local data = file:md5()
			fileClose(file)

            if data ~= v[2] then
                table.insert(newArgs[1], v[1])
            end
        end
    end
	
	Downloadmanager["cache"]["data"].compFiles = table.getn(newArgs[1])

	triggerServerEvent("Downloadmanager.startDownload", root, unpack(newArgs))
end
addEventHandler("Downloadmanager.verifyFiles", root, Downloadmanager.verifyFiles)

function Downloadmanager.prepareClient (data)
	local self = Downloadmanager;
	self.cache["data"].compSize = data["compSize"]

	outputDebug("Downloading "..self.cache["data"].compFiles.." Files. "..(self.cache["data"].compSize/1024).."KB ")

	
	self["cache"]["render"].barW, self["cache"]["render"].barH = 250, 250
	self["cache"]["render"].base = dxMoveable:createMoveable(self["cache"]["render"].barW, self["cache"]["render"].barH, true)
	self["cache"]["render"].baseRendertarget = dxCreateRenderTarget(self["cache"]["render"].barW, self["cache"]["render"].barH, true)
	--self["cache"]["render"].baseShader = maskShader:create(self.cache.render.baseRendertarget, "core/FILES/shader/mask/mask_images/mask_round_inside.png")
	--self["cache"]["render"].imageShader = maskShader:create("gamemodes/lobby/FILES/images/github/octocat3.png", "core/FILES/shader/mask/mask_images/mask_round_small.png")
	self["cache"]["render"].baseShader = Shader:newShader("mask", "core/FILES/shader/mask/maskShader.fx", self.cache.render.baseRendertarget, "core/FILES/shader/mask/mask_images/mask_round_inside.png")
	self["cache"]["render"].imageShader = Shader:newShader("mask", "core/FILES/shader/mask/maskShader.fx", "gamemodes/lobby/FILES/images/github/octocat3.png", "core/FILES/shader/mask/mask_images/mask_round_small.png")

	-- Set the position
	self["cache"]["render"]["base"].posX, self["cache"]["render"]["base"].posY = (screenW - self["cache"]["render"].barW)/2, (screenH - self["cache"]["render"].barH) - 10
	
	-- Predraw the stuff
	dxSetRenderTarget(self["cache"]["render"].baseRendertarget, true)
		dxDrawRectangle(0, 0, self["cache"]["render"].barW, self["cache"]["render"].barH, tocolor(225, 225, 225, 255))
		dxDrawCircle(self["cache"]["render"].barW/2, self["cache"]["render"].barH/2, self["cache"]["render"].barW * 0.452, self["cache"]["render"].barH * 0.048, 0.1, 0, (self["cache"]["data"].currPercent/100)*360, tocolor(254, 138, 0, 255))
	dxSetRenderTarget()
	
	dxSetRenderTarget(self["cache"]["render"]["base"].renderTarget, true)
		--self["cache"]["render"].baseShader:render(0, 0, self["cache"]["render"].barW, self["cache"]["render"].barH)
	self["cache"]["render"].baseShader:draw(0, 0, self["cache"]["render"].barW, self["cache"]["render"].barH)
	dxSetRenderTarget()
	
	addEventHandler("onClientRender", root, self.renderDownloadbar)
	
	self = nil;
end
addEventHandler("Downloadmanager.prepareDownload", root, Downloadmanager.prepareClient)


function Downloadmanager.renderDownloadbar ()
	local self = Downloadmanager;

	self.cache["data"].currPercent = (self.cache["data"].currFiles/self.cache["data"].compFiles)*100
	
	-- Redraw the stuff (update)
	dxSetRenderTarget(self["cache"]["render"].baseRendertarget, true)
		dxDrawRectangle(0, 0, self["cache"]["render"].barW, self["cache"]["render"].barH, tocolor(225, 225, 225, 255))
		dxDrawCircle(self["cache"]["render"].barW/2, self["cache"]["render"].barH/2, self["cache"]["render"].barW * 0.452, self["cache"]["render"].barH * 0.048, 0.1, 0, (self["cache"]["data"].currPercent/100)*360, tocolor(254, 138, 0, 255))
	dxSetRenderTarget()
	
	dxSetRenderTarget(self["cache"]["render"]["base"].renderTarget, true)
		--self["cache"]["render"].baseShader:render(0, 0, self["cache"]["render"].barW, self["cache"]["render"].barH)
		self["cache"]["render"].baseShader:draw(0, 0, self["cache"]["render"].barW, self["cache"]["render"].barH)
	dxSetRenderTarget()


	-- Render the stuff
	dxDrawImage(self["cache"]["render"]["base"].posX, self["cache"]["render"]["base"].posY, self["cache"]["render"]["base"].w, self["cache"]["render"]["base"].h, self["cache"]["render"]["base"].renderTarget)
	--self["cache"]["render"].imageShader:render(self["cache"]["render"]["base"].posX, self["cache"]["render"]["base"].posY, self["cache"]["render"]["base"].w, self["cache"]["render"]["base"].h)
	self["cache"]["render"].imageShader:draw(self["cache"]["render"]["base"].posX, self["cache"]["render"]["base"].posY, self["cache"]["render"]["base"].w, self["cache"]["render"]["base"].h)
	
	self = nil;
end

function Downloadmanager.onFileReceived (data)
	local self = Downloadmanager;
	--[[
		Datatable Format:
			base64 "FileName"
			base64 "FileData"
			base64 "size"
	--]]
	self.cache["data"].currFiles = self.cache["data"].currFiles + 1
	local splittedData = split(base64Decode(data[1]), "/")
	
	if fileExists(("temp/file_%s/data.%s"):format(self.cache["data"].currFiles, "base64")) then
		fileDelete(("temp/file_%s/data.%s"):format(self.cache["data"].currFiles, "base64"))
	elseif fileExists(("temp/file_%s/name.%s"):format(self.cache["data"].currFiles, "base64")) then
		fileDelete(("temp/file_%s/name.%s"):format(self.cache["data"].currFiles, "base64"))
	elseif fileExists(("temp/file_%s/size.%s"):format(self.cache["data"].currFiles, "base64")) then
		fileDelete(("temp/file_%s/size.%s"):format(self.cache["data"].currFiles, "base64"))
	end
	
	local file = fileCreate(("temp/file_%s/data.%s"):format(self.cache["data"].currFiles, "base64"))
	file:write(data[2])
	file:close()
	local file = fileCreate(("temp/file_%s/name.%s"):format(self.cache["data"].currFiles, "base64"))
	file:write(data[1])
	file:close()
	
	
	if self.cache["data"].currFiles == 1 then
		addEventHandler("onClientResourceStop", resourceRoot, Downloadmanager.onDownloadFinished)
	end
	if self.cache["data"].currFiles == self.cache["data"].compFiles then
		Downloadmanager.onDownloadFinished()
	end
end
addEventHandler("Downloadmanager.receiveData", root, Downloadmanager.onFileReceived)

function Downloadmanager.onDownloadFinished ()
	local self = Downloadmanager;

	-- create all the files and delete the temp files
	for i = 1, self.cache["data"].compFiles do 
		if fileExists(("temp/file_%s/data.%s"):format(i, "base64")) 
			and fileExists(("temp/file_%s/name.%s"):format(i, "base64")) 
		then
			local name_file = fileOpen(("temp/file_%s/name.%s"):format(i, "base64")) 
			local data_file = fileOpen(("temp/file_%s/data.%s"):format(i, "base64"))
			name = base64Decode(name_file:read())
			data = base64Decode(data_file:read())
			fileClose(name_file)
			fileClose(data_file)
		
			local newFile = fileCreate(name)
			newFile:write(data)
			newFile:close()
			
			fileDelete(("temp/file_%s/name.%s"):format(i, "base64"))
			fileDelete(("temp/file_%s/data.%s"):format(i, "base64"))
		end
	end

	-- Remove the downloadbar
	removeEventHandler("onClientRender", root, self.renderDownloadbar)
	self["cache"]["render"].baseShader:destroy()
	self["cache"]["render"].imageShader:destroy()
	
	-- test
	triggerServerEvent("Donwloadmanager.onPlayerDownloadFinish", localPlayer, localPlayer)
	removeEventHandler("onClientResourceStop", resourceRoot, Downloadmanager.onDownloadFinished)

	-- Clear the cache.
	Downloadmanager.cache = {}
end