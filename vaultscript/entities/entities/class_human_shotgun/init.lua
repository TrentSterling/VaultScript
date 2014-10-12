
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )     

function ENT:Initialize()

	self:SetSolid( SOLID_BBOX )
	self:SetMoveType( MOVETYPE_STEP ) 
	
	self:SetNPCState( NPC_STATE_IDLE )
	
	self:SetMaxYawSpeed( 5000 ) 
	
	self:SetDefaultHealth( 100 )
	
	self:SetHullType( HULL_HUMAN )
	self:SetHullSizeNormal()

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

	self:SetMaxYawSpeed( 120 ) 
	--self:Give( "ai_weapon_shotgun" )
	self:SetHealth( 120 )
	self:SetMaxHealth( 120 )
	self:SetModel( self.model )
	
	--self.BaseClass.Initialize( self )	
	
	
end

function ENT:DoAttack( Target )
	self:DoRangeAttack( Target )
end


function ENT:GetAttackSpread( Weapon, Target )
	return 0
end




	