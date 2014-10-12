

DialogTree = 
{
	--{CHATLINE ID, NPC ID, "TEXT", ARGS},
	{1, 1, "Welcome to this big shit hole!", "ROOT", 2, 3},
	{2, 1, "Fuck you assbandit!", "ENDCHAT"},
	{3, 1, "Smells like ass here.", 4},
	{4, 1, "Damn right it is.", "ROOT", 5},
	{5, 1, "Thanks well I'll be going!", "ENDCHAT"},
	{6, 2, "You're ugly!", "ROOT", 7},
	{7, 2, "Fuck you!", "ENDCHAT"}
}


function LoadBranch(ply,cmd,args)

	local replies = {}

	local CHATLINEID = tonumber(args[1])
	local CHATLINE = DialogTree[CHATLINEID]
	for i=4, #CHATLINE do
		print("NEW ARG: " .. type(CHATLINE[i]))
		
		
		
		if(CHATLINE[i] == "ROOT")then
			root = true
		end
		
		if( type(CHATLINE[i]) == "number" )then
			table.insert( replies, CHATLINE[i] )--reply chatline number
		end
		
	end
	
	if(root == true)then
		ply:ChatPrint("HE SAYS: " .. CHATLINE[3])
	end
	
	
	
	for k,v in pairs(replies) do
		local CHATLINEID = v
		local CHATLINE = DialogTree[CHATLINEID]
		ply:ChatPrint("YOU CAN REPLY WITH: " .. CHATLINE[3])
	end
	

end
concommand.Add("loadbranch",LoadBranch)




options = {};

function AddDialogOptions( data )
	local currentoption = {}

	local text = data:ReadString( )
	if(text == "RECREATETABLE")then
		options = {};--erase the dialog option table!
		return
	end
	table.insert( currentoption, text )--text
	
	table.insert( options, currentoption )
	print("OPTION ADDED!")
end
usermessage.Hook( "adddialogoptions", AddDialogOptions );




function LoadNPCTree(ply,cmd,args)

	local currentoption = {}

	local NPCID = tonumber(args[1])
	
	for k,v in pairs(DialogTree) do
		if(v[2] == NPCID)then
			table.insert( currentoption, v[3] )--text
		end
	end
	
	umsg.Start( "adddialogoptions", ply );
		umsg.String( "RECREATETABLE" );
	umsg.End( );
	
	for k,v in pairs(currentoption) do
		umsg.Start( "adddialogoptions", ply );
			umsg.String( v );
		umsg.End( );
	end
end
concommand.Add("loadnpctree",LoadNPCTree)






function SpawnNPCs()
	PNPC = ents.Create("ai_basenpc")
	PNPC:SetPos( Vector(3954.937500, 2828.250000, -12199.968750) )
	PNPC:SetNWString("name", "Joe Assplode")
	PNPC:SetNWInt("NPCID", 1)
	PNPC.modeltouse = "models/humans/group01/fout_03.mdl"
	PNPC:SetModel(PNPC.modeltouse)
	PNPC:Spawn()
	PNPC:Activate()
	PNPC:SetModel(PNPC.modeltouse)
	
	
	PNPC = ents.Create("ai_basenpc")
	PNPC:SetPos( Vector(2833.531250, 1230.812500, -12181.437500) )
	PNPC:SetNWString("name", "Billy the goat fucker")
	PNPC:SetNWInt("NPCID", 2)
	PNPC.modeltouse = "models/humans/group01/fout_05.mdl"
	PNPC:SetModel(PNPC.modeltouse)
	PNPC:Spawn()
	PNPC:Activate()
	PNPC:SetModel(PNPC.modeltouse)
end
concommand.Add("spawnnpcs",SpawnNPCs)


function ChatWithNearByNPC(ply,cmd,args)


	local PlayerNPC = ply:GetNetworkedEntity("PlayerNPC")
		ply:ChatPrint("STARTING FUNCTION!!")

	local entstable = ents.FindByClass("ai_basenpc")

	for k, v in pairs( entstable ) do 
		distance = (PlayerNPC:GetPos()):Distance(v:GetPos())
		if(distance < 200)then
		ply:ChatPrint("FOUND A NEARBY NPC!")
			local NPCID = v:GetNWInt("NPCID")
			umsg.Start( "startnpcchat", ply );
			umsg.String( NPCID );--id
			umsg.String( v:EntIndex() );--index
			umsg.String( v:GetNWString("name") );--name of the npc
			print("ChatWithNearByNPC " .. FindRootDialog(NPCID))
			umsg.String( FindRootDialog(NPCID) );--root text of the npc
			
			local ROOTLINE = FindRootDialogEntireLine(NPCID)

			local replies = {}

	local CHATLINE = ROOTLINE
	for i=4, #CHATLINE do
		print("NEW ARG: " .. type(CHATLINE[i]))
		
		
		
		if(CHATLINE[i] == "ROOT")then
			root = true
		end
		
		if( type(CHATLINE[i]) == "number" )then
			table.insert( replies, CHATLINE[i] )--reply chatline number or reply LINEID
		end
		
	end
	
			--for k,v in pairs(replies) do
				--local CHATLINEID = v
				--local CHATLINE = DialogTree[CHATLINEID]
				--ply:ChatPrint("YOU CAN REPLY WITH: " .. CHATLINE[3])
			--end
			print("Reply count: " .. #replies)
				--for i=1, #replies do
					--umsg.String(  replies[i] );--Answer
				--end
				
				for k,v in pairs(replies) do
					umsg.String( FindLineByID(v)[3] );--Answer--Take the LINEID from the reply table and find the fuckin right shit!
					umsg.String( FindLineByID(v)[1] );--AnswerID
					umsg.String( FindEndChat(v) );--Does this end the chat?
				end
				
				remainder = 4- #replies
				
				for i=1, remainder do
					umsg.String( "BLANK ANSWER" );--Answer
					umsg.String( "BLANK ANSWERID" );--AnswerID
					umsg.String( "0" );--AnswerID
				end
			
			umsg.End( );
		return
		end
	end


end
concommand.Add("chatwithnearbynpc",ChatWithNearByNPC)


function FindRootDialog(NPCID)
	if(NPCID != nil) then
		for k,v in pairs(DialogTree) do
			if(v[2] == NPCID)then
				for i=4, #v do
					print("NEW ARG: " .. type(v[i]))
					if(v[i] == "ROOT")then
						print("FindRootDialog " .. v[3])
						return v[3]--return the entire V to get cooler results later
					end
				end
			end
		end
	end
	return nil
end



function FindRootDialogEntireLine(NPCID)
	if(NPCID != nil) then
		for k,v in pairs(DialogTree) do
			if(v[2] == NPCID)then
				for i=4, #v do
					print("NEW ARG: " .. type(v[i]))
					if(v[i] == "ROOT")then
						print("FindRootDialog " .. v[3])
						return v
					end
				end
			end
		end
	end
	return nil
end




function FindLineByID(LINEID)
	if(LINEID != nil) then
		for k,v in pairs(DialogTree) do
			if(v[1] == LINEID)then
				return v
			end
		end
	end
	return nil
end



function FindEndChat(LINEID)
	if(LINEID != nil) then
		for k,v in pairs(DialogTree) do
			if(v[1] == LINEID)then
				local CHATLINE = v
				for i=4, #CHATLINE do
					print("NEW ARG: " .. type(CHATLINE[i]))
					if(CHATLINE[i] == "ENDCHAT")then
						return "1"
					end
				end
			end
		end
	end
	return "0"
end





