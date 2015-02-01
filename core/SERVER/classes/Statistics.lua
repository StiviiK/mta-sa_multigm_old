if Database:isConnected() then
	Statistics = {};
	Statistics.classes = {}
	
	function Statistics:constructor ()
		outputDebug("[Statistics] Statistics has been successfull activated!")
	end
	
	function Statistics:isClasspresent (class)
		for i, v in ipairs(self.classes) do
			if v[2] == class then
				return true;
			end
		end
		
		return false;
	end

	function Statistics:destructor ()
		outputDebug("[Statistics] Statistics has been successfull disabled!")
	end
else
	outputDebug("[Statistics] There was not database connection established! Statistics won'old_dxClass work!", 1)
end