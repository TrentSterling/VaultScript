
ENT.Type 		= "ai"
ENT.Base 		= "base_ai"
ENT.Spawnable 	= false
ENT.AutomaticFrameAdvance = true

function ENT:SetPlayer( Player )
	self:SetNWEntity( "Player", Player )
end

function ENT:GetPlayer()
	return self:GetNWEntity( "Player" )
end

function ENT:GetNPCMaxHealth()
	return self:GetNWInt( "NPCMaxHealth" )
end

function ENT:GetNPCHealth()
	return self:GetNWInt( "NPCHealth" )
end

function ENT:Armor()
	return self:GetNWInt( "Armor" )
end

function ENT:GetMaxArmor()
	return self:GetNWInt( "MaxArmor" )
end