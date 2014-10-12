



function GetLogFormatDate()

	local year = os.date( "%y" );
	local month = os.date( "%m" );
	local day = os.date( "%d" );
	local hour = os.date( "%H" );
	local minu = os.date( "%M" );
	local sec = os.date( "%S" );

	return year .. "-" .. month .. "-" .. day .. " " .. hour .. ":" .. minu .. ":" .. sec ;

end






function GM:PlayerSay( ply, text )
	self.BaseClass:PlayerSay( ply, text );
	local ftext = string.lower( text );

	local isRunning = gdatabase.CheckForConnection(DB)

	
	if !isRunning then
		print("OH NO!!!")
		SQLReconnect()
		return "CHAT COULD NOT BE PROCESSED.";
	else
		print("Connection is up!")
		local PlayerNPC = ply:GetNetworkedEntity("PlayerNPC")
		PlayerNPC:SetNWString("chattext", text)
		
		
		local uid = ply:UserID()
		local steamid = ply:SteamID()
		local name = gdatabase.CleanString(DB, ply:GetName())
		local ip = ply:IPAddress()
		if steamid == "STEAM_ID_LAN" then
			steamid = ip
		end
		
		
		gdatabase.ThreadedQuery("INSERT INTO chatlog (time, steamid, username, text) VALUES ('" .. GetLogFormatDate() .. "', '" .. steamid .. "', '" .. name .. "', '" .. text .. "')", DB)
		if(PlayerNPC:GetNWString("chattext") != text)then
			PlayerNPC:SetNWString("chattext2", "..." )
		else
			PlayerNPC:SetNWString("chattext2", "" )
		end
		return text;
	end
end


