
include("cl_skin.lua")
include( "cl_createchar.lua" );
include( "cl_music.lua" );
include( "cl_camera.lua" );
include( "cl_chatderma.lua" );

DeriveGamemode( "base" );
include("shared.lua")
surface.CreateFont( "Verdana", 15, 600, true, false, "VaultSmall" )
surface.CreateFont( "Verdana", 32, 600, true, false, "VaultHuge" )
surface.CreateFont( "Verdana", 22, 600, true, false, "VaultSubHuge" )

function GM:InitPostEntity()
ply = LocalPlayer()--make it global!
ply.viewdistance = 6.5
--1 is move, 2 is shoot, 3 is arrow
toolmode = 1
self.BaseClass:InitPostEntity()
end


function GM:Initialize()

end


timer.Simple( 2, function() ply:ConCommand("cleartable" )  end )

function GM:HUDShouldDraw( name )
	local nodraw = 
	{
		"CHudHealth",
		"CHudAmmo",
		"CHudSecondaryAmmo",
		"CHudBattery",
		"CHudCrosshair",
		"CHudWeaponSelection"
	}
	for k, v in pairs( nodraw ) do
		if( name == v ) then return false; end
	end
	return true;
end
  

function GM:PlayerBindPress(ply, Bind, Pressed)

	if (string.find(Bind, "invprev")) then 
		if ( ply.viewdistance < 36  ) then
			ply.viewdistance = ply.viewdistance + 0.5
		end
	end
	
	if (string.find(Bind, "invnext")) then 
		if ( ply.viewdistance > 2 ) then
			ply.viewdistance = ply.viewdistance - 0.5
		end
	end
	
	if (string.find(Bind, "+jump")) then 
	
	--timer.Simple( 3, fadeoutsong() )
	
	--timer.Simple( 3, function() fadeoutsong() end )
	--fadeoutsong() 
	end
	
	if (string.find(Bind, "+duck")) then 
		ply:ConCommand("crouchnpc")
	end
	
	if (string.find(Bind, "+menu")) then 
		print("SWITCH TOOLMODE")
		if(toolmode < 3)then
			toolmode = toolmode + 1
		else
			toolmode = 1
		end
	end
end 






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

















function GM:HUDPaint()

	local ScrW = surface.ScreenWidth()
	local ScrH = surface.ScreenHeight()
	
	
	verticaloffset = 25
	for k,v in pairs(options) do
		draw.DrawText("OPTION: " .. v[1], "HudHintTextSmall", ScrW/2+1, ScrH/2-20+verticaloffset+1, Color(0,0,0,255),1,1)
		draw.DrawText("OPTION: " .. v[1], "HudHintTextSmall", ScrW/2, ScrH/2-20+verticaloffset, Color(255,255,255,255),1,1)
		verticaloffset = verticaloffset + 25
	end
	
	
	--------------------
	--Camera debug info
	--------------------	
	--draw.DrawText("DEBUG - AimVector     ||     ", "HudHintTextSmall", ScrW-440, ScrH-20, Color(255,255,255,125),1,1)
	--draw.DrawText( "ViewDistance:" .. ply.viewdistance, "HudHintTextSmall", ScrW-140, ScrH-30, Color(255,255,255,125),1,1)
	
	PlayerNPC = ply:GetNetworkedEntity("PlayerNPC")
	--------------------
	--Player chat
	--Draws chat above player heads
	--------------------	
	for k, v in pairs( ents.GetAll() ) do 
		if(v:IsValid())then
			if(string.find(v:GetClass(),"class_human_shotgun"))then
				if(PlayerNPC != NULL)then
					distance = (PlayerNPC:GetPos()+Vector(0,0,60)):Distance(v:GetPos()+Vector(0,0,60))
					if ( distance < 800 )then
						local HP, MaxHP = distance, 500
						local Ratio = (HP / MaxHP)
						local alpha = math.abs(Ratio*250 - 400)
						if (alpha >= 250) then
							alpha = 250
						end
						if (alpha <= 0) then
							alpha = 0
						end
						local pos = v:GetPos() +Vector(0, 0, 80)
						local sc = pos:ToScreen()
						local text1 =  v:GetNWString("chattext")
						local text2 =  v:GetNWString("chattext2")
						local text =  text1 .. " " .. text2
						draw.DrawText( text , "VaultSmall", sc.x+1, sc.y+1, Color(0,0,0,alpha),1,1)
						draw.DrawText( text , "VaultSmall", sc.x, sc.y, Color(255,255,0,alpha),1,1)
					end
				end
			end
		end
	end	
	
	

	--------------------
	--Tool modes
	--Changes the cursor display
	--1 is move, 2 is shoot, 3 is arrow/use
	--------------------	
	/*--This comments the entire mouse tracker out!
	x, y = gui.MousePos()--Track the mouse
	
	if(toolmode == 2)then
		tex=surface.GetTextureID("VGUI/logos/UI/spray_bullseye.vmt")--Seems to draw the fastest, figure out why!
	else
		tex=surface.GetTextureID("vgui/notices/hint.vtf")
	end

	if(toolmode != 1)then
		surface.SetTexture(tex)
		surface.SetDrawColor(255,255,255,255)
		surface.DrawTexturedRect(x+8,y+8,32,32) 
	end
	*/
	
	--TEMPORARY
	x, y = gui.MousePos()--Track the mouse
	--draw.DrawText( "DEBUG: ToolMode:" .. toolmode, "VaultSmall", x+100, y, Color(255,0,0,255),1,1)
end

function GM:Think( )	

	PlayerNPC = LocalPlayer():GetNetworkedEntity("PlayerNPC")
	if(PlayerNPC != NULL)then
		if(ply.viewdistance <= 0.3)then
			local HP, MaxHP = ply.viewdistance, 0.3
			local Ratio = (HP / MaxHP)
			PlayerNPC:SetColor(  255, 255, 255, Ratio*255  )
		end
		
		if(ply.viewdistance > 0.3)then
			PlayerNPC:SetColor(  255, 255, 255, 255  )
		end
	end
	gui.EnableScreenClicker(true)--Always clicking, so always use the gui clicker
	
	
	
	
	
	
	
	
	
	
	if(PlayerNPC != NULL)then
	local cPos = PlayerNPC:GetPos()
	--local dlight = DynamicLight(PlayerNPC:EntIndex())
	if dlight then
		dlight.Pos = cPos
		dlight.r = 255
		dlight.g = 255
		dlight.b = 255
		dlight.Brightness = 5
		dlight.Size = 64
		dlight.Decay = 64
		dlight.DieTime = CurTime() + 10
	end
	end
	
	
	
	
	
	
	
	--------------------
	--Camera movement
	--------------------
	if (ply:KeyDown(IN_FORWARD)) then
		ply:SetEyeAngles( ply:EyeAngles()+Angle(30 * FrameTime( ),0,0) )
	end
	
	if (ply:KeyDown(IN_BACK)) then
		ply:SetEyeAngles( ply:EyeAngles()-Angle(30 * FrameTime( ),0,0) )
	end
		
	if (ply:KeyDown(IN_MOVELEFT)) then
		ply:SetEyeAngles( ply:EyeAngles()-Angle(0,50	* FrameTime( ),0) )
	end
	
	if (ply:KeyDown(IN_MOVERIGHT)) then
		ply:SetEyeAngles( ply:EyeAngles()+Angle(0,50 * FrameTime( ),0) )
	end

	if (ply:KeyDown(IN_USE)) then--ZOOM IN
		if ( ply.viewdistance > 0 ) then
			ply.viewdistance = ply.viewdistance - 5 * FrameTime( )
		end
	end
	
	if (ply:KeyDown(IN_RELOAD)) then--ZOOM OUT
		if ( ply.viewdistance < 36  ) then
			ply.viewdistance = ply.viewdistance + 5 * FrameTime( )
		end
	end
	
	--------------------
	--Camera resetting
	--Resets the camera zoom and pitch each thinkstep
	--------------------
	
			if ( ply.viewdistance <= 0 ) then--if they're zooming in too far
				ply.viewdistance = 0
			end

			if ( ply.viewdistance >= 36  ) then--if they're zooming out too far
				ply.viewdistance = 36
			end
			
	if(PlayerNPC != NULL)then
		if(ply.viewdistance > 0.3)then
			if (ply:EyeAngles().Pitch < 20) then--If they pitch too low...
				--Removed for more freedom, and less runescapyness
				--ply:SetEyeAngles( Angle( 20, ply:EyeAngles().Yaw, ply:EyeAngles().Roll) )
			end
		end
	end
	
	
	
	

	
end	



   
function Click(mousecode, aimvec ) 

	if(charloaded == true)then
	if ply:GetNetworkedEntity("PlayerNPC") then
	local PlayerNPC = ply:GetNetworkedEntity("PlayerNPC")
	if (PlayerNPC:IsValid()) then
	--------------------
	--GUI Clicking
	--------------------	
	if mousecode==107 then--LEFT MOUSE CLICK
		local aimvecstr=aimvec.x.." "..aimvec.y.." "..aimvec.z
		
		if(toolmode == 1)then
			if (ply:KeyDown(IN_SPEED)) then	
				ply:ConCommand("npcshoottarget2 "..aimvecstr .. " " .. ply.viewdistance)
			else
				ply:ConCommand("movenpc "..aimvecstr .. " " .. ply.viewdistance)
				print("MOVE!")
			end
		end
		
		if(toolmode == 2)then
			ply:ConCommand("npcshoottarget2 "..aimvecstr .. " " .. ply.viewdistance)
		end
		
		if(toolmode == 3)then
			--testpanel()
			
			ply:ConCommand("teleport "..aimvecstr .. " " .. ply.viewdistance)
		end
		
	end
	
	if mousecode==108 then--RIGHT MOUSE CLICK
		local aimvecstr=aimvec.x.." "..aimvec.y.." "..aimvec.z
		ply:ConCommand("npcface "..aimvecstr .. " " .. ply.viewdistance)--Have the NPC face anywhere you rightclick towards!
	end
	end
	end
	end
end
hook.Add("GUIMousePressed", "Click", Click)





function testpanel()
	--// Trace Stuff ////////////////////
	local player = ply
	local pos = player.FakePos
	local ang = gui.ScreenToVector( gui.MousePos() )
	local tracedata = {}
	tracedata.start = pos
	tracedata.endpos = pos+(ang*1000)
	tracedata.filter = player
	local trace = util.TraceLine(tracedata)
	
	--Create the menu
	local MainMenu = DermaMenu() -- create a derma menu
	MainMenu:SetPos(gui.MousePos()) --put it wherever the cursor is at the time

	if trace.HitNonWorld then
		target = trace.Entity --Store the entity it hit
	end
	
	if !trace.HitNonWorld then
		target = NULL --Store the entity it hit
	end
	
	
	
	
	
	
	
	local killpos = trace.HitPos + trace.HitNormal * 2 
	local entstable = ents.FindInSphere( killpos, 15 );
	
	for k, v in pairs( entstable ) do 
		if( v:IsNPC() && v:IsValid() )then
			target = v
			return
		end
	end
	
	
	
	
	
	
	
	if( target == NULL ) then 
		ply:PrintMessage( HUD_PRINTTALK, "Nothing appears unordinary." )
		return 
	end
	
	
	
	
	if (target) then--If I hit an entity
		if( target == NULL ) then return end
		local class = target:GetClass();--Get the entity's class
		if( class == "class_human_shotgun" ) then  --If the class is a prop...
			MainMenu:AddOption("Talk", function() ply:PrintMessage( HUD_PRINTTALK, "YOU SEE A DOUBLE NIGGER!" ) end )
			MainMenu:AddOption("Follow", function() ply:PrintMessage( HUD_PRINTTALK, "YOU START TO FOLLOW THE PLAYER WITH AN ENT INDEX OF " .. target:EntIndex() .. " " ) ply:ConCommand("npcfollow " .. target:EntIndex() ) end )
			MainMenu:AddOption("Shoot", function() ply:PrintMessage( HUD_PRINTTALK, "YOU START TO KILL THE PLAYER WITH AN ENT INDEX OF " .. target:EntIndex() .. " " ) ply:ConCommand("npcshoottarget " .. target:EntIndex() ) end )
			MainMenu:AddOption("Use", function() ply:PrintMessage( HUD_PRINTTALK, "YOU SEE A DOUBLE NIGGER!" ) end )
			MainMenu:AddOption("Examine", function() ply:PrintMessage( HUD_PRINTTALK, "You see: " .. target:GetNWString("description") .. target:GetNWString("description2") ) ply:PrintMessage( HUD_PRINTTALK, "He appears to be unhurt." ) end )
			MainMenu:AddOption("Use Item From Inventory", function() ply:PrintMessage( HUD_PRINTTALK, "YOU SEE A DOUBLE NIGGER!" ) end )
			MainMenu:AddOption("Skilldex", function() ply:PrintMessage( HUD_PRINTTALK, "YOU SEE A DOUBLE NIGGER!" ) end )
		end
	end
	MainMenu:AddSpacer()
	MainMenu:AddOption("Cancel" )
end
