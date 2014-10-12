
DeriveGamemode( "base" );
AddCSLuaFile( "cl_init.lua" );
AddCSLuaFile( "cl_skin.lua" );
AddCSLuaFile( "cl_createchar.lua" );
AddCSLuaFile( "cl_music.lua" );
AddCSLuaFile( "cl_camera.lua" );
include("shared.lua")
include("chat.lua")

resource.AddFile("sound/vaultscript/music/worldmap.mp3")
resource.AddFile("materials/sprites/sparkle.vmt")
resource.AddFile("materials/sprites/sparkle.vtf")

CitizenMaleModels2 = 
{
	"models/stalker_antigas_killer.mdl",
	"models/stalker_bandit_veteran.mdl",
	"models/stalker_hood.mdl",
	"models/stalker_kontroler.mdl",
	"models/stalker_exo/exosk_dolg.mdl"
}


CitizenMaleModels = 
{
	"models/humans/group01/male_01.mdl",
	"models/humans/group01/male_02.mdl",
	"models/humans/group01/male_03.mdl",
	"models/humans/group01/male_04.mdl",
	"models/humans/group01/male_06.mdl",
	"models/humans/group01/male_07.mdl",
	"models/humans/group01/male_08.mdl",
	"models/humans/group01/male_09.mdl",
	"models/humans/group02/male_01.mdl",
	"models/humans/group02/male_02.mdl",
	"models/humans/group02/male_03.mdl",
	"models/humans/group02/male_04.mdl",
	"models/humans/group02/male_06.mdl",
	"models/humans/group02/male_07.mdl",
	"models/humans/group02/male_08.mdl",
	"models/humans/group02/male_09.mdl",
	"models/humans/group03/male_01.mdl",
	"models/humans/group03/male_02.mdl",
	"models/humans/group03/male_03.mdl",
	"models/humans/group03/male_04.mdl",
	"models/humans/group03/male_06.mdl",
	"models/humans/group03/male_07.mdl",
	"models/humans/group03/male_08.mdl",
	"models/humans/group03/male_09.mdl",
	"models/humans/group03m/male_01.mdl",
	"models/humans/group03m/male_02.mdl",
	"models/humans/group03m/male_03.mdl",
	"models/humans/group03m/male_04.mdl",
	"models/humans/group03m/male_06.mdl",
	"models/humans/group03m/male_07.mdl",
	"models/humans/group03m/male_08.mdl",
	"models/humans/group03m/male_09.mdl",
	"models/humans/group01/female_01.mdl",
	"models/humans/group01/female_02.mdl",
	"models/humans/group01/female_03.mdl",
	"models/humans/group01/female_04.mdl",
	"models/humans/group01/female_06.mdl",
	"models/humans/group01/female_07.mdl",
	"models/humans/group02/female_01.mdl",
	"models/humans/group02/female_02.mdl",
	"models/humans/group02/female_03.mdl",
	"models/humans/group02/female_04.mdl",
	"models/humans/group02/female_06.mdl",
	"models/humans/group02/female_07.mdl",
	"models/humans/group03/female_01.mdl",
	"models/humans/group03/female_02.mdl",
	"models/humans/group03/female_03.mdl",
	"models/humans/group03/female_04.mdl",
	"models/humans/group03/female_06.mdl",
	"models/humans/group03/female_07.mdl",
	"models/humans/group03m/female_01.mdl",
	"models/humans/group03m/female_02.mdl",
	"models/humans/group03m/female_03.mdl",
	"models/humans/group03m/female_04.mdl",
	"models/humans/group03m/female_06.mdl",
	"models/humans/group03m/female_07.mdl"	 
}


for _, player_model in pairs(CitizenMaleModels) do
	util.PrecacheModel(player_model)
end





DB = gdatabase.MakeConnection("www.modtacular.com", "modtacul_vault", "vault", "modtacul_vault")



function GM:PlayerInitialSpawn( ply )


	local isRunning = gdatabase.CheckForConnection(DB)

	
	if !isRunning then
		print("OH NO!!!")
		ply:ChatPrint("OHSHIIIIIIIIIIIIIT")
	end

	if isRunning then
		ply:ChatPrint("MYSQL IS RUNNING")
	end
	
	ply:SetModel( "models/Police.mdl" ); 
	
	-- Send them valid models
	for k, v in pairs( CitizenMaleModels ) do
		umsg.Start( "addmodel", ply );
		
			umsg.String( v );
			
		umsg.End( );
	end
	
	
	local uid = ply:UserID()
	local steamid = ply:SteamID()
	local name = gdatabase.CleanString(DB, ply:GetName())
	local ip = ply:IPAddress()
	
	if steamid == "STEAM_ID_LAN" then
		steamid = ip
	end
	--gdatabase.ThreadedQuery("SELECT * FROM characters", DB, query)
	--local query = gdatabase.Query("SELECT * FROM characters;", DB)
	--local query = gdatabase.Query("SELECT id, steamid, name, model, age FROM characters WHERE steamid = \'"..steamid.."\';", DB)
	local query = gdatabase.Query("SELECT id, steamid, name, model, age FROM characters WHERE steamid = \'"..steamid.."\';", DB)

	ply:ChatPrint("SAVES READY")
	if(#query > 4)then
	ply:ChatPrint("YOU HAVE MORE THAN 4 SAVES! Any more than 4 have been discarded!")
	end
		umsg.Start( "save", ply );
			umsg.String( "RECREATETABLE" );
			umsg.String( "RECREATETABLE" );
		umsg.End( );
	for k,v in pairs(query) do
		if(k >= 5)then
			break
		end
		ply:ChatPrint("SAVE SENT")
		print("SAVE: " .. v[3])
		print("MODEL: " .. v[4])
		umsg.Start( "save", ply );
			umsg.String( v[3] );
			umsg.String( v[4] );
		umsg.End( );
	end



	--ply.gcommunicateid = query[1][1] or 0
	--gdatabase.ThreadedQuery("", DB)
	--gdatabase.threadedquery("SELECT * FROM mail WHERE id = '"..args[1].."'", chardb, VLPop, ply)
	--gdatabase.ThreadedQuery("INSERT INTO chatlog (time, steamid, username, text) VALUES ('" .. GetLogFormatDate() .. "', '" .. ply:SteamID() .. "', '" .. ply:Nick() .. "', '" .. text .. "')", DB)
		
	
end 
	
//MAKE A CHARACTER!!!!
function StartMakeCharacter(ply,cmd,args)
	
	
		
	local uid = ply:UserID()
	local steamid = ply:SteamID()
	local name = gdatabase.CleanString(DB, ply:GetName())
	local ip = ply:IPAddress()
	
	if steamid == "STEAM_ID_LAN" then
		steamid = ip
	end
	local query = gdatabase.Query("SELECT id, steamid, name, model, age FROM characters WHERE steamid = \'"..steamid.."\';", DB)

	if(#query >= 4)then
		ply:ChatPrint("No more saves for you!")
		return
	end
	
	ply:ChatPrint("CHARACTER STARTED")
	ply:SetNWInt( "charactercreate", 1 )
	
	
end
concommand.Add("rp_startcreate",StartMakeCharacter)



function CreateAge(ply,cmd,args)
	if(ply:GetNWInt( "charactercreate" ) != 1 )then
		ply:ChatPrint("NO U!")
		return
	end
	ply:ChatPrint("AGE SET")
	local age = tonumber(args[1])
	if(age < 70 or age > 16 )then
		ply:SetNWInt( "create_age", age )
	else
		ply:ChatPrint("STOP AGE EXPLOITING ASSHOLE!")
	end
end
concommand.Add("rp_create_age",CreateAge)

function CreateName(ply,cmd,args)
	if(ply:GetNWInt( "charactercreate" ) != 1 )then
		ply:ChatPrint("NO U!")
		return
	end
	ply:ChatPrint("NAME SET")
	local name = table.concat(args," ")
	ply:SetNWString( "create_name", name )
end
concommand.Add("rp_create_name",CreateName)

function CreateModel(ply,cmd,args)
	if(ply:GetNWInt( "charactercreate" ) != 1 )then
		ply:ChatPrint("NO U!")
		return
	end
	ply:ChatPrint("MODEL SET")
	local model = args[1]
	if( table.HasValue( CitizenMaleModels, model ) ) then	
	ply:SetNWString( "create_model", model )
	else
	ply:ChatPrint("STOP MODEL EXPLOITING ASSHOLE!")
	end
end
concommand.Add("rp_create_model",CreateModel)


function FinishMakeCharacter(ply,cmd,args)
	if(ply:GetNWInt( "charactercreate" ) != 1)then
		return
	end
	local model = ply:GetNWString( "create_model" )
	local name = ply:GetNWString( "create_name" )
	local age = ply:GetNWInt( "create_age" )
	if(model == "" or name == "" or age == "" )then
		return
	end
	ply:ChatPrint("FINISHING CHARACTER")
	
	gdatabase.Query("INSERT INTO characters (steamid, name, model, age) VALUES ('" .. ply:SteamID() .. "', '" .. name .. "', '" .. model .. "', '" .. age .. "')", DB)
	
		umsg.Start( "save", ply );
			umsg.String( name );
			umsg.String( model );
		umsg.End( );
	
	ply:SetNWInt( "charactercreate", 0 )
	
	
end
concommand.Add("rp_finishcreate",FinishMakeCharacter)






function DeleteCharacter(ply,cmd,args)
	local name = table.concat(args," ")
	
	
	local uid = ply:UserID()
	local steamid = ply:SteamID()
	local playername = gdatabase.CleanString(DB, ply:GetName())
	local ip = ply:IPAddress()
	
	if steamid == "STEAM_ID_LAN" then
		steamid = ip
	end
	
	ply:ChatPrint("REMOVING: " .. name)
	gdatabase.Query("DELETE FROM characters WHERE steamid = \'"..steamid.."\' AND name = \'"..name.."\' LIMIT 1;", DB)
	
		umsg.Start( "removesave", ply );
			umsg.String( name );
		umsg.End( );
	
end
concommand.Add("rp_deletechar",DeleteCharacter)



function LoadCharacter(ply,cmd,args)
	local name = table.concat(args," ")
	
	
	local uid = ply:UserID()
	local steamid = ply:SteamID()
	local playername = gdatabase.CleanString(DB, ply:GetName())
	local ip = ply:IPAddress()
	
	if steamid == "STEAM_ID_LAN" then
		steamid = ip
	end
	
	ply:ChatPrint("LOADING: " .. name)
	local query = gdatabase.Query("SELECT id, steamid, name, model, age FROM characters WHERE steamid = \'"..steamid.."\' AND name = \'"..name.."\';", DB)
	
		umsg.Start( "loadchar", ply );
			umsg.String( name );
		umsg.End( );
	
	
	if(query[1])then
	
	PlayerNPC = ply:GetNetworkedEntity("PlayerNPC")
	ply:ChatPrint("PLAYERNPC CHECK!")
	ply:Spawn()
	
	
	if( PlayerNPC:IsValid() )then
		--ADD BACK IN TO REMOVE THE TON OF PLAYERS THAT GET SPAWNED EACH TIME YOU PICK A CHARACTER
		--ADD BACK IN TO REMOVE THE TON OF PLAYERS THAT GET SPAWNED EACH TIME YOU PICK A CHARACTER
		--ADD BACK IN TO REMOVE THE TON OF PLAYERS THAT GET SPAWNED EACH TIME YOU PICK A CHARACTER
		--ADD BACK IN TO REMOVE THE TON OF PLAYERS THAT GET SPAWNED EACH TIME YOU PICK A CHARACTER
		--ADD BACK IN TO REMOVE THE TON OF PLAYERS THAT GET SPAWNED EACH TIME YOU PICK A CHARACTER
		--ADD BACK IN TO REMOVE THE TON OF PLAYERS THAT GET SPAWNED EACH TIME YOU PICK A CHARACTER
		--PlayerNPC:Remove();
	end
	
	ply:SetNetworkedEntity("PlayerNPC", nil)
	--if( !PlayerNPC:IsValid() )then
	--ply:ChatPrint("PLAYERNPC NOT VALID!")
	local PNPC = ents.Create("class_human_shotgun")
	modeltouse = tostring(query[1][4])
	PNPC:SetKeyValue( "model", modeltouse )
	PNPC:SetKeyValue( "citizentype", 4 )
	PNPC:SetModel( modeltouse )
	--ply:ChatPrint("PLAYERNPC MODEL: " .. query[1][4] )
	PNPC:SetPos( ply:GetPos()+Vector(0,0,200) )
	PNPC.model = modeltouse
	--PNPC:SetPos( Vector(0,0,90) )
	--PNPC:SetCollisionGroup(COLLISION_GROUP_WEAPON);
	
	PNPC:Spawn()
	PNPC:Activate()
	ply:SetNetworkedEntity("PlayerNPC", PNPC)
	ply:ChatPrint("SPAWNING PLAYERNPC!")
	
	PNPC:SetModel( PNPC.model )
	local PlayerNPC = ply:GetNetworkedEntity("PlayerNPC")
	PlayerNPC:SetModel( PlayerNPC.model )
	
	
	PlayerNPC:SetNPCState( NPC_STATE_IDLE )
	
	PlayerNPC:SetLastPosition( PlayerNPC:GetPos()+Vector(0,0,90) )

	PlayerNPC:SetSchedule( SCHED_FORCED_GO )
	--end
	end
	
end
concommand.Add("rp_loadchar",LoadCharacter)




function GM:PlayerSpawn( ply )
	ply:SetModel( "models/Police.mdl" ); 
	ply:SetCollisionGroup(COLLISION_GROUP_NONE);
	ply:SetMoveType(MOVETYPE_NONE)
	ply:SetNoDraw( true );
	ply:SetNotSolid( true )
	ply:SetPos( ply:GetPos()+Vector(0,0,190) )
	
	
	for k, v in pairs( ents.GetAll() ) do 
		if(string.find(v:GetClass(),"class_human"))then
			local previoustext = v:GetNWString("chattext")
			v:SetNWString("chattext", "")
			v:SetNWString("chattext", previoustext)
			local previousdescription = v:GetNWString("description")
			local previousdescription2 = v:GetNWString("description2")
		v:SetNWString("description", "")
		v:SetNWString("description2", "")
		v:SetNWString("description", previousdescription)
		v:SetNWString("description2", previousdescription2)
		end
	end
	
	
	local uid = ply:UserID()
	local steamid = ply:SteamID()
	local playername = gdatabase.CleanString(DB, ply:GetName())
	local ip = ply:IPAddress()
	
	if steamid == "STEAM_ID_LAN" then
		steamid = ip
	end
	
	
	local query = gdatabase.Query("SELECT id, steamid, name, model, age FROM characters WHERE steamid = \'"..steamid.."\';", DB)

	ply:ChatPrint("SAVES READY")
	if(#query > 4)then
	ply:ChatPrint("YOU HAVE MORE THAN 4 SAVES! Any more than 4 have been discarded!")
	end
		umsg.Start( "save", ply );
			umsg.String( "RECREATETABLE" );
			umsg.String( "RECREATETABLE" );
		umsg.End( );
	for k,v in pairs(query) do
		if(k >= 5)then
			break
		end
		ply:ChatPrint("SAVE SENT")
		print("SAVE: " .. v[3])
		print("MODEL: " .. v[4])
		umsg.Start( "save", ply );
			umsg.String( v[3] );
			umsg.String( v[4] );
		umsg.End( );
	end


end


function AvatarView( Player )
	local PlayerNPC = Player:GetNWEntity( "PlayerNPC" )
	if not ValidEntity( PlayerNPC ) then 
	AddOriginToPVS( Vector(-600,-600,600) ) 
	return
	end
	AddOriginToPVS( PlayerNPC:GetPos() )
end
hook.Add( "SetupPlayerVisibility", "AvatarView", AvatarView )  

















function MoveNPC(ply,cmd,args)
	local PlayerNPC = ply:GetNetworkedEntity("PlayerNPC")
	PlayerNPC.busy = false
	PlayerNPC.LastTargetedPlayer = nil--CLEAR NPC's FOLLOWING TARGET
	local aimvec=Vector(tonumber(args[1]),tonumber(args[2]),tonumber(args[3]))


	local mul = tonumber(args[4])
	local trace = { }
	
				startpoint = PlayerNPC:GetPos()+Vector(0,0,60)
					
					x1 = startpoint.x
					y1 = startpoint.y
					z1 = startpoint.z
					
					endpoint = (PlayerNPC:GetPos()+Vector(0,0,60)) - ply:GetAimVector() * 100 * mul
					
					x2 = endpoint.x
					y2 = endpoint.y
					z2 = endpoint.z
					
					x3 = ((x1 + x2) / 2)
					y3 = ((y1 + y2) / 2)
					z3 = ((z1 + z2) / 2)
					
					x4 = ((x2 + x3) / 2)
					y4 = ((y2 + y3) / 2)
					z4 = ((z2 + z3) / 2)
					
		newpoint = Vector(x4, y4, z4)
	
	trace.start = newpoint;
	
	trace.endpos = trace.start + 4096 * aimvec;
	trace.filter = PlayerNPC;
	
	local tr = util.TraceLine( trace )
	
		
	local effectdata = EffectData()
		effectdata:SetOrigin( tr.HitPos + tr.HitNormal * 2 )
		effectdata:SetNormal(  tr.HitNormal )
		effectdata:SetMagnitude( 2 )
		effectdata:SetScale( 1 )
		effectdata:SetRadius( 2 )
		effectdata:SetEntity( ply )
	util.Effect( "pl_move", effectdata )
	
	
	PlayerNPC:SetNPCState( NPC_STATE_IDLE )
	
	PlayerNPC:SetLastPosition( tr.HitPos + tr.HitNormal * 2 )
	
		PlayerNPC:SetSchedule( SCHED_FORCED_GO_RUN )

	if (ply:KeyDown(IN_WALK)) then
		PlayerNPC:SetSchedule( SCHED_FORCED_GO )
	end
	
Msg("DEBUG - User #" ..  ply:UserID() .. " has moved.\n")
end
concommand.Add("movenpc",MoveNPC)

function NPCFace(ply,cmd,args)

	local PlayerNPC = ply:GetNetworkedEntity("PlayerNPC")
	--PlayerNPC.busy = false
	PlayerNPC.LastTargetedPlayer = nil--CLEAR NPC's FOLLOWING TARGET
	local aimvec=Vector(tonumber(args[1]),tonumber(args[2]),tonumber(args[3]))
	local mul = tonumber(args[4])
	local trace = { }
				startpoint = PlayerNPC:GetPos()+Vector(0,0,60)
					
					x1 = startpoint.x
					y1 = startpoint.y
					z1 = startpoint.z
					
					endpoint = (PlayerNPC:GetPos()+Vector(0,0,60)) - ply:GetAimVector() * 100 * mul
					
					x2 = endpoint.x
					y2 = endpoint.y
					z2 = endpoint.z
					
					x3 = ((x1 + x2) / 2)
					y3 = ((y1 + y2) / 2)
					z3 = ((z1 + z2) / 2)
					
					x4 = ((x2 + x3) / 2)
					y4 = ((y2 + y3) / 2)
					z4 = ((z2 + z3) / 2)
					
		newpoint = Vector(x4, y4, z4)
	trace.start = newpoint;
	trace.endpos = trace.start + 4096 * aimvec;
	trace.filter = PlayerNPC;
	local tr = util.TraceLine( trace )
	
	
	
	local effectdata = EffectData()
		effectdata:SetOrigin( tr.HitPos + tr.HitNormal * 2 )
		effectdata:SetNormal(  tr.HitNormal )
		effectdata:SetMagnitude( 4 )
		effectdata:SetScale( 1 )
		effectdata:SetRadius( 2 )
		effectdata:SetEntity( ply )
	util.Effect( "pl_move", effectdata )
	
	
	
	
	
	
	
	
	if (ply:KeyDown(IN_WALK)) then	
		local BullsEye = ents.Create("npc_citizen")
		BullsEye:SetPos( tr.HitPos + tr.HitNormal * 2 )
		BullsEye:Spawn()
		BullsEye:Activate()
	end
	

	
	
	
	if (ply:KeyDown(IN_SPEED)) then	
		PlayerNPC:SetSchedule( SCHED_RELOAD )
		return
	end
	
	
	PlayerNPC:SetNPCState( NPC_STATE_SCRIPT )
	PlayerNPC:SetLastPosition( tr.HitPos + tr.HitNormal * 2 )
	PlayerNPC:DoFace( tr.HitPos + tr.HitNormal * 2  )
	
	

	
	
	
	
	
end
concommand.Add("npcface",NPCFace)

function NPCFace2(ply,cmd,args)
	local PlayerNPC = ply:GetNetworkedEntity("PlayerNPC")
	local aimvec=Vector(tonumber(args[1]),tonumber(args[2]),tonumber(args[3]))
	local mul = tonumber(args[4])
	local trace = { }
				startpoint = PlayerNPC:GetPos()+Vector(0,0,60)
					
					x1 = startpoint.x
					y1 = startpoint.y
					z1 = startpoint.z
					
					endpoint = (PlayerNPC:GetPos()+Vector(0,0,60)) - ply:GetAimVector() * 100 * mul
					
					x2 = endpoint.x
					y2 = endpoint.y
					z2 = endpoint.z
					
					x3 = ((x1 + x2) / 2)
					y3 = ((y1 + y2) / 2)
					z3 = ((z1 + z2) / 2)
					
					x4 = ((x2 + x3) / 2)
					y4 = ((y2 + y3) / 2)
					z4 = ((z2 + z3) / 2)
					
		newpoint = Vector(x4, y4, z4)
	
	trace.start = newpoint;
	
	trace.endpos = trace.start + 4096 * aimvec;
	trace.filter = PlayerNPC;
	
	local tr = util.TraceLine( trace )
	
	
	
	PlayerNPC:SetLastPosition( tr.HitPos + tr.HitNormal * 2 )
	
		--PlayerNPC:SetSchedule( SCHED_ALERT_FACE )
		
			--PlayerNPC:DoFace( tr.HitPos + tr.HitNormal * 2  )
			
			
PlayerNPC:SetNPCState( NPC_STATE_SCRIPT )
local cheer = ai_schedule.New( "AIFighter Chase" ) 
cheer:EngTask( "TASK_STOP_MOVING" )
cheer:EngTask( "TASK_FACE_LASTPOSITION" )
--cheer:AddTask( "OpenDoor2", 				{ Name = "d1_t02_Playground_Cit2_Pockets", Speed = 1 } ) 
cheer:AddTask( "PlaySequence", 				{ Name = "photo_react_blind", Speed = 1 } ) 
--cheer:AddTask( "OpenDoor2", 				{ Name = "LineIdle02", Speed = 1 } ) 
--cheer:AddTask( "PlaySequence", 				{ Name = "Idle_to_Sit_Ground", Speed = .9 } ) 
--cheer:AddTask( "OpenDoor2", 				{ Name = "Sit_Ground", Speed = 0.5 } ) 
--cheer:AddTask( "PlaySequence", 				{ Name = "d1_town05_Daniels_Kneel_Entry", Speed = 1 } ) 
--cheer:AddTask( "OpenDoor2", 				{ Name = "d1_town05_Daniels_Kneel_Idle", Speed = 1 } ) 
--cheer:AddTask( "PlaySequence", 				{ Name = "Sit_Ground_to_Idle", Speed = .9 } ) 
PlayerNPC:StartSchedule( cheer )
	--local sequence = PlayerNPC:LookupSequence("d1_town05_Wounded_Idle_2")
	--PlayerNPC:SetSequence(sequence) 

end
concommand.Add("npcface2",NPCFace2)




function CrouchNPC(ply,cmd,args)
	local PlayerNPC = ply:GetNetworkedEntity("PlayerNPC")

		--PlayerNPC:SetSchedule( SCHED_ALERT_FACE )
		
			--PlayerNPC:DoFace( tr.HitPos + tr.HitNormal * 2  )
			
if(PlayerNPC.busy == false)then
PlayerNPC.busy = true
PlayerNPC:SetNPCState( NPC_STATE_SCRIPT )
local cheer = ai_schedule.New( "AIFighter Chase" ) 
cheer:EngTask( "TASK_STOP_MOVING" )
--cheer:EngTask( "TASK_FACE_LASTPOSITION" )
--cheer:AddTask( "OpenDoor2", 				{ Name = "d1_t02_Playground_Cit2_Pockets", Speed = 1 } ) 
--cheer:AddTask( "PlaySequence", 				{ Name = "photo_react_blind", Speed = 1 } ) 
--cheer:AddTask( "OpenDoor2", 				{ Name = "LineIdle02", Speed = 1 } ) 
cheer:AddTask( "PlaySequence", 				{ Name = "Idle_to_Sit_Ground", Speed = .9 } ) 
cheer:AddTask( "OpenDoor2", 				{ Name = "Sit_Ground", Speed = 0.5 } ) 
--cheer:AddTask( "PlaySequence", 				{ Name = "d1_town05_Daniels_Kneel_Entry", Speed = 1 } ) 
--cheer:AddTask( "OpenDoor2", 				{ Name = "d1_town05_Daniels_Kneel_Idle", Speed = 1 } ) 
--cheer:AddTask( "PlaySequence", 				{ Name = "Sit_Ground_to_Idle", Speed = .9 } ) 
PlayerNPC:StartSchedule( cheer )
	--local sequence = PlayerNPC:LookupSequence("d1_town05_Wounded_Idle_2")
	--PlayerNPC:SetSequence(sequence) 
end
end
concommand.Add("crouchnpc",CrouchNPC)







function GetEntityByIndex(index)
	if(index != nil) then
		for k, v in pairs(ents.GetAll()) do
			if(string.find(v:EntIndex(), index) != nil) then
				return v
			end
		end
	end
	return nil
end





function NPCShootTarget(ply,cmd,args)

	local PlayerNPC = ply:GetNetworkedEntity("PlayerNPC")
	--PlayerNPC.busy = false
	PlayerNPC.LastTargetedPlayer = nil--CLEAR NPC's FOLLOWING TARGET
	
	local target = tonumber(args[1])
	PlayerNPC.LastShotPlayer = GetEntityByIndex(target)
	
	
	
	
	
	local effectdata = EffectData()
		effectdata:SetOrigin( PlayerNPC.LastShotPlayer:GetPos() )
		--effectdata:SetNormal(  tr.HitNormal )
		effectdata:SetMagnitude( 1 )
		effectdata:SetScale( 1 )
		effectdata:SetRadius( 2 )
		effectdata:SetEntity( ply )
	util.Effect( "pl_move", effectdata )

	PlayerNPC:DoAttack( PlayerNPC.LastShotPlayer )-- attack a vector or an entity here, it's flexible!
	
end
concommand.Add("npcshoottarget",NPCShootTarget)



function NPCShootTarget2(ply,cmd,args)
	local PlayerNPC = ply:GetNetworkedEntity("PlayerNPC")
	
	PlayerNPC:SetNPCState( NPC_STATE_IDLE )
	
	local bullets = PlayerNPC:GetActiveWeapon():Clip1()
	
	ply:ChatPrint("BULLETS: " .. bullets)
	if( bullets <= 0 )then
		--PlayerNPC:SetSchedule( SCHED_RELOAD )
		--return
	end
	
	
	local aimvec=Vector(tonumber(args[1]),tonumber(args[2]),tonumber(args[3]))
	local mul = tonumber(args[4])
	local trace = { }
				startpoint = PlayerNPC:GetPos()+Vector(0,0,60)
					
					x1 = startpoint.x
					y1 = startpoint.y
					z1 = startpoint.z
					
					endpoint = (PlayerNPC:GetPos()+Vector(0,0,60)) - ply:GetAimVector() * 100 * mul
					
					x2 = endpoint.x
					y2 = endpoint.y
					z2 = endpoint.z
					
					x3 = ((x1 + x2) / 2)
					y3 = ((y1 + y2) / 2)
					z3 = ((z1 + z2) / 2)
					
					x4 = ((x2 + x3) / 2)
					y4 = ((y2 + y3) / 2)
					z4 = ((z2 + z3) / 2)
					
		newpoint = Vector(x4, y4, z4)
	
	trace.start = newpoint;
	
	trace.endpos = trace.start + 4096 * aimvec;
	trace.filter = PlayerNPC;
	
	local tr = util.TraceLine( trace )
	
	
	local effectdata = EffectData()
		effectdata:SetOrigin( tr.HitPos + tr.HitNormal * 2 )
		effectdata:SetNormal(  tr.HitNormal )
		effectdata:SetMagnitude( 1 )
		effectdata:SetScale( 1 )
		effectdata:SetRadius( 2 )
		effectdata:SetEntity( ply )
	util.Effect( "pl_move", effectdata )
	
	
	local killpos = tr.HitPos + tr.HitNormal * 2 
	local entstable = ents.FindInSphere( killpos, 15 );
	
	for k, v in pairs( entstable ) do 
		if( v:IsNPC() && v:IsValid() )then
			PlayerNPC:DoAttack( v )-- attack a vector or an entity here, it's flexible!
			return
		end
	end
	--make a kill point if an NPC isn't there
	local BullsEye = ents.Create("npc_bullseye")
	BullsEye:SetPos( killpos )
	BullsEye:SetCollisionGroup(COLLISION_GROUP_WORLD);
	BullsEye:Spawn()
	BullsEye:Activate()
	
	PlayerNPC:DoAttack( BullsEye )-- attack a vector or an entity here, it's flexible!
	
	
end
concommand.Add("npcshoottarget2",NPCShootTarget2)











function NPCGive(ply,cmd,args)
	local PlayerNPC = ply:GetNetworkedEntity("PlayerNPC")
	PlayerNPC:Give( args[1] )
end
concommand.Add("npcgive",NPCGive)


function NPCKill(ply,cmd,args)
	local PlayerNPC = ply:GetNetworkedEntity("PlayerNPC")
	PlayerNPC:Kill()
end
concommand.Add("npckill",NPCKill)


function NPCModelfix(ply,cmd,args)
	local PlayerNPC = ply:GetNetworkedEntity("PlayerNPC")
	PlayerNPC:SetModel( PlayerNPC.model )
end
concommand.Add("npcmodelfix",NPCModelfix)


function ChatNPC(ply,cmd,args)
	for k, v in pairs( ents.GetAll() ) do 
		if(string.find(v:GetClass(),"class_human"))then
			v:SetNWString("chattext", "LOL THIS IS CHAT!")
		end
	end
end
concommand.Add("chatnpc",ChatNPC)




function NPCFollow(ply,cmd,args)
	local PlayerNPC = ply:GetNetworkedEntity("PlayerNPC")
	PlayerNPC.LastTargetedPlayer = nil--CLEAR NPC's FOLLOWING TARGET
	PlayerNPC:SetNPCState( NPC_STATE_SCRIPT )
	local target = tonumber(args[1])
	PlayerNPC.LastTargetedPlayer = GetEntityByIndex(target)
	--print("FOLLOW COMMAND SENT" .. target .. "\n")
	
	
	
	
end
concommand.Add("npcfollow",NPCFollow)





function NPCRoam(ply,cmd,args)
	PlayerNPC = ply:GetNetworkedEntity("PlayerNPC")
	local pnpcindex = PlayerNPC:EntIndex()
	print("ENTINDEX " .. tonumber(pnpcindex))
	NPCRoam2(pnpcindex)
end
concommand.Add("npcroam",NPCRoam)




function NPCRoam2(arg)
print("ARGS LOL " .. tonumber(arg))
	PlayerNPC = GetEntityByIndex(tonumber(arg))
	PlayerNPC:SetNPCState( NPC_STATE_SCRIPT )
	local schdChase = ai_schedule.New( "AIFighter Chase" ) 
		schdChase:EngTask( "TASK_STOP_MOVING" )
		schdChase:EngTask( "TASK_GET_PATH_TO_RANDOM_NODE", 512 )
		schdChase:EngTask( "TASK_RUN_PATH", 0 )
	PlayerNPC:StartSchedule( schdChase )
	timer.Simple( 5, function() NPCRoam2(tonumber(arg)) end )
end

function ClearTable(ply, cmd, arg)

	local uid = ply:UserID()
	local steamid = ply:SteamID()
	local name = gdatabase.CleanString(DB, ply:GetName())
	local ip = ply:IPAddress()
	
	if steamid == "STEAM_ID_LAN" then
		steamid = ip
	end
	--gdatabase.ThreadedQuery("SELECT * FROM characters", DB, query)
	--local query = gdatabase.Query("SELECT * FROM characters;", DB)
	--local query = gdatabase.Query("SELECT id, steamid, name, model, age FROM characters WHERE steamid = \'"..steamid.."\';", DB)
	local query = gdatabase.Query("SELECT id, steamid, name, model, age FROM characters WHERE steamid = \'"..steamid.."\';", DB)

	ply:ChatPrint("SAVES READY")
	if(#query > 4)then
	ply:ChatPrint("YOU HAVE MORE THAN 4 SAVES! Any more than 4 have been discarded!")
	end
		umsg.Start( "save", ply );
			umsg.String( "RECREATETABLE" );
			umsg.String( "RECREATETABLE" );
		umsg.End( );
	for k,v in pairs(query) do
		if(k >= 5)then
			break
		end
		ply:ChatPrint("SAVE SENT")
		print("SAVE: " .. v[3])
		print("MODEL: " .. v[4])
		umsg.Start( "save", ply );
			umsg.String( v[3] );
			umsg.String( v[4] );
		umsg.End( );
	end

end
concommand.Add("cleartable",ClearTable)
