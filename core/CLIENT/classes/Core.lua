Core = {}

function Core:constructor ()
	core = self

	Debug:constructor()

	return self
end

function Core:destructor ()
	if self ~= core then return end

	-- delete the core
	self.destructor = false
	core = nil
end