AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')


function ENT:Initialize()

	self:SetModel( self.modeltouse )
	
	self.BaseClass.Initialize( self )
	
	self:SetHullType( HULL_HUMAN );
	self:SetHullSizeNormal();
	
	self:SetSolid( SOLID_BBOX )
	self:SetMoveType( MOVETYPE_STEP )
	
	
	self:CapabilitiesAdd( 
		CAP_MOVE_GROUND | 
		CAP_OPEN_DOORS | 
		CAP_ANIMATEDFACE | 
		CAP_MOVE_SHOOT | 
		CAP_TURN_HEAD | 
		CAP_USE_SHOT_REGULATOR | 
		CAP_AIM_GUN | 
		CAP_SKIP_NAV_GROUND_CHECK |
		CAP_MOVE_GROUND | 
		CAP_MOVE_JUMP | 
		CAP_ANIMATEDFACE | 
		CAP_TURN_HEAD | 
		CAP_USE_SHOT_REGULATOR | 
		CAP_USE |
		CAP_AUTO_DOORS |
		CAP_OPEN_DOORS | 
		CAP_WEAPON_MELEE_ATTACK1 |
		CAP_AIM_GUN )
	
	self:SetMaxYawSpeed( 5000 )

	--self:Give( "ai_weapon_shotgun" )
	
	self:SetNPCState( NPC_STATE_IDLE )
	self:SetLastPosition( self:GetPos() )

end


function ENT:Think()
	self:NextThink( CurTime() + 0.5 )

	local entstable = ents.FindByClass("class_human_shotgun")

	for k, v in pairs( entstable ) do 
		distance = (self:GetPos()):Distance(v:GetPos())
		if(distance < 500)then
			--print("Player is close")
			
			self:SetNPCState( NPC_STATE_IDLE )
			--self:SetNPCState( NPC_STATE_SCRIPT )
			--if(facing == false)then
				--print("***********Player is FACING!!!")
				local ply = v:GetOwner()
				if (!ply:KeyDown(IN_WALK)) then--SNEAKING. ADD BETTER SNEAKING CHECK LATER
					self:SetLastPosition( v:GetPos() )
				end
				--self:DoFace( v:GetPos()  )
				facing = true
			--end
		else
			facing = false
			--print("Player is far away")
		end
	end
end

	FaceSchedule = ai_schedule.New( "Face" )
	FaceSchedule:EngTask( "TASK_STOP_MOVING" )
	FaceSchedule:EngTask( "TASK_FACE_LASTPOSITION" )
	
function ENT:DoFace( Position )
	self:SetLastPosition( Position )
	self:StartSchedule( FaceSchedule )
end





function ENT:SelectSchedule()

	self:StartSchedule( FaceSchedule ) 

end




