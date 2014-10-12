
introview = 1
introvector = Vector(-600,600,600)
introangles = Vector(30,-60,0)
introfov = 90

introdivider = 1

function LoadChar( data )
	local savetoload = data:ReadString( )
	charloaded = true
	
		if(SaveWindow)then
			SaveWindow:Remove()
			SaveWindow = nil
		end
		
		if(CharacterWindow)then
			CharacterWindow:Remove()
			CharacterWindow = nil
		end
		
		if(ModelWindow)then
			ModelWindow:Remove()
			ModelWindow = nil
		end
end
usermessage.Hook( "loadchar", LoadChar );





function IntroView( ply, origin, angles, fov )
	if(charloaded == false)then
		if(introdivider != 0)then

			introdivider = introdivider/1.001
			
			introangles = Vector(introangles.x,introangles.y+introdivider/10,introangles.z-introdivider/100)
			introvector = Vector(introvector.x+introdivider,introvector.y+introdivider,introvector.z-introdivider)
			introfov = introfov-introdivider/300
			
			if(introdivider < 0.001)then
				introdivider = 0
			end
		end
		gui.EnableScreenClicker(true)--Always clicking, so always use the gui clicker


		local View = {}
		View.origin = introvector
		View.angles = introangles
		View.fov = introfov
		return View
	end
end
hook.Add( "CalcView", "IntroView", IntroView );








function CalcView( ply, origin, angles, fov )
	if(charloaded == true)then
		if ply:GetNetworkedEntity("PlayerNPC") then
		local PlayerNPC = ply:GetNetworkedEntity("PlayerNPC")
		if (PlayerNPC:IsValid()) then
			--ply:PrintMessage( HUD_PRINTTALK, "CAM ACTIVATED!" )
			-- Prevent camera from noclipping with world
			if (PlayerNPC:IsValid()) then
				local mul = ply.viewdistance
				local mul2 = mul/2
				local mul3 = mul/3
				local Trace2 = util.QuickTrace(PlayerNPC:GetPos()+Vector(0,0,60), ply:GetAimVector() * -100 * mul, {PlayerNPC, ply})
				distance = (PlayerNPC:GetPos()+Vector(0,0,60)):Distance(Trace2.HitPos + (Trace2.HitNormal * 2))
				local mul4 = distance
				local Trace = util.QuickTrace(PlayerNPC:GetPos()+Vector(0,0,60), ply:GetAimVector() * -(mul4-1), {PlayerNPC, ply})
				local View = {}
				--View.origin = Trace.HitPos + (Trace.HitNormal * 2)
				View.angles = Angles
				startpoint = PlayerNPC:GetPos()+Vector(0,0,60)

				x1 = startpoint.x
				y1 = startpoint.y
				z1 = startpoint.z

				endpoint = Trace.HitPos + (Trace.HitNormal * 2)

				x2 = endpoint.x
				y2 = endpoint.y
				z2 = endpoint.z

				x3 = ((x1 + x2) / 2)
				y3 = ((y1 + y2) / 2)
				z3 = ((z1 + z2) / 2)

				x4 = ((x2 + x3) / 2)
				y4 = ((y2 + y3) / 2)
				z4 = ((z2 + z3) / 2)

				View.origin = Vector(x4, y4, z4) + (Trace.HitNormal * 2)
				-- We're not actually here..
				ply.FakePos = View.origin
				return View
			end
		end
		end
	end
end
hook.Add( "CalcView", "NPCView", CalcView );

