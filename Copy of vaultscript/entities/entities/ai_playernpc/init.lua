AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')


function ENT:Initialize()

	self:SetModel( "models/stalker_exo/exo_specna.mdl" )
	
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

	self:Give( "ai_weapon_shotgun" )
	
	self:SetNPCState( NPC_STATE_IDLE )

end

function ENT:DoAttack( Target )
	self:DoMeleeAttack( Target )
end
